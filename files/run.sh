#!/usr/bin/env bash

set -euo pipefail

set_flake='--flake .#'
if [[ "$#" -eq 0 ]]; then
	args="switch"
elif [[ "$*" == *"--build-host"* ]]; then
  set_flake=""
	args="$@"
else
	args="$@"
fi


script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${script_dir}"

set -x
#time sudo nixos-rebuild "$args" --flake .#
eval time sudo nixos-rebuild "$args" "$set_flake"
