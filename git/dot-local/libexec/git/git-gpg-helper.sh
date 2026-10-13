#!/bin/sh
# SPDX-License-Identifier: MIT
#
# A Git helper script that automatically picks the correct GPG key matching the
# 'user.email' setting in a repository.
#
# Usage:
#   Add the following to the global user git configuration:
#
#       [gpg]
#           program = ~/.local/libexec/git/git-gpg-helper.sh
#
# Copyright (c) 2026 Jerry Xeo

email="$(git config user.email)" || exit
gpgkey="$(gpg --with-colons --list-secret-keys "${email}" 2>/dev/null \
  | awk -F: '$1 == "sec" {print $5; exit}')"

if [ -n "${gpgkey}" ]; then
  exec gpg -u "${gpgkey}" "$@"
else
  exec gpg "$@"
fi
