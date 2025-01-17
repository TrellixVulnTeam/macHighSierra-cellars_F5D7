// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/ssa/opt.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/ssa/opt.go:1
// Copyright 2015 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package ssa

// machine-independent optimization
func opt(f *Func) {
	applyRewrite(f, rewriteBlockgeneric, rewriteValuegeneric)
}

func dec(f *Func) {
	applyRewrite(f, rewriteBlockdec, rewriteValuedec)
	if f.Config.RegSize == 4 {
		applyRewrite(f, rewriteBlockdec64, rewriteValuedec64)
	}
}
