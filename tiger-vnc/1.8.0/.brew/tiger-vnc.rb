class TigerVnc < Formula
  desc "High-performance, platform-neutral implementation of VNC"
  homepage "http://tigervnc.org/"
  url "https://github.com/TigerVNC/tigervnc/archive/v1.8.0.tar.gz"
  sha256 "9951dab0e10f8de03996ec94bec0d938da9f36d48dca8c954e8bbc95c16338f8"

  depends_on "cmake" => :build
  depends_on "gnutls" => :recommended
  depends_on "jpeg-turbo"
  depends_on "gettext"
  depends_on "fltk"
  depends_on :x11

  # Remove for > 1.8.0
  # Fix "redefinition of 'kVK_RightCommand' as different kind of symbol"
  # Upstream commit from 24 May 2017 "Compatibility with macOS 10.12 SDK"
  patch do
    url "https://github.com/TigerVNC/tigervnc/commit/2b0a0ef0.patch?full_index=1"
    sha256 "ddf74e2ccf57ff20e595f272ac41498c2f698003a619f365670871d00797db2b"
  end

  def install
    turbo = Formula["jpeg-turbo"]
    args = std_cmake_args + %W[
      -DJPEG_INCLUDE_DIR=#{turbo.include}
      -DJPEG_LIBRARY=#{turbo.lib}/libjpeg.dylib
      .
    ]
    system "cmake", *args
    system "make", "install"
  end
end
