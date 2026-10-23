class Easyalias < Formula
  desc "Graphical manager for terminal aliases"
  homepage "https://easyalias.org"
  url "https://github.com/hannesgnann-hub/easyalias/releases/download/v1.1.1/Linux_EasyAlias_1.1.1_arm64.deb",
      using: :nounzip
  version "1.1.1"
  sha256 "de58f74ae54441a3e9021361019ca5fcdc8fa2a4690994e055abe39f46892386"
  license "MIT"
  revision 1

  depends_on "binutils" => :build
  depends_on arch: :arm64
  depends_on :linux

  def install
    system "ar", "x", "Linux_EasyAlias_1.1.1_arm64.deb"
    system "tar", "-xzf", "data.tar.gz"

    bin.install "usr/bin/easyalias"
    inreplace "usr/share/applications/EasyAlias.desktop",
              "Exec=easyalias", "Exec=#{bin}/easyalias"
    (share/"applications").install "usr/share/applications/EasyAlias.desktop"
    (share/"icons/hicolor/512x512/apps").install "usr/share/icons/hicolor/512x512/apps/easyalias.png"
  end

  def caveats
    <<~EOS
      EasyAlias uses the native Ubuntu desktop libraries. Install them with:
        sudo apt update
        sudo apt install libayatana-appindicator3-1 libwebkit2gtk-4.1-0 libgtk-3-0

      EasyAlias is currently available through this formula for ARM64 Linux.
      Start it from a terminal with:
        easyalias
    EOS
  end

  test do
    assert_predicate bin/"easyalias", :executable?
    assert_path_exists share/"applications/EasyAlias.desktop"
  end
end
