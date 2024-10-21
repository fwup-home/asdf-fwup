# asdf-fwup [![Build](https://github.com/fwup-home/asdf-fwup/actions/workflows/build.yml/badge.svg)](https://github.com/fwup-home/asdf-fwup/actions/workflows/build.yml) [![Lint](https://github.com/fwup-home/asdf-fwup/actions/workflows/lint.yml/badge.svg)](https://github.com/fwup-home/asdf-fwup/actions/workflows/lint.yml)

This is the [fwup](https://github.com/fwup-home/fwup) plugin for the [asdf](https://asdf-vm.com) and [mise-en-place](https://mise.jdx.dev/) package managers.

</div>

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Usage](#usage)

## Dependencies

### Linux

```bash
sudo apt-get install autoconf pkg-config help2man libconfuse-dev libarchive-dev
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

or

```shell
mise plugin install fwup https://github.com/fwup-home/asdf-fwup.git
```

## Usage

```shell
# Show all installable versions
asdf list-all fwup

# Install the latest version
asdf install fwup latest

# Set a version globally (on your ~/.tool-versions file)
asdf global fwup latest

# Now fwup commands are available
fwup --version
```

Check the [asdf](https://github.com/asdf-vm/asdf) and [mise](https://mise.jdx.dev/about.html) instructions on how to install & manage versions.
