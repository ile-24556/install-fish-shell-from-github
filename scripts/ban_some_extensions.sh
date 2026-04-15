#!/bin/bash

set -eu

readonly arg="${1:-}"
readonly extension="${arg##*.}"

if [[ "${arg}" != "${extension}" && "${extension}" == 'yml' ]]; then
  echo "
The file extension of '${arg}' is not allowed.
Although GitHub recommends 'action.yml', [1] I use '.yaml'. Because:

  • The YAML Company recommends '.yaml'. [2]
  • pre-commit only supports '.pre-commit-config.yaml'. [3]
  • I don't want to mix two extensions in one repository.

[1]: https://docs.github.com/en/actions/concepts/workflows-and-actions/custom-actions
[2]: https://yaml.com/resources/faq/
[3]: https://github.com/pre-commit/pre-commit/issues/702
"

  exit 1
fi >&2
