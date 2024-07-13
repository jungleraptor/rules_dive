#!/usr/bin/env bash

readonly DIVE_BIN="{{dive_bin}}"
readonly TARBALL="{{tarball}}"

"$DIVE_BIN" "docker-archive://$TARBALL"
