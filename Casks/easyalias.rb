cask "easyalias" do
  version "1.1.1"
  sha256 "7b9fb7af73f34b8c2d0030843965a9651290e2ec66496e2f14e58567b792f6b7"

  url "https://github.com/hannesgnann-hub/easyalias/releases/download/v#{version}/Mac_EasyAlias_#{version}.app.zip"
  name "EasyAlias"
  desc "Graphical manager for terminal aliases"
  homepage "https://easyalias.org/"

  depends_on macos: :sonoma

  app "EasyAlias_#{version}.app", target: "EasyAlias.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-cr", "{{appdir}}/EasyAlias.app"],
        sudo: true
    run "/usr/bin/codesign",
        args: ["--force", "--deep", "--sign", "-", "{{appdir}}/EasyAlias.app"],
        sudo: true
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/EasyAlias.app"],
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
