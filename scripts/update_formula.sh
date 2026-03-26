#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_REPO="${UPSTREAM_REPO:-OsamuDazai666/ani-nexus-tui}"
RELEASE_TAG="${RELEASE_TAG:-}"

if [[ -n "$RELEASE_TAG" ]]; then
  API_URL="https://api.github.com/repos/${UPSTREAM_REPO}/releases/tags/${RELEASE_TAG}"
else
  API_URL="https://api.github.com/repos/${UPSTREAM_REPO}/releases/latest"
fi

release_json="$(curl -fsSL "$API_URL")"

tag="$(jq -r '.tag_name' <<<"$release_json")"
version="${tag#v}"

asset_digest() {
  local asset_name="$1"
  jq -r --arg n "$asset_name" '.assets[] | select(.name == $n) | .digest | sub("^sha256:"; "")' <<<"$release_json"
}

macos_arm_sha="$(asset_digest "ani-nexus-tui-aarch64-apple-darwin.tar.xz")"
macos_x64_sha="$(asset_digest "ani-nexus-tui-x86_64-apple-darwin.tar.xz")"
linux_x64_sha="$(asset_digest "ani-nexus-tui-x86_64-unknown-linux-gnu.tar.xz")"
linux_bottle_sha="$(asset_digest "ani-nexus-tui--${version}.x86_64_linux.bottle.tar.gz")"

for value in "$version" "$macos_arm_sha" "$macos_x64_sha" "$linux_x64_sha"; do
  if [[ -z "$value" || "$value" == "null" ]]; then
    echo "Missing required release metadata from ${API_URL}" >&2
    exit 1
  fi
done

bottle_block=""
if [[ -n "$linux_bottle_sha" && "$linux_bottle_sha" != "null" ]]; then
  bottle_block="$(cat <<EOF
  bottle do
    root_url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/${tag}"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "${linux_bottle_sha}"
  end

EOF
)"
else
  echo "Linux bottle asset not found for ${tag}; generating formula without bottle block." >&2
fi

cat > Formula/ani-nexus-tui.rb <<EOF
class AniNexusTui < Formula
  desc "Blazing-fast TUI for Anime"
  homepage "https://github.com/OsamuDazai666/ani-nexus-tui"
  version "${version}"
  license "CC-BY-NC-SA-4.0"

${bottle_block}

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/${tag}/ani-nexus-tui-aarch64-apple-darwin.tar.xz"
      sha256 "${macos_arm_sha}"
    else
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/${tag}/ani-nexus-tui-x86_64-apple-darwin.tar.xz"
      sha256 "${macos_x64_sha}"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/OsamuDazai666/ani-nexus-tui/releases/download/${tag}/ani-nexus-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "${linux_x64_sha}"
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
EOF

echo "Updated Formula/ani-nexus-tui.rb to ${tag}"
