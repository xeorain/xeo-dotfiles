# A login shell profile that defines a shared base shell environment.
#
# This file can be used as either a standalone profile or a base profile to be
# sourced by other more specific shell profiles or rc files. For example, source
# this file in ~/.bash_profile to establish a base shell environment in Bash.
#
# Copyright (c) 2026 Jerry Xeo

# OSTYPE is a built-in shell parameter in both Bash and Zsh. Its value is
# "linux-gnu" on Linux distros, or "darwin<VER>" (e.g. darwin23) on macOS. Fall
# back to `uname -s` for shells that do not provide OSTYPE.
[ -n "${OSTYPE}" ] || OSTYPE="$(uname -s | tr '[:upper:]' '[:lower:]')"

# --- Settings for Homebrew on macOS ---------------------------------------{{{
case "${OSTYPE}" in
  darwin*)
    if [ -z "${HOMEBREW_PREFIX}" ]; then
      for dir in /opt/homebrew /usr/local; do
        [ -x "${dir}/bin/brew" ] || continue

        export HOMEBREW_PREFIX="${dir}"
        export HOMEBREW_CELLAR="${dir}/Cellar"
        if [ -e "${dir}/Homebrew/Library" ]; then
          export HOMEBREW_REPOSITORY="${dir}/Homebrew"
        else
          export HOMEBREW_REPOSITORY="${dir}"
        fi
        export HOMEBREW_NO_AUTO_UPDATE=1
        PATH="${dir}/bin:${dir}/sbin${PATH+:${PATH}}"
        # Homebrew may manipulate MANPATH, keep using the system default manpaths.
        [ -z "${MANPATH-}" ] || MANPATH=":${MANPATH#:}"
        export INFOPATH="${dir}/share/info:${INFOPATH:-}"

        # NOTE: Mirrors are only needed in certain countries; do not use it if
        # you are in free world!
        #
        # aliyun
        #export HOMEBREW_BREW_GIT_REMOTE='https://mirrors.aliyun.com/homebrew/brew.git'
        #export HOMEBREW_CORE_GIT_REMOTE='https://mirrors.aliyun.com/homebrew/homebrew-core.git'
        #export HOMEBREW_API_DOMAIN='https://mirrors.aliyun.com/homebrew-bottles/api'
        #export HOMEBREW_BOTTLE_DOMAIN='https://mirrors.aliyun.com/homebrew/homebrew-bottles'
        #export HOMEBREW_PIP_INDEX_URL='https://mirrors.aliyun.com/pypi/web/simple'
        # tsinghua
        export HOMEBREW_BREW_GIT_REMOTE='https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git'
        export HOMEBREW_CORE_GIT_REMOTE='https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git'
        export HOMEBREW_API_DOMAIN='https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api'
        export HOMEBREW_BOTTLE_DOMAIN='https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles'
        export HOMEBREW_PIP_INDEX_URL='https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple'

        break
      done
    fi
    ;;
esac
# }}}

# --- User LS_COLORS guard -------------------------------------------------{{{
# HACK: RedHat-derived Linux distros source /etc/profile.d/colors.sh at login,
# which runs `dircolors` to set a color scheme for `ls` output, but some of its
# colors have very low contrast on a light background. That script internally
# checks USER_LS_COLORS to decide whether to apply its settings, and we can set
# it to 1 to make that script skip applying them.
export USER_LS_COLORS=1
# }}}

# --- XDG Base Directories -------------------------------------------------{{{
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
# }}}

# --- Common environment variables -----------------------------------------{{{
# NOTE: Change EDITOR if Neovim is not your default text editor.
export EDITOR='nvim'
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export PAGER='/usr/bin/less'

# XDG-compliant GTK2 rc file path
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

