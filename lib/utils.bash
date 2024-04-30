#!/usr/bin/env bash

set -euo pipefail

# GH_REPO="https://github.com/mbutov/asdf-jetbrains-idea"
TOOL_NAME="idea"
TOOL_TEST="bin/idea.sh --version"

JETBRAINS_PRODUCT_CODE="IIU"

fail() {
	echo -e "asdf-${TOOL_NAME}: $*"
	exit 1
}

platform() {
	local kernel machine
	kernel="$(uname -s)"
	machine="$(uname -m)"

	case "${kernel}" in
	Darwin)
		case "${machine}" in
		aarch64 | arm64)
			echo "macM1"
			;;
		*)
			echo "mac"
			;;
		esac
		;;
	Linux)
		case "${machine}" in
		aarch64 | arm64)
			echo "linuxARM64"
			;;
		*)
			echo "linux"
			;;
		esac
		;;
	*)
		fail "Unknown operating system: ${kernel}"
		;;
	esac
}

curl_opts=(-fsSL)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
	curl "${curl_opts[@]}" "https://data.services.jetbrains.com/products?code=${JETBRAINS_PRODUCT_CODE}&release.type=release" |
		jq -r '.[] | select(.code=="'${JETBRAINS_PRODUCT_CODE}'") | .releases | .[] | select(.downloads!={}) | .version'
}

download_release() {
	local version filename platform url
	version="$1"
	filename="$2"

	platform=$(platform)

	url=$(
		curl "${curl_opts[@]}" "https://data.services.jetbrains.com/products?code=${JETBRAINS_PRODUCT_CODE}&release.type=release" |
			jq -r '.[] | select(.code=="'${JETBRAINS_PRODUCT_CODE}'") | .releases | .[] | select(.version=="'${version}'") | .downloads.'${platform}'.link'
	)

	echo "* Downloading ${TOOL_NAME} release ${version} from ${url}..."
	curl "${curl_opts[@]}" -o "${filename}" -C - "${url}" || fail "Could not download ${url}"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="$3"

	if [ "${install_type}" != "version" ]; then
		fail "asdf-${TOOL_NAME} supports release installs only"
	fi

	(
		mkdir -p "${install_path}"
		cp -r "${ASDF_DOWNLOAD_PATH}/." "${install_path}"

		local tool_cmd
		tool_cmd="$(echo "${TOOL_TEST}" | cut -d' ' -f1)"
		test -x "${install_path}/${tool_cmd}" || fail "Expected ${install_path}/${tool_cmd} to be executable."

		echo "${TOOL_NAME} ${version} installation was successful!"
	) || (
		rm -rf "${install_path}"
		fail "An error occurred while installing ${TOOL_NAME} ${version}."
	)
}
