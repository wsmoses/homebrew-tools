class Cilkrts < Formula
  desc "Cilk runtime system"
  homepage "http://cilk.mit.edu"
  version "1.0-1"

  stable do
    url "http://cilk.mit.edu/cilkrts.tgz"
    sha256 "7b2ff7b57e621567765fb6a9dada820f7fffff99a5958ae286bd1c7ac37ac732"
  end

  head do
    url "http://github.com/CilkHub/cilkrts.git"
  end

  depends_on "libffi"
  depends_on "tapir"
  depends_on "cmake" => :build

  # requires gcc >= 4.8
  fails_with :gcc_4_0
  fails_with :gcc
  ("4.3".."4.7").each do |n|
    fails_with :gcc => n
  end

  def ver
    return "1.0"
  end

  def install

    install_prefix = lib/"cilkrts-#{ver}"

    args = %W[
      -DCMAKE_INSTALL_PREFIX=#{install_prefix}
      -DCMAKE_C_COMPILER=/usr/local/opt/tapir/bin/clang
      -DCMAKE_CXX_COMPILER=/usr/local/opt/tapir/bin/clang++
    ]

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "cmake", "--build", "."
      system "cmake", "--build", ".", "--target", "install"
    end

  end
end
