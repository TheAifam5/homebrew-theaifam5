class Stduuid < Formula
  desc "C++17 cross-platform implementation for UUIDs"
  homepage "https://github.com/mariusbancila/stduuid"
  url "https://github.com/mariusbancila/stduuid/archive/v1.2.3.tar.gz"
  sha256 "b1176597e789531c38481acbbed2a6894ad419aab0979c10410d59eb0ebf40d3"
  license "MIT"
  head "https://github.com/mariusbancila/stduuid.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/theaifam5/theaifam5"
    sha256 cellar: :any_skip_relocation, ventura:      "d5ce9afb4258d81a3a4744ebc40a7dced254bcf6614e63fd4a63fea4f5708d40"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6fe8749302aaad58b32ca661440ef0daa7a9ebe7e926f4643db84014a9b50a43"
  end

  option "with-system-generator", "Enable operating system uuid generator"
  option "with-time-generator", "Enable experimental time-based uuid generator"
  option "with-cxx20-span", "Using span from std instead of gsl"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build",
      "-DUUID_BUILD_TESTS=OFF",
      "-DUUID_ENABLE_INSTALL=ON",
      "-DUUID_SYSTEM_GENERATOR=#{build.with?("system-generator") ? "ON" : "OFF"}",
      "-DUUID_TIME_GENERATOR=#{build.with?("time-generator") ? "ON" : "OFF"}",
      "-DUUID_USING_CXX20_SPAN=#{build.with?("cxx20-span") ? "ON" : "OFF"}",
      *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
