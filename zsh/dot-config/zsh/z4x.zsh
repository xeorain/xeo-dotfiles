# SPDX-License-Identifier: MIT
#
# Pre-initialization of z4x.
#
# Copyright (c) 2020 Roman Perepelitsa
# Copyright (c) 2026 Jerry Xeo

# --- Options --------------------------------------------------------------{{{
# Command history options
setopt extended_history       # include timestamp and execution duration in history entry (:start:elapsed:command)
setopt hist_expire_dups_first # discard older duplicate entries first when the history file hits max size
setopt hist_find_no_dups      # skip duplicate matches when searching backward through history
setopt hist_ignore_dups       # prevent consecutive duplicate commands from entering history
#setopt hist_ignore_all_dups   # remove all previous duplicates when a command enters history
setopt hist_ignore_space      # prevent tracking commands that begin with a space
setopt hist_save_no_dups      # avoid writing duplicate commands to the history file
setopt share_history          # instantly share and sync command histories across all Zsh sessions

# Naviagtion options
setopt auto_cd                # auto switch to a directory just by typing its path name
setopt auto_pushd             # push the current directory onto directory history stack upon `cd`

# Pattern matching (globbing) options
setopt extended_glob          # turn on advanced pattern matching operators (like ^, #, and ~)
setopt glob_dots              # allow wildcards to match hidden files without an explicit leading dot

# Prompt formatting options
setopt no_prompt_bang         # treat the '!' character as literal text inside your prompt strings
setopt no_prompt_subst        # turn off dynamic variable expansion and command execution inside prompts
setopt prompt_cr              # print a carriage return before the prompt to ensure it aligns on a new line
setopt prompt_percent         # enable standard percent-escapes (like %n or %~) inside custom prompt strings
setopt prompt_sp              # safeguard against missing newlines, preventing prompt from overwriting text

# Tab-completion options
setopt always_to_end          # move cursor to the end of a word after a full completion
setopt auto_param_slash       # auto append a trailing slash if a completed token is a directory
setopt no_auto_menu           # require an extra TAB press to open the completion menu
setopt no_auto_remove_slash   # prevent Zsh from automatically deleting the trailing slash
setopt no_list_types          # hide file type indicator marks (like *, /, @) in completion list menus

# Misc. options
setopt c_bases                # display hexadecimal numbers in standard C-style formatting (0xFF)
setopt no_beep                # silence all system bells, terminal warnings, and audio alerts
setopt no_bg_nice             # prevent background jobs from being deprioritized, keeping them at full CPU speed
setopt no_flow_control        # disable XON/XOFF flow control, preventing terminal from freezing upon accidental ctrl+s hits
setopt typeset_silent         # mute warnings for re-defining pre-existing variables using `typeset`
setopt interactive_comments   # allow comments in interactive ssh sessions
# }}}

# --- z4x global variables -------------------------------------------------{{{
# A flag indicating whether to load ZLE widgets. ZLE is not needed when Zsh
# starts to run a script or a command directly specified on the command line,
# even though it is running in interactive mode. For example, executing a script
# containing a shebang of `/bin/zsh -i`, or executing `zsh -i <command>` in a
# terminal.
#
# * $ZSH_SCRIPT stores the path of the script given on the command line.
# * $ZSH_EXECUTION_STRING stores the command string given on the command line.
if [ -n "${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X}" ]; then
  typeset -gri _z4x_zle=0
else
  typeset -gri _z4x_zle=1
fi

# A variable containing the commands for setting Zsh options, reused in many
# functions to avoid repeating this long list of options.
typeset -gr _z4x_opt='emulate -L zsh &&
  setopt typeset_silent pipe_fail extended_glob prompt_percent no_prompt_subst &&
  setopt no_prompt_bang no_bg_nice no_aliases'
# }}}

# --- Load Zsh built-in modules --------------------------------------------{{{
zmodload zsh/{datetime,langinfo,system,terminfo,zselect} || return
zmodload -F zsh/files b:{zf_mkdir,zf_mv,zf_rm,zf_rmdir,zf_ln} || return
zmodload -F zsh/stat b:zstat || return
# }}}

