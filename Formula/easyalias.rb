class Easyalias < Formula
  desc "Graphical manager for terminal aliases"
  homepage "https://github.com/hannesgnann-hub/easyalias"
  url "https://raw.githubusercontent.com/hannesgnann-hub/easyalias/d1c2a9b9a8b0902456ec2108842582955d34254a/linux_export/EasyAlias_0.1.0_arm64.deb.zip"
  version "1.0.1"
  sha256 "b7bb56683c4d212746cf1f8b4d1729ef44a187b33ca50b2d952a3dbb48960dd7"
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
