class Binutils < Formula
  desc "FSF/GNU ld, ar, readelf, etc. for native development"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.29.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.29.1.tar.gz"
  sha256 "0d9d2bbf71e17903f26a676e7fba7c200e581c84b8f2f43e72d875d0e638771c"

  # No --default-names option as it interferes with Homebrew builds.

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-deterministic-archives",
                          "--program-prefix=g",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--mandir=#{man}",
                          "--disable-werror",
                          "--enable-interwork",
                          "--enable-multilib",
                          "--enable-64-bit-bfd",
                          "--enable-targets=all"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "main", shell_output("#{bin}/gnm #{bin}/gnm")
  end
end