# Manual and info pages from manually unpacked applications under /opt are not
# in the standard search paths, so add their directories to MANPATH and
# INFOPATH.
# NOTE: Temporarily disable the NOMATCH option in Zsh to suppress the annoying
# warning message when globbing fails (i.e., no directories under /opt).
[ -n "${ZSH_VERSION}" ] && setopt +o nomatch
for dir in /opt/*/; do
  dir=${dir%/}
  [ -d "${dir}/share/man" ] && MANPATH="${dir}/share/man${MANPATH:+:${MANPATH}}"
  [ -d "${dir}/share/info" ] && INFOPATH="${dir}/share/info${INFOPATH:+:${INFOPATH}}"
done
MANPATH="${MANPATH:+${MANPATH}:}"
INFOPATH="${INFOPATH:+${INFOPATH}:}"
[ -n "${ZSH_VERSION}" ] && setopt -o nomatch
# }}}

# --- Application-specific environment variables ---------------------------{{{
# Disable history for `less`.
export LESSHISTFILE='-'
# Forces `less` (>= 633) to correctly render custom glyphs, icons, and symbols
# (specifically those provided by Nerd Fonts).
# See https://github.com/sharkdp/bat/issues/2578
export LESSUTFCHARDEF=E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p

# ssh-agent socket path
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# XDG-compliant configuration file path for `wget`.
[ -f "${XDG_CONFIG_HOME}/wget/wgetrc" ] \
  && export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"

# XDG-compliant configuration file path for `fzf`
[ -f "${XDG_CONFIG_HOME}/fzf/fzfrc" ] \
  && export FZF_DEFAULT_OPTS_FILE="${XDG_CONFIG_HOME}/fzf/fzfrc"

# Use `bat` as `man` pager with syntax highlighting support.
command -v bat >/dev/null 2>&1 && {
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  # Prevent `man` formatter's own colorization from interfering with bat's
  # rendering.
  export MANROFFOPT='-c'
}
# }}}

# --- Devtools-specific environment variables -----------------------------{{{1
# --- Go ------------------------------------------------------------------{{{2
# * XDG-compliant cache directory for Go modules.
# * XDG-compliant data directory for Go workspace storing "$GOPATH/pkg",
#   "$GOPATH/src" (only forf Go 1.11 and older), etc.
# * Manually installed Go toolchains like `go` (compiler), `gofmt` (formatter),
#   go into "~/.local/opt/go/bin".
export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"
export GOPATH="${XDG_DATA_HOME}/go"
case ":${PATH}:" in
  *":${HOME}/.local/opt/go/bin:${GOPATH}/bin:"*)
    ;;
  *)
    PATH="${HOME}/.local/opt/go/bin:${GOPATH}/bin:${PATH}"
    ;;
esac
# }}}2

# --- Node.js -------------------------------------------------------------{{{2
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
# }}}2

# --- Python --------------------------------------------------------------{{{2
# XDG-compliant history file path for Python (default: ~/.python_history)
export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"
# Prevent the `uv` installer or the `uv update` command from adding binary path
# to shell rc files.
export UV_NO_MODIFY_PATH=1
# }}}2

# --- Rust ----------------------------------------------------------------{{{2
# Mirror for rustup. (NOTE: only required in certain countries)
export RUSTUP_DIST_SERVER='https://rsproxy.cn'
export RUSTUP_UPDATE_ROOT='https://rsproxy.cn/rustup'
# XDG-compliant home directory for `cargo` and `rustup`.
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
[ -s "${CARGO_HOME}/env" ] && . "${CARGO_HOME}/env"
# }}}2
# }}}1

# --- Wayland-specific settings --------------------------------------------{{{
if [ -n "${WAYLAND_DISPLAY}" ]; then
  # Force wlroots compositors to draw the mouse cursor using software instead of
  # letting the graphics card handle it. Uncomment it if you encounter invisible
  # or flickering mouse cursor with proprietary NVIDIA graphical drivers.
  #export WLR_NO_HARDWARE_CURSORS=1

  # Force wlroots compositors to abandon Atomic Mode Setting and fall back to
  # the Legacy DRM interface. Uncomment it if you encounter terminal freezing
  # with proprietary NVIDIA graphical drivers.
  #export WLR_DRM_NO_ATOMIC=1

  # For compatibility with old electron apps.
  export ELECTRON_OZONE_PLATFORM_HINT=auto

  # Default directory for `grim` to save screenshots
  #export GRIM_DEFAULT_DIR="${XDG_PICTURES_DIR:-${HOME}/Pictures}/Screenshots"
fi
# }}}

# --- User binary search paths ---------------------------------------------{{{
case ":${PATH}:" in
  *":${HOME}/.local/bin:${HOME}/bin:"*)
    ;;
  *)
    PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"
    ;;
esac
# }}}

# --- XEO extra shell environment ------------------------------------------{{{
# An extra shell environment that defines extremely personal variables and
# supporting functions.
# NOTE: Comment it out if you do not need the xeo extra features.
. "${XDG_CONFIG_HOME}/shell/xeo-extra-env.sh"
# }}}

unset dir
export MANPATH PATH

# vim:foldmethod=marker:foldlevel=0
