// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/sizeof_test.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/sizeof_test.go:1
// Copyright 2016 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build !nacl

package gc

import (
	"reflect"
	"testing"
	"unsafe"
)

// Assert that the size of important structures do not change unexpectedly.

func TestSizeof(t *testing.T) {
	const _64bit = unsafe.Sizeof(uintptr(0)) == 8

	var tests = []struct {
		val    interface{} // type as a value
		_32bit uintptr     // size on 32bit platforms
		_64bit uintptr     // size on 64bit platforms
	}{
		{Func{}, 124, 216},
		{Name{}, 36, 56},
		{Param{}, 28, 56},
		{Node{}, 76, 128},
	}

	for _, tt := range tests {
		want := tt._32bit
		if _64bit {
			want = tt._64bit
		}
		got := reflect.TypeOf(tt.val).Size()
		if want != got {
			t.Errorf("unsafe.Sizeof(%T) = %d, want %d", tt.val, got, want)
		}
	}
}
