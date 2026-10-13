# XEO extra shell environment variables.
#
# The extra environment variables are written out to a temporary file with a
# unique name in the form of sh-extra-env-<EUID>-<SID>, where the combination of
# effective user ID and login session ID helps isolate different login sessions
# even for the same login name. The temporary file is only created in graphical
# login sessions, and is supposed to be cleared upon logout via a cleanup
# systemd user service.
#
# These extra environment variables are highly personalized, feel free to
# modify, remove, or add them per your own needs.
#
# Supporting functions defined in xeo-extra-funcs.sh manipulate these
# environment variables to perform extra operations.
#
# Copyright (c) 2026 Jerry Xeo

case "${OSTYPE}" in
  darwin*)
    asid="$(id -A | awk -F'=' '/^asid/ {print $2}')"
    XEO_SH_EXTRA_ENV_FILE="$(getconf DARWIN_USER_TEMP_DIR)/xeo-sh-extra-env-${EUID:-$(id -u)}-${asid}"
    unset asid
    ;;
  linux*)
    if [ "${XDG_SESSION_TYPE-}" = 'tty' ]; then  # Linux virtual console
      export XEO_VIM_BACKGROUND='dark'
    else
      XEO_SH_EXTRA_ENV_FILE="${XDG_RUNTIME_DIR:-/tmp}/xeo-sh-extra-env-${EUID:-$(id -u)}-${XDG_SESSION_ID:-$(cat /proc/self/sessionid)}"
    fi
    ;;
esac

[ -n "${XEO_SH_EXTRA_ENV_FILE}" ] || return

if ! [ -f "${XEO_SH_EXTRA_ENV_FILE}" ]; then
  cat <<EOF >"${XEO_SH_EXTRA_ENV_FILE}"
# Preset background style ('dark' or 'light') for vim/nvim used by personalx
# vim/nvim configuration.
export XEO_VIM_BACKGROUND='light'
# Disable Neovim (>=0.11) terminal background query feature that could break a
# colorscheme lazy-loaded by lazy.nvim. (See README.md in XeoVim)
export NVIM_NOTTYFAST=1

# bat themes (specified themes must be available)
export BAT_THEME_DARK='ashen'
export BAT_THEME_LIGHT='modus_operandi'

# delta themes (specified themes must be available)
export DELTA_THEME_DARK='modus_vivendi'
export DELTA_THEME_LIGHT='modus_operandi'

# foot themes (specified themes must be available)
export FOOT_THEME_DARK='xeorain-dark2'
export FOOT_THEME_LIGHT='modus-operandi'

# ghostty themes (specified themes must be available)
export GHOSTTY_THEME_DARK='Xeorain Dark Retina'
export GHOSTTY_THEME_LIGHT='Modus Operandi'

# kitty themes (specified themes must be available)
export KITTY_THEME_DARK='Xeorain Dark2'
export KITTY_THEME_LIGHT='Modus Operandi'
EOF
fi

[ -f "${XEO_SH_EXTRA_ENV_FILE}" ] \
  && . "${XEO_SH_EXTRA_ENV_FILE}"  \
  && export XEO_SH_EXTRA_ENV_FILE
