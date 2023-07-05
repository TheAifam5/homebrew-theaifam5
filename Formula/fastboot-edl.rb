
class FastbootEdl < Formula
  PLATFORM_SDK_VERSION = "34.0.3"

  desc "The fastboot protocol is a mechanism for communicating with bootloaders over USB or ethernet. It is designed to be very straightforward to implement, to allow it to be used across a wide range of devices and from hosts running Linux, macOS, or Windows."
  homepage "https://android.googlesource.com/platform/system/core/+/master/fastboot/"
  url "https://android.googlesource.com/platform/system/core/+archive/refs/tags/platform-tools-34.0.3/fastboot.tar.gz"
  sha256 "e583c8a1a7bdae22e8f5903a5e7581481857cd32ae5c145f3c8b29425dfe0622"
  license "APL-2.0"

  depends_on "openssl@3"
  depends_on "zlib"

  resource "libbase" do
    url "https://android.googlesource.com/platform/system/libbase/+archive/refs/tags/platform-tools-34.0.3.tar.gz"
    sha256 "7eb477832f3dabbb4937b189ef939567a3d3471664eab72f5ca77515358073f3"
  end

  resource "liblp" do
    url "https://android.googlesource.com/platform/system/core/+archive/refs/tags/platform-tools-34.0.3/fs_mgr/liblp.tar.gz"
    sha256 "0431b5809d25c5f83c6ef798aa2258b10bed4d4ffc180b7a1ab96b953f555649"
  end

  resource "libsparse" do
    url "https://android.googlesource.com/platform/system/core/+archive/refs/tags/platform-tools-34.0.3/libsparse.tar.gz"
    sha256 "efd5d87638fee898bd90a5db313840cb74c5c37d6cd71d56af72d72d40caf227"
  end

  resource "libcutils" do
    url "https://android.googlesource.com/platform/system/core/+archive/refs/tags/platform-tools-34.0.3/libcutils.tar.gz"
    sha256 "93dac0f88d75b0cde26932b22a3e908ce368900395fd03ac284f3a7be247b7de"
  end

  resource "libstorage_literals" do
    url "https://android.googlesource.com/platform/system/core/+archive/refs/tags/platform-tools-34.0.3/fs_mgr/libstorage_literals.tar.gz"
    sha256 "067e78f8a9dafeaf713d0e350b8ff1eb232437b181921725d73fad95bc5668b8"
  end

  resource "libfmt" do
    url "https://android.googlesource.com/platform/external/fmtlib/+archive/refs/tags/platform-tools-34.0.3.tar.gz"
    sha256 "f840bc92b9bebcade68004c8e0256118c0852c837a5df76da64cba832d45b43c"
  end

  resource "libavb" do
    url "https://android.googlesource.com/platform/external/avb/+archive/refs/tags/platform-tools-34.0.3.tar.gz"
    sha256 "c9cf12c25c5881679dba0d4d032281ddc36e9c94ff69b678367b204ff360bee9"
  end

  resource "libbuildversion" do
    url "https://android.googlesource.com/platform/build/soong/+archive/refs/tags/platform-tools-34.0.3/cc/libbuildversion.tar.gz"
    sha256 "fef13734d844606a6fe2e7ec54455880f36c3bee7bfdc0f4e44a0758282c871e"
  end

  resource "libziparchive" do
    url "https://android.googlesource.com/platform/system/libziparchive/+archive/refs/tags/platform-tools-34.0.3.tar.gz"
    sha256 "4228431f7df9d89f750cafe1142caebc3bd906dca889b53dcf14c6731308fa19"
  end

  resource "diagnose_usb" do
    url "https://android.googlesource.com/platform/system/core/+archive/refs/tags/platform-tools-34.0.3/diagnose_usb.tar.gz"
    sha256 "368e7df20077c18cbf19341706b7865b3f7f0fbfdb64ce3bc4b3fce027f86d72"
  end

  resource "liblog" do
    url "https://android.googlesource.com/platform/system/logging/+archive/refs/tags/platform-tools-34.0.3/liblog.tar.gz"
    sha256 "c88bd6cd1e20bb95dfc68200b4619ef621e52fc3e553d6727f31e4244f74a1e3"
  end

  resource "ext4_utils" do
    url "https://android.googlesource.com/platform/system/extras/+archive/refs/tags/platform-tools-34.0.3/ext4_utils.tar.gz"
    sha256 "bc71f0bffd92139db53171e0dd321081a141f492c16c5248cc4e3e7d12780341"
  end

  resource "googletest" do
    url "https://android.googlesource.com/platform/external/googletest/+archive/refs/tags/platform-tools-34.0.3.tar.gz"
    sha256 "3463c53c8fdad927888f2ab839c642f7f44aefc6f02764c352f79248fbf756cc"
  end

  resource "mkbootimg" do
    url "https://android.googlesource.com/platform/system/tools/mkbootimg/+archive/refs/tags/platform-tools-34.0.3.tar.gz"
    sha256 "18116b96e05ad6936566d2030eb8c7e1a49350c45ef9ac13d9270fb68c778109"
  end

  def install
    (buildpath/"libbase").install resource("libbase")
    (buildpath/"liblp").install resource("liblp")
    (buildpath/"libsparse").install resource("libsparse")
    (buildpath/"libfmt").install resource("libfmt")
    (buildpath/"libcutils").install resource("libcutils")
    (buildpath/"libstorage_literals").install resource("libstorage_literals")
    (buildpath/"libavb").install resource("libavb")
    (buildpath/"libbuildversion").install resource("libbuildversion")
    (buildpath/"libziparchive").install resource("libziparchive")
    (buildpath/"diagnose_usb").install resource("diagnose_usb")
    (buildpath/"liblog").install resource("liblog")
    (buildpath/"ext4_utils").install resource("ext4_utils")

    (buildpath/"googletest").install resource("googletest")

    (buildpath/"mkbootimg").install resource("mkbootimg")

    (buildpath/"platform_tools_version.h").write "#define PLATFORM_TOOLS_VERSION \"#{PLATFORM_SDK_VERSION}\""

    cd "libziparchive" do
      inreplace "zip_archive.cc", "zstream.next_in = buf;", "zstream.next_in = (Bytef *)buf;"
      inreplace "zip_archive_stream_entry.cc", "z_stream_.next_in = res;", "z_stream_.next_in = (Bytef *)res;"
    end
    
    system ENV.cxx,
      # flags
      "-Wno-narrowing",
      # includes
      "-I.", "-I./sdk", "-I./device", "-I./libbase/include",
      "-I./mkbootimg/include/bootimg", "-I./liblp/include", "-I./libsparse/include",
      "-I./libfmt/include", "-I./libcutils/include", "-I./libstorage_literals",
      "-I./googletest/googletest/include", "-I./libavb", "-I./libbuildversion/include",
      "-I./libziparchive/include", "-I./libziparchive/incfs_support/include", "-I./diagnose_usb/include", "-I./liblog/include",
      "-I./ext4_utils/include",
      "-I#{Formula["openssl@3"].include}", "-L#{Formula["openssl@3"].lib}", "-lssl", "-lcrypto",
      "-I#{Formula["zlib"].include}", "-L#{Formula["zlib"].lib}", "-lz",
      "-framework", "CoreFoundation", "-framework", "IOKit",
      "-std=c++20", "-stdlib=libc++", "-o", "fastboot",
      # fastboot
      "bootimg_utils.cpp", "fastboot.cpp", "fastboot_driver.cpp", "filesystem.cpp",
      "fs.cpp", "main.cpp", "socket.cpp",
      "storage.cpp", "super_flash_helper.cpp", "task.cpp",
      "tcp.cpp", "udp.cpp", "usb_osx.cpp",
      "util.cpp", "vendor_boot_img_utils.cpp",
      # vendor
      "libfmt/src/format.cc",
      "libziparchive/zip_archive.cc", "libziparchive/zip_archive_stream_entry.cc", "libziparchive/zip_error.cpp", "libziparchive/zip_cd_entry_map.cc",
      "diagnose_usb/diagnose_usb.cpp",
      "libbase/file.cpp",
      "libsparse/sparse.cpp", "libsparse/sparse_read.cpp", "libsparse/backed_block.cpp", "libsparse/output_file.cpp", "libsparse/sparse_crc32.cpp", "libsparse/sparse_err.cpp",
      "libbase/logging.cpp", "libbase/mapped_file.cpp", "libbase/stringprintf.cpp", "libbase/parsenetaddress.cpp", "libbase/strings.cpp", "libbase/threads.cpp", "libbase/errors_unix.cpp", "libbase/properties.cpp", "libbase/parsebool.cpp", "libbase/posix_strerror_r.cpp",
      "libcutils/sockets.cpp", "libcutils/sockets_unix.cpp", "libcutils/socket_inaddr_any_server_unix.cpp", "libcutils/socket_network_client_unix.cpp",
      "liblp/builder.cpp", "liblp/images.cpp", "liblp/reader.cpp", "liblp/super_layout_builder.cpp", "liblp/utility.cpp", "liblp/writer.cpp", "liblp/partition_opener.cpp", "liblp/property_fetcher.cpp",
      "ext4_utils/ext4_utils.cpp", "ext4_utils/ext4_sb.cpp",
      "libbuildversion/libbuildversion.cpp",
      "liblog/logger_write.cpp", "liblog/properties.cpp"

    bin.install "fastboot" => "fastboot-edl"
  end

  test do
    assert_match "flashing:", shell_output("#{bin}/fastboot-edl --help")
  end
end
