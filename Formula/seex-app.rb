class SeexApp < Formula
  desc "Native desktop curve viewer for Seex"
  homepage "https://github.com/reformovo/seex"
  url "https://github.com/reformovo/seex/archive/refs/tags/v0.1.0-beta.6.tar.gz"
  sha256 "77c73265a87fd04e5a59bfcf02b85ccd8c92dbdacaa5802de99fff76292439e1"
  license "MIT"

  depends_on "cargo-bundle" => :build
  depends_on "rust" => :build
  depends_on arch: :arm64
  depends_on :macos

  def install
    cd "crates/seex-app" do
      system "cargo", "bundle", "--release", "--format", "osx"
    end

    app = "target/release/bundle/osx/Seex.app"
    system "/usr/bin/codesign", "--force", "--deep", "--sign", "-", app
    prefix.install app
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
