#!/bin/bash
#
# Installs fish shell from its GitHub releases.

set -euo pipefail

readonly arg="${1:-}"

if [[ -n "${arg}" ]]; then
  readonly tag="${arg}"
  #                     4.1~             5.0~  10.0~
  if ! [[ "${tag}" =~ ^(4\.[1-9][0-9]*|([5-9]|[1-9][0-9]+)\.(0|[1-9][0-9]*))\.(0|[1-9][0-9]*)$ ]]; then
    echo "Invalid tag: ${tag}" >&2
    exit 1
  fi
else
  tag="$(curl -fsS 'https://api.github.com/repos/fish-shell/fish-shell/releases/latest' | jq -r '.tag_name')"
  readonly tag
fi

readonly filename="fish-${tag}-linux-x86_64.tar.xz"
curl -fsSLO "https://github.com/fish-shell/fish-shell/releases/download/${tag}/${filename}"

readonly dest="${HOME}/.local/bin"
test -d "${dest}" || mkdir -p "${dest}"
tar -xf "${filename}" --directory="${dest}"
rm "${filename}"

# fish, fish_indent and fish_key_reader are the hard-linked same files.
ln "${dest}/"{'fish','fish_indent'}
ln "${dest}/"{'fish','fish_key_reader'}
