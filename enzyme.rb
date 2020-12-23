class Enzyme < Formula
  desc "Enzyme Automatic Differentiation"
  homepage "https://enzyme.mit.edu"
  version "1.0-4"

  head do
    url "http://github.com/wsmoses/Enzyme.git"
  end

  depends_on "llvm"
  depends_on "cmake" => :build

  def install

    args = %W[
      -DLLVM_DIR=#{Formula["llvm"].opt_lib}/cmake/llvm
    ]

    mktemp do
      system "cmake", buildpath+"/enzyme", *(std_cmake_args + args)
      system "cmake", "--build", "."
      system "cmake", "--build", ".", "--target", "install"
    end

  end
end
