// Do not edit. Bootstrap copy of /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/asm/main.go

//line /private/tmp/go-20171004-32030-1lwkjbw/go/src/cmd/asm/main.go:1
// Copyright 2014 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"os"

	"bootstrap/cmd/asm/internal/arch"
	"bootstrap/cmd/asm/internal/asm"
	"bootstrap/cmd/asm/internal/flags"
	"bootstrap/cmd/asm/internal/lex"

	"bootstrap/cmd/internal/bio"
	"bootstrap/cmd/internal/obj"
	"bootstrap/cmd/internal/objabi"
)

func main() {
	log.SetFlags(0)
	log.SetPrefix("asm: ")

	GOARCH := objabi.GOARCH

	architecture := arch.Set(GOARCH)
	if architecture == nil {
		log.Fatalf("unrecognized architecture %s", GOARCH)
	}

	flags.Parse()

	ctxt := obj.Linknew(architecture.LinkArch)
	if *flags.PrintOut {
		ctxt.Debugasm = true
	}
	ctxt.Flag_dynlink = *flags.Dynlink
	ctxt.Flag_shared = *flags.Shared || *flags.Dynlink
	ctxt.Bso = bufio.NewWriter(os.Stdout)
	defer ctxt.Bso.Flush()

	architecture.Init(ctxt)

	// Create object file, write header.
	out, err := os.Create(*flags.OutputFile)
	if err != nil {
		log.Fatal(err)
	}
	defer bio.MustClose(out)
	buf := bufio.NewWriter(bio.MustWriter(out))

	fmt.Fprintf(buf, "go object %s %s %s\n", objabi.GOOS, objabi.GOARCH, objabi.Version)
	fmt.Fprintf(buf, "!\n")

	var ok, diag bool
	var failedFile string
	for _, f := range flag.Args() {
		lexer := lex.NewLexer(f)
		parser := asm.NewParser(ctxt, architecture, lexer)
		ctxt.DiagFunc = func(format string, args ...interface{}) {
			diag = true
			log.Printf(format, args...)
		}
		pList := new(obj.Plist)
		pList.Firstpc, ok = parser.Parse()
		if !ok {
			failedFile = f
			break
		}
		// reports errors to parser.Errorf
		obj.Flushplist(ctxt, pList, nil)
	}
	if ok {
		obj.WriteObjFile(ctxt, buf)
	}
	if !ok || diag {
		if failedFile != "" {
			log.Printf("assembly of %s failed", failedFile)
		} else {
			log.Print("assembly failed")
		}
		out.Close()
		os.Remove(*flags.OutputFile)
		os.Exit(1)
	}
	buf.Flush()
}
