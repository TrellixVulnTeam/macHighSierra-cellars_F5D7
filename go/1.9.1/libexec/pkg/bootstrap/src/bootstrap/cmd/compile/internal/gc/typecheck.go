// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/typecheck.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/typecheck.go:1
// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package gc

import (
	"bootstrap/cmd/compile/internal/types"
	"bootstrap/cmd/internal/objabi"
	"bootstrap/cmd/internal/src"
	"fmt"
	"math"
	"strings"
)

const (
	Etop      = 1 << iota // evaluated at statement level
	Erv                   // evaluated in value context
	Etype                 // evaluated in type context
	Ecall                 // call-only expressions are ok
	Efnstruct             // multivalue function returns are ok
	Easgn                 // assigning to expression
	Ecomplit              // type in composite literal
)

// type checks the whole tree of an expression.
// calculates expression types.
// evaluates compile time constants.
// marks variables that escape the local frame.
// rewrites n.Op to be more specific in some cases.

var typecheckdefstack []*Node

// resolve ONONAME to definition, if any.
func resolve(n *Node) *Node {
	if n != nil && n.Op == ONONAME && n.Sym != nil {
		r := asNode(n.Sym.Def)
		if r != nil {
			if r.Op != OIOTA {
				n = r
			} else if len(typecheckdefstack) > 0 {
				x := typecheckdefstack[len(typecheckdefstack)-1]
				if x.Op == OLITERAL {
					n = nodintconst(x.Iota())
				}
			}
		}
	}

	return n
}

func typecheckslice(l []*Node, top int) {
	for i := range l {
		l[i] = typecheck(l[i], top)
	}
}

var _typekind = []string{
	TINT:        "int",
	TUINT:       "uint",
	TINT8:       "int8",
	TUINT8:      "uint8",
	TINT16:      "int16",
	TUINT16:     "uint16",
	TINT32:      "int32",
	TUINT32:     "uint32",
	TINT64:      "int64",
	TUINT64:     "uint64",
	TUINTPTR:    "uintptr",
	TCOMPLEX64:  "complex64",
	TCOMPLEX128: "complex128",
	TFLOAT32:    "float32",
	TFLOAT64:    "float64",
	TBOOL:       "bool",
	TSTRING:     "string",
	TPTR32:      "pointer",
	TPTR64:      "pointer",
	TUNSAFEPTR:  "unsafe.Pointer",
	TSTRUCT:     "struct",
	TINTER:      "interface",
	TCHAN:       "chan",
	TMAP:        "map",
	TARRAY:      "array",
	TSLICE:      "slice",
	TFUNC:       "func",
	TNIL:        "nil",
	TIDEAL:      "untyped number",
}

func typekind(t *types.Type) string {
	if t.IsSlice() {
		return "slice"
	}
	et := t.Etype
	if int(et) < len(_typekind) {
		s := _typekind[et]
		if s != "" {
			return s
		}
	}
	return fmt.Sprintf("etype=%d", et)
}

// sprint_depchain prints a dependency chain of nodes into trace.
// It is used by typecheck in the case of OLITERAL nodes
// to print constant definition loops.
func sprint_depchain(trace *string, stack []*Node, cur *Node, first *Node) {
	for i := len(stack) - 1; i >= 0; i-- {
		if n := stack[i]; n.Op == cur.Op {
			if n != first {
				sprint_depchain(trace, stack[:i], n, first)
			}
			*trace += fmt.Sprintf("\n\t%v: %v uses %v", n.Line(), n, cur)
			return
		}
	}
}

var typecheck_tcstack []*Node

// typecheck type checks node n.
// The result of typecheck MUST be assigned back to n, e.g.
// 	n.Left = typecheck(n.Left, top)
func typecheck(n *Node, top int) *Node {
	// cannot type check until all the source has been parsed
	if !typecheckok {
		Fatalf("early typecheck")
	}

	if n == nil {
		return nil
	}

	lno := setlineno(n)

	// Skip over parens.
	for n.Op == OPAREN {
		n = n.Left
	}

	// Resolve definition of name and value of iota lazily.
	n = resolve(n)

	// Skip typecheck if already done.
	// But re-typecheck ONAME/OTYPE/OLITERAL/OPACK node in case context has changed.
	if n.Typecheck() == 1 {
		switch n.Op {
		case ONAME, OTYPE, OLITERAL, OPACK:
			break

		default:
			lineno = lno
			return n
		}
	}

	if n.Typecheck() == 2 {
		// Typechecking loop. Trying printing a meaningful message,
		// otherwise a stack trace of typechecking.
		switch n.Op {
		// We can already diagnose variables used as types.
		case ONAME:
			if top&(Erv|Etype) == Etype {
				yyerror("%v is not a type", n)
			}

		case OTYPE:
			if top&Etype == Etype {
				var trace string
				sprint_depchain(&trace, typecheck_tcstack, n, n)
				yyerrorl(n.Pos, "invalid recursive type alias %v%s", n, trace)
			}

		case OLITERAL:
			if top&(Erv|Etype) == Etype {
				yyerror("%v is not a type", n)
				break
			}
			var trace string
			sprint_depchain(&trace, typecheck_tcstack, n, n)
			yyerrorl(n.Pos, "constant definition loop%s", trace)
		}

		if nsavederrors+nerrors == 0 {
			var trace string
			for i := len(typecheck_tcstack) - 1; i >= 0; i-- {
				x := typecheck_tcstack[i]
				trace += fmt.Sprintf("\n\t%v %v", x.Line(), x)
			}
			yyerror("typechecking loop involving %v%s", n, trace)
		}

		lineno = lno
		return n
	}

	n.SetTypecheck(2)

	typecheck_tcstack = append(typecheck_tcstack, n)
	n = typecheck1(n, top)

	n.SetTypecheck(1)

	last := len(typecheck_tcstack) - 1
	typecheck_tcstack[last] = nil
	typecheck_tcstack = typecheck_tcstack[:last]

	lineno = lno
	return n
}

// does n contain a call or receive operation?
func callrecv(n *Node) bool {
	if n == nil {
		return false
	}

	switch n.Op {
	case OCALL,
		OCALLMETH,
		OCALLINTER,
		OCALLFUNC,
		ORECV,
		OCAP,
		OLEN,
		OCOPY,
		ONEW,
		OAPPEND,
		ODELETE:
		return true
	}

	return callrecv(n.Left) || callrecv(n.Right) || callrecvlist(n.Ninit) || callrecvlist(n.Nbody) || callrecvlist(n.List) || callrecvlist(n.Rlist)
}

func callrecvlist(l Nodes) bool {
	for _, n := range l.Slice() {
		if callrecv(n) {
			return true
		}
	}
	return false
}

// indexlit implements typechecking of untyped values as
// array/slice indexes. It is equivalent to defaultlit
// except for constants of numerical kind, which are acceptable
// whenever they can be represented by a value of type int.
// The result of indexlit MUST be assigned back to n, e.g.
// 	n.Left = indexlit(n.Left)
func indexlit(n *Node) *Node {
	if n == nil || !n.Type.IsUntyped() {
		return n
	}
	switch consttype(n) {
	case CTINT, CTRUNE, CTFLT, CTCPLX:
		n = defaultlit(n, types.Types[TINT])
	}

	n = defaultlit(n, nil)
	return n
}

