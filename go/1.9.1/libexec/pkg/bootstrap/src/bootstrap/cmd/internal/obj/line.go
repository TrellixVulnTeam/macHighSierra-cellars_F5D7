// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/internal/obj/line.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/internal/obj/line.go:1
// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package obj

import (
	"bootstrap/cmd/internal/src"
)

// AddImport adds a package to the list of imported packages.
func (ctxt *Link) AddImport(pkg string) {
	ctxt.Imports = append(ctxt.Imports, pkg)
}

func linkgetlineFromPos(ctxt *Link, xpos src.XPos) (f string, l int32) {
	pos := ctxt.PosTable.Pos(xpos)
	if !pos.IsKnown() {
		pos = src.Pos{}
	}
	// TODO(gri) Should this use relative or absolute line number?
	return pos.SymFilename(), int32(pos.RelLine())
}
