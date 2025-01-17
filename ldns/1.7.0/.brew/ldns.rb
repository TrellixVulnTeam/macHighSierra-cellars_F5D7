class Ldns < Formula
  desc "DNS library written in C"
  homepage "https://nlnetlabs.nl/projects/ldns/"
  url "https://nlnetlabs.nl/downloads/ldns/ldns-1.7.0.tar.gz"
  sha256 "c19f5b1b4fb374cfe34f4845ea11b1e0551ddc67803bd6ddd5d2a20f0997a6cc"

  depends_on "swig" => :build
  depends_on "openssl@1.1"

  def install
    args = %W[
      --prefix=#{prefix}
      --with-drill
      --with-examples
      --with-ssl=#{Formula["openssl@1.1"].opt_prefix}
      --with-pyldns
      PYTHON_SITE_PKG=#{lib}/python2.7/site-packages
    ]

    system "./configure", *args

    inreplace "Makefile" do |s|
      s.change_make_var! "PYTHON_LDFLAGS", "-undefined dynamic_lookup"
      s.gsub! /(\$\(PYTHON_LDFLAGS\).*) -no-undefined/, "\\1"
    end

    system "make"
    system "make", "install"
    system "make", "install-pyldns"
    (lib/"pkgconfig").install "packaging/libldns.pc"
  end

  test do
    (testpath/"powerdns.com.dnskey").write <<-EOS.undent
      powerdns.com.   10773 IN  DNSKEY  256 3 8 AwEAAbQOlJUPNWM8DQown5y/wFgDVt7jskfEQcd4pbLV/1osuBfBNDZX v9ru7wDC/PbpvysEZgFXTPJ9QrdwSsd8KAZVO5mjeDNL0RnlhjHWuXKC qnLI+iLb3OMLQTizjdscdHPoW98wk5931pJkyf2qMDRjRB4c5d81sfoZ Od6D7Rrx
      powerdns.com.   10773 IN  DNSKEY  257 3 8 AwEAAb/+pXOZWYQ8mv9WM5dFva8WU9jcIUdDuEjldbyfnkQ/xlrJC5zA EfhYhrea3SmIPmMTDimLqbh3/4SMTNPTUF+9+U1vpNfIRTFadqsmuU9F ddz3JqCcYwEpWbReg6DJOeyu+9oBoIQkPxFyLtIXEPGlQzrynKubn04C x83I6NfzDTraJT3jLHKeW5PVc1ifqKzHz5TXdHHTA7NkJAa0sPcZCoNE 1LpnJI/wcUpRUiuQhoLFeT1E432GuPuZ7y+agElGj0NnBxEgnHrhrnZW UbULpRa/il+Cr5Taj988HqX9Xdm6FjcP4Lbuds/44U7U8du224Q8jTrZ 57Yvj4VDQKc="
    EOS
    system "#{bin}/ldns-key2ds", "powerdns.com.dnskey"
    assert_match /d4c3d5552b8679faeebc317e5f048b614b2e5f607dc57f1553182d49ab2179f7/, File.read("Kpowerdns.com.+008+44030.ds")
  end
end
