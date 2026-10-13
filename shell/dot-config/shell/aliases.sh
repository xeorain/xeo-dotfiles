# Shared shell aliases.
#
# This file is intended to be soruced in more specific shell rc files, e.g.,
# .bashrc, .zshrc, etc.
#
# Copyright (c) 2026 Jerry Xeo

# Make aliases work with `sudo`.
#
# Excerpt from Bash manual
#
#   If the shell reads an unquoted word in the right position, it checks the
#   word to see if it matches an alias name. If it matches, the shell replaces
#   the word with the alias value, and reads that value as if it had been read
#   instead of the word. **The shell doesn’t look at any characters following
#   the word before attempting alias substitution**.
#
#   If the last character of the alias value is a blank, then the shell checks
#   the next command word following the alias for alias expansion.
#
# That's to say, Bash performs alias substitution on `ll` in `sudo ll` only if
# `sudo` is an alias ending with a blank character.
#
# See:
# * http://www.gnu.org/software/bash/manual/bashref.html#Aliases
# * https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo

# Tempting, but unsafe! We wrapper `sudo` in a function with the same name
# defined in "$XDG_CONFIG_HOEM/shell/functions.sh".
#alias sudo='sudo '

alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'

# Require confirmation before some dangerous commands proceed.
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# On some Linux distros, the `grep`, `egrep`, and `fgrep` aliases may already
# been set in system shell profiles, e.g., '/etc/profile.d/colorgrep.sh' on
# Fedora. Uncomment them if your system doesn't set them.
#alias grep='grep --color=auto'
#alias egrep='grep -E --color=auto'
#alias fgrep='grep -F --color=auto'
alias zgrep='zgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
# }}}

# Force `git` to use `less` instead of any other Git pagers (e.g., `delta`) on
# text console in case their color theme is incompatible with the console's
# color capability.
if [ "${XDG_SESSION_TYPE:-}" = 'tty' ]; then
  alias git='git -c core.pager=less '
fi

# Diff two files even if they are not in a git repo, using the -w option to
# ignore whitespace differences.
alias gdiff='git diff --no-index'
alias gbdiff='git diff --name-only --relative --diff-filter=d | xargs bat --diff'
alias vdiff='nvim -d'

# Include hidden files, git-ignored files, but exclude git repo metadata
# (`.git/`) in `rg`.
alias rg='rg --hidden --no-ignore --glob "!.git/"'

# Disable logging in `ncmpcpp`.
alias ncmpcpp='ncmpcpp -q'

# Use `eza` as an alternative to GNU `tree`.
if command -v eza >/dev/null 2>&1; then
  alias tree='eza -T'
fi

# Unified alias for terminal image viewers.
#
# To show an image in a terminal, the terminal must support one of the terminal
# graphics protocols including "Kitty Graphics Protocol", "Sixel", or "iTerm2
# Inline Images Protocol". The following popular terminal image viewers are
# checked in order:
#
#   `kitten icat`  kitty's official image viewer, only supporting Kitty
#                  Graphics Protocol
#   chafa          A versatile tool written in C, supporting all protocols
#   viu            A lightweight tool written in Rust, no Sixel support, no SVG
#                  preview
#   timg           A terminal image and video viewer written in C++, supporting
#                  all protocols
#
# Kitty Graphics Protocol is generally better for performance, image quality,
# and modern features, while Sixel is superior for broad compatibility. Prefer
# `kitten icat` whenever `kitten` is available and the terminal supports Kitty
# Graphics Protocol.
#
# Terminal emulators known to support Kitty Grahpics Protocol are: kitty,
# Konsole, ghostty, WezTerm, iTerm2, and Warp.
#
# NOTE: Do not run `kitten icat --detect-support` to check whether a terminal
# supports the Kitty Graphics Protocol. It sends special escape sequences to a
# terminal, and terminals that do not handle them correctly may respond by
# spitting garbage characters.
if command -v kitten >/dev/null 2>&1; then
  if [ -n "${KITTY_PID}" ] || [ -n "${KONSOLE_VERSION}" ]; then
      use_kitten_icat=1
  else
    case "${TERM_PROGRAM}" in
      ghostty|WezTerm|iTerm.app|WarpTerminal)
        use_kitten_icat=1
        ;;
      *)
        ;;
    esac
  fi
fi
if [ -n "${use_kitten_icat}" ]; then
  alias icat='kitten icat'
elif command -v chafa >/dev/null 2>&1; then
  alias icat='chafa'
elif command -v viu >/dev/null 2>&1; then
  alias icat='viu'
elif command -v timg >/dev/null 2>&1; then
  alias icat='timg'
fi
unset use_kitten_icat