// The result of typecheck1 MUST be assigned back to n, e.g.
// 	n.Left = typecheck1(n.Left, top)
func typecheck1(n *Node, top int) *Node {
	switch n.Op {
	case OXDOT, ODOT, ODOTPTR, ODOTMETH, ODOTINTER:
		// n.Sym is a field/method name, not a variable.
	default:
		if n.Sym != nil {
			if n.Op == ONAME && n.Etype != 0 && top&Ecall == 0 {
				yyerror("use of builtin %v not in function call", n.Sym)
				n.Type = nil
				return n
			}

			typecheckdef(n)
			if n.Op == ONONAME {
				n.Type = nil
				return n
			}
		}
	}

	ok := 0
OpSwitch:
	switch n.Op {
	// until typecheck is complete, do nothing.
	default:
		Dump("typecheck", n)

		Fatalf("typecheck %v", n.Op)

	// names
	case OLITERAL:
		ok |= Erv

		if n.Type == nil && n.Val().Ctype() == CTSTR {
			n.Type = types.Idealstring
		}
		break OpSwitch

	case ONONAME:
		ok |= Erv
		break OpSwitch

	case ONAME:
		if n.Name.Decldepth == 0 {
			n.Name.Decldepth = decldepth
		}
		if n.Etype != 0 {
			ok |= Ecall
			break OpSwitch
		}

		if top&Easgn == 0 {
			// not a write to the variable
			if isblank(n) {
				yyerror("cannot use _ as value")
				n.Type = nil
				return n
			}

			n.Name.SetUsed(true)
		}

		ok |= Erv
		break OpSwitch

	case OPACK:
		yyerror("use of package %v without selector", n.Sym)
		n.Type = nil
		return n

	case ODDD:
		break

	// types (OIND is with exprs)
	case OTYPE:
		ok |= Etype

		if n.Type == nil {
			return n
		}

	case OTARRAY:
		ok |= Etype
		r := typecheck(n.Right, Etype)
		if r.Type == nil {
			n.Type = nil
			return n
		}

		var t *types.Type
		if n.Left == nil {
			t = types.NewSlice(r.Type)
		} else if n.Left.Op == ODDD {
			if top&Ecomplit == 0 {
				if !n.Diag() {
					n.SetDiag(true)
					yyerror("use of [...] array outside of array literal")
				}
				n.Type = nil
				return n
			}
			t = types.NewDDDArray(r.Type)
		} else {
			n.Left = indexlit(typecheck(n.Left, Erv))
			l := n.Left
			if consttype(l) != CTINT {
				switch {
				case l.Type == nil:
					// Error already reported elsewhere.
				case l.Type.IsInteger() && l.Op != OLITERAL:
					yyerror("non-constant array bound %v", l)
				default:
					yyerror("invalid array bound %v", l)
				}
				n.Type = nil
				return n
			}

			v := l.Val()
			if doesoverflow(v, types.Types[TINT]) {
				yyerror("array bound is too large")
				n.Type = nil
				return n
			}

			bound := v.U.(*Mpint).Int64()
			if bound < 0 {
				yyerror("array bound must be non-negative")
				n.Type = nil
				return n
			}
			t = types.NewArray(r.Type, bound)
		}

		n.Op = OTYPE
		n.Type = t
		n.Left = nil
		n.Right = nil
		if !t.IsDDDArray() {
			checkwidth(t)
		}

	case OTMAP:
		ok |= Etype
		n.Left = typecheck(n.Left, Etype)
		n.Right = typecheck(n.Right, Etype)
		l := n.Left
		r := n.Right
		if l.Type == nil || r.Type == nil {
			n.Type = nil
			return n
		}
		if l.Type.NotInHeap() {
			yyerror("go:notinheap map key not allowed")
		}
		if r.Type.NotInHeap() {
			yyerror("go:notinheap map value not allowed")
		}
		n.Op = OTYPE
		n.Type = types.NewMap(l.Type, r.Type)

		// map key validation
		alg, bad := algtype1(l.Type)
		if alg == ANOEQ {
			if bad.Etype == TFORW {
				// queue check for map until all the types are done settling.
				mapqueue = append(mapqueue, mapqueueval{l, n.Pos})
			} else if bad.Etype != TANY {
				// no need to queue, key is already bad
				yyerror("invalid map key type %v", l.Type)
			}
		}
		n.Left = nil
		n.Right = nil

	case OTCHAN:
		ok |= Etype
		n.Left = typecheck(n.Left, Etype)
		l := n.Left
		if l.Type == nil {
			n.Type = nil
			return n
		}
		if l.Type.NotInHeap() {
			yyerror("chan of go:notinheap type not allowed")
		}
		t := types.NewChan(l.Type, types.ChanDir(n.Etype)) // TODO(marvin): Fix Node.EType type union.
		n.Op = OTYPE
		n.Type = t
		n.Left = nil
		n.Etype = 0

	case OTSTRUCT:
		ok |= Etype
		n.Op = OTYPE
		n.Type = tostruct(n.List.Slice())
		if n.Type == nil || n.Type.Broke() {
			n.Type = nil
			return n
		}
		n.List.Set(nil)

	case OTINTER:
		ok |= Etype
		n.Op = OTYPE
		n.Type = tointerface(n.List.Slice())
		if n.Type == nil {
			return n
		}

	case OTFUNC:
		ok |= Etype
		n.Op = OTYPE
		n.Type = functype(n.Left, n.List.Slice(), n.Rlist.Slice())
		if n.Type == nil {
			return n
		}
		n.Left = nil
		n.List.Set(nil)
		n.Rlist.Set(nil)

	// type or expr
	case OIND:
		n.Left = typecheck(n.Left, Erv|Etype|top&Ecomplit)
		l := n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if l.Op == OTYPE {
			ok |= Etype
			n.Op = OTYPE
			n.Type = types.NewPtr(l.Type)
			// Ensure l.Type gets dowidth'd for the backend. Issue 20174.
			// Don't checkwidth [...] arrays, though, since they
			// will be replaced by concrete-sized arrays. Issue 20333.
			if !l.Type.IsDDDArray() {
				checkwidth(l.Type)
			}
			n.Left = nil
			break OpSwitch
		}

		if !t.IsPtr() {
			if top&(Erv|Etop) != 0 {
				yyerror("invalid indirect of %L", n.Left)
				n.Type = nil
				return n
			}

			break OpSwitch
		}

		ok |= Erv
		n.Type = t.Elem()
		break OpSwitch

	// arithmetic exprs
	case OASOP,
		OADD,
		OAND,
		OANDAND,
		OANDNOT,
		ODIV,
		OEQ,
		OGE,
		OGT,
		OLE,
		OLT,
		OLSH,
		ORSH,
		OMOD,
		OMUL,
		ONE,
		OOR,
		OOROR,
		OSUB,
		OXOR:
		var l *Node
		var op Op
		var r *Node
		if n.Op == OASOP {
			ok |= Etop
			n.Left = typecheck(n.Left, Erv)
			n.Right = typecheck(n.Right, Erv)
			l = n.Left
			r = n.Right
			checkassign(n, n.Left)
			if l.Type == nil || r.Type == nil {
				n.Type = nil
				return n
			}
			if n.Implicit() && !okforarith[l.Type.Etype] {
				yyerror("invalid operation: %v (non-numeric type %v)", n, l.Type)
				n.Type = nil
				return n
			}
			// TODO(marvin): Fix Node.EType type union.
			op = Op(n.Etype)
		} else {
			ok |= Erv
			n.Left = typecheck(n.Left, Erv)
			n.Right = typecheck(n.Right, Erv)
			l = n.Left
			r = n.Right
			if l.Type == nil || r.Type == nil {
				n.Type = nil
				return n
			}
			op = n.Op
		}
		if op == OLSH || op == ORSH {
			r = defaultlit(r, types.Types[TUINT])
			n.Right = r
			t := r.Type
			if !t.IsInteger() || t.IsSigned() {
				yyerror("invalid operation: %v (shift count type %v, must be unsigned integer)", n, r.Type)
				n.Type = nil
				return n
			}

			t = l.Type
			if t != nil && t.Etype != TIDEAL && !t.IsInteger() {
				yyerror("invalid operation: %v (shift of type %v)", n, t)
				n.Type = nil
				return n
			}

			// no defaultlit for left
			// the outer context gives the type
			n.Type = l.Type

			break OpSwitch
		}

		// ideal mixed with non-ideal
		l, r = defaultlit2(l, r, false)

		n.Left = l
		n.Right = r
		if l.Type == nil || r.Type == nil {
			n.Type = nil
			return n
		}
		t := l.Type
		if t.Etype == TIDEAL {
			t = r.Type
		}
		et := t.Etype
		if et == TIDEAL {
			et = TINT
		}
		var aop Op = OXXX
		if iscmp[n.Op] && t.Etype != TIDEAL && !eqtype(l.Type, r.Type) {
			// comparison is okay as long as one side is
			// assignable to the other.  convert so they have
			// the same type.
			//
			// the only conversion that isn't a no-op is concrete == interface.
			// in that case, check comparability of the concrete type.
			// The conversion allocates, so only do it if the concrete type is huge.
			if r.Type.Etype != TBLANK {
				aop = assignop(l.Type, r.Type, nil)
				if aop != 0 {
					if r.Type.IsInterface() && !l.Type.IsInterface() && !IsComparable(l.Type) {
						yyerror("invalid operation: %v (operator %v not defined on %s)", n, op, typekind(l.Type))
						n.Type = nil
						return n
					}

					dowidth(l.Type)
					if r.Type.IsInterface() == l.Type.IsInterface() || l.Type.Width >= 1<<16 {
						l = nod(aop, l, nil)
						l.Type = r.Type
						l.SetTypecheck(1)
						n.Left = l
					}

					t = r.Type
					goto converted
				}
			}

			if l.Type.Etype != TBLANK {
				aop = assignop(r.Type, l.Type, nil)
				if aop != 0 {
					if l.Type.IsInterface() && !r.Type.IsInterface() && !IsComparable(r.Type) {
						yyerror("invalid operation: %v (operator %v not defined on %s)", n, op, typekind(r.Type))
						n.Type = nil
						return n
					}

					dowidth(r.Type)
					if r.Type.IsInterface() == l.Type.IsInterface() || r.Type.Width >= 1<<16 {
						r = nod(aop, r, nil)
						r.Type = l.Type
						r.SetTypecheck(1)
						n.Right = r
					}

					t = l.Type
				}
			}

		converted:
			et = t.Etype
		}

		if t.Etype != TIDEAL && !eqtype(l.Type, r.Type) {
			l, r = defaultlit2(l, r, true)
			if r.Type.IsInterface() == l.Type.IsInterface() || aop == 0 {
				yyerror("invalid operation: %v (mismatched types %v and %v)", n, l.Type, r.Type)
				n.Type = nil
				return n
			}
		}

		if !okfor[op][et] {
			yyerror("invalid operation: %v (operator %v not defined on %s)", n, op, typekind(t))
			n.Type = nil
			return n
		}

		// okfor allows any array == array, map == map, func == func.
		// restrict to slice/map/func == nil and nil == slice/map/func.
		if l.Type.IsArray() && !IsComparable(l.Type) {
			yyerror("invalid operation: %v (%v cannot be compared)", n, l.Type)
			n.Type = nil
			return n
		}

		if l.Type.IsSlice() && !isnil(l) && !isnil(r) {
			yyerror("invalid operation: %v (slice can only be compared to nil)", n)
			n.Type = nil
			return n
		}

		if l.Type.IsMap() && !isnil(l) && !isnil(r) {
			yyerror("invalid operation: %v (map can only be compared to nil)", n)
			n.Type = nil
			return n
		}

		if l.Type.Etype == TFUNC && !isnil(l) && !isnil(r) {
			yyerror("invalid operation: %v (func can only be compared to nil)", n)
			n.Type = nil
			return n
		}

		if l.Type.IsStruct() {
			if f := IncomparableField(l.Type); f != nil {
				yyerror("invalid operation: %v (struct containing %v cannot be compared)", n, f.Type)
				n.Type = nil
				return n
			}
		}

		t = l.Type
		if iscmp[n.Op] {
			evconst(n)
			t = types.Idealbool
			if n.Op != OLITERAL {
				l, r = defaultlit2(l, r, true)
				n.Left = l
				n.Right = r
			}
		}

		if et == TSTRING {
			if iscmp[n.Op] {
				// TODO(marvin): Fix Node.EType type union.
				n.Etype = types.EType(n.Op)
				n.Op = OCMPSTR
			} else if n.Op == OADD {
				// create OADDSTR node with list of strings in x + y + z + (w + v) + ...
				n.Op = OADDSTR

				if l.Op == OADDSTR {
					n.List.Set(l.List.Slice())
				} else {
					n.List.Set1(l)
				}
				if r.Op == OADDSTR {
					n.List.AppendNodes(&r.List)
				} else {
					n.List.Append(r)
				}
				n.Left = nil
				n.Right = nil
			}
		}

		if et == TINTER {
			if l.Op == OLITERAL && l.Val().Ctype() == CTNIL {
				// swap for back end
				n.Left = r

				n.Right = l
			} else if r.Op == OLITERAL && r.Val().Ctype() == CTNIL {
			} else // leave alone for back end
			if r.Type.IsInterface() == l.Type.IsInterface() {
				// TODO(marvin): Fix Node.EType type union.
				n.Etype = types.EType(n.Op)
				n.Op = OCMPIFACE
			}
		}

		if (op == ODIV || op == OMOD) && Isconst(r, CTINT) {
			if r.Val().U.(*Mpint).CmpInt64(0) == 0 {
				yyerror("division by zero")
				n.Type = nil
				return n
			}
		}

		n.Type = t
		break OpSwitch

	case OCOM, OMINUS, ONOT, OPLUS:
		ok |= Erv
		n.Left = typecheck(n.Left, Erv)
		l := n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if !okfor[n.Op][t.Etype] {
			yyerror("invalid operation: %v %v", n.Op, t)
			n.Type = nil
			return n
		}

		n.Type = t
		break OpSwitch

	// exprs
	case OADDR:
		ok |= Erv

		n.Left = typecheck(n.Left, Erv)
		if n.Left.Type == nil {
			n.Type = nil
			return n
		}
		checklvalue(n.Left, "take the address of")
		r := outervalue(n.Left)
		var l *Node
		for l = n.Left; l != r; l = l.Left {
			l.SetAddrtaken(true)
			if l.IsClosureVar() && !capturevarscomplete {
				// Mark the original variable as Addrtaken so that capturevars
				// knows not to pass it by value.
				// But if the capturevars phase is complete, don't touch it,
				// in case l.Name's containing function has not yet been compiled.
				l.Name.Defn.SetAddrtaken(true)
			}
		}

		if l.Orig != l && l.Op == ONAME {
			Fatalf("found non-orig name node %v", l)
		}
		l.SetAddrtaken(true)
		if l.IsClosureVar() && !capturevarscomplete {
			// See comments above about closure variables.
			l.Name.Defn.SetAddrtaken(true)
		}
		n.Left = defaultlit(n.Left, nil)
		l = n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		n.Type = types.NewPtr(t)
		break OpSwitch

	case OCOMPLIT:
		ok |= Erv
		n = typecheckcomplit(n)
		if n.Type == nil {
			return n
		}
		break OpSwitch

	case OXDOT, ODOT:
		if n.Op == OXDOT {
			n = adddot(n)
			n.Op = ODOT
			if n.Left == nil {
				n.Type = nil
				return n
			}
		}

		n.Left = typecheck(n.Left, Erv|Etype)

		n.Left = defaultlit(n.Left, nil)

		t := n.Left.Type
		if t == nil {
			adderrorname(n)
			n.Type = nil
			return n
		}

		s := n.Sym

		if n.Left.Op == OTYPE {
			if !looktypedot(n, t, 0) {
				if looktypedot(n, t, 1) {
					yyerror("%v undefined (cannot refer to unexported method %v)", n, n.Sym)
				} else {
					yyerror("%v undefined (type %v has no method %v)", n, t, n.Sym)
				}
				n.Type = nil
				return n
			}

			if n.Type.Etype != TFUNC || !n.IsMethod() {
				yyerror("type %v has no method %S", n.Left.Type, n.Sym)
				n.Type = nil
				return n
			}

			n.Op = ONAME
			if n.Name == nil {
				n.Name = new(Name)
			}
			n.Right = newname(n.Sym)
			n.Type = methodfunc(n.Type, n.Left.Type)
			n.Xoffset = 0
			n.SetClass(PFUNC)
			ok = Erv
			break OpSwitch
		}

		if t.IsPtr() && !t.Elem().IsInterface() {
			t = t.Elem()
			if t == nil {
				n.Type = nil
				return n
			}
			n.Op = ODOTPTR
			checkwidth(t)
		}

		if n.Sym.IsBlank() {
			yyerror("cannot refer to blank field or method")
			n.Type = nil
			return n
		}

		if lookdot(n, t, 0) == nil {
			// Legitimate field or method lookup failed, try to explain the error
			switch {
			case t.IsEmptyInterface():
				yyerror("%v undefined (type %v is interface with no methods)", n, n.Left.Type)

			case t.IsPtr() && t.Elem().IsInterface():
				// Pointer to interface is almost always a mistake.
				yyerror("%v undefined (type %v is pointer to interface, not interface)", n, n.Left.Type)

			case lookdot(n, t, 1) != nil:
				// Field or method matches by name, but it is not exported.
				yyerror("%v undefined (cannot refer to unexported field or method %v)", n, n.Sym)

			default:
				if mt := lookdot(n, t, 2); mt != nil { // Case-insensitive lookup.
					yyerror("%v undefined (type %v has no field or method %v, but does have %v)", n, n.Left.Type, n.Sym, mt.Sym)
				} else {
					yyerror("%v undefined (type %v has no field or method %v)", n, n.Left.Type, n.Sym)
				}
			}
			n.Type = nil
			return n
		}

		switch n.Op {
		case ODOTINTER, ODOTMETH:
			if top&Ecall != 0 {
				ok |= Ecall
			} else {
				typecheckpartialcall(n, s)
				ok |= Erv
			}

		default:
			ok |= Erv
		}

		break OpSwitch

	case ODOTTYPE:
		ok |= Erv
		n.Left = typecheck(n.Left, Erv)
		n.Left = defaultlit(n.Left, nil)
		l := n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if !t.IsInterface() {
			yyerror("invalid type assertion: %v (non-interface type %v on left)", n, t)
			n.Type = nil
			return n
		}

		if n.Right != nil {
			n.Right = typecheck(n.Right, Etype)
			n.Type = n.Right.Type
			n.Right = nil
			if n.Type == nil {
				return n
			}
		}

		if n.Type != nil && !n.Type.IsInterface() {
			var missing, have *types.Field
			var ptr int
			if !implements(n.Type, t, &missing, &have, &ptr) {
				if have != nil && have.Sym == missing.Sym {
					yyerror("impossible type assertion:\n\t%v does not implement %v (wrong type for %v method)\n"+
						"\t\thave %v%0S\n\t\twant %v%0S", n.Type, t, missing.Sym, have.Sym, have.Type, missing.Sym, missing.Type)
				} else if ptr != 0 {
					yyerror("impossible type assertion:\n\t%v does not implement %v (%v method has pointer receiver)", n.Type, t, missing.Sym)
				} else if have != nil {
					yyerror("impossible type assertion:\n\t%v does not implement %v (missing %v method)\n"+
						"\t\thave %v%0S\n\t\twant %v%0S", n.Type, t, missing.Sym, have.Sym, have.Type, missing.Sym, missing.Type)
				} else {
					yyerror("impossible type assertion:\n\t%v does not implement %v (missing %v method)", n.Type, t, missing.Sym)
				}
				n.Type = nil
				return n
			}
		}

		break OpSwitch

	case OINDEX:
		ok |= Erv
		n.Left = typecheck(n.Left, Erv)
		n.Left = defaultlit(n.Left, nil)
		n.Left = implicitstar(n.Left)
		l := n.Left
		n.Right = typecheck(n.Right, Erv)
		r := n.Right
		t := l.Type
		if t == nil || r.Type == nil {
			n.Type = nil
			return n
		}
		switch t.Etype {
		default:
			yyerror("invalid operation: %v (type %v does not support indexing)", n, t)
			n.Type = nil
			return n

		case TSTRING, TARRAY, TSLICE:
			n.Right = indexlit(n.Right)
			if t.IsString() {
				n.Type = types.Bytetype
			} else {
				n.Type = t.Elem()
			}
			why := "string"
			if t.IsArray() {
				why = "array"
			} else if t.IsSlice() {
				why = "slice"
			}

			if n.Right.Type != nil && !n.Right.Type.IsInteger() {
				yyerror("non-integer %s index %v", why, n.Right)
				break
			}

			if !n.Bounded() && Isconst(n.Right, CTINT) {
				x := n.Right.Int64()
				if x < 0 {
					yyerror("invalid %s index %v (index must be non-negative)", why, n.Right)
				} else if t.IsArray() && x >= t.NumElem() {
					yyerror("invalid array index %v (out of bounds for %d-element array)", n.Right, t.NumElem())
				} else if Isconst(n.Left, CTSTR) && x >= int64(len(n.Left.Val().U.(string))) {
					yyerror("invalid string index %v (out of bounds for %d-byte string)", n.Right, len(n.Left.Val().U.(string)))
				} else if n.Right.Val().U.(*Mpint).Cmp(maxintval[TINT]) > 0 {
					yyerror("invalid %s index %v (index too large)", why, n.Right)
				}
			}

		case TMAP:
			n.Etype = 0
			n.Right = defaultlit(n.Right, t.Key())
			if n.Right.Type != nil {
				n.Right = assignconv(n.Right, t.Key(), "map index")
			}
			n.Type = t.Val()
			n.Op = OINDEXMAP
		}

		break OpSwitch

	case ORECV:
		ok |= Etop | Erv
		n.Left = typecheck(n.Left, Erv)
		n.Left = defaultlit(n.Left, nil)
		l := n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if !t.IsChan() {
			yyerror("invalid operation: %v (receive from non-chan type %v)", n, t)
			n.Type = nil
			return n
		}

		if !t.ChanDir().CanRecv() {
			yyerror("invalid operation: %v (receive from send-only type %v)", n, t)
			n.Type = nil
			return n
		}

		n.Type = t.Elem()
		break OpSwitch

	case OSEND:
		ok |= Etop
		n.Left = typecheck(n.Left, Erv)
		l := n.Left
		n.Right = typecheck(n.Right, Erv)
		n.Left = defaultlit(n.Left, nil)
		l = n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if !t.IsChan() {
			yyerror("invalid operation: %v (send to non-chan type %v)", n, t)
			n.Type = nil
			return n
		}

		if !t.ChanDir().CanSend() {
			yyerror("invalid operation: %v (send to receive-only type %v)", n, t)
			n.Type = nil
			return n
		}

		n.Right = defaultlit(n.Right, t.Elem())
		r := n.Right
		if r.Type == nil {
			n.Type = nil
			return n
		}
		n.Right = assignconv(r, l.Type.Elem(), "send")

		// TODO: more aggressive
		n.Etype = 0

		n.Type = nil
		break OpSwitch

	case OSLICE, OSLICE3:
		ok |= Erv
		n.Left = typecheck(n.Left, Erv)
		low, high, max := n.SliceBounds()
		hasmax := n.Op.IsSlice3()
		low = typecheck(low, Erv)
		high = typecheck(high, Erv)
		max = typecheck(max, Erv)
		n.Left = defaultlit(n.Left, nil)
		low = indexlit(low)
		high = indexlit(high)
		max = indexlit(max)
		n.SetSliceBounds(low, high, max)
		l := n.Left
		if l.Type == nil {
			n.Type = nil
			return n
		}
		if l.Type.IsArray() {
			if !islvalue(n.Left) {
				yyerror("invalid operation %v (slice of unaddressable value)", n)
				n.Type = nil
				return n
			}

			n.Left = nod(OADDR, n.Left, nil)
			n.Left.SetImplicit(true)
			n.Left = typecheck(n.Left, Erv)
			l = n.Left
		}
		t := l.Type
		var tp *types.Type
		if t.IsString() {
			if hasmax {
				yyerror("invalid operation %v (3-index slice of string)", n)
				n.Type = nil
				return n
			}
			n.Type = t
			n.Op = OSLICESTR
		} else if t.IsPtr() && t.Elem().IsArray() {
			tp = t.Elem()
			n.Type = types.NewSlice(tp.Elem())
			dowidth(n.Type)
			if hasmax {
				n.Op = OSLICE3ARR
			} else {
				n.Op = OSLICEARR
			}
		} else if t.IsSlice() {
			n.Type = t
		} else {
			yyerror("cannot slice %v (type %v)", l, t)
			n.Type = nil
			return n
		}

		if low != nil && !checksliceindex(l, low, tp) {
			n.Type = nil
			return n
		}
		if high != nil && !checksliceindex(l, high, tp) {
			n.Type = nil
			return n
		}
		if max != nil && !checksliceindex(l, max, tp) {
			n.Type = nil
			return n
		}
		if !checksliceconst(low, high) || !checksliceconst(low, max) || !checksliceconst(high, max) {
			n.Type = nil
			return n
		}
		break OpSwitch

	// call and call like
	case OCALL:
		n.Left = typecheck(n.Left, Erv|Etype|Ecall)
		if n.Left.Diag() {
			n.SetDiag(true)
		}

		l := n.Left

		if l.Op == ONAME && l.Etype != 0 {
			// TODO(marvin): Fix Node.EType type union.
			if n.Isddd() && Op(l.Etype) != OAPPEND {
				yyerror("invalid use of ... with builtin %v", l)
			}

			// builtin: OLEN, OCAP, etc.
			// TODO(marvin): Fix Node.EType type union.
			n.Op = Op(l.Etype)
			n.Left = n.Right
			n.Right = nil
			n = typecheck1(n, top)
			return n
		}

		n.Left = defaultlit(n.Left, nil)
		l = n.Left
		if l.Op == OTYPE {
			if n.Isddd() || l.Type.IsDDDArray() {
				if !l.Type.Broke() {
					yyerror("invalid use of ... in type conversion to %v", l.Type)
				}
				n.SetDiag(true)
			}

			// pick off before type-checking arguments
			ok |= Erv

			// turn CALL(type, arg) into CONV(arg) w/ type
			n.Left = nil

			n.Op = OCONV
			n.Type = l.Type
			if !onearg(n, "conversion to %v", l.Type) {
				n.Type = nil
				return n
			}
			n = typecheck1(n, top)
			return n
		}

		if n.List.Len() == 1 && !n.Isddd() {
			n.List.SetFirst(typecheck(n.List.First(), Erv|Efnstruct))
		} else {
			typecheckslice(n.List.Slice(), Erv)
		}
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		checkwidth(t)

		switch l.Op {
		case ODOTINTER:
			n.Op = OCALLINTER

		case ODOTMETH:
			n.Op = OCALLMETH

			// typecheckaste was used here but there wasn't enough
			// information further down the call chain to know if we
			// were testing a method receiver for unexported fields.
			// It isn't necessary, so just do a sanity check.
			tp := t.Recv().Type

			if l.Left == nil || !eqtype(l.Left.Type, tp) {
				Fatalf("method receiver")
			}

		default:
			n.Op = OCALLFUNC
			if t.Etype != TFUNC {
				yyerror("cannot call non-function %v (type %v)", l, t)
				n.Type = nil
				return n
			}
		}

		typecheckaste(OCALL, n.Left, n.Isddd(), t.Params(), n.List, func() string { return fmt.Sprintf("argument to %v", n.Left) })
		ok |= Etop
		if t.Results().NumFields() == 0 {
			break OpSwitch
		}
		ok |= Erv
		if t.Results().NumFields() == 1 {
			n.Type = l.Type.Results().Field(0).Type

			if n.Op == OCALLFUNC && n.Left.Op == ONAME && isRuntimePkg(n.Left.Sym.Pkg) && n.Left.Sym.Name == "getg" {
				// Emit code for runtime.getg() directly instead of calling function.
				// Most such rewrites (for example the similar one for math.Sqrt) should be done in walk,
				// so that the ordering pass can make sure to preserve the semantics of the original code
				// (in particular, the exact time of the function call) by introducing temporaries.
				// In this case, we know getg() always returns the same result within a given function
				// and we want to avoid the temporaries, so we do the rewrite earlier than is typical.
				n.Op = OGETG
			}

			break OpSwitch
		}

		// multiple return
		if top&(Efnstruct|Etop) == 0 {
			yyerror("multiple-value %v() in single-value context", l)
			break OpSwitch
		}

		n.Type = l.Type.Results()

		break OpSwitch

	case OALIGNOF, OOFFSETOF, OSIZEOF:
		ok |= Erv
		if !onearg(n, "%v", n.Op) {
			n.Type = nil
			return n
		}

		// any side effects disappear; ignore init
		var r Node
		nodconst(&r, types.Types[TUINTPTR], evalunsafe(n))
		r.Orig = n
		n = &r

		break OpSwitch

	case OCAP, OLEN:
		ok |= Erv
		if !onearg(n, "%v", n.Op) {
			n.Type = nil
			return n
		}

		n.Left = typecheck(n.Left, Erv)
		n.Left = defaultlit(n.Left, nil)
		n.Left = implicitstar(n.Left)
		l := n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}

		var ok bool
		if n.Op == OLEN {
			ok = okforlen[t.Etype]
		} else {
			ok = okforcap[t.Etype]
		}
		if !ok {
			yyerror("invalid argument %L for %v", l, n.Op)
			n.Type = nil
			return n
		}

		// result might be constant
		var res int64 = -1 // valid if >= 0
		switch t.Etype {
		case TSTRING:
			if Isconst(l, CTSTR) {
				res = int64(len(l.Val().U.(string)))
			}

		case TARRAY:
			if !callrecv(l) {
				res = t.NumElem()
			}
		}
		if res >= 0 {
			var r Node
			nodconst(&r, types.Types[TINT], res)
			r.Orig = n
			n = &r
		}

		n.Type = types.Types[TINT]
		break OpSwitch

	case OREAL, OIMAG:
		ok |= Erv
		if !onearg(n, "%v", n.Op) {
			n.Type = nil
			return n
		}

		n.Left = typecheck(n.Left, Erv)
		l := n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}

		if t.Etype != TIDEAL && !t.IsComplex() {
			yyerror("invalid argument %L for %v", l, n.Op)
			n.Type = nil
			return n
		}

		// if the argument is a constant, the result is a constant
		// (any untyped numeric constant can be represented as a
		// complex number)
		if l.Op == OLITERAL {
			var re, im *Mpflt
			switch consttype(l) {
			case CTINT, CTRUNE:
				re = newMpflt()
				re.SetInt(l.Val().U.(*Mpint))
				// im = 0
			case CTFLT:
				re = l.Val().U.(*Mpflt)
				// im = 0
			case CTCPLX:
				re = &l.Val().U.(*Mpcplx).Real
				im = &l.Val().U.(*Mpcplx).Imag
			default:
				yyerror("invalid argument %L for %v", l, n.Op)
				n.Type = nil
				return n
			}
			if n.Op == OIMAG {
				if im == nil {
					im = newMpflt()
				}
				re = im
			}
			orig := n
			n = nodfltconst(re)
			n.Orig = orig
		}

		// determine result type
		et := t.Etype
		switch et {
		case TIDEAL:
			// result is ideal
		case TCOMPLEX64:
			et = TFLOAT32
		case TCOMPLEX128:
			et = TFLOAT64
		default:
			Fatalf("unexpected Etype: %v\n", et)
		}
		n.Type = types.Types[et]
		break OpSwitch

	case OCOMPLEX:
		ok |= Erv
		var r *Node
		var l *Node
		if n.List.Len() == 1 {
			typecheckslice(n.List.Slice(), Efnstruct)
			if n.List.First().Op != OCALLFUNC && n.List.First().Op != OCALLMETH {
				yyerror("invalid operation: complex expects two arguments")
				n.Type = nil
				return n
			}

			t := n.List.First().Left.Type
			if !t.IsKind(TFUNC) {
				// Bail. This error will be reported elsewhere.
				return n
			}
			if t.Results().NumFields() != 2 {
				yyerror("invalid operation: complex expects two arguments, %v returns %d results", n.List.First(), t.Results().NumFields())
				n.Type = nil
				return n
			}

			t = n.List.First().Type
			l = asNode(t.Field(0).Nname)
			r = asNode(t.Field(1).Nname)
		} else {
			if !twoarg(n) {
				n.Type = nil
				return n
			}
			n.Left = typecheck(n.Left, Erv)
			n.Right = typecheck(n.Right, Erv)
			l = n.Left
			r = n.Right
			if l.Type == nil || r.Type == nil {
				n.Type = nil
				return n
			}
			l, r = defaultlit2(l, r, false)
			if l.Type == nil || r.Type == nil {
				n.Type = nil
				return n
			}
			n.Left = l
			n.Right = r
		}

		if !eqtype(l.Type, r.Type) {
			yyerror("invalid operation: %v (mismatched types %v and %v)", n, l.Type, r.Type)
			n.Type = nil
			return n
		}

		var t *types.Type
		switch l.Type.Etype {
		default:
			yyerror("invalid operation: %v (arguments have type %v, expected floating-point)", n, l.Type)
			n.Type = nil
			return n

		case TIDEAL:
			t = types.Types[TIDEAL]

		case TFLOAT32:
			t = types.Types[TCOMPLEX64]

		case TFLOAT64:
			t = types.Types[TCOMPLEX128]
		}

		if l.Op == OLITERAL && r.Op == OLITERAL {
			// make it a complex literal
			r = nodcplxlit(l.Val(), r.Val())

			r.Orig = n
			n = r
		}

		n.Type = t
		break OpSwitch

	case OCLOSE:
		if !onearg(n, "%v", n.Op) {
			n.Type = nil
			return n
		}
		n.Left = typecheck(n.Left, Erv)
		n.Left = defaultlit(n.Left, nil)
		l := n.Left
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if !t.IsChan() {
			yyerror("invalid operation: %v (non-chan type %v)", n, t)
			n.Type = nil
			return n
		}

		if !t.ChanDir().CanSend() {
			yyerror("invalid operation: %v (cannot close receive-only channel)", n)
			n.Type = nil
			return n
		}

		ok |= Etop
		break OpSwitch

	case ODELETE:
		args := n.List
		if args.Len() == 0 {
			yyerror("missing arguments to delete")
			n.Type = nil
			return n
		}

		if args.Len() == 1 {
			yyerror("missing second (key) argument to delete")
			n.Type = nil
			return n
		}

		if args.Len() != 2 {
			yyerror("too many arguments to delete")
			n.Type = nil
			return n
		}

		ok |= Etop
		typecheckslice(args.Slice(), Erv)
		l := args.First()
		r := args.Second()
		if l.Type != nil && !l.Type.IsMap() {
			yyerror("first argument to delete must be map; have %L", l.Type)
			n.Type = nil
			return n
		}

		args.SetSecond(assignconv(r, l.Type.Key(), "delete"))
		break OpSwitch

	case OAPPEND:
		ok |= Erv
		args := n.List
		if args.Len() == 0 {
			yyerror("missing arguments to append")
			n.Type = nil
			return n
		}

		if args.Len() == 1 && !n.Isddd() {
			args.SetFirst(typecheck(args.First(), Erv|Efnstruct))
		} else {
			typecheckslice(args.Slice(), Erv)
		}

		t := args.First().Type
		if t == nil {
			n.Type = nil
			return n
		}

		// Unpack multiple-return result before type-checking.
		var funarg *types.Type
		if t.IsFuncArgStruct() {
			funarg = t
			t = t.Field(0).Type
		}

		n.Type = t
		if !t.IsSlice() {
			if Isconst(args.First(), CTNIL) {
				yyerror("first argument to append must be typed slice; have untyped nil")
				n.Type = nil
				return n
			}

			yyerror("first argument to append must be slice; have %L", t)
			n.Type = nil
			return n
		}

		if n.Isddd() {
			if args.Len() == 1 {
				yyerror("cannot use ... on first argument to append")
				n.Type = nil
				return n
			}

			if args.Len() != 2 {
				yyerror("too many arguments to append")
				n.Type = nil
				return n
			}

			if t.Elem().IsKind(TUINT8) && args.Second().Type.IsString() {
				args.SetSecond(defaultlit(args.Second(), types.Types[TSTRING]))
				break OpSwitch
			}

			args.SetSecond(assignconv(args.Second(), t.Orig, "append"))
			break OpSwitch
		}

		if funarg != nil {
			for _, t := range funarg.FieldSlice()[1:] {
				if assignop(t.Type, n.Type.Elem(), nil) == 0 {
					yyerror("cannot append %v value to []%v", t.Type, n.Type.Elem())
				}
			}
		} else {
			as := args.Slice()[1:]
			for i, n := range as {
				if n.Type == nil {
					continue
				}
				as[i] = assignconv(n, t.Elem(), "append")
				checkwidth(as[i].Type) // ensure width is calculated for backend
			}
		}

		break OpSwitch

	case OCOPY:
		ok |= Etop | Erv
		args := n.List
		if args.Len() < 2 {
			yyerror("missing arguments to copy")
			n.Type = nil
			return n
		}

		if args.Len() > 2 {
			yyerror("too many arguments to copy")
			n.Type = nil
			return n
		}

		n.Left = args.First()
		n.Right = args.Second()
		n.List.Set(nil)
		n.Type = types.Types[TINT]
		n.Left = typecheck(n.Left, Erv)
		n.Right = typecheck(n.Right, Erv)
		if n.Left.Type == nil || n.Right.Type == nil {
			n.Type = nil
			return n
		}
		n.Left = defaultlit(n.Left, nil)
		n.Right = defaultlit(n.Right, nil)
		if n.Left.Type == nil || n.Right.Type == nil {
			n.Type = nil
			return n
		}

		// copy([]byte, string)
		if n.Left.Type.IsSlice() && n.Right.Type.IsString() {
			if eqtype(n.Left.Type.Elem(), types.Bytetype) {
				break OpSwitch
			}
			yyerror("arguments to copy have different element types: %L and string", n.Left.Type)
			n.Type = nil
			return n
		}

		if !n.Left.Type.IsSlice() || !n.Right.Type.IsSlice() {
			if !n.Left.Type.IsSlice() && !n.Right.Type.IsSlice() {
				yyerror("arguments to copy must be slices; have %L, %L", n.Left.Type, n.Right.Type)
			} else if !n.Left.Type.IsSlice() {
				yyerror("first argument to copy should be slice; have %L", n.Left.Type)
			} else {
				yyerror("second argument to copy should be slice or string; have %L", n.Right.Type)
			}
			n.Type = nil
			return n
		}

		if !eqtype(n.Left.Type.Elem(), n.Right.Type.Elem()) {
			yyerror("arguments to copy have different element types: %L and %L", n.Left.Type, n.Right.Type)
			n.Type = nil
			return n
		}

		break OpSwitch

	case OCONV:
		ok |= Erv
		saveorignode(n)
		checkwidth(n.Type) // ensure width is calculated for backend
		n.Left = typecheck(n.Left, Erv)
		n.Left = convlit1(n.Left, n.Type, true, noReuse)
		t := n.Left.Type
		if t == nil || n.Type == nil {
			n.Type = nil
			return n
		}
		var why string
		n.Op = convertop(t, n.Type, &why)
		if n.Op == 0 {
			if !n.Diag() && !n.Type.Broke() {
				yyerror("cannot convert %L to type %v%s", n.Left, n.Type, why)
				n.SetDiag(true)
			}

			n.Op = OCONV
		}

		switch n.Op {
		case OCONVNOP:
			if n.Left.Op == OLITERAL {
				r := nod(OXXX, nil, nil)
				n.Op = OCONV
				n.Orig = r
				*r = *n
				n.Op = OLITERAL
				n.SetVal(n.Left.Val())
			} else if t.Etype == n.Type.Etype {
				switch t.Etype {
				case TFLOAT32, TFLOAT64, TCOMPLEX64, TCOMPLEX128:
					// Floating point casts imply rounding and
					// so the conversion must be kept.
					n.Op = OCONV
				}
			}

		// do not use stringtoarraylit.
		// generated code and compiler memory footprint is better without it.
		case OSTRARRAYBYTE:
			break

		case OSTRARRAYRUNE:
			if n.Left.Op == OLITERAL {
				n = stringtoarraylit(n)
			}
		}

		break OpSwitch

	case OMAKE:
		ok |= Erv
		args := n.List.Slice()
		if len(args) == 0 {
			yyerror("missing argument to make")
			n.Type = nil
			return n
		}

		n.List.Set(nil)
		l := args[0]
		l = typecheck(l, Etype)
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}

		i := 1
		switch t.Etype {
		default:
			yyerror("cannot make type %v", t)
			n.Type = nil
			return n

		case TSLICE:
			if i >= len(args) {
				yyerror("missing len argument to make(%v)", t)
				n.Type = nil
				return n
			}

			l = args[i]
			i++
			l = typecheck(l, Erv)
			var r *Node
			if i < len(args) {
				r = args[i]
				i++
				r = typecheck(r, Erv)
			}

			if l.Type == nil || (r != nil && r.Type == nil) {
				n.Type = nil
				return n
			}
			if !checkmake(t, "len", l) || r != nil && !checkmake(t, "cap", r) {
				n.Type = nil
				return n
			}
			if Isconst(l, CTINT) && r != nil && Isconst(r, CTINT) && l.Val().U.(*Mpint).Cmp(r.Val().U.(*Mpint)) > 0 {
				yyerror("len larger than cap in make(%v)", t)
				n.Type = nil
				return n
			}

			n.Left = l
			n.Right = r
			n.Op = OMAKESLICE

		case TMAP:
			if i < len(args) {
				l = args[i]
				i++
				l = typecheck(l, Erv)
				l = defaultlit(l, types.Types[TINT])
				if l.Type == nil {
					n.Type = nil
					return n
				}
				if !checkmake(t, "size", l) {
					n.Type = nil
					return n
				}
				n.Left = l
			} else {
				n.Left = nodintconst(0)
			}
			n.Op = OMAKEMAP

		case TCHAN:
			l = nil
			if i < len(args) {
				l = args[i]
				i++
				l = typecheck(l, Erv)
				l = defaultlit(l, types.Types[TINT])
				if l.Type == nil {
					n.Type = nil
					return n
				}
				if !checkmake(t, "buffer", l) {
					n.Type = nil
					return n
				}
				n.Left = l
			} else {
				n.Left = nodintconst(0)
			}
			n.Op = OMAKECHAN
		}

		if i < len(args) {
			yyerror("too many arguments to make(%v)", t)
			n.Op = OMAKE
			n.Type = nil
			return n
		}

		n.Type = t
		break OpSwitch

	case ONEW:
		ok |= Erv
		args := n.List
		if args.Len() == 0 {
			yyerror("missing argument to new")
			n.Type = nil
			return n
		}

		l := args.First()
		l = typecheck(l, Etype)
		t := l.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if args.Len() > 1 {
			yyerror("too many arguments to new(%v)", t)
			n.Type = nil
			return n
		}

		n.Left = l
		n.Type = types.NewPtr(t)
		break OpSwitch

	case OPRINT, OPRINTN:
		ok |= Etop
		typecheckslice(n.List.Slice(), Erv)
		ls := n.List.Slice()
		for i1, n1 := range ls {
			// Special case for print: int constant is int64, not int.
			if Isconst(n1, CTINT) {
				ls[i1] = defaultlit(ls[i1], types.Types[TINT64])
			} else {
				ls[i1] = defaultlit(ls[i1], nil)
			}
		}

		break OpSwitch

	case OPANIC:
		ok |= Etop
		if !onearg(n, "panic") {
			n.Type = nil
			return n
		}
		n.Left = typecheck(n.Left, Erv)
		n.Left = defaultlit(n.Left, types.Types[TINTER])
		if n.Left.Type == nil {
			n.Type = nil
			return n
		}
		break OpSwitch

	case ORECOVER:
		ok |= Erv | Etop
		if n.List.Len() != 0 {
			yyerror("too many arguments to recover")
			n.Type = nil
			return n
		}

		n.Type = types.Types[TINTER]
		break OpSwitch

	case OCLOSURE:
		ok |= Erv
		typecheckclosure(n, top)
		if n.Type == nil {
			return n
		}
		break OpSwitch

	case OITAB:
		ok |= Erv
		n.Left = typecheck(n.Left, Erv)
		t := n.Left.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if !t.IsInterface() {
			Fatalf("OITAB of %v", t)
		}
		n.Type = types.NewPtr(types.Types[TUINTPTR])
		break OpSwitch

	case OIDATA:
		// Whoever creates the OIDATA node must know a priori the concrete type at that moment,
		// usually by just having checked the OITAB.
		Fatalf("cannot typecheck interface data %v", n)
		break OpSwitch

	case OSPTR:
		ok |= Erv
		n.Left = typecheck(n.Left, Erv)
		t := n.Left.Type
		if t == nil {
			n.Type = nil
			return n
		}
		if !t.IsSlice() && !t.IsString() {
			Fatalf("OSPTR of %v", t)
		}
		if t.IsString() {
			n.Type = types.NewPtr(types.Types[TUINT8])
		} else {
			n.Type = types.NewPtr(t.Elem())
		}
		break OpSwitch

	case OCLOSUREVAR:
		ok |= Erv
		break OpSwitch

	case OCFUNC:
		ok |= Erv
		n.Left = typecheck(n.Left, Erv)
		n.Type = types.Types[TUINTPTR]
		break OpSwitch

	case OCONVNOP:
		ok |= Erv
		n.Left = typecheck(n.Left, Erv)
		break OpSwitch

	// statements
	case OAS:
		ok |= Etop

		typecheckas(n)

		// Code that creates temps does not bother to set defn, so do it here.
		if n.Left.Op == ONAME && n.Left.IsAutoTmp() {
			n.Left.Name.Defn = n
		}
		break OpSwitch

	case OAS2:
		ok |= Etop
		typecheckas2(n)
		break OpSwitch

	case OBREAK,
		OCONTINUE,
		ODCL,
		OEMPTY,
		OGOTO,
		OXFALL,
		OVARKILL,
		OVARLIVE:
		ok |= Etop
		break OpSwitch

	case OLABEL:
		ok |= Etop
		decldepth++
		if n.Left.Sym.IsBlank() {
			// Empty identifier is valid but useless.
			// Eliminate now to simplify life later.
			// See issues 7538, 11589, 11593.
			n.Op = OEMPTY
			n.Left = nil
		}
		break OpSwitch

	case ODEFER:
		ok |= Etop
		n.Left = typecheck(n.Left, Etop|Erv)
		if !n.Left.Diag() {
			checkdefergo(n)
		}
		break OpSwitch

	case OPROC:
		ok |= Etop
		n.Left = typecheck(n.Left, Etop|Erv)
		checkdefergo(n)
		break OpSwitch

	case OFOR, OFORUNTIL:
		ok |= Etop
		typecheckslice(n.Ninit.Slice(), Etop)
		decldepth++
		n.Left = typecheck(n.Left, Erv)
		if n.Left != nil {
			t := n.Left.Type
			if t != nil && !t.IsBoolean() {
				yyerror("non-bool %L used as for condition", n.Left)
			}
		}
		n.Right = typecheck(n.Right, Etop)
		typecheckslice(n.Nbody.Slice(), Etop)
		decldepth--
		break OpSwitch

	case OIF:
		ok |= Etop
		typecheckslice(n.Ninit.Slice(), Etop)
		n.Left = typecheck(n.Left, Erv)
		if n.Left != nil {
			t := n.Left.Type
			if t != nil && !t.IsBoolean() {
				yyerror("non-bool %L used as if condition", n.Left)
			}
		}
		typecheckslice(n.Nbody.Slice(), Etop)
		typecheckslice(n.Rlist.Slice(), Etop)
		break OpSwitch

	case ORETURN:
		ok |= Etop
		if n.List.Len() == 1 {
			typecheckslice(n.List.Slice(), Erv|Efnstruct)
		} else {
			typecheckslice(n.List.Slice(), Erv)
		}
		if Curfn == nil {
			yyerror("return outside function")
			n.Type = nil
			return n
		}

		if Curfn.Type.FuncType().Outnamed && n.List.Len() == 0 {
			break OpSwitch
		}
		typecheckaste(ORETURN, nil, false, Curfn.Type.Results(), n.List, func() string { return "return argument" })
		break OpSwitch

	case ORETJMP:
		ok |= Etop
		break OpSwitch

	case OSELECT:
		ok |= Etop
		typecheckselect(n)
		break OpSwitch

	case OSWITCH:
		ok |= Etop
		typecheckswitch(n)
		break OpSwitch

	case ORANGE:
		ok |= Etop
		typecheckrange(n)
		break OpSwitch

	case OTYPESW:
		yyerror("use of .(type) outside type switch")
		n.Type = nil
		return n

	case OXCASE:
		ok |= Etop
		typecheckslice(n.List.Slice(), Erv)
		typecheckslice(n.Nbody.Slice(), Etop)
		break OpSwitch

	case ODCLFUNC:
		ok |= Etop
		typecheckfunc(n)
		break OpSwitch

	case ODCLCONST:
		ok |= Etop
		n.Left = typecheck(n.Left, Erv)
		break OpSwitch

	case ODCLTYPE:
		ok |= Etop
		n.Left = typecheck(n.Left, Etype)
		checkwidth(n.Left.Type)
		if n.Left.Type != nil && n.Left.Type.NotInHeap() && n.Left.Name.Param.Pragma&NotInHeap == 0 {
			// The type contains go:notinheap types, so it
			// must be marked as such (alternatively, we
			// could silently propagate go:notinheap).
			yyerror("type %v must be go:notinheap", n.Left.Type)
		}
		break OpSwitch
	}

	t := n.Type
	if t != nil && !t.IsFuncArgStruct() && n.Op != OTYPE {
		switch t.Etype {
		case TFUNC, // might have TANY; wait until it's called
			TANY, TFORW, TIDEAL, TNIL, TBLANK:
			break

		default:
			checkwidth(t)
		}
	}

	if safemode && !inimport && compiling_wrappers == 0 && t != nil && t.Etype == TUNSAFEPTR {
		yyerror("cannot use unsafe.Pointer")
	}

	evconst(n)
	if n.Op == OTYPE && top&Etype == 0 {
		if !n.Type.Broke() {
			yyerror("type %v is not an expression", n.Type)
		}
		n.Type = nil
		return n
	}

	if top&(Erv|Etype) == Etype && n.Op != OTYPE {
		yyerror("%v is not a type", n)
		n.Type = nil
		return n
	}

	// TODO(rsc): simplify
	if (top&(Ecall|Erv|Etype) != 0) && top&Etop == 0 && ok&(Erv|Etype|Ecall) == 0 {
		yyerror("%v used as value", n)
		n.Type = nil
		return n
	}

	if (top&Etop != 0) && top&(Ecall|Erv|Etype) == 0 && ok&Etop == 0 {
		if !n.Diag() {
			yyerror("%v evaluated but not used", n)
			n.SetDiag(true)
		}

		n.Type = nil
		return n
	}

	return n
}

