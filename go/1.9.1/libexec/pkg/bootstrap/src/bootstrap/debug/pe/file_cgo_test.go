// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/debug/pe/file_cgo_test.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/debug/pe/file_cgo_test.go:1
// Copyright 2017 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build cgo

package pe

import (
	"os/exec"
	"testing"
)

func testCgoDWARF(t *testing.T, linktype int) {
	if _, err := exec.LookPath("gcc"); err != nil {
		t.Skip("skipping test: gcc is missing")
	}
	testDWARF(t, linktype)
}

func TestDefaultLinkerDWARF(t *testing.T) {
	testCgoDWARF(t, linkCgoDefault)
}

func TestInternalLinkerDWARF(t *testing.T) {
	testCgoDWARF(t, linkCgoInternal)
}

func TestExternalLinkerDWARF(t *testing.T) {
	testCgoDWARF(t, linkCgoExternal)
}
