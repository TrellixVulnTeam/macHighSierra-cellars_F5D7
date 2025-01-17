// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/bitset.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/compile/internal/gc/bitset.go:1
// Copyright 2017 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package gc

type bitset8 uint8

func (f *bitset8) set(mask uint8, b bool) {
	if b {
		*(*uint8)(f) |= mask
	} else {
		*(*uint8)(f) &^= mask
	}
}

type bitset32 uint32

func (f *bitset32) set(mask uint32, b bool) {
	if b {
		*(*uint32)(f) |= mask
	} else {
		*(*uint32)(f) &^= mask
	}
}

func (f bitset32) get2(shift uint8) uint8 {
	return uint8(f>>shift) & 3
}

// set2 sets two bits in f using the bottom two bits of b.
func (f *bitset32) set2(shift uint8, b uint8) {
	// Clear old bits.
	*(*uint32)(f) &^= 3 << shift
	// Set new bits.
	*(*uint32)(f) |= uint32(b&3) << shift
}

func (f bitset32) get3(shift uint8) uint8 {
	return uint8(f>>shift) & 7
}

// set3 sets three bits in f using the bottom three bits of b.
func (f *bitset32) set3(shift uint8, b uint8) {
	// Clear old bits.
	*(*uint32)(f) &^= 7 << shift
	// Set new bits.
	*(*uint32)(f) |= uint32(b&7) << shift
}
