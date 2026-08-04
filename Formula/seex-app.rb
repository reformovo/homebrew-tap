class SeexApp < Formula
  desc "Native desktop curve viewer for Seex"
  homepage "https://github.com/reformovo/seex"
  url "https://github.com/reformovo/seex/archive/refs/tags/v0.1.0-beta.2.tar.gz"
  sha256 "c209dec60d440470e8b8477f66697b92074773a4803b40576f2a9f0d6cdbadda"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/reformovo/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "07ec183e0d5ac2f47accec1452815a5d6399a8c5ac091f0823567b2958e7b0b7"
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
