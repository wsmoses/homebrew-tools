class Cilkrts < Formula
  desc "Cilkrts compiler"
  homepage "http://github.com/wsmoses/Parallel-IR"

  stable do
    url "https://www.cilkplus.org/sites/default/files/runtime_source/cilkplus-rtl-004467.tgz"
    sha256 "e3cc83e42afe34c03da7938b79cdebc3b7f3237d3734a4d45c9ad91d7abe475e"
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

  # version suffix
  def ver
    "1.0"
  end

  def install

    install_prefix = lib/"cilkrts-#{ver}"

    args = %W[
      -DCMAKE_INSTALL_PREFIX=#{install_prefix}
      -DCMAKE_C_COMPILER=clang-5.0
      -DCMAKE_CXX_COMPILER=clang++-5.0 
    ]

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "cmake", "--build", "."
      system "cmake", "--build", ".", "--target", "install"
    end

  end
end
