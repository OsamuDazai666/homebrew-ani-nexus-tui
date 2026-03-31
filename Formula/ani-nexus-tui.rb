class AniNexusTui < Formula
  desc "Blazing-fast TUI for Anime"
  homepage "https://github.com/OsamuDazai666/ani-nexus-tui"
  version "0.1.3"
  license "CC-BY-NC-SA-4.0"

  bottle do
    root_url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f9343945327941057e3747c8f0654e4943e8ccbd53558c4bf6bc1f24aa1abce1"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.3/ani-nexus-tui-aarch64-apple-darwin.tar.xz"
      sha256 "47970bba00b2e2e7ba586c932bab9df406cbb916a8389e9c3127a98d599d0114"
    else
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.3/ani-nexus-tui-x86_64-apple-darwin.tar.xz"
      sha256 "0de2f669f864125b31d4eeaf1e34389ff1312b7efe1783ffd31d37aa4627224f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      depends_on "gcc" => :build
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.3/ani-nexus-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fd0bbbfaf95cac53a6fa3ee733b433ff7923fdcdcebb54fea6a2cbcc410f2c31"
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
