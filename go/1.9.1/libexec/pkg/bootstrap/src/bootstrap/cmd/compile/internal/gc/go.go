// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/go.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/go.go:1
// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package gc

import (
	"bootstrap/cmd/compile/internal/ssa"
	"bootstrap/cmd/compile/internal/types"
	"bootstrap/cmd/internal/bio"
	"bootstrap/cmd/internal/obj"
	"bootstrap/cmd/internal/src"
	"sync"
)

const (
	BADWIDTH        = types.BADWIDTH
	MaxStackVarSize = 10 * 1024 * 1024
)

// isRuntimePkg reports whether p is package runtime.
func isRuntimePkg(p *types.Pkg) bool {
	if compiling_runtime && p == localpkg {
		return true
	}
	return p.Path == "runtime"
}

// The Class of a variable/function describes the "storage class"
// of a variable or function. During parsing, storage classes are
// called declaration contexts.
type Class uint8

//go:generate stringer -type=Class
const (
	Pxxx      Class = iota // no class; used during ssa conversion to indicate pseudo-variables
	PEXTERN                // global variable
	PAUTO                  // local variables
	PAUTOHEAP              // local variable or parameter moved to heap
	PPARAM                 // input arguments
	PPARAMOUT              // output results
	PFUNC                  // global function

	PDISCARD // discard during parse of duplicate import
	// Careful: Class is stored in three bits in Node.flags.
	// Adding a new Class will overflow that.
)

func init() {
	if PDISCARD != 7 {
		panic("PDISCARD changed; does all Class values still fit in three bits?")
	}
}

// note this is the runtime representation
// of the compilers arrays.
//
// typedef	struct
// {				// must not move anything
// 	uchar	array[8];	// pointer to data
// 	uchar	nel[4];		// number of elements
// 	uchar	cap[4];		// allocated number of elements
// } Array;
var array_array int // runtime offsetof(Array,array) - same for String

var array_nel int // runtime offsetof(Array,nel) - same for String

var array_cap int // runtime offsetof(Array,cap)

var sizeof_Array int // runtime sizeof(Array)

// note this is the runtime representation
// of the compilers strings.
//
// typedef	struct
// {				// must not move anything
// 	uchar	array[8];	// pointer to data
// 	uchar	nel[4];		// number of elements
// } String;
var sizeof_String int // runtime sizeof(String)

var pragcgobuf string

var outfile string
var linkobj string
var dolinkobj bool

var bout *bio.Writer

// nerrors is the number of compiler errors reported
// since the last call to saveerrors.
var nerrors int

// nsavederrors is the total number of compiler errors
// reported before the last call to saveerrors.
var nsavederrors int

var nsyntaxerrors int

var decldepth int32

var safemode bool

var nolocalimports bool

var Debug [256]int

var debugstr string

var Debug_checknil int
var Debug_typeassert int

var localpkg *types.Pkg // package being compiled

var inimport bool // set during import

var itabpkg *types.Pkg // fake pkg for itab entries

var itablinkpkg *types.Pkg // fake package for runtime itab entries

var Runtimepkg *types.Pkg // fake package runtime

var racepkg *types.Pkg // package runtime/race

var msanpkg *types.Pkg // package runtime/msan

var unsafepkg *types.Pkg // package unsafe

var trackpkg *types.Pkg // fake package for field tracking

var mappkg *types.Pkg // fake package for map zero value
var zerosize int64

var myimportpath string

var localimport string

var asmhdr string

var simtype [NTYPE]types.EType

var (
	isforw    [NTYPE]bool
	isInt     [NTYPE]bool
	isFloat   [NTYPE]bool
	isComplex [NTYPE]bool
	issimple  [NTYPE]bool
)

var (
	okforeq    [NTYPE]bool
	okforadd   [NTYPE]bool
	okforand   [NTYPE]bool
	okfornone  [NTYPE]bool
	okforcmp   [NTYPE]bool
	okforbool  [NTYPE]bool
	okforcap   [NTYPE]bool
	okforlen   [NTYPE]bool
	okforarith [NTYPE]bool
	okforconst [NTYPE]bool
)

var (
	okfor [OEND][]bool
	iscmp [OEND]bool
)

var minintval [NTYPE]*Mpint

var maxintval [NTYPE]*Mpint

var minfltval [NTYPE]*Mpflt

var maxfltval [NTYPE]*Mpflt

var xtop []*Node

var exportlist []*Node

var importlist []*Node // imported functions and methods with inlinable bodies

var (
	funcsymsmu sync.Mutex // protects funcsyms and associated package lookups (see func funcsym)
	funcsyms   []*types.Sym
)

var dclcontext Class // PEXTERN/PAUTO

var Curfn *Node

var Widthptr int

var Widthreg int

var nblank *Node

var typecheckok bool

var compiling_runtime bool

// Compiling the standard library
var compiling_std bool

var compiling_wrappers int

var use_writebarrier bool

var pure_go bool

var flag_installsuffix string

var flag_race bool

var flag_msan bool

var flagDWARF bool

// Whether we are adding any sort of code instrumentation, such as
// when the race detector is enabled.
var instrumenting bool

// Whether we are tracking lexical scopes for DWARF.
var trackScopes bool

var debuglive int

var Ctxt *obj.Link

var writearchive bool

var Nacl bool

var nodfp *Node

var disable_checknil int

var autogeneratedPos src.XPos

// interface to back end

type Arch struct {
	LinkArch *obj.LinkArch

	REGSP    int
	MAXWIDTH int64
	Use387   bool // should 386 backend use 387 FP instructions instead of sse2.

	PadFrame  func(int64) int64
	ZeroRange func(*Progs, *obj.Prog, int64, int64, *uint32) *obj.Prog
	Ginsnop   func(*Progs)

	// SSAMarkMoves marks any MOVXconst ops that need to avoid clobbering flags.
	SSAMarkMoves func(*SSAGenState, *ssa.Block)

	// SSAGenValue emits Prog(s) for the Value.
	SSAGenValue func(*SSAGenState, *ssa.Value)

	// SSAGenBlock emits end-of-block Progs. SSAGenValue should be called
	// for all values in the block before SSAGenBlock.
	SSAGenBlock func(s *SSAGenState, b, next *ssa.Block)

	// ZeroAuto emits code to zero the given auto stack variable.
	// ZeroAuto must not use any non-temporary registers.
	// ZeroAuto will only be called for variables which contain a pointer.
	ZeroAuto func(*Progs, *Node)
}

var thearch Arch

var (
	staticbytes,
	zerobase *Node

	Newproc,
	Deferproc,
	Deferreturn,
	Duffcopy,
	Duffzero,
	panicindex,
	panicslice,
	panicdivide,
	growslice,
	panicdottypeE,
	panicdottypeI,
	panicnildottype,
	assertE2I,
	assertE2I2,
	assertI2I,
	assertI2I2,
	goschedguarded,
	writeBarrier,
	writebarrierptr,
	typedmemmove,
	typedmemclr,
	Udiv *obj.LSym

	// GO386=387
	ControlWord64trunc,
	ControlWord32 *obj.LSym
)
