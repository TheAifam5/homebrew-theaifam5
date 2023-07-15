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
  sha256 "a2fa84c74107d0b1d3796865b37a1c0cc481204d4370349aeb9854970c263651"
  license "Apache-2.0"

  livecheck do
    skip "No version information available"
  end

  depends_on "openssl@3"
  depends_on "zlib"

  resource "libbuildversion" do
    url "https://android.googlesource.com/platform/build/soong/+archive/#{LIBBUILDVERSION_COMMIT_ID}/cc/libbuildversion.tar.gz"
    sha256 "901d05c3f3367481db554d339b42944b30f46ae736bd04bbd1f0032746c7e3bb"
  end

  resource "libbase" do
    url "https://android.googlesource.com/platform/system/libbase/+archive/#{LIBBASE_COMMIT_ID}.tar.gz"
    sha256 "65c5b3e2996ebad4d82aff8cca03677c31400b3be61312c67edc5352f5f74f02"
  end

  resource "liblp" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/fs_mgr/liblp.tar.gz"
    sha256 "85f701310865e979ffd6e6395c676171ed6cb29838ad1cb248616329f2be304d"
  end

  resource "libsparse" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/libsparse.tar.gz"
    sha256 "b80c10c04edf15db8ae628682bd552a9b85ef0b2031645e713df81d5a37a9ee9"
  end

  resource "libcutils" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/libcutils.tar.gz"
    sha256 "b7f7e2c44a0e8a76cd9a077b3339d8c4c367baf5fc9321ac1acf4db866e7f6f9"
  end

  resource "libstorage_literals" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/fs_mgr/libstorage_literals.tar.gz"
    sha256 "67bd6e79d71a6735c1533331795cb861fb90c80e623f9c0fd61f280b462d2a10"
  end

  resource "diagnose_usb" do
    url "https://android.googlesource.com/platform/system/core/+archive/#{CORE_COMMIT_ID}/diagnose_usb.tar.gz"
    sha256 "97fe85abf8dde34458d923e8e328eb1e8547c64a1347b2a65c249fbf80f77626"
  end

  resource "libziparchive" do
    url "https://android.googlesource.com/platform/system/libziparchive/+archive/#{LIBZIPARCHIVE_COMMIT_ID}.tar.gz"
    sha256 "2ce1150772629bd3b43fcab609cd110fcf49e6cde0cef25af21127438c2d2f01"
  end

  resource "liblog" do
    url "https://android.googlesource.com/platform/system/logging/+archive/#{LOGGING_COMMIT_ID}/liblog.tar.gz"
    sha256 "5bdf6fec73a755eb27662969ed6350a8e748de07e0f545537f18bed0fad35553"
  end

  resource "ext4_utils" do
    url "https://android.googlesource.com/platform/system/extras/+archive/#{EXTRAS_COMMIT_ID}/ext4_utils.tar.gz"
    sha256 "3d5dafaa210228175cd6b98cef6ee6dff1bd9ccfcd8a7b3fefa6932241957734"
  end

  resource "mkbootimg" do
    url "https://android.googlesource.com/platform/system/tools/mkbootimg/+archive/#{MKBOOTIMG_COMMIT_ID}.tar.gz"
    sha256 "6bb595c666bbe29ad394e811db3a691adf9d11f536932cbf6d154b06cdb9e941"
  end

  resource "libfmt" do
    url "https://android.googlesource.com/platform/external/fmtlib/+archive/#{EXTERNAL_FMTLIB_COMMIT_ID}.tar.gz"
    sha256 "83b8f8abf4cea81ff13a5c37c1ffd4586edb8028ae9a60ece59a19c309d5b818"
  end

  resource "libavb" do
    url "https://android.googlesource.com/platform/external/avb/+archive/#{EXTERNAL_AVB_COMMIT_ID}.tar.gz"
    sha256 "a953f42bb1bfb164d378d39682c9b76082ae2645bd2b0482a8da303a21f5b286"
  end

  resource "googletest" do
    url "https://android.googlesource.com/platform/external/googletest/+archive/#{EXTERNAL_GOOGLETEST_COMMIT_ID}.tar.gz"
    sha256 "c855f5a21fe61d373684260a1c4a4a7678e744e41f1ec9e7854645178b8ca6bb"
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
