class Cilkrts < Formula
  desc "Cilk runtime system"
  homepage "http://cilk.mit.edu"

  url "http://cilk.mit.edu/cilkrts.tgz"
  sha256 "1"

  depends_on "libffi"
  depends_on "tapir"
  depends_on "cmake" => :build

  # requires gcc >= 4.8
  fails_with :gcc_4_0
  fails_with :gcc
  ("4.3".."4.7").each do |n|
    fails_with :gcc => n
  end

  # version suffix
  def ver
    "1.1"
  end

  def install

    install_prefix = lib/"cilkrts-#{ver}"

    args = %W[
      -DCMAKE_INSTALL_PREFIX=#{install_prefix}
      -DCMAKE_C_COMPILER=clang-5.0
      -DCMAKE_CXX_COMPILER=clang++-5.0
      -DCMAKE_CXX_FLAGS="-I/usr/local/opt/tapir/lib/llvm-5.0/include/c++/v1"
      -DCMAKE_LD_FLAGS="-L/usr/local/opt/tapir/lib/llvm-5.0/lib"
    ]

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "cmake", "--build", "."
      system "cmake", "--build", ".", "--target", "install"
    end

  end
end
