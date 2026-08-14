class Easyalias < Formula
  desc "Graphical manager for terminal aliases"
  homepage "https://easyalias.org"
  url "https://raw.githubusercontent.com/hannesgnann-hub/easyalias/096163aa5baff744dfa35bd3b1e1d79f0817748b/linux_export/EasyAlias_0.1.0_arm64.deb.zip"
  version "1.0.2"
  sha256 "738a6eb45040903b1e2c091f54f6e879382466a243a024fd9ba9c3580c66724f"
  license "MIT"

  depends_on "binutils" => :build
  depends_on arch: :arm64
  depends_on "gtk+3"
  depends_on :linux
  depends_on "webkitgtk"

  def install
    system "ar", "x", "EasyAlias_0.1.0_arm64.deb"
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
