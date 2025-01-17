// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/arm64/ggen.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/arm64/ggen.go:1
// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package arm64

import (
	"bootstrap/cmd/compile/internal/gc"
	"bootstrap/cmd/internal/obj"
	"bootstrap/cmd/internal/obj/arm64"
	"bootstrap/cmd/internal/objabi"
)

var darwin = objabi.GOOS == "darwin"

func padframe(frame int64) int64 {
	// arm64 requires that the frame size (not counting saved LR)
	// be empty or be 8 mod 16. If not, pad it.
	if frame != 0 && frame%16 != 8 {
		frame += 8
	}
	return frame
}

func zerorange(pp *gc.Progs, p *obj.Prog, off, cnt int64, _ *uint32) *obj.Prog {
	if cnt == 0 {
		return p
	}
	if cnt < int64(4*gc.Widthptr) {
		for i := int64(0); i < cnt; i += int64(gc.Widthptr) {
			p = pp.Appendpp(p, arm64.AMOVD, obj.TYPE_REG, arm64.REGZERO, 0, obj.TYPE_MEM, arm64.REGSP, 8+off+i)
		}
	} else if cnt <= int64(128*gc.Widthptr) && !darwin { // darwin ld64 cannot handle BR26 reloc with non-zero addend
		p = pp.Appendpp(p, arm64.AMOVD, obj.TYPE_REG, arm64.REGSP, 0, obj.TYPE_REG, arm64.REGRT1, 0)
		p = pp.Appendpp(p, arm64.AADD, obj.TYPE_CONST, 0, 8+off-8, obj.TYPE_REG, arm64.REGRT1, 0)
		p.Reg = arm64.REGRT1
		p = pp.Appendpp(p, obj.ADUFFZERO, obj.TYPE_NONE, 0, 0, obj.TYPE_MEM, 0, 0)
		p.To.Name = obj.NAME_EXTERN
		p.To.Sym = gc.Duffzero
		p.To.Offset = 4 * (128 - cnt/int64(gc.Widthptr))
	} else {
		p = pp.Appendpp(p, arm64.AMOVD, obj.TYPE_CONST, 0, 8+off-8, obj.TYPE_REG, arm64.REGTMP, 0)
		p = pp.Appendpp(p, arm64.AMOVD, obj.TYPE_REG, arm64.REGSP, 0, obj.TYPE_REG, arm64.REGRT1, 0)
		p = pp.Appendpp(p, arm64.AADD, obj.TYPE_REG, arm64.REGTMP, 0, obj.TYPE_REG, arm64.REGRT1, 0)
		p.Reg = arm64.REGRT1
		p = pp.Appendpp(p, arm64.AMOVD, obj.TYPE_CONST, 0, cnt, obj.TYPE_REG, arm64.REGTMP, 0)
		p = pp.Appendpp(p, arm64.AADD, obj.TYPE_REG, arm64.REGTMP, 0, obj.TYPE_REG, arm64.REGRT2, 0)
		p.Reg = arm64.REGRT1
		p = pp.Appendpp(p, arm64.AMOVD, obj.TYPE_REG, arm64.REGZERO, 0, obj.TYPE_MEM, arm64.REGRT1, int64(gc.Widthptr))
		p.Scond = arm64.C_XPRE
		p1 := p
		p = pp.Appendpp(p, arm64.ACMP, obj.TYPE_REG, arm64.REGRT1, 0, obj.TYPE_NONE, 0, 0)
		p.Reg = arm64.REGRT2
		p = pp.Appendpp(p, arm64.ABNE, obj.TYPE_NONE, 0, 0, obj.TYPE_BRANCH, 0, 0)
		gc.Patch(p, p1)
	}

	return p
}

func zeroAuto(pp *gc.Progs, n *gc.Node) {
	// Note: this code must not clobber any registers.
	sym := n.Sym.Linksym()
	size := n.Type.Size()
	for i := int64(0); i < size; i += 8 {
		p := pp.Prog(arm64.AMOVD)
		p.From.Type = obj.TYPE_REG
		p.From.Reg = arm64.REGZERO
		p.To.Type = obj.TYPE_MEM
		p.To.Name = obj.NAME_AUTO
		p.To.Reg = arm64.REGSP
		p.To.Offset = n.Xoffset + i
		p.To.Sym = sym
	}
}

func ginsnop(pp *gc.Progs) {
	p := pp.Prog(arm64.AHINT)
	p.From.Type = obj.TYPE_CONST
}
