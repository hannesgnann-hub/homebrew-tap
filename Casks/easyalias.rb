cask "easyalias" do
  version "1.0.1"
  sha256 "06a06c2b8a5c28a3c790538e2cadcb2bacf996c5e863859824fb3c4afe4d9c2d"

  url "https://raw.githubusercontent.com/hannesgnann-hub/easyalias/d1c2a9b9a8b0902456ec2108842582955d34254a/mac_export/EasyAlias.zip",
      verified: "raw.githubusercontent.com/hannesgnann-hub/easyalias/"
  name "EasyAlias"
  desc "Graphical manager for terminal aliases"
  homepage "https://github.com/hannesgnann-hub/easyalias"

  depends_on macos: :sonoma

  app "EasyAlias.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/EasyAlias.app"],
                   sudo: true
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/EasyAlias.app"],
                   sudo: true
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/EasyAlias.app"],
                   sudo: true
  end

  zap trash: [
    "~/.easyalias",
    "~/Library/Application Support/EasyAlias",
    "~/Library/Caches/EasyAlias",
    "~/Library/Preferences/com.easyalias.app.plist",
  ]

  caveats <<~EOS
    EasyAlias v#{version} is not notarized yet. This cask locally ad-hoc signs the
    installed app and removes Apple's quarantine attribute after installation.

    For public releases, the preferred long-term fix is to ship a Developer ID
    signed and notarized macOS asset.
  EOS
end
