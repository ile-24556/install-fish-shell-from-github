#!/bin/bash
#
# Installs fish shell from its GitHub releases.

set -euo pipefail

readonly arg="${1:-}"

if [[ -n "${arg}" ]]; then
  readonly tag="${arg}"
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

# fish, fish_indent and fish_key_reader are the hard-linked same files.
ln "${dest}/"{'fish','fish_indent'}
ln "${dest}/"{'fish','fish_key_reader'}
