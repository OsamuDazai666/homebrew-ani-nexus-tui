class AniNexusTui < Formula
  desc "Blazing-fast TUI for Anime"
  homepage "https://github.com/OsamuDazai666/ani-nexus-tui"
  version "0.1.2"
  license "CC-BY-NC-SA-4.0"

  bottle do
    root_url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "913207a476b6f5ea2daed8405a4365184a0f2ba958f1226a0d524864181839d7"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.2/ani-nexus-tui-aarch64-apple-darwin.tar.xz"
      sha256 "5dcdaf0f8ca98d01562de26e248c04a487cadf07857fcf381c660c837100c87f"
    else
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.2/ani-nexus-tui-x86_64-apple-darwin.tar.xz"
      sha256 "1f4a5de5a1c129c4fb2f51f7cff469f0ecbe6de885063d17682218c9b5a902e8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      depends_on "gcc" => :build
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.2/ani-nexus-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "45c4b0c605699a8c9598100555d2dbfdba13328a6c9dc5c69d58a72a4557bd15"
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
