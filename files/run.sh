#!/usr/bin/env bash

set -euo pipefail

if [[ "$#" -eq 0 ]]; then
	args="switch"
else
	args="$@"
fi


script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${script_dir}"

set -x
time sudo nixos-rebuild "$args" --flake .#
