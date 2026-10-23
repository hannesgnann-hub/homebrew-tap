class Easyalias < Formula
  desc "Graphical manager for terminal aliases"
  homepage "https://easyalias.org"
  url "https://github.com/hannesgnann-hub/easyalias/releases/download/v1.1.1/Linux_EasyAlias_1.1.1_arm64.deb",
      using: :nounzip
  version "1.1.1"
  sha256 "de58f74ae54441a3e9021361019ca5fcdc8fa2a4690994e055abe39f46892386"
  license "MIT"

  depends_on "binutils" => :build
  depends_on arch: :arm64
  depends_on "gtk+3"
  depends_on :linux
  depends_on "webkitgtk"

  def install
    system "ar", "x", "Linux_EasyAlias_1.1.1_arm64.deb"
    system "tar", "-xzf", "data.tar.gz"

    libexec.install "usr/bin/easyalias"
    (bin/"easyalias").write_env_script libexec/"easyalias",
                                             LD_LIBRARY_PATH: [
                                               formula_opt_lib("gtk+3"),
                                               formula_opt_lib("webkitgtk"),
                                               "$LD_LIBRARY_PATH",
                                             ].join(":")
    (share/"applications").install "usr/share/applications/EasyAlias.desktop"
    (share/"icons/hicolor/512x512/apps").install "usr/share/icons/hicolor/512x512/apps/easyalias.png"
  end

  def caveats
    <<~EOS
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
