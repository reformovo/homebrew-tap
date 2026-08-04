class SeexApp < Formula
  desc "Native desktop curve viewer for Seex"
  homepage "https://github.com/reformovo/seex"
  url "https://github.com/reformovo/seex/archive/refs/tags/v0.1.0-beta.3.tar.gz"
  sha256 "114e83b035f7ad683aa01e04891e2d335908299c4f08a6035582028f591f4126"
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
