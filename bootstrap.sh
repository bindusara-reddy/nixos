#!/usr/bin/env bash
# One-command apply for this repo on the laptop's NixOS install.
# Safe to run repeatedly. Old generations stay in the boot menu regardless.
set -euo pipefail

HOST="hal-9000"
REPO_URL="https://github.com/bindusara-reddy/nixos"
DIR="${HOME}/nixos"

if [ ! -f /etc/NIXOS ]; then
  echo "This script is meant to run on the NixOS side of the laptop." >&2
  exit 1
fi

# run from inside a clone if we are in one, otherwise clone to ~/nixos
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "${SCRIPT_DIR}/flake.nix" ]; then
  DIR="${SCRIPT_DIR}"
elif [ ! -d "${DIR}" ]; then
  if command -v git >/dev/null; then
    git clone "${REPO_URL}" "${DIR}"
  else
    nix-shell -p git --run "git clone ${REPO_URL} ${DIR}"
  fi
fi
cd "${DIR}"

# the machine's real hardware scan wins over whatever the repo carries
LIVE=/etc/nixos/hardware-configuration.nix
OURS="hosts/${HOST}/hardware-configuration.nix"
if [ -f "${LIVE}" ] && ! cmp -s "${LIVE}" "${OURS}"; then
  cp "${LIVE}" "${OURS}"
  echo ">> synced ${OURS} from ${LIVE}"
fi

echo ">> rebuilding as flake .#${HOST} (sudo will ask for your password)"
sudo env NIX_CONFIG="experimental-features = nix-command flakes" \
  nixos-rebuild switch --flake ".#${HOST}"

# keep the repo the source of truth for what's actually running
git add flake.lock "${OURS}" 2>/dev/null || true
if ! git diff --cached --quiet 2>/dev/null; then
  git commit -m "bootstrap: sync flake.lock + hardware-configuration"
  echo ">> committed lock/hardware sync — push when you feel like it"
fi

echo ">> done. Log out/in for shell changes; 'sudo tailscale up' if not joined yet."