func checksliceindex(l *Node, r *Node, tp *types.Type) bool {
	t := r.Type
	if t == nil {
		return false
	}
	if !t.IsInteger() {
		yyerror("invalid slice index %v (type %v)", r, t)
		return false
	}

	if r.Op == OLITERAL {
		if r.Int64() < 0 {
			yyerror("invalid slice index %v (index must be non-negative)", r)
			return false
		} else if tp != nil && tp.NumElem() >= 0 && r.Int64() > tp.NumElem() {
			yyerror("invalid slice index %v (out of bounds for %d-element array)", r, tp.NumElem())
			return false
		} else if Isconst(l, CTSTR) && r.Int64() > int64(len(l.Val().U.(string))) {
			yyerror("invalid slice index %v (out of bounds for %d-byte string)", r, len(l.Val().U.(string)))
			return false
		} else if r.Val().U.(*Mpint).Cmp(maxintval[TINT]) > 0 {
			yyerror("invalid slice index %v (index too large)", r)
			return false
		}
	}

	return true
}

func checksliceconst(lo *Node, hi *Node) bool {
	if lo != nil && hi != nil && lo.Op == OLITERAL && hi.Op == OLITERAL && lo.Val().U.(*Mpint).Cmp(hi.Val().U.(*Mpint)) > 0 {
		yyerror("invalid slice index: %v > %v", lo, hi)
		return false
	}

	return true
}

