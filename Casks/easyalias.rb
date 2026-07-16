cask "easyalias" do
  version "1.0.0"
  sha256 "832042885915bfc43f167655050dfdada594e86dc6582105e86c5977348a398a"

  url "https://github.com/hannesgnann-hub/easyalias/releases/download/v#{version}/EasyAlias_#{version}_Mac.zip"
  name "EasyAlias"
  desc "Graphical manager for terminal aliases"
  homepage "https://github.com/hannesgnann-hub/easyalias"

  depends_on macos: :sonoma

  app "EasyAlias.app"

  postflight do
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/EasyAlias.app"]
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
