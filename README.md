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

### Usage with `sudo`

By default, `sudo` will override your `PATH`, which will prevent `asdf` from working. One workaround for this
is to use the absolute path to the `fwup` binary like so:

```shell
sudo $(asdf which fwup) --version
```

For a more permanent solution that will work with other `asdf`-managed tools, you can modify your `sudoers`
policy by running `visudo /etc/sudoers.d/01-asdf` and adding the following:

```
# Replace your username below. Additionally, if you use an alternative ASDF_DATA_DIR,
# be sure to modify the path below.
Defaults:YOUR_USERNAME secure_path = /home/YOUR_USERNAME/.asdf/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```
