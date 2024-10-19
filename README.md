# asdf-fwup [![Build](https://github.com/fwup-home/asdf-fwup/actions/workflows/build.yml/badge.svg)](https://github.com/fwup-home/asdf-fwup/actions/workflows/build.yml) [![Lint](https://github.com/fwup-home/asdf-fwup/actions/workflows/lint.yml/badge.svg)](https://github.com/fwup-home/asdf-fwup/actions/workflows/lint.yml)

[fwup](https://github.com/fwup-home/fwup) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

## Contents

- [Dependencies](#dependencies)
- [Install](#install)

## Dependencies

### Linux

```bash
sudo apt-get install curl build-essential autoconf pkg-config libtool mtools unzip zip help2man libconfuse-dev libarchive-dev xdelta3 dosfstools
```

### MacOS

```bash
brew install confuse libarchive pkg-config automake
```

## Install

Plugin:

```shell
asdf plugin add fwup https://github.com/fwup-home/asdf-fwup.git
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
fwup --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.
