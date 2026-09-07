class SeexApp < Formula
  desc "Native desktop curve viewer for Seex"
  homepage "https://github.com/reformovo/seex"
  url "https://github.com/reformovo/seex/archive/refs/tags/v0.1.0-beta.4.tar.gz"
  sha256 "b42e28436b5677164edfce685084dc8632c71bee7fe026a419b371145837d85d"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/reformovo/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2dfc2961e8707fce507a7fca614abd12e598a0dde26959cb592be93eac879838"
  end

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
