// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/types.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/types.go:1
// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package gc

import (
	"bootstrap/cmd/compile/internal/types"
)

// convenience constants
const (
	Txxx = types.Txxx

	TINT8    = types.TINT8
	TUINT8   = types.TUINT8
	TINT16   = types.TINT16
	TUINT16  = types.TUINT16
	TINT32   = types.TINT32
	TUINT32  = types.TUINT32
	TINT64   = types.TINT64
	TUINT64  = types.TUINT64
	TINT     = types.TINT
	TUINT    = types.TUINT
	TUINTPTR = types.TUINTPTR

	TCOMPLEX64  = types.TCOMPLEX64
	TCOMPLEX128 = types.TCOMPLEX128

	TFLOAT32 = types.TFLOAT32
	TFLOAT64 = types.TFLOAT64

	TBOOL = types.TBOOL

	TPTR32 = types.TPTR32
	TPTR64 = types.TPTR64

	TFUNC      = types.TFUNC
	TSLICE     = types.TSLICE
	TARRAY     = types.TARRAY
	TSTRUCT    = types.TSTRUCT
	TCHAN      = types.TCHAN
	TMAP       = types.TMAP
	TINTER     = types.TINTER
	TFORW      = types.TFORW
	TANY       = types.TANY
	TSTRING    = types.TSTRING
	TUNSAFEPTR = types.TUNSAFEPTR

	// pseudo-types for literals
	TIDEAL = types.TIDEAL
	TNIL   = types.TNIL
	TBLANK = types.TBLANK

	// pseudo-types for frame layout
	TFUNCARGS = types.TFUNCARGS
	TCHANARGS = types.TCHANARGS

	// pseudo-types for import/export
	TDDDFIELD = types.TDDDFIELD // wrapper: contained type is a ... field

	NTYPE = types.NTYPE
)
