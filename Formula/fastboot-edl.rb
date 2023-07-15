class FastbootEdl < Formula
  LIBBUILDVERSION_COMMIT_ID = "61d6748027ad43dee7bf96d26b2cd59dec0fed64".freeze
  LIBBASE_COMMIT_ID = "270063f54b2b1152367a76cd018eb8c155bc6d98".freeze
  CORE_COMMIT_ID = "a24e8f972f52a903b898fe7a8223f06bd86736eb".freeze
  LIBZIPARCHIVE_COMMIT_ID = "8fc2060e5cab634ac87e453c24f4d404e8de1c97".freeze
  LOGGING_COMMIT_ID = "a95edfc827a4f1038776bf9e8951fe0c7f7ded2b".freeze
  EXTRAS_COMMIT_ID = "f0d2b53d1d887b61e635e81db72a8da23fbcb1fd".freeze
  MKBOOTIMG_COMMIT_ID = "6aa8ca743fad98954aba9994ac5178e9c63b1c1d".freeze
  EXTERNAL_FMTLIB_COMMIT_ID = "695001ee76a2d3fb5a8ae71caa8d80bb8b780592".freeze
  EXTERNAL_AVB_COMMIT_ID = "f45d8524cb404170f6c629beb87dadc5777c46e7".freeze
  EXTERNAL_GOOGLETEST_COMMIT_ID = "52f1f6e0fcc35f9f3e0a9c8ef1385fdd0dbc2e14".freeze

  desc "Fastboot protocol for communicating with bootloaders over USB or ethernet"
  homepage "https://android.googlesource.com/platform/system/core/+/master/fastboot/"
  url "https://android.googlesource.com/platform/system/core/+archive/b2631b9ec54fc26a87b1ae8f603f7a899d090616/fastboot.tar.gz"
  version "34.0.3"
  sha256 "696b83a184790d810679a604e0b39ffe5b23ff467917a50b70ed85215e0ac3bc"
  license "Apache-2.0"

  livecheck do
    skip "No version information available"
  end

  depends_on "openssl@3"
  depends_on "zlib"

  resource "libbuildversion" do
    url "https://android.googlesource.com/platform/build/soong/+archive/#{LIBBUILDVERSION_COMMIT_ID}/cc/libbuildversion.tar.gz"
    sha256 "2c6d9e11aa454a7c6df496041d1bf403058ce7a2991580492fdfcc59b0df4b0f"
  end

  resource "libbase" do
    url "https://android.googlesource.com/platform/system/libbase/+archive/#{LIBBASE_COMMIT_ID}.tar.gz"
    sha256 "85ad09d751baf571be4daf7604ae55f17c786cb3637bcf3e18b63432e133f290"
  end

  resource "liblp" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/fs_mgr/liblp.tar.gz"
    sha256 "e353e8312cac628d8c4306519f6d495c20ecb0b24f25f3e538c4f7daec0fa5dd"
  end

  resource "libsparse" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/libsparse.tar.gz"
    sha256 "3153e612bb249c919b79f7cb3e1bda92602d7f13d6e60ceddbf137d5dcf5cacd"
  end

  resource "libcutils" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/libcutils.tar.gz"
    sha256 "864024162ddfc84a6b7606241ac9088bd4d054620da9e67e2e2eafc0e0eda7e9"
  end

  resource "libstorage_literals" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/fs_mgr/libstorage_literals.tar.gz"
    sha256 "37abdb89faae2e74ac3cf69dc226a108e92f35ed2a7a050685786599eeada6ae"
  end

  resource "diagnose_usb" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/diagnose_usb.tar.gz"
    sha256 "7ce5dc5b0a8dd486c817302f7941668d52a6a59bf18ecd49c74faa951022030d"
  end

  resource "libziparchive" do
    url "https://android.googlesource.com/platform/system/libziparchive/+archive/#{LIBZIPARCHIVE_COMMIT_ID}.tar.gz"
    sha256 "ca992e60dc7f22baf33a2c8cf941903f83952488004b13c35f5c9a80bc990a8d"
  end

  resource "liblog" do
    url "https://android.googlesource.com/platform/system/logging/+archive/#{LOGGING_COMMIT_ID}/liblog.tar.gz"
    sha256 "d9f4289858b05d491bcf7808451fa30e9a6f9f14e8753fd3814ad29ac938894f"
  end

  resource "ext4_utils" do
    url "https://android.googlesource.com/platform/system/extras/+archive/#{EXTRAS_COMMIT_ID}/ext4_utils.tar.gz"
    sha256 "db0329e9ff8224e877cc7b227fb4cd0a9c721f35a01ff882d98bdf4922c11c18"
  end

  resource "mkbootimg" do
    url "https://android.googlesource.com/platform/system/tools/mkbootimg/+archive/#{MKBOOTIMG_COMMIT_ID}.tar.gz"
    sha256 "8f5847510fddc88f3ec7538ac58122968183d29f96430822eedafb64691381af"
  end

  resource "libfmt" do
    url "https://android.googlesource.com/platform/external/fmtlib/+archive/#{EXTERNAL_FMTLIB_COMMIT_ID}.tar.gz"
    sha256 "7db1b58543d4983b459c4659966ff5cb60efc7f858f7825e7ca703704c1c7902"
  end

  resource "libavb" do
    url "https://android.googlesource.com/platform/external/avb/+archive/#{EXTERNAL_AVB_COMMIT_ID}.tar.gz"
    sha256 "c4d1e1bf086eccfc3cb029fd8a0d73064e119adbe112eb5616ed7d05ea447333"
  end

  resource "googletest" do
    url "https://android.googlesource.com/platform/external/googletest/+archive/#{EXTERNAL_GOOGLETEST_COMMIT_ID}.tar.gz"
    sha256 "696b83a184790d810679a604e0b39ffe5b23ff467917a50b70ed85215e0ac3bc"
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

    (buildpath/"platform_tools_version.h").write "#define PLATFORM_TOOLS_VERSION \"#{version}\""

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
      "-I./libziparchive/include", "-I./libziparchive/incfs_support/include",
      "-I./diagnose_usb/include", "-I./liblog/include",
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
      "libziparchive/zip_archive.cc", "libziparchive/zip_archive_stream_entry.cc",
      "libziparchive/zip_error.cpp", "libziparchive/zip_cd_entry_map.cc",
      "diagnose_usb/diagnose_usb.cpp",
      "libbase/file.cpp",
      "libsparse/sparse.cpp", "libsparse/sparse_read.cpp", "libsparse/backed_block.cpp",
      "libsparse/output_file.cpp", "libsparse/sparse_crc32.cpp", "libsparse/sparse_err.cpp",
      "libbase/logging.cpp", "libbase/mapped_file.cpp", "libbase/stringprintf.cpp",
      "libbase/parsenetaddress.cpp", "libbase/strings.cpp", "libbase/threads.cpp",
      "libbase/errors_unix.cpp", "libbase/properties.cpp", "libbase/parsebool.cpp",
      "libbase/posix_strerror_r.cpp",
      "libcutils/sockets.cpp", "libcutils/sockets_unix.cpp",
      "libcutils/socket_inaddr_any_server_unix.cpp", "libcutils/socket_network_client_unix.cpp",
      "liblp/builder.cpp", "liblp/images.cpp", "liblp/reader.cpp",
      "liblp/super_layout_builder.cpp", "liblp/utility.cpp", "liblp/writer.cpp",
      "liblp/partition_opener.cpp", "liblp/property_fetcher.cpp",
      "ext4_utils/ext4_utils.cpp", "ext4_utils/ext4_sb.cpp",
      "libbuildversion/libbuildversion.cpp",
      "liblog/logger_write.cpp", "liblog/properties.cpp"

    bin.install "fastboot" => "fastboot-edl"
  end

  test do
    assert_match "flashing:", shell_output("#{bin}/fastboot-edl --help")
  end
end
