#!/bin/bash
#
# Installs fish shell from its GitHub releases.

set -euo pipefail

cd "$(mktemp -d)"

gh release -R fish-shell/fish-shell download "${1:-}" -p 'fish-*-linux-x86_64.tar.xz'

readonly dest="${HOME}/.local/bin"
test -d "${dest}" || mkdir -p "${dest}"

tar -xf fish-*-linux-x86_64.tar.xz -C "${dest}"
