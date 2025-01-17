// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/internal/objabi/stack.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/internal/objabi/stack.go:1
// Copyright 2011 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package objabi

// For the linkers. Must match Go definitions.

const (
	STACKSYSTEM = 0
	StackSystem = STACKSYSTEM
	StackBig    = 4096
	StackGuard  = 880*stackGuardMultiplier + StackSystem
	StackSmall  = 128
	StackLimit  = StackGuard - StackSystem - StackSmall
)

const (
	StackPreempt = -1314 // 0xfff...fade
)
