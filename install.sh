#!/bin/bash
#
# Installs fish shell from its GitHub releases.

set -euo pipefail

# shellcheck disable=2157,2296
if [[ -n "${{ inputs.fish-version }}" ]]; then
  # shellcheck disable=2296
  readonly tag="${{ inputs.fish-versionk }}"
  if ! [[ "${tag}" =~ ^[0-9]+\.[0-9]+[.b][0-9]+$ || "${tag}" =~ ^OpenBeta_r[12]$ ]]; then
    echo "Invalid tag: ${tag}" >&2
    exit 1
  fi
else
  tag="$(curl -fsS 'https://api.github.com/repos/fish-shell/fish-shell/releases/latest' | jq -r '.tag_name')"
  readonly tag
fi

readonly url="https://github.com/fish-shell/fish-shell/releases/download/${tag}/fish-${tag}-linux-x86_64.tar.xz"

readonly dest="${HOME}/.local/bin"
test -d "${dest}" || mkdir -p "${dest}"

curl -fsSL "${url}" | tar -xJ --directory="${dest}"
