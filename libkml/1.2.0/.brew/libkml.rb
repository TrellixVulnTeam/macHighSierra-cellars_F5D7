class Libkml < Formula
  desc "Library to parse, generate and operate on KML"
  homepage "https://code.google.com/archive/p/libkml/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/libkml/libkml-1.2.0.tar.gz"
  sha256 "fae9085e4cd9f0d4ae0d0626be7acf4ad5cbb37991b9d886df29daf72df37cbc"

  # Fix compilation with clang and gcc 4.7+
  # https://code.google.com/p/libkml/issues/detail?id=179
  patch :DATA

  # Correct an issue where internal third-party libs (libminizip and liburiparser)
  # are installed as dylibs. liburiparser conflicts with uriparser formula.
  # libminizip conflicts with new formula, and some of its symbols have been
  # renamed with prefixes of "libkml_", i.e, can't be linked against for other builds
  # Fix just forces internal libs to be linked statically until the following
  # is addressed upstream: https://code.google.com/p/libkml/issues/detail?id=50
  patch do
    url "https://gist.githubusercontent.com/dakcarto/7419882/raw/10ae08af224b3fee0617fa6288d806d3ccf37c0f/libkml-1.2-static-deps"
    sha256 "c39995a1c1ebabc1692dc6be698d68e18170230d71d5a0ce426d8f41bdf0dc72"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end

__END__
diff --git a/src/kml/base/file_posix.cc b/src/kml/base/file_posix.cc
index 764ae55..8ee9892 100644
--- a/src/kml/base/file_posix.cc
+++ b/src/kml/base/file_posix.cc
@@ -29,6 +29,7 @@
 #include "kml/base/file.h"
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
