class AniNexusTui < Formula
  desc "Blazing-fast TUI for Anime"
  homepage "https://github.com/OsamuDazai666/ani-nexus-tui"
  version "0.1.0"
  license "CC-BY-NC-SA-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.0/ani-nexus-tui-aarch64-apple-darwin.tar.xz"
      sha256 "521a9cf03ff7b18b066f15722d102c5bed10403301d51dd4f36272f698cbdc5c"
    else
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.0/ani-nexus-tui-x86_64-apple-darwin.tar.xz"
      sha256 "f9678b67a65593f48d35ed9571c5e4be42099afcaac6123bb49779a4208b9956"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/v0.1.0/ani-nexus-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "93d52e7ba34ca0ba921009af0edbdbc3839032b0092e75ec8a598a2ccf76b038"
    else
      odie "ani-nexus-tui currently publishes Homebrew Linux assets for x86_64 only"
    end
  end

  def install
    binary = Dir["**/ani-nexus"].first
    odie "ani-nexus binary not found in archive" if binary.nil?

    bin.install binary => "ani-nexus"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ani-nexus --version")
  end
end
