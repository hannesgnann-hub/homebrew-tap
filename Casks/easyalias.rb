cask "easyalias" do
  version "1.0.2"
  sha256 "3ddbd02ee578ea1c38e297060d737f9bd85aa364645e644d4dd04e48adb218b6"

  url "https://raw.githubusercontent.com/hannesgnann-hub/easyalias/096163aa5baff744dfa35bd3b1e1d79f0817748b/mac_export/EasyAlias.zip",
      verified: "raw.githubusercontent.com/hannesgnann-hub/easyalias/"
  name "EasyAlias"
  desc "Graphical manager for terminal aliases"
  homepage "https://easyalias.org/"

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
