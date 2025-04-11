#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/fwup-home/fwup"
TOOL_NAME="fwup"
TOOL_TEST="fwup --version"
OS=$(uname -s)

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$GH_REPO/releases/download/v${version}/fwup-${version}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		cd "$ASDF_DOWNLOAD_PATH"

		case "$OS" in
		Darwin)
			set +u
			PKG_CONFIG_PATH="$(brew --prefix libarchive)/lib/pkgconfig:$(brew --prefix)/lib/pkgconfig:$PKG_CONFIG_PATH" ./configure --prefix=
			set -u
			;;
		Linux)
			./configure --prefix=
			;;
		*)
			fail "Unsupported OS: $OS"
			;;
		esac

		make -j4

		if ! ./src/fwup --version; then
			fail "Could not execute fwup after building"
		fi

		mkdir -p "$install_path"
		make DESTDIR="$ASDF_INSTALL_PATH" install

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
		echo ""

		post_install_instructions
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

post_install_instructions() {
	# This isn't needed on macOS.
	if [ "$OS" = "Darwin" ]; then
		return
	fi

	cat <<EOF
******* IMPORTANT: Usage with sudo ********
By default, tools installed with asdf are not available when using sudo since
sudo resets some/all of the shell environment.

A common workaround is to include the -E option to sudo, which preserves the
environment. However, this does not preserve the PATH variable, so you will need
to invoke $TOOL_NAME with the absolute path like so:

sudo -E \$(asdf which $TOOL_NAME) <fwup-arguments>

Alternatively, you can modify your sudoers policy so that it sets your PATH
correctly. This is a more permanent solution that should also work for other
asdf-managed tools.

EOF

	asdf_data_dir="${ASDF_DATA_DIR:-${ASDF_DIR:-$HOME/.asdf}}"

	case "$SHELL" in
	*/zsh)
		# shellcheck disable=SC2088
		rc_file="~/.zshrc"
		;;
	*/bash)
		# shellcheck disable=SC2088
		rc_file="~/.bashrc"
		;;
	*/fish)
		# shellcheck disable=SC2088
		rc_file="~/.config/fish/config.fish"
		;;
	*)
		rc_file="your shell config file"
		return
		;;
	esac

	cat <<EOF
  1. Ensure you have the following line in your shell config ($rc_file):

     For asdf 0.16 and later:
     $(get_export_cmd "ASDF_DATA_DIR" "$asdf_data_dir")

     For asdf 0.15 and earlier:
     $(get_export_cmd "ASDF_DIR" "$asdf_data_dir")

     Your asdf version is $(asdf version).

  2. Using visudo, add the following lines to /etc/sudoers.d/01-asdf or /etc/sudoers:

     Defaults:$USER    secure_path="$asdf_data_dir/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
     Defaults:$USER    env_keep += "ASDF_DIR ASDF_DATA_DIR"

EOF
}

get_export_cmd() {
	case "$SHELL" in
	*/fish)
		echo "set -x $1 \"$2\""
		;;
	*)
		echo "export $1=\"$2\""
		;;
	esac
}
