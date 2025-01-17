class Ettercap < Formula
  desc "Multipurpose sniffer/interceptor/logger for switched LAN"
  homepage "https://ettercap.github.io/ettercap/"
  revision 1

  head "https://github.com/Ettercap/ettercap.git"

  stable do
    url "https://github.com/Ettercap/ettercap/archive/v0.8.2.tar.gz"
    sha256 "f38514f35bea58bfe6ef1902bfd4761de0379942a9aa3e175fc9348f4eef2c81"

    # Fixes CVE-2017-6430.
    patch do
      url "https://github.com/Ettercap/ettercap/commit/4ad7f85dc01202e363659aa473c99470b3f4e1f4.patch?full_index=1"
      sha256 "13be172067e133f64a31b14de434acea261ac795d493897d085958192ac1cdd4"
    end
  end

  option "without-curses", "Install without curses interface"
  option "without-plugins", "Install without plugins support"
  option "without-ipv6", "Install without IPv6 support"

  depends_on "cmake" => :build
  depends_on "ghostscript" => [:build, :optional]
  depends_on "pcre"
  depends_on "libnet"
  depends_on "openssl"
  depends_on "curl" if MacOS.version <= :mountain_lion # requires >= 7.26.0.
  depends_on "gtk+" => :optional
  depends_on "gtk+3" => :optional
  depends_on "luajit" => :optional

  def install
    args = std_cmake_args + %W[
      -DBUNDLED_LIBS=OFF
      -DINSTALL_SYSCONFDIR=#{etc}
    ]

    if build.with? "curses"
      args << "-DENABLE_CURSES=ON"
    else
      args << "-DENABLE_CURSES=OFF"
    end

    if build.with? "plugins"
      args << "-DENABLE_PLUGINS=ON"
    else
      args << "-DENABLE_PLUGINS=OFF"
    end

    if build.with? "ipv6"
      args << "-DENABLE_IPV6=ON"
    else
      args << "-DENABLE_IPV6=OFF"
    end

    if build.with? "ghostscript"
      args << "-DENABLE_PDF_DOCS=ON"
    else
      args << "-DENABLE_PDF_DOCS=OFF"
    end

    if build.with?("gtk+") || build.with?("gtk+3")
      args << "-DENABLE_GTK=ON" << "-DINSTALL_DESKTOP=ON"
      args << "-DGTK_BUILD_TYPE=GTK3" if build.with? "gtk+3"
    else
      args << "-DENABLE_GTK=OFF" << "-DINSTALL_DESKTOP=OFF"
    end

    if build.with? "luajit"
      args << "-DENABLE_LUA=ON"
    else
      args << "-DENABLE_LUA=OFF"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ettercap --version")
  end
end
