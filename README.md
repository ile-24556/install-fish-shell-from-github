# install-fish-shell-from-github

Installs [fish shell] from [its GitHub releases][fish-releases].

## Usage

This action is worked only on Ubuntu runner images.
If you want to work on macOS, consider using [fish-shop/install-fish-shell].

The following step installs the latest version of fish:

```yaml
- uses: ile-24556/install-fish-shell-from-github@v1.0.0
```

You can install a specific version of fish with the `fish-version` input:

```yaml
- uses: ile-24556/install-fish-shell-from-github@v1.0.0
  with:
    fish-version: "4.3.3"
```

The value must be '4.1.0' or later corresponding to an existing release tag.

<!-- Link reference definitions -->

[fish shell]: https://fishshell.com/
[fish-releases]: https://github.com/fish-shell/fish-shell/releases
[fish-shop/install-fish-shell]: https://github.com/fish-shop/install-fish-shell
