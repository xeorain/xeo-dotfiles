# Shared shell functions.
#
# Functions prefixed with double underscores are intended for internal use in
# shell configurations rather than in client scripts.
#
# Copyright (c) 2026 Jerry Xeo

# -----------------------------------------------------------------------------
# Generate and export BSD LSCOLORS from a custom color scheme source file.
# Cache the generated result to a local file, thus boosting subsequent shell
# startup by attempting to source the cache first instead of always executing
# the entire function.
#
# The external ~/.local/libexec/shell/gen-bsd-lscolors script is used to
# generate or update the cache.
#
# Arguments:
#   $1: A string representing the absolute path to the source file.
#   $2: A string representing the absolute path to the cache file.
#
# Returns:
#   0 on success; 1 otherwise.
# -----------------------------------------------------------------------------
function __xeo_export_bsd_lscolors() {
  [[ "$#" -eq 2 ]] || return 1

  local srcfile="$1"
  local cache="$2"

  [ -f "${srcfile}" ] || return 1

  # Load the cache directly if it exists and is newer than the source file.
  if [ -f "${cache}" ]  && [ "${cache}" -nt "${srcfile}" ]; then
    # shellcheck disable=SC1090
    . "${cache}"
    return
  fi

  local generator="${HOME}/.local/libexec/shell/gen-bsd-lscolors"

  if [ -f "${srcfile}" ] \
      && "${generator}" "${srcfile}" "${cache}" 2>/dev/null; then
      # shellcheck disable=SC1090
    . "${cache}"
  else
    return 1
  fi
}

# -----------------------------------------------------------------------------
# Safer `sudo` for dangerous commands by wrapping the original `sudo` command to
# force interactive confirmation for specific commands like `cp`, `mv`, and
# `rm`.
#
# Arguments:
#   $1: A string representing the command to execute with `sudo`.
#   ${@:2}: The command line arguments supplied to the executed command ($1).
# -----------------------------------------------------------------------------
function sudo() {
  case "$1" in
    cp|mv|rm)
      local cmd="$1"
      shift
      command sudo "${cmd}" -i "$@"
      ;;
    *)
      command sudo "$@"
      ;;
  esac
}

# -----------------------------------------------------------------------------
# Enhance command help documentation with syntax highlighting via `bat`. Fall
# back to `less` with case-insensitive search if `bat` is unavailable.
#
# Arguments:
#   $1: A string representing the command.
# -----------------------------------------------------------------------------
function help() {
  if command -v bat >/dev/null 2>&1; then
    # always paging for search
    "$@" --help 2>&1 | bat --plain --language=help --paging=always
  else
    "$@" --help 2>&1 | less -i
  fi
}