func checkdefergo(n *Node) {
	what := "defer"
	if n.Op == OPROC {
		what = "go"
	}

	switch n.Left.Op {
	// ok
	case OCALLINTER,
		OCALLMETH,
		OCALLFUNC,
		OCLOSE,
		OCOPY,
		ODELETE,
		OPANIC,
		OPRINT,
		OPRINTN,
		ORECOVER:
		return

	case OAPPEND,
		OCAP,
		OCOMPLEX,
		OIMAG,
		OLEN,
		OMAKE,
		OMAKESLICE,
		OMAKECHAN,
		OMAKEMAP,
		ONEW,
		OREAL,
		OLITERAL: // conversion or unsafe.Alignof, Offsetof, Sizeof
		if n.Left.Orig != nil && n.Left.Orig.Op == OCONV {
			break
		}
		yyerror("%s discards result of %v", what, n.Left)
		return
	}

	// type is broken or missing, most likely a method call on a broken type
	// we will warn about the broken type elsewhere. no need to emit a potentially confusing error
	if n.Left.Type == nil || n.Left.Type.Broke() {
		return
	}

	if !n.Diag() {
		// The syntax made sure it was a call, so this must be
		// a conversion.
		n.SetDiag(true)
		yyerror("%s requires function call, not conversion", what)
	}
}

