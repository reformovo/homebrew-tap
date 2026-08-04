class SeexApp < Formula
  desc "Native desktop curve viewer for Seex"
  homepage "https://github.com/reformovo/seex"
  url "https://github.com/reformovo/seex/releases/download/v0.1.0-beta.1/seex-app-macos-aarch64"
  version "0.1.0-beta.1"
  sha256 "ded8b5569604a28d2e4b87b0e0d2c12440495175fb89b9698504bc9efb379eb5"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "seex-app-macos-aarch64" => "seex-app"
  end

  test do
    output = shell_output("#{bin}/seex-app first second 2>&1", 2)
    assert_match "usage: seex-app [PROJECT_PATH]", output
  end
end
