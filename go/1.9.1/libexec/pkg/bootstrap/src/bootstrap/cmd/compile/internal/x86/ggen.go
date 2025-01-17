// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/x86/ggen.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/x86/ggen.go:1
// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package x86

import (
	"bootstrap/cmd/compile/internal/gc"
	"bootstrap/cmd/internal/obj"
	"bootstrap/cmd/internal/obj/x86"
)

func zerorange(pp *gc.Progs, p *obj.Prog, off, cnt int64, ax *uint32) *obj.Prog {
	if cnt == 0 {
		return p
	}
	if *ax == 0 {
		p = pp.Appendpp(p, x86.AMOVL, obj.TYPE_CONST, 0, 0, obj.TYPE_REG, x86.REG_AX, 0)
		*ax = 1
	}

	if cnt <= int64(4*gc.Widthreg) {
		for i := int64(0); i < cnt; i += int64(gc.Widthreg) {
			p = pp.Appendpp(p, x86.AMOVL, obj.TYPE_REG, x86.REG_AX, 0, obj.TYPE_MEM, x86.REG_SP, off+i)
		}
	} else if !gc.Nacl && cnt <= int64(128*gc.Widthreg) {
		p = pp.Appendpp(p, x86.ALEAL, obj.TYPE_MEM, x86.REG_SP, off, obj.TYPE_REG, x86.REG_DI, 0)
		p = pp.Appendpp(p, obj.ADUFFZERO, obj.TYPE_NONE, 0, 0, obj.TYPE_ADDR, 0, 1*(128-cnt/int64(gc.Widthreg)))
		p.To.Sym = gc.Duffzero
	} else {
		p = pp.Appendpp(p, x86.AMOVL, obj.TYPE_CONST, 0, cnt/int64(gc.Widthreg), obj.TYPE_REG, x86.REG_CX, 0)
		p = pp.Appendpp(p, x86.ALEAL, obj.TYPE_MEM, x86.REG_SP, off, obj.TYPE_REG, x86.REG_DI, 0)
		p = pp.Appendpp(p, x86.AREP, obj.TYPE_NONE, 0, 0, obj.TYPE_NONE, 0, 0)
		p = pp.Appendpp(p, x86.ASTOSL, obj.TYPE_NONE, 0, 0, obj.TYPE_NONE, 0, 0)
	}

	return p
}

func zeroAuto(pp *gc.Progs, n *gc.Node) {
	// Note: this code must not clobber any registers.
	sym := n.Sym.Linksym()
	size := n.Type.Size()
	for i := int64(0); i < size; i += 4 {
		p := pp.Prog(x86.AMOVL)
		p.From.Type = obj.TYPE_CONST
		p.From.Offset = 0
		p.To.Type = obj.TYPE_MEM
		p.To.Name = obj.NAME_AUTO
		p.To.Reg = x86.REG_SP
		p.To.Offset = n.Xoffset + i
		p.To.Sym = sym
	}
}

func ginsnop(pp *gc.Progs) {
	p := pp.Prog(x86.AXCHGL)
	p.From.Type = obj.TYPE_REG
	p.From.Reg = x86.REG_AX
	p.To.Type = obj.TYPE_REG
	p.To.Reg = x86.REG_AX
}
