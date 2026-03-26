class AniNexusTui < Formula
  desc "Blazing-fast TUI for Anime"
  homepage "https://github.com/OsamuDazai666/ani-nexus-tui"
  version "0.1.1"
  license "CC-BY-NC-SA-4.0"

  bottle do
    root_url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c454fb5d10b0482daf5f75f4347ef4a241df4581879e1290274395467431d270"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-aarch64-apple-darwin.tar.xz"
      sha256 "d0eaaaee82a3820b792edcc6cf20c0806a802ec257e27d7d5595271b031b4c66"
    else
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-x86_64-apple-darwin.tar.xz"
      sha256 "90ef42946ea639034a6434996370020244fd606c5e1396f4e97dba927923fd2c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      depends_on "gcc" => :build
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fbc4da356ac7d11e00726794c6baa9e3a601b9a62364c2de486691b500b4b238"
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
