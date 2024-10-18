<div align="center">

# asdf-fwup [![Build](https://github.com/bjyoungblood/asdf-fwup/actions/workflows/build.yml/badge.svg)](https://github.com/bjyoungblood/asdf-fwup/actions/workflows/build.yml) [![Lint](https://github.com/bjyoungblood/asdf-fwup/actions/workflows/lint.yml/badge.svg)](https://github.com/bjyoungblood/asdf-fwup/actions/workflows/lint.yml)

[fwup](https://github.com/fwup-home/fwup) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add fwup
# or
asdf plugin add fwup https://github.com/bjyoungblood/asdf-fwup.git
```

fwup:

```shell
# Show all installable versions
asdf list-all fwup

# Install specific version
asdf install fwup latest

# Set a version globally (on your ~/.tool-versions file)
asdf global fwup latest

# Now fwup commands are available
fwup --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/bjyoungblood/asdf-fwup/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ben Youngblood](https://github.com/bjyoungblood/)