// The result of implicitstar MUST be assigned back to n, e.g.
// 	n.Left = implicitstar(n.Left)
func implicitstar(n *Node) *Node {
	// insert implicit * if needed for fixed array
	t := n.Type
	if t == nil || !t.IsPtr() {
		return n
	}
	t = t.Elem()
	if t == nil {
		return n
	}
	if !t.IsArray() {
		return n
	}
	n = nod(OIND, n, nil)
	n.SetImplicit(true)
	n = typecheck(n, Erv)
	return n
}

func onearg(n *Node, f string, args ...interface{}) bool {
	if n.Left != nil {
		return true
	}
	if n.List.Len() == 0 {
		p := fmt.Sprintf(f, args...)
		yyerror("missing argument to %s: %v", p, n)
		return false
	}

	if n.List.Len() > 1 {
		p := fmt.Sprintf(f, args...)
		yyerror("too many arguments to %s: %v", p, n)
		n.Left = n.List.First()
		n.List.Set(nil)
		return false
	}

	n.Left = n.List.First()
	n.List.Set(nil)
	return true
}

func twoarg(n *Node) bool {
	if n.Left != nil {
		return true
	}
	if n.List.Len() == 0 {
		yyerror("missing argument to %v - %v", n.Op, n)
		return false
	}

	n.Left = n.List.First()
	if n.List.Len() == 1 {
		yyerror("missing argument to %v - %v", n.Op, n)
		n.List.Set(nil)
		return false
	}

	if n.List.Len() > 2 {
		yyerror("too many arguments to %v - %v", n.Op, n)
		n.List.Set(nil)
		return false
	}

	n.Right = n.List.Second()
	n.List.Set(nil)
	return true
}

func lookdot1(errnode *Node, s *types.Sym, t *types.Type, fs *types.Fields, dostrcmp int) *types.Field {
	var r *types.Field
	for _, f := range fs.Slice() {
		if dostrcmp != 0 && f.Sym.Name == s.Name {
			return f
		}
		if dostrcmp == 2 && strings.EqualFold(f.Sym.Name, s.Name) {
			return f
		}
		if f.Sym != s {
			continue
		}
		if r != nil {
			if errnode != nil {
				yyerror("ambiguous selector %v", errnode)
			} else if t.IsPtr() {
				yyerror("ambiguous selector (%v).%v", t, s)
			} else {
				yyerror("ambiguous selector %v.%v", t, s)
			}
			break
		}

		r = f
	}

	return r
}

func looktypedot(n *Node, t *types.Type, dostrcmp int) bool {
	s := n.Sym

	if t.IsInterface() {
		f1 := lookdot1(n, s, t, t.Fields(), dostrcmp)
		if f1 == nil {
			return false
		}

		n.Sym = methodsym(n.Sym, t, false)
		n.Xoffset = f1.Offset
		n.Type = f1.Type
		n.Op = ODOTINTER
		return true
	}

	// Find the base type: methtype will fail if t
	// is not of the form T or *T.
	mt := methtype(t)
	if mt == nil {
		return false
	}

	expandmeth(mt)
	f2 := lookdot1(n, s, mt, mt.AllMethods(), dostrcmp)
	if f2 == nil {
		return false
	}

	// disallow T.m if m requires *T receiver
	if f2.Type.Recv().Type.IsPtr() && !t.IsPtr() && f2.Embedded != 2 && !isifacemethod(f2.Type) {
		yyerror("invalid method expression %v (needs pointer receiver: (*%v).%S)", n, t, f2.Sym)
		return false
	}

	n.Sym = methodsym(n.Sym, t, false)
	n.Xoffset = f2.Offset
	n.Type = f2.Type
	n.Op = ODOTMETH
	return true
}

func derefall(t *types.Type) *types.Type {
	for t != nil && t.Etype == types.Tptr {
		t = t.Elem()
	}
	return t
}

type typeSymKey struct {
	t *types.Type
	s *types.Sym
}

// dotField maps (*types.Type, *types.Sym) pairs to the corresponding struct field (*types.Type with Etype==TFIELD).
// It is a cache for use during usefield in walk.go, only enabled when field tracking.
var dotField = map[typeSymKey]*types.Field{}

