cask "macbox" do
  version "0.2.9"
  sha256 "f1c7715bd5e5ff4fb1458260025a376601cc3cee88e866bda4a12e1d50e1243a"

  url "https://github.com/Moonif/MacBox/releases/download/#{version}/MacBox.app.zip"
  name "MacBox for 86Box"
  desc "86Box emulator manager to make it easier to handle multiple virtual machines"
  homepage "https://github.com/Moonif/MacBox"

  livecheck do
    url "https://github.com/Moonif/MacBox"
    strategy :github_latest
  end

  depends_on macos: ">= :high_sierra"

  app "MacBox.app"

  zap trash: [
    "~/Library/Caches/Moonif.MacBox",
    "~/Library/HTTPStorages/Moonif.MacBox",
    "~/Library/Preferences/Moonif.MacBox.plist",
  ]

  caveats <<~EOS
    #{token} requires 86box to operate.

    You can use the official cask:

      brew install --cask 86box

    Or use the nightly version from this tap:

      brew install --cask theaifam5/86box-nightly
  EOS
end
