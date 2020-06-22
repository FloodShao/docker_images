#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install add-on tools components"

apt-get update
apt-get install mercurial #be able to use hg clone