func lookdot(n *Node, t *types.Type, dostrcmp int) *types.Field {
	s := n.Sym

	dowidth(t)
	var f1 *types.Field
	if t.IsStruct() || t.IsInterface() {
		f1 = lookdot1(n, s, t, t.Fields(), dostrcmp)
	}

	var f2 *types.Field
	if n.Left.Type == t || n.Left.Type.Sym == nil {
		mt := methtype(t)
		if mt != nil {
			f2 = lookdot1(n, s, mt, mt.Methods(), dostrcmp)
		}
	}

	if f1 != nil {
		if dostrcmp > 1 {
			// Already in the process of diagnosing an error.
			return f1
		}
		if f2 != nil {
			yyerror("%v is both field and method", n.Sym)
		}
		if f1.Offset == BADWIDTH {
			Fatalf("lookdot badwidth %v %p", f1, f1)
		}
		n.Xoffset = f1.Offset
		n.Type = f1.Type
		if objabi.Fieldtrack_enabled > 0 {
			dotField[typeSymKey{t.Orig, s}] = f1
		}
		if t.IsInterface() {
			if n.Left.Type.IsPtr() {
				n.Left = nod(OIND, n.Left, nil) // implicitstar
				n.Left.SetImplicit(true)
				n.Left = typecheck(n.Left, Erv)
			}

			n.Op = ODOTINTER
		}

		return f1
	}

	if f2 != nil {
		if dostrcmp > 1 {
			// Already in the process of diagnosing an error.
			return f2
		}
		tt := n.Left.Type
		dowidth(tt)
		rcvr := f2.Type.Recv().Type
		if !eqtype(rcvr, tt) {
			if rcvr.Etype == types.Tptr && eqtype(rcvr.Elem(), tt) {
				checklvalue(n.Left, "call pointer method on")
				n.Left = nod(OADDR, n.Left, nil)
				n.Left.SetImplicit(true)
				n.Left = typecheck(n.Left, Etype|Erv)
			} else if tt.Etype == types.Tptr && rcvr.Etype != types.Tptr && eqtype(tt.Elem(), rcvr) {
				n.Left = nod(OIND, n.Left, nil)
				n.Left.SetImplicit(true)
				n.Left = typecheck(n.Left, Etype|Erv)
			} else if tt.Etype == types.Tptr && tt.Elem().Etype == types.Tptr && eqtype(derefall(tt), derefall(rcvr)) {
				yyerror("calling method %v with receiver %L requires explicit dereference", n.Sym, n.Left)
				for tt.Etype == types.Tptr {
					// Stop one level early for method with pointer receiver.
					if rcvr.Etype == types.Tptr && tt.Elem().Etype != types.Tptr {
						break
					}
					n.Left = nod(OIND, n.Left, nil)
					n.Left.SetImplicit(true)
					n.Left = typecheck(n.Left, Etype|Erv)
					tt = tt.Elem()
				}
			} else {
				Fatalf("method mismatch: %v for %v", rcvr, tt)
			}
		}

		pll := n
		ll := n.Left
		for ll.Left != nil && (ll.Op == ODOT || ll.Op == ODOTPTR || ll.Op == OIND) {
			pll = ll
			ll = ll.Left
		}
		if pll.Implicit() && ll.Type.IsPtr() && ll.Type.Sym != nil && asNode(ll.Type.Sym.Def) != nil && asNode(ll.Type.Sym.Def).Op == OTYPE {
			// It is invalid to automatically dereference a named pointer type when selecting a method.
			// Make n.Left == ll to clarify error message.
			n.Left = ll
			return nil
		}

		n.Sym = methodsym(n.Sym, n.Left.Type, false)
		n.Xoffset = f2.Offset
		n.Type = f2.Type

		n.Op = ODOTMETH

		return f2
	}

	return nil
}

func nokeys(l Nodes) bool {
	for _, n := range l.Slice() {
		if n.Op == OKEY || n.Op == OSTRUCTKEY {
			return false
		}
	}
	return true
}

func hasddd(t *types.Type) bool {
	for _, tl := range t.Fields().Slice() {
		if tl.Isddd() {
			return true
		}
	}

	return false
}

// typecheck assignment: type list = expression list
func typecheckaste(op Op, call *Node, isddd bool, tstruct *types.Type, nl Nodes, desc func() string) {
	var t *types.Type
	var n *Node
	var n1 int
	var n2 int
	var i int

	lno := lineno

	if tstruct.Broke() {
		goto out
	}

	n = nil
	if nl.Len() == 1 {
		n = nl.First()
		if n.Type != nil {
			if n.Type.IsFuncArgStruct() {
				if !hasddd(tstruct) {
					n1 := tstruct.NumFields()
					n2 := n.Type.NumFields()
					if n2 > n1 {
						goto toomany
					}
					if n2 < n1 {
						goto notenough
					}
				}

				lfs := tstruct.FieldSlice()
				rfs := n.Type.FieldSlice()
				var why string
				for i, tl := range lfs {
					if tl.Isddd() {
						for _, tn := range rfs[i:] {
							if assignop(tn.Type, tl.Type.Elem(), &why) == 0 {
								if call != nil {
									yyerror("cannot use %v as type %v in argument to %v%s", tn.Type, tl.Type.Elem(), call, why)
								} else {
									yyerror("cannot use %v as type %v in %s%s", tn.Type, tl.Type.Elem(), desc(), why)
								}
							}
						}
						goto out
					}

					if i >= len(rfs) {
						goto notenough
					}
					tn := rfs[i]
					if assignop(tn.Type, tl.Type, &why) == 0 {
						if call != nil {
							yyerror("cannot use %v as type %v in argument to %v%s", tn.Type, tl.Type, call, why)
						} else {
							yyerror("cannot use %v as type %v in %s%s", tn.Type, tl.Type, desc(), why)
						}
					}
				}

				if len(rfs) > len(lfs) {
					goto toomany
				}
				goto out
			}
		}
	}

	n1 = tstruct.NumFields()
	n2 = nl.Len()
	if !hasddd(tstruct) {
		if n2 > n1 {
			goto toomany
		}
		if n2 < n1 {
			goto notenough
		}
	} else {
		if !isddd {
			if n2 < n1-1 {
				goto notenough
			}
		} else {
			if n2 > n1 {
				goto toomany
			}
			if n2 < n1 {
				goto notenough
			}
		}
	}

	i = 0
	for _, tl := range tstruct.Fields().Slice() {
		t = tl.Type
		if tl.Isddd() {
			if isddd {
				if i >= nl.Len() {
					goto notenough
				}
				if nl.Len()-i > 1 {
					goto toomany
				}
				n = nl.Index(i)
				setlineno(n)
				if n.Type != nil {
					nl.SetIndex(i, assignconvfn(n, t, desc))
				}
				goto out
			}

			for ; i < nl.Len(); i++ {
				n = nl.Index(i)
				setlineno(n)
				if n.Type != nil {
					nl.SetIndex(i, assignconvfn(n, t.Elem(), desc))
				}
			}

			goto out
		}

		if i >= nl.Len() {
			goto notenough
		}
		n = nl.Index(i)
		setlineno(n)
		if n.Type != nil {
			nl.SetIndex(i, assignconvfn(n, t, desc))
		}
		i++
	}

	if i < nl.Len() {
		goto toomany
	}
	if isddd {
		if call != nil {
			yyerror("invalid use of ... in call to %v", call)
		} else {
			yyerror("invalid use of ... in %v", op)
		}
	}

out:
	lineno = lno
	return

notenough:
	if n == nil || !n.Diag() {
		details := errorDetails(nl, tstruct, isddd)
		if call != nil {
			// call is the expression being called, not the overall call.
			// Method expressions have the form T.M, and the compiler has
			// rewritten those to ONAME nodes but left T in Left.
			if call.Op == ONAME && call.Left != nil && call.Left.Op == OTYPE {
				yyerror("not enough arguments in call to method expression %v%s", call, details)
			} else {
				yyerror("not enough arguments in call to %v%s", call, details)
			}
		} else {
			yyerror("not enough arguments to %v%s", op, details)
		}
		if n != nil {
			n.SetDiag(true)
		}
	}

	goto out

toomany:
	details := errorDetails(nl, tstruct, isddd)
	if call != nil {
		yyerror("too many arguments in call to %v%s", call, details)
	} else {
		yyerror("too many arguments to %v%s", op, details)
	}
	goto out
}

func errorDetails(nl Nodes, tstruct *types.Type, isddd bool) string {
	// If we don't know any type at a call site, let's suppress any return
	// message signatures. See Issue https://golang.org/issues/19012.
	if tstruct == nil {
		return ""
	}
	// If any node has an unknown type, suppress it as well
	for _, n := range nl.Slice() {
		if n.Type == nil {
			return ""
		}
	}
	return fmt.Sprintf("\n\thave %s\n\twant %v", nl.retsigerr(isddd), tstruct)
}

// sigrepr is a type's representation to the outside world,
// in string representations of return signatures
// e.g in error messages about wrong arguments to return.
func sigrepr(t *types.Type) string {
	switch t {
	default:
		return t.String()

	case types.Types[TIDEAL]:
		// "untyped number" is not commonly used
		// outside of the compiler, so let's use "number".
		return "number"

	case types.Idealstring:
		return "string"

	case types.Idealbool:
		return "bool"
	}
}

// retsigerr returns the signature of the types
// at the respective return call site of a function.
func (nl Nodes) retsigerr(isddd bool) string {
	if nl.Len() < 1 {
		return "()"
	}

	var typeStrings []string
	if nl.Len() == 1 && nl.First().Type != nil && nl.First().Type.IsFuncArgStruct() {
		for _, f := range nl.First().Type.Fields().Slice() {
			typeStrings = append(typeStrings, sigrepr(f.Type))
		}
	} else {
		for _, n := range nl.Slice() {
			typeStrings = append(typeStrings, sigrepr(n.Type))
		}
	}

	ddd := ""
	if isddd {
		ddd = "..."
	}
	return fmt.Sprintf("(%s%s)", strings.Join(typeStrings, ", "), ddd)
}

// type check composite
func fielddup(name string, hash map[string]bool) {
	if hash[name] {
		yyerror("duplicate field name in struct literal: %s", name)
		return
	}
	hash[name] = true
}

func keydup(n *Node, hash map[uint32][]*Node) {
	orign := n
	if n.Op == OCONVIFACE {
		n = n.Left
	}
	evconst(n)
	if n.Op != OLITERAL {
		return // we don't check variables
	}

	const PRIME1 = 3

	var h uint32
	switch v := n.Val().U.(type) {
	default: // unknown, bool, nil
		h = 23

	case *Mpint:
		h = uint32(v.Int64())

	case *Mpflt:
		x := math.Float64bits(v.Float64())
		for i := 0; i < 8; i++ {
			h = h*PRIME1 + uint32(x&0xFF)
			x >>= 8
		}

	case string:
		for i := 0; i < len(v); i++ {
			h = h*PRIME1 + uint32(v[i])
		}
	}

	var cmp Node
	for _, a := range hash[h] {
		cmp.Op = OEQ
		cmp.Left = n
		if a.Op == OCONVIFACE && orign.Op == OCONVIFACE {
			a = a.Left
		}
		if !eqtype(a.Type, n.Type) {
			continue
		}
		cmp.Right = a
		evconst(&cmp)
		if cmp.Op != OLITERAL {
			// Sometimes evconst fails. See issue 12536.
			continue
		}
		if cmp.Val().U.(bool) {
			yyerror("duplicate key %v in map literal", n)
			return
		}
	}

	hash[h] = append(hash[h], orign)
}

// iscomptype reports whether type t is a composite literal type
// or a pointer to one.
func iscomptype(t *types.Type) bool {
	if t.IsPtr() {
		t = t.Elem()
	}

	switch t.Etype {
	case TARRAY, TSLICE, TSTRUCT, TMAP:
		return true
	default:
		return false
	}
}

func pushtype(n *Node, t *types.Type) {
	if n == nil || n.Op != OCOMPLIT || !iscomptype(t) {
		return
	}

	if n.Right == nil {
		n.Right = typenod(t)
		n.SetImplicit(true)       // don't print
		n.Right.SetImplicit(true) // * is okay
	} else if Debug['s'] != 0 {
		n.Right = typecheck(n.Right, Etype)
		if n.Right.Type != nil && eqtype(n.Right.Type, t) {
			fmt.Printf("%v: redundant type: %v\n", n.Line(), t)
		}
	}
}

