#!/usr/bin/env bash

set -euo pipefail

pushd /home/xatier || exit 1
/home/xatier/backup_home.sh

popd || exit 1
