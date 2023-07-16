cask "86box-nightly" do
  version :latest
  sha256 :no_check

  url do
    require "open-uri"
    base_url = "https://ci.86box.net/job/86Box/lastSuccessfulBuild"
    file = JSON.parse(URI.parse("#{base_url}/api/json").open.string)["artifacts"].find do |artifact|
             artifact["fileName"].start_with?("86Box-macOS-")
           end["relativePath"]
    "#{base_url}/artifact/#{ERB::Util.url_encode(file)}"
  end
  name "86Box"
  desc "Emulator of x86-based machines based on PCem"
  homepage "https://86box.net/"

  conflicts_with cask: ["86box", "86box-ndr-nightly"]
  depends_on macos: ">= :high_sierra"

  app "86Box.app", target: "86Box/86Box.app"

  roms_dir = Pathname("~/Library/Application Support/net.86box.86Box/roms")

  preflight do
    roms_dir.expand_path.mkpath
  end

  zap trash: [
    "/Applications/86Box",
    "~/Library/Application Support/net.86box.86Box",
    "~/Library/Saved Application State/net.86Box.86Box.savedState",
  ]

  caveats do
    <<~EOS
      ROM files from https://github.com/86Box/roms need to be installed into
        #{roms_dir}
    EOS
  end
end
