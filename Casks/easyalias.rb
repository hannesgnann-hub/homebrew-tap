cask "easyalias" do
  version "1.0.0"
  sha256 "832042885915bfc43f167655050dfdada594e86dc6582105e86c5977348a398a"

  url "https://github.com/hannesgnann-hub/easyalias/releases/download/v#{version}/EasyAlias_#{version}_Mac.zip"
  name "EasyAlias"
  desc "Graphical manager for terminal aliases"
  homepage "https://github.com/hannesgnann-hub/easyalias"

  depends_on macos: :sonoma

  app "EasyAlias.app"

  zap trash: [
    "~/.easyalias",
    "~/Library/Application Support/EasyAlias",
    "~/Library/Caches/EasyAlias",
    "~/Library/Preferences/com.easyalias.app.plist",
  ]
end