# --- Register autoload functions ------------------------------------------{{{
fpath=(
  $HOME/.local/share/zsh/site-functions(-/N)
  ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share/zsh/site-functions}(-/N)
  /opt/homebrew/share/zsh/site-functions(-/N)
  $fpath
  $ZDOTDIR/z4x-functions)

autoload -Uz -- $ZDOTDIR/z4x-functions/(|-|_)z4x[^.]#(:t) || return
functions -Ms _z4x_err
# }}}

# --- z4x public APIs ------------------------------------------------------{{{
# -----------------------------------------------------------------------------
# Source Zsh script files, optionally compiling them.
#
# If `-c` or `--compile` is specified in the argument list, files will be
# compiled to speed up future sourcing.
#
# Files paths can be either absolute or relative, globs are allowd; relative
# paths are resolved from $ZDOTDIR.
#
# Arguments:
#   $@: A list of strings representing file paths.
#
# Returns:
#   0 on success; non-zero otherwise.
# -----------------------------------------------------------------------------
function -z4x-cmd-source() {
  local _z4x_compile
  # Filter out -c and --compile options from the argument list, add the options
  # to _z4x_compile.
  zparseopts -D -F -- c=_z4x_compile -compile=_z4x_compile || return '_z4x_err()'

  # Find all relative paths in the argument list, and prepend $ZDOTDIR/ to each
  # of them.
  emulate zsh -o extended_glob -c 'local _z4x_files=(${^${(M)@:#/*}}(N) $ZDOTDIR/${^${@:#/*}}(N))'
  local _z4x_file

  if (( ${#_z4x_compile} )); then
    builtin set --
    for _z4x_file in "${_z4x_files[@]}"; do
      -z4x-compile "$_z4x_file" || true
      builtin source -- "$_z4x_file"
    done
  else
    # Remove all .zwc files outside $ZDOTDIR.
    emulate zsh -o extended_glob -c 'local _z4x_rm=(${^${(@)_z4x_files:#$ZDOTDIR/*}}.zwc(N))'
    (( ! ${#_z4x_rm} )) || zf_rm -f -- "${_z4x_rm[@]}" || true
    builtin set --
    for _z4x_file in "${_z4x_files[@]}"; do
      builtin source -- "$_z4x_file"
    done
  fi
}

# -----------------------------------------------------------------------------
# Load Zsh plugins structured in either "Oh My Zsh" or Prezto format.
#
# * The "Oh My Zsh" plugin format requires a `<plugin-name>.plugin.zsh` primary
#   file in the plugin directory.
# * The Prezto plugin format requires a `init.zsh` primary file in the plugin
#   directory.
#
# Files paths can be either absolute or relative, globs are allowed; relative
# paths are resolved from $ZDOTDIR.
#
# Arguments:
#   $@: A list of strings representing plugin directory paths.
#
# Returns:
#   0 on success; non-zero otherwise;
# -----------------------------------------------------------------------------
function -z4x-cmd-load() {
  local -a compile
  zparseopts -D -F -- c=compile -compile=compile || return '_z4x_err()'

  local -a files

  () {
    emulate -L zsh -o extended_glob
    local pkgs=(${(M)@:#/*} $ZDOTDIR/${^${@:#/*}})
    pkgs=(${^${(u)pkgs}}(-F/N)) # `(u)`: deduplicate; `-F`: only match directory
    # Find all autoload functions from each plugin, ignoring the following
    # files:
    # * hidden files
    # * files starting with underscore in names
    # * prompt setup scripts matching prompt_*_setup in names
    # * editor backup files
    # * .zwc compiled files
    #
    # In `(-.N:t)`, `-` matches regular files only; `.` follows symlinks; `-N`
    # silence failures; `:t` strips directory components.
    local dirs=(${^pkgs}/functions(-F/N))
    local funcs=(${^dirs}/^([_.]*|prompt_*_setup|README*|*~|*.zwc)(-.N:t))
    fpath+=($pkgs $dirs)
    (( ${#funcs} )) && autoload -Uz -- "${funcs[@]}"

    # Find the primary file in each plugin.
    local dir
    for dir in "${pkgs[@]}"; do
      if [[ -s "$dir/init.zsh" ]]; then
        files+=("$dir/init.zsh")
      elif [[ -s "$dir/${dir:t}.plugin.zsh" ]]; then
        files+=("$dir/${dir:t}.plugin.zsh")
      fi
    done
  } "$@"

  -z4x-cmd-source "${complie[@]}" -- "${files[@]}"
}

# -----------------------------------------------------------------------------
# Initialize the z4x configuration.
#
# This function prepares the core plugins, caches the terminal file descriptor,
# enables the powerlevel10k instant prompt, and then hands over the heavy
# lifting to the `-z4x-init` function.
#
# Returns:
#   0 if the initialization succeeds; 1 otherwise.
# -----------------------------------------------------------------------------
function -z4x-cmd-init() {
  if (( ${+_z4x_init_called} )); then
    print -ru2 -- ${(%):-"%F{3}z4x%f: %F{1}init%f cannot be called more than once"}
    return '_z4x_err()'
  fi
  typeset -gri _z4x_init_called=1

  # Use an XDG-compliant cache directory.
  [[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] \
    || zf_mkdir -p -- "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" \
    || return

  () {
    -z4x-prepare powerlevel10k zsh-history-substring-search zsh-syntax-highlighting

    eval "$_z4x_opt"
    # Cache the terminal file descriptor as a global variable for background tasks
    # to bypass stdin/stdout redirection without having to frequently use
    # `>/dev/tty` to write to the terminal, which could compromise performance.
    if [[ -w "$TTY" ]]; then
      typeset -gi _z4x_tty_fd
      sysopen -o cloexec -rwu _z4x_tty_fd -- "$TTY" || return
      typeset -gri _z4x_tty_fd
    elif [[ -w /dev/tty ]]; then
      typeset -gi _z4x_tty_fd
      if sysopen -o cloexec -rwu _z4x_tty_fd -- /dev/tty 2>/dev/null; then
        typeset -gri _z4x_tty_fd
      else
        unset _z4x_tty_fd
      fi
    fi
  } || return

  : ${ZLE_PROMPT_INDENT:=0}

  # Enable Powerlevel10k instant prompt
  (( ! _z4x_zle )) || zstyle -t :z4x:powerlevel10k channel none || () {
    local user="${(%):-%n}"
    # HACK: Powerlevel10k takes $XDG_CACHE_HOME as its cache directory. Use a
    # local XDG_CACHE_HOME variable to override the global XDG_CACHE_HOME
    # environment variable (which is usually set to ~/.cache) for powerlevel10k
    # to save its cache files into a more dedicated directory instead of the
    # cache root.
    local XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/powerlevel10k"
    [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-$user.zsh" ]] || return 0
    builtin source "${XDG_CACHE_HOME}/p10k-instant-prompt-$user.zsh"
  }

  local -i z4x_no_flock

  {
    () {
      eval "$_z4x_opt"
      -z4x-init && return || return 1
    }
  }  always {
    # Use modern system-level Unix `fcntl` function call to lock history file if
    # possible. For platforms that do not support `fcntl`, e.g., WSL (Windows
    # Subsystem for Linux) 1, use the Zsh legacy file-locking method for
    # compatibility.
    (( z4x_no_flock )) || setopt hist_fcntl_lock
  }

  if zstyle -t :z4x: vi-mode; then
    set -o vi
  else
    bindkey -e
  fi
}

# -----------------------------------------------------------------------------
# The public user interface for users to execute z4x commands. It works by
# dispatching `z4x <command>` to the corresponding `-z4x-cmd-<command>`
# functions.
#
# Returns:
#   0 if the command execution succeeds; non-zero otherwise.
# -----------------------------------------------------------------------------
function z4x() {
  if (( ${+functions[-z4x-cmd-${1-}]} )); then
    -z4x-cmd-"$1" "${@:2}"
  else
    -z4x-cmd-help >&2
    return 1
  fi
}
# }}}

# Disable kitty and iTerm2 shell integration, and instead use the z4x
# implementation (z4x-functions/-z4x-enable-iterm2-integration) based on the
# standard OSC 133 which is also recognized by kitty and iTerm2.
unset KITTY_SHELL_INTEGRATION ITERM_INJECT_SHELL_INTEGRATION

# vim:ft=zsh:foldmethod=marker:foldlevel=0
