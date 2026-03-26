# homebrew-ani-nexus-tui

Homebrew tap for `ani-nexus-tui`.

## Install

```bash
brew tap OsamuDazai666/ani-nexus-tui
brew install ani-nexus-tui
ani-nexus-tui --version
```

`ani-nexus` and `ani-nexus-tui` both point to the same executable.

## Files

- `Formula/ani-nexus-tui.rb`: Homebrew formula
- `scripts/update_formula.sh`: Regenerates formula from latest upstream release metadata
- `.github/workflows/update-formula.yml`: Updates and commits formula in this tap

## Automation Flow

1. Upstream repo publishes a release tag (for example `v0.1.1`).
2. Upstream workflow dispatches `update-formula` to this tap.
3. This tap workflow runs `scripts/update_formula.sh`, commits formula updates, and pushes.

## Required Upstream Secrets

Set these in the upstream repo (`ani-nexus-tui`):

- `HOMEBREW_TAP_REPO` (example: `OsamuDazai666/homebrew-ani-nexus-tui`)
- `HOMEBREW_TAP_TOKEN` (PAT with access to the tap repo)
