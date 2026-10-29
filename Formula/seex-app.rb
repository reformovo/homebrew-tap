class SeexApp < Formula
  desc "Native desktop curve viewer for Seex"
  homepage "https://github.com/reformovo/seex"
  version "0.1.0-beta.6"
  url "https://github.com/reformovo/seex/releases/download/v0.1.0-beta.6/Seex-macos-aarch64.zip"
  sha256 "92ade4001d29adabc71775ec48276d3d0c7f26e3d7f4548bbadc1adfddbfbcac"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    prefix.install "Seex.app"
    bin.install_symlink prefix/"Seex.app/Contents/MacOS/seex-app" => "seex-app"
  end

  def caveats
    <<~EOS
      Launch the Seex app bundle with:
        open "#{opt_prefix}/Seex.app"
    EOS
  end

  test do
    assert_path_exists prefix/"Seex.app/Contents/Resources/Seex.icns"
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", prefix/"Seex.app"
    output = shell_output("#{bin}/seex-app first second 2>&1", 2)
    assert_match "usage: seex-app [PROJECT_PATH]", output
  end
end