// The result of typecheckcomplit MUST be assigned back to n, e.g.
// 	n.Left = typecheckcomplit(n.Left)
func typecheckcomplit(n *Node) *Node {
	lno := lineno
	defer func() {
		lineno = lno
	}()

	if n.Right == nil {
		yyerrorl(n.Pos, "missing type in composite literal")
		n.Type = nil
		return n
	}

	// Save original node (including n.Right)
	norig := nod(n.Op, nil, nil)

	*norig = *n

	setlineno(n.Right)
	n.Right = typecheck(n.Right, Etype|Ecomplit)
	l := n.Right // sic
	t := l.Type
	if t == nil {
		n.Type = nil
		return n
	}
	nerr := nerrors
	n.Type = t

	if t.IsPtr() {
		// For better or worse, we don't allow pointers as the composite literal type,
		// except when using the &T syntax, which sets implicit on the OIND.
		if !n.Right.Implicit() {
			yyerror("invalid pointer type %v for composite literal (use &%v instead)", t, t.Elem())
			n.Type = nil
			return n
		}

		// Also, the underlying type must be a struct, map, slice, or array.
		if !iscomptype(t) {
			yyerror("invalid pointer type %v for composite literal", t)
			n.Type = nil
			return n
		}

		t = t.Elem()
	}

	switch t.Etype {
	default:
		yyerror("invalid type for composite literal: %v", t)
		n.Type = nil

	case TARRAY, TSLICE:
		// If there are key/value pairs, create a map to keep seen
		// keys so we can check for duplicate indices.
		var indices map[int64]bool
		for _, n1 := range n.List.Slice() {
			if n1.Op == OKEY {
				indices = make(map[int64]bool)
				break
			}
		}

		var length, i int64
		checkBounds := t.IsArray() && !t.IsDDDArray()
		nl := n.List.Slice()
		for i2, l := range nl {
			setlineno(l)
			vp := &nl[i2]
			if l.Op == OKEY {
				l.Left = typecheck(l.Left, Erv)
				evconst(l.Left)
				i = nonnegintconst(l.Left)
				if i < 0 && !l.Left.Diag() {
					yyerror("index must be non-negative integer constant")
					l.Left.SetDiag(true)
					i = -(1 << 30) // stay negative for a while
				}
				vp = &l.Right
			}

			if i >= 0 && indices != nil {
				if indices[i] {
					yyerror("duplicate index in array literal: %d", i)
				} else {
					indices[i] = true
				}
			}

			r := *vp
			pushtype(r, t.Elem())
			r = typecheck(r, Erv)
			r = defaultlit(r, t.Elem())
			*vp = assignconv(r, t.Elem(), "array or slice literal")

			i++
			if i > length {
				length = i
				if checkBounds && length > t.NumElem() {
					setlineno(l)
					yyerror("array index %d out of bounds [0:%d]", length-1, t.NumElem())
					checkBounds = false
				}
			}
		}

		if t.IsDDDArray() {
			t.SetNumElem(length)
		}
		if t.IsSlice() {
			n.Right = nodintconst(length)
			n.Op = OSLICELIT
		} else {
			n.Op = OARRAYLIT
		}

	case TMAP:
		hash := make(map[uint32][]*Node)
		for i3, l := range n.List.Slice() {
			setlineno(l)
			if l.Op != OKEY {
				n.List.SetIndex(i3, typecheck(n.List.Index(i3), Erv))
				yyerror("missing key in map literal")
				continue
			}

			r := l.Left
			pushtype(r, t.Key())
			r = typecheck(r, Erv)
			r = defaultlit(r, t.Key())
			l.Left = assignconv(r, t.Key(), "map key")
			if l.Left.Op != OCONV {
				keydup(l.Left, hash)
			}

			r = l.Right
			pushtype(r, t.Val())
			r = typecheck(r, Erv)
			r = defaultlit(r, t.Val())
			l.Right = assignconv(r, t.Val(), "map value")
		}

		n.Op = OMAPLIT

	case TSTRUCT:
		// Need valid field offsets for Xoffset below.
		dowidth(t)

		bad := 0
		if n.List.Len() != 0 && nokeys(n.List) {
			// simple list of variables
			ls := n.List.Slice()
			for i, n1 := range ls {
				setlineno(n1)
				n1 = typecheck(n1, Erv)
				ls[i] = n1
				if i >= t.NumFields() {
					if bad == 0 {
						yyerror("too many values in struct initializer")
					}
					bad++
					continue
				}

				f := t.Field(i)
				s := f.Sym
				if s != nil && !exportname(s.Name) && s.Pkg != localpkg {
					yyerror("implicit assignment of unexported field '%s' in %v literal", s.Name, t)
				}
				// No pushtype allowed here. Must name fields for that.
				n1 = assignconv(n1, f.Type, "field value")
				n1 = nodSym(OSTRUCTKEY, n1, f.Sym)
				n1.Xoffset = f.Offset
				ls[i] = n1
			}
			if len(ls) < t.NumFields() {
				yyerror("too few values in struct initializer")
			}
		} else {
			hash := make(map[string]bool)

			// keyed list
			ls := n.List.Slice()
			for i, l := range ls {
				setlineno(l)

				if l.Op == OKEY {
					key := l.Left

					l.Op = OSTRUCTKEY
					l.Left = l.Right
					l.Right = nil

					// An OXDOT uses the Sym field to hold
					// the field to the right of the dot,
					// so s will be non-nil, but an OXDOT
					// is never a valid struct literal key.
					if key.Sym == nil || key.Op == OXDOT || key.Sym.IsBlank() {
						yyerror("invalid field name %v in struct initializer", key)
						l.Left = typecheck(l.Left, Erv)
						continue
					}

					// Sym might have resolved to name in other top-level
					// package, because of import dot. Redirect to correct sym
					// before we do the lookup.
					s := key.Sym
					if s.Pkg != localpkg && exportname(s.Name) {
						s1 := lookup(s.Name)
						if s1.Origpkg == s.Pkg {
							s = s1
						}
					}
					l.Sym = s
				}

				if l.Op != OSTRUCTKEY {
					if bad == 0 {
						yyerror("mixture of field:value and value initializers")
					}
					bad++
					ls[i] = typecheck(ls[i], Erv)
					continue
				}

				f := lookdot1(nil, l.Sym, t, t.Fields(), 0)
				if f == nil {
					yyerror("unknown field '%v' in struct literal of type %v", l.Sym, t)
					continue
				}
				fielddup(f.Sym.Name, hash)
				l.Xoffset = f.Offset

				// No pushtype allowed here. Tried and rejected.
				l.Left = typecheck(l.Left, Erv)
				l.Left = assignconv(l.Left, f.Type, "field value")
			}
		}

		n.Op = OSTRUCTLIT
	}

	if nerr != nerrors {
		return n
	}

	n.Orig = norig
	if n.Type.IsPtr() {
		n = nod(OPTRLIT, n, nil)
		n.SetTypecheck(1)
		n.Type = n.Left.Type
		n.Left.Type = t
		n.Left.SetTypecheck(1)
	}

	n.Orig = norig
	return n
}

// lvalue etc
func islvalue(n *Node) bool {
	switch n.Op {
	case OINDEX:
		if n.Left.Type != nil && n.Left.Type.IsArray() {
			return islvalue(n.Left)
		}
		if n.Left.Type != nil && n.Left.Type.IsString() {
			return false
		}
		fallthrough
	case OIND, ODOTPTR, OCLOSUREVAR:
		return true

	case ODOT:
		return islvalue(n.Left)

	case ONAME:
		if n.Class() == PFUNC {
			return false
		}
		return true
	}

	return false
}

func checklvalue(n *Node, verb string) {
	if !islvalue(n) {
		yyerror("cannot %s %v", verb, n)
	}
}

func checkassign(stmt *Node, n *Node) {
	// Variables declared in ORANGE are assigned on every iteration.
	if n.Name == nil || n.Name.Defn != stmt || stmt.Op == ORANGE {
		r := outervalue(n)
		var l *Node
		for l = n; l != r; l = l.Left {
			l.SetAssigned(true)
			if l.IsClosureVar() {
				l.Name.Defn.SetAssigned(true)
			}
		}

		l.SetAssigned(true)
		if l.IsClosureVar() {
			l.Name.Defn.SetAssigned(true)
		}
	}

	if islvalue(n) {
		return
	}
	if n.Op == OINDEXMAP {
		n.Etype = 1
		return
	}

	// have already complained about n being invalid
	if n.Type == nil {
		return
	}

	if n.Op == ODOT && n.Left.Op == OINDEXMAP {
		yyerror("cannot assign to struct field %v in map", n)
	} else {
		yyerror("cannot assign to %v", n)
	}
	n.Type = nil
}

func checkassignlist(stmt *Node, l Nodes) {
	for _, n := range l.Slice() {
		checkassign(stmt, n)
	}
}

// Check whether l and r are the same side effect-free expression,
// so that it is safe to reuse one instead of computing both.
func samesafeexpr(l *Node, r *Node) bool {
	if l.Op != r.Op || !eqtype(l.Type, r.Type) {
		return false
	}

	switch l.Op {
	case ONAME, OCLOSUREVAR:
		return l == r

	case ODOT, ODOTPTR:
		return l.Sym != nil && r.Sym != nil && l.Sym == r.Sym && samesafeexpr(l.Left, r.Left)

	case OIND, OCONVNOP:
		return samesafeexpr(l.Left, r.Left)

	case OCONV:
		// Some conversions can't be reused, such as []byte(str).
		// Allow only numeric-ish types. This is a bit conservative.
		return issimple[l.Type.Etype] && samesafeexpr(l.Left, r.Left)

	case OINDEX:
		return samesafeexpr(l.Left, r.Left) && samesafeexpr(l.Right, r.Right)

	case OLITERAL:
		return eqval(l.Val(), r.Val())
	}

	return false
}

// type check assignment.
// if this assignment is the definition of a var on the left side,
// fill in the var's type.
func typecheckas(n *Node) {
	// delicate little dance.
	// the definition of n may refer to this assignment
	// as its definition, in which case it will call typecheckas.
	// in that case, do not call typecheck back, or it will cycle.
	// if the variable has a type (ntype) then typechecking
	// will not look at defn, so it is okay (and desirable,
	// so that the conversion below happens).
	n.Left = resolve(n.Left)

	if n.Left.Name == nil || n.Left.Name.Defn != n || n.Left.Name.Param.Ntype != nil {
		n.Left = typecheck(n.Left, Erv|Easgn)
	}

	n.Right = typecheck(n.Right, Erv)
	checkassign(n, n.Left)
	if n.Right != nil && n.Right.Type != nil {
		if n.Left.Type != nil {
			n.Right = assignconv(n.Right, n.Left.Type, "assignment")
		}
	}

	if n.Left.Name != nil && n.Left.Name.Defn == n && n.Left.Name.Param.Ntype == nil {
		n.Right = defaultlit(n.Right, nil)
		n.Left.Type = n.Right.Type
	}

	// second half of dance.
	// now that right is done, typecheck the left
	// just to get it over with.  see dance above.
	n.SetTypecheck(1)

	if n.Left.Typecheck() == 0 {
		n.Left = typecheck(n.Left, Erv|Easgn)
	}
	if !isblank(n.Left) {
		checkwidth(n.Left.Type) // ensure width is calculated for backend
	}
}

func checkassignto(src *types.Type, dst *Node) {
	var why string

	if assignop(src, dst.Type, &why) == 0 {
		yyerror("cannot assign %v to %L in multiple assignment%s", src, dst, why)
		return
	}
}

func typecheckas2(n *Node) {
	ls := n.List.Slice()
	for i1, n1 := range ls {
		// delicate little dance.
		n1 = resolve(n1)
		ls[i1] = n1

		if n1.Name == nil || n1.Name.Defn != n || n1.Name.Param.Ntype != nil {
			ls[i1] = typecheck(ls[i1], Erv|Easgn)
		}
	}

	cl := n.List.Len()
	cr := n.Rlist.Len()
	if cl > 1 && cr == 1 {
		n.Rlist.SetFirst(typecheck(n.Rlist.First(), Erv|Efnstruct))
	} else {
		typecheckslice(n.Rlist.Slice(), Erv)
	}
	checkassignlist(n, n.List)

	var l *Node
	var r *Node
	if cl == cr {
		// easy
		ls := n.List.Slice()
		rs := n.Rlist.Slice()
		for il, nl := range ls {
			nr := rs[il]
			if nl.Type != nil && nr.Type != nil {
				rs[il] = assignconv(nr, nl.Type, "assignment")
			}
			if nl.Name != nil && nl.Name.Defn == n && nl.Name.Param.Ntype == nil {
				rs[il] = defaultlit(rs[il], nil)
				nl.Type = rs[il].Type
			}
		}

		goto out
	}

	l = n.List.First()
	r = n.Rlist.First()

	// x,y,z = f()
	if cr == 1 {
		if r.Type == nil {
			goto out
		}
		switch r.Op {
		case OCALLMETH, OCALLINTER, OCALLFUNC:
			if !r.Type.IsFuncArgStruct() {
				break
			}
			cr = r.Type.NumFields()
			if cr != cl {
				goto mismatch
			}
			n.Op = OAS2FUNC
			for i, l := range n.List.Slice() {
				f := r.Type.Field(i)
				if f.Type != nil && l.Type != nil {
					checkassignto(f.Type, l)
				}
				if l.Name != nil && l.Name.Defn == n && l.Name.Param.Ntype == nil {
					l.Type = f.Type
				}
			}
			goto out
		}
	}

	// x, ok = y
	if cl == 2 && cr == 1 {
		if r.Type == nil {
			goto out
		}
		switch r.Op {
		case OINDEXMAP, ORECV, ODOTTYPE:
			switch r.Op {
			case OINDEXMAP:
				n.Op = OAS2MAPR

			case ORECV:
				n.Op = OAS2RECV

			case ODOTTYPE:
				n.Op = OAS2DOTTYPE
				r.Op = ODOTTYPE2
			}

			if l.Type != nil {
				checkassignto(r.Type, l)
			}
			if l.Name != nil && l.Name.Defn == n {
				l.Type = r.Type
			}
			l := n.List.Second()
			if l.Type != nil && !l.Type.IsBoolean() {
				checkassignto(types.Types[TBOOL], l)
			}
			if l.Name != nil && l.Name.Defn == n && l.Name.Param.Ntype == nil {
				l.Type = types.Types[TBOOL]
			}
			goto out
		}
	}

mismatch:
	yyerror("cannot assign %d values to %d variables", cr, cl)

	// second half of dance
out:
	n.SetTypecheck(1)
	ls = n.List.Slice()
	for i1, n1 := range ls {
		if n1.Typecheck() == 0 {
			ls[i1] = typecheck(ls[i1], Erv|Easgn)
		}
	}
}

// type check function definition
func typecheckfunc(n *Node) {
	for _, ln := range n.Func.Dcl {
		if ln.Op == ONAME && (ln.Class() == PPARAM || ln.Class() == PPARAMOUT) {
			ln.Name.Decldepth = 1
		}
	}

	n.Func.Nname = typecheck(n.Func.Nname, Erv|Easgn)
	t := n.Func.Nname.Type
	if t == nil {
		return
	}
	n.Type = t
	t.FuncType().Nname = asTypesNode(n.Func.Nname)
	rcvr := t.Recv()
	if rcvr != nil && n.Func.Shortname != nil {
		n.Func.Nname.Sym = methodname(n.Func.Shortname, rcvr.Type)
		declare(n.Func.Nname, PFUNC)

		addmethod(n.Func.Shortname, t, true, n.Func.Pragma&Nointerface != 0)
	}

	if Ctxt.Flag_dynlink && !inimport && n.Func.Nname != nil {
		makefuncsym(n.Func.Nname.Sym)
	}
}

