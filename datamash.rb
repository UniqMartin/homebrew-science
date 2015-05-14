class Datamash < Formula
  homepage "https://www.gnu.org/software/datamash"
  url "http://ftpmirror.gnu.org/datamash/datamash-1.0.6.tar.gz"
  sha256 "0154c25c45b5506b6d618ca8e18d0ef093dac47946ac0df464fb21e77b504118"

  head do
    url "git://git.savannah.gnu.org/datamash.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
  end

  bottle do
    cellar :any
    sha1 "28231bb8c1782e8453d9c2575792d2ea300c29f3" => :mavericks
    sha1 "67f68d8ab48a76ce80d7c68b32345d9a9dfea2aa" => :mountain_lion
    sha1 "c28075f2c254bc61485b2b20a8d778082bb46f92" => :lion
  end

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    assert_equal "55\n", shell_output("seq 10 |'#{bin}/datamash' sum 1")
  end
end
