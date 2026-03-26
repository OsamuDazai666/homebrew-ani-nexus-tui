class AniNexusTui < Formula
  desc "Blazing-fast TUI for Anime"
  homepage "https://github.com/OsamuDazai666/ani-nexus-tui"
  version "0.1.1"
  license "CC-BY-NC-SA-4.0"



  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-aarch64-apple-darwin.tar.xz"
      sha256 "1c0a76da70f52afa9ec4ba453e4e7a6a05246bd9129de41f13ea3526b292a386"
    else
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-x86_64-apple-darwin.tar.xz"
      sha256 "9da0fa5e53a3a13433ff9b8d963ecb88795c8d7264d834c55d7334772d15c7a8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.1/ani-nexus-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c6770f41fde42a83431f193e3530f0881d78a82a45b4eb0c56cc9ddc64a01708"
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