// The result of stringtoarraylit MUST be assigned back to n, e.g.
// 	n.Left = stringtoarraylit(n.Left)
func stringtoarraylit(n *Node) *Node {
	if n.Left.Op != OLITERAL || n.Left.Val().Ctype() != CTSTR {
		Fatalf("stringtoarraylit %v", n)
	}

	s := n.Left.Val().U.(string)
	var l []*Node
	if n.Type.Elem().Etype == TUINT8 {
		// []byte
		for i := 0; i < len(s); i++ {
			l = append(l, nod(OKEY, nodintconst(int64(i)), nodintconst(int64(s[0]))))
		}
	} else {
		// []rune
		i := 0
		for _, r := range s {
			l = append(l, nod(OKEY, nodintconst(int64(i)), nodintconst(int64(r))))
			i++
		}
	}

	nn := nod(OCOMPLIT, nil, typenod(n.Type))
	nn.List.Set(l)
	nn = typecheck(nn, Erv)
	return nn
}

var ntypecheckdeftype int

type mapqueueval struct {
	n   *Node
	lno src.XPos
}

// tracks the line numbers at which forward types are first used as map keys
var mapqueue []mapqueueval

func copytype(n *Node, t *types.Type) {
	if t.Etype == TFORW {
		// This type isn't computed yet; when it is, update n.
		t.ForwardType().Copyto = append(t.ForwardType().Copyto, asTypesNode(n))
		return
	}

	embedlineno := n.Type.ForwardType().Embedlineno
	l := n.Type.ForwardType().Copyto

	ptrBase := n.Type.PtrBase
	sliceOf := n.Type.SliceOf

	// TODO(mdempsky): Fix Type rekinding.
	*n.Type = *t

	t = n.Type
	t.Sym = n.Sym
	t.SetLocal(n.Local())
	if n.Name != nil {
		t.Vargen = n.Name.Vargen
	}

	// spec: "The declared type does not inherit any methods bound
	// to the existing type, but the method set of an interface
	// type [...] remains unchanged."
	if !t.IsInterface() {
		*t.Methods() = types.Fields{}
		*t.AllMethods() = types.Fields{}
	}

	t.Nod = asTypesNode(n)
	t.SetDeferwidth(false)
	t.PtrBase = ptrBase
	t.SliceOf = sliceOf

	// Propagate go:notinheap pragma from the Name to the Type.
	if n.Name != nil && n.Name.Param != nil && n.Name.Param.Pragma&NotInHeap != 0 {
		t.SetNotInHeap(true)
	}

	// Update nodes waiting on this type.
	for _, n := range l {
		copytype(asNode(n), t)
	}

	// Double-check use of type as embedded type.
	lno := lineno

	if embedlineno.IsKnown() {
		lineno = embedlineno
		if t.IsPtr() || t.IsUnsafePtr() {
			yyerror("embedded type cannot be a pointer")
		}
	}

	lineno = lno
}

func typecheckdeftype(n *Node) {
	ntypecheckdeftype++
	lno := lineno
	setlineno(n)
	n.Type.Sym = n.Sym
	n.SetTypecheck(1)
	n.Name.Param.Ntype = typecheck(n.Name.Param.Ntype, Etype)
	t := n.Name.Param.Ntype.Type
	if t == nil {
		n.SetDiag(true)
		n.Type = nil
		goto ret
	}

	if n.Type == nil {
		n.SetDiag(true)
		goto ret
	}

	// copy new type and clear fields
	// that don't come along.
	copytype(n, t)

ret:
	lineno = lno

	// if there are no type definitions going on, it's safe to
	// try to validate the map key types for the interfaces
	// we just read.
	if ntypecheckdeftype == 1 {
		for _, e := range mapqueue {
			lineno = e.lno
			if !IsComparable(e.n.Type) {
				yyerror("invalid map key type %v", e.n.Type)
			}
		}
		mapqueue = nil
		lineno = lno
	}

	ntypecheckdeftype--
}

func typecheckdef(n *Node) *Node {
	lno := lineno
	setlineno(n)

	if n.Op == ONONAME {
		if !n.Diag() {
			n.SetDiag(true)
			if n.Pos.IsKnown() {
				lineno = n.Pos
			}

			// Note: adderrorname looks for this string and
			// adds context about the outer expression
			yyerror("undefined: %v", n.Sym)
		}

		return n
	}

	if n.Walkdef() == 1 {
		return n
	}

	typecheckdefstack = append(typecheckdefstack, n)
	if n.Walkdef() == 2 {
		flusherrors()
		fmt.Printf("typecheckdef loop:")
		for i := len(typecheckdefstack) - 1; i >= 0; i-- {
			n := typecheckdefstack[i]
			fmt.Printf(" %v", n.Sym)
		}
		fmt.Printf("\n")
		Fatalf("typecheckdef loop")
	}

	n.SetWalkdef(2)

	if n.Type != nil || n.Sym == nil { // builtin or no name
		goto ret
	}

	switch n.Op {
	default:
		Fatalf("typecheckdef %v", n.Op)

	case OGOTO, OLABEL, OPACK:
		// nothing to do here

	case OLITERAL:
		if n.Name.Param.Ntype != nil {
			n.Name.Param.Ntype = typecheck(n.Name.Param.Ntype, Etype)
			n.Type = n.Name.Param.Ntype.Type
			n.Name.Param.Ntype = nil
			if n.Type == nil {
				n.SetDiag(true)
				goto ret
			}
		}

		e := n.Name.Defn
		n.Name.Defn = nil
		if e == nil {
			lineno = n.Pos
			Dump("typecheckdef nil defn", n)
			yyerror("xxx")
		}

		e = typecheck(e, Erv)
		if Isconst(e, CTNIL) {
			yyerror("const initializer cannot be nil")
			goto ret
		}

		if e.Type != nil && e.Op != OLITERAL || !isgoconst(e) {
			if !e.Diag() {
				yyerror("const initializer %v is not a constant", e)
				e.SetDiag(true)
			}

			goto ret
		}

		t := n.Type
		if t != nil {
			if !okforconst[t.Etype] {
				yyerror("invalid constant type %v", t)
				goto ret
			}

			if !e.Type.IsUntyped() && !eqtype(t, e.Type) {
				yyerror("cannot use %L as type %v in const initializer", e, t)
				goto ret
			}

			e = convlit(e, t)
		}

		n.SetVal(e.Val())
		n.Type = e.Type

	case ONAME:
		if n.Name.Param.Ntype != nil {
			n.Name.Param.Ntype = typecheck(n.Name.Param.Ntype, Etype)
			n.Type = n.Name.Param.Ntype.Type
			if n.Type == nil {
				n.SetDiag(true)
				goto ret
			}
		}

		if n.Type != nil {
			break
		}
		if n.Name.Defn == nil {
			if n.Etype != 0 { // like OPRINTN
				break
			}
			if nsavederrors+nerrors > 0 {
				// Can have undefined variables in x := foo
				// that make x have an n.name.Defn == nil.
				// If there are other errors anyway, don't
				// bother adding to the noise.
				break
			}

			Fatalf("var without type, init: %v", n.Sym)
		}

		if n.Name.Defn.Op == ONAME {
			n.Name.Defn = typecheck(n.Name.Defn, Erv)
			n.Type = n.Name.Defn.Type
			break
		}

		n.Name.Defn = typecheck(n.Name.Defn, Etop) // fills in n.Type

	case OTYPE:
		if p := n.Name.Param; p.Alias {
			// Type alias declaration: Simply use the rhs type - no need
			// to create a new type.
			// If we have a syntax error, p.Ntype may be nil.
			if p.Ntype != nil {
				p.Ntype = typecheck(p.Ntype, Etype)
				n.Type = p.Ntype.Type
				if n.Type == nil {
					n.SetDiag(true)
					goto ret
				}
				n.Sym.Def = asTypesNode(p.Ntype)
			}
			break
		}

		// regular type declaration
		if Curfn != nil {
			defercheckwidth()
		}
		n.SetWalkdef(1)
		n.Type = types.New(TFORW)
		n.Type.Nod = asTypesNode(n)
		n.Type.Sym = n.Sym // TODO(gri) this also happens in typecheckdeftype(n) - where should it happen?
		nerrors0 := nerrors
		typecheckdeftype(n)
		if n.Type.Etype == TFORW && nerrors > nerrors0 {
			// Something went wrong during type-checking,
			// but it was reported. Silence future errors.
			n.Type.SetBroke(true)
		}
		if Curfn != nil {
			resumecheckwidth()
		}
	}

ret:
	if n.Op != OLITERAL && n.Type != nil && n.Type.IsUntyped() {
		Fatalf("got %v for %v", n.Type, n)
	}
	last := len(typecheckdefstack) - 1
	if typecheckdefstack[last] != n {
		Fatalf("typecheckdefstack mismatch")
	}
	typecheckdefstack[last] = nil
	typecheckdefstack = typecheckdefstack[:last]

	lineno = lno
	n.SetWalkdef(1)
	return n
}

func checkmake(t *types.Type, arg string, n *Node) bool {
	if !n.Type.IsInteger() && n.Type.Etype != TIDEAL {
		yyerror("non-integer %s argument in make(%v) - %v", arg, t, n.Type)
		return false
	}

	// Do range checks for constants before defaultlit
	// to avoid redundant "constant NNN overflows int" errors.
	switch consttype(n) {
	case CTINT, CTRUNE, CTFLT, CTCPLX:
		n.SetVal(toint(n.Val()))
		if n.Val().U.(*Mpint).CmpInt64(0) < 0 {
			yyerror("negative %s argument in make(%v)", arg, t)
			return false
		}
		if n.Val().U.(*Mpint).Cmp(maxintval[TINT]) > 0 {
			yyerror("%s argument too large in make(%v)", arg, t)
			return false
		}
	}

	// defaultlit is necessary for non-constants too: n might be 1.1<<k.
	n = defaultlit(n, types.Types[TINT])

	return true
}

func markbreak(n *Node, implicit *Node) {
	if n == nil {
		return
	}

	switch n.Op {
	case OBREAK:
		if n.Left == nil {
			if implicit != nil {
				implicit.SetHasBreak(true)
			}
		} else {
			lab := asNode(n.Left.Sym.Label)
			if lab != nil {
				lab.SetHasBreak(true)
			}
		}
	case OFOR, OFORUNTIL, OSWITCH, OTYPESW, OSELECT, ORANGE:
		implicit = n
		fallthrough
	default:
		markbreak(n.Left, implicit)
		markbreak(n.Right, implicit)
		markbreaklist(n.Ninit, implicit)
		markbreaklist(n.Nbody, implicit)
		markbreaklist(n.List, implicit)
		markbreaklist(n.Rlist, implicit)
	}
}

func markbreaklist(l Nodes, implicit *Node) {
	s := l.Slice()
	for i := 0; i < len(s); i++ {
		n := s[i]
		if n == nil {
			continue
		}
		if n.Op == OLABEL && i+1 < len(s) && n.Name.Defn == s[i+1] {
			switch n.Name.Defn.Op {
			case OFOR, OFORUNTIL, OSWITCH, OTYPESW, OSELECT, ORANGE:
				n.Left.Sym.Label = asTypesNode(n.Name.Defn)
				markbreak(n.Name.Defn, n.Name.Defn)
				n.Left.Sym.Label = nil
				i++
				continue
			}
		}

		markbreak(n, implicit)
	}
}

// isterminating reports whether the Nodes list ends with a terminating statement.
func (l Nodes) isterminating() bool {
	s := l.Slice()
	c := len(s)
	if c == 0 {
		return false
	}
	return s[c-1].isterminating()
}

// Isterminating reports whether the node n, the last one in a
// statement list, is a terminating statement.
func (n *Node) isterminating() bool {
	switch n.Op {
	// NOTE: OLABEL is treated as a separate statement,
	// not a separate prefix, so skipping to the last statement
	// in the block handles the labeled statement case by
	// skipping over the label. No case OLABEL here.

	case OBLOCK:
		return n.List.isterminating()

	case OGOTO, ORETURN, ORETJMP, OPANIC, OXFALL:
		return true

	case OFOR, OFORUNTIL:
		if n.Left != nil {
			return false
		}
		if n.HasBreak() {
			return false
		}
		return true

	case OIF:
		return n.Nbody.isterminating() && n.Rlist.isterminating()

	case OSWITCH, OTYPESW, OSELECT:
		if n.HasBreak() {
			return false
		}
		def := 0
		for _, n1 := range n.List.Slice() {
			if !n1.Nbody.isterminating() {
				return false
			}
			if n1.List.Len() == 0 { // default
				def = 1
			}
		}

		if n.Op != OSELECT && def == 0 {
			return false
		}
		return true
	}

	return false
}

// checkreturn makes sure that fn terminates appropriately.
func checkreturn(fn *Node) {
	if fn.Type.Results().NumFields() != 0 && fn.Nbody.Len() != 0 {
		markbreaklist(fn.Nbody, nil)
		if !fn.Nbody.isterminating() {
			yyerrorl(fn.Func.Endlineno, "missing return at end of function")
		}
	}
}

func deadcode(fn *Node) {
	deadcodeslice(fn.Nbody)
}

func deadcodeslice(nn Nodes) {
	for _, n := range nn.Slice() {
		if n == nil {
			continue
		}
		if n.Op == OIF && Isconst(n.Left, CTBOOL) {
			if n.Left.Bool() {
				n.Rlist = Nodes{}
			} else {
				n.Nbody = Nodes{}
			}
		}
		deadcodeslice(n.Ninit)
		deadcodeslice(n.Nbody)
		deadcodeslice(n.List)
		deadcodeslice(n.Rlist)
	}
}
