class AniNexusTui < Formula
  desc "Blazing-fast TUI for Anime"
  homepage "https://github.com/OsamuDazai666/ani-nexus-tui"
  version "0.1.1"
  license "CC-BY-NC-SA-4.0"

  bottle do
    root_url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f749fb090d35ee4a0daee8c6556111096546d7958d439feec9e9a05f787b477c"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-aarch64-apple-darwin.tar.xz"
      sha256 "07b79f21814a160ad693289b78667a8d25b84a4a4526c88a2166929da9973af5"
    else
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-x86_64-apple-darwin.tar.xz"
      sha256 "05eb49a45a007516c514dafd1fe4f05f73da1080e2f2170445e09ec71ad077b1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      depends_on "gcc" => :build
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0073aa7c2bf0c3f91aa3b435f7b1ac70329d47240851da0a4dbc762fb622672c"
    else
      odie "ani-nexus-tui currently publishes Homebrew Linux assets for x86_64 only"
    end
  end

  def install
    binary = Dir["**/ani-nexus"].first
    odie "ani-nexus binary not found in archive" if binary.nil?

    bin.install binary => "ani-nexus"
    bin.install_symlink "ani-nexus" => "ani-nexus-tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ani-nexus --version")
    assert_predicate bin/"ani-nexus-tui", :exist?
  end
end
