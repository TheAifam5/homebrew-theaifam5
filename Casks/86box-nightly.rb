cask "86box-nightly" do
  version "3.11,4714"
  sha256 "8e9d434c0fb460a2e6ca0b40bdbbfc5191d8827764757d19bf6a1560a58cdad7"

  url "https://ci.86box.net/job/86Box/#{version.csv.second}/artifact/Old%20Recompiler%20(recommended)/macOS%20-%20Universal%20(Intel%20and%20Apple%20Silicon)/86Box-macOS-x86_64+arm64-#{version.csv.second}.zip",
      verified: "github.com/86Box/86Box/"
  name "86Box"
  desc "Emulator of x86-based machines based on PCem"
  homepage "https://86box.net/"

  livecheck do
    url "https://ci.86box.net/job/86Box/api/json"
    strategy :json do |json|
      "3.11,#{json["lastStableBuild"]["number"]}"
    end
  end

  conflicts_with cask: "86box"
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
