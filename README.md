<!-- markdownlint-disable MD040 -->

# Dotfiles

Personal dotfiles for Linux, managed by GNU [stow].

## Installation

Clone the repository:

```sh
git clone --recurse-submodules https://github.com/xeorain/xeo-dotfiles
```

## Usage

Install the dependencies required by the dotfiles packages to be deployed. See
the “[Dependencies](#dependencies)” section below.

**Always** use the `setup` script to deploy/undeploy/redeploy dotfiles rather
than executing `stow` directly. Run `./setup -h` for full help.

There are two modes of using the dotfiles: _production_ mode and _development_
mode.

### Production mode

The production mode constructs a completely isolated, static directory to hold a
snapshot of the dotfiles and stows the files under the snapshot directory,
decoupling the deployed files from the repository working tree. This ensures
that any changes made to the dotfiles codebase will not affect the deployed
files.

To create a snapshot of the current working tree into the default snapshot
directory, run:

```sh
./setup dump
```

The default directory is `$XDG_STATE_HOME/xeo-dotfiles`, or
`~/.local/state/xeo-dotfiles` if the `XDG_STATE_HOME` environment variable is
not set.

It is allowed to dump a specific commit object as a snapshot into a custom
snapshot directory. The example below dumps the content from commit `123456`
into the `~/.xeo-dotfiles` directory:

```sh
./setup dump -c 1234567 -d ~/.xeo-dotfiles
```

The argument to the `-c` option can be a Git commit SHA1 hash, a branch name, or
a tag. The `-d` option specifies a custom snapshot directory. For security
reasons, the snapshot directory must reside within the user home.

To deploy the dumped snapshot dotfiles, enter the snapshot directory and run the
`setup` script. Below are some typical examples for reference:

```
1. Deploy (stow) all packages:

    ./setup deploy -a

2. Deploy (stow)  'foo' and 'bar' packages:

    ./setup deploy foo bar

3. Deploy (stow) all packages except for 'foo' and 'bar':

    ./setup deploy -a -x foo -x bar

4. Undeploy (unstow) all packages:

    ./setup deploy -D -a

5. Undeploy (unstow) 'foo' and 'bar' packages:

    ./setup deploy -D foo bar

6. Undeploy (unstow) all packages except for 'foo' and 'bar':

    ./setup deploy -D -a -x foo -x bar

7. Reploy (restow) all packages except 'foo' and 'bar':

    ./setup deploy -R -a -x foo -x bar
```

### Development mode

The development mode directly stows the files in the repository working tree, so
that any changes made to the codebase will immediately be reflected in the
deployment. Operations such as reorganizing dotfiles, switching branches, or
relocating the repository could break stowed symlinks. Therefore, the
development mode is only suitable for developing or debugging the dotfiles.

To deploy dotfiles in development mode, run the `setup` script in the repository
working tree without the snapshot dump step. Actually, a production-mode
deployment is a special case of applying a development-mode deployment to the
dotfiles in the snapshot directory, so the examples in the “[production
mode](#production-mode)” section still hold true.

## Dependencies

Core dependencies:

- bash (required to run the `setup` script)
- stow (required to install/uninstall dotfiles)

For most dotfiles packages, the directory is named after the application it
configures, which serves as the primary dependency to be installed, with the
following exceptions:

- `X11`: X11-specific settings.
- `shell`: A general shell environment shared by Bash and Zsh
- `environment.d`: Per-user environment variables for `systemd --user`
- `gtk-2.0`: Runtime configuration (rc) file for GTK2 applications
- `gtk-3.0`: Runtime configuration (rc) file for GTK3 applications
- `gtk-4.0`: Runtime configuration (rc) file for GTK4 applications
- `readline`: Configuration for the GNU Readline library used by Bash
- `systemd`: Per-user systemd units
- `xeo-utils-desktop`: Helper and utility scripts for desktop
- `xeo-utils-extra`: Utilities for xeo extra features

Some dotfiles packages may require additional dependencies, or rely on other
dotfiles packages.

### Dependencies for terminal emulator dotfiles

Installed manually:

- [Aporetic](https://github.com/apkd/aporetic) font (for foot and [kitty])
- [Iosevka Term SS08](https://github.com/be5invis/iosevka) font (for [Ghostty])

### Dependencies for git dotfiles

Installed via distro package manager:

- Fedora

  ```
  git, git-delta, gnupg2, openssh-clients
  ```

- Debian/Ubuntu

  ```
  git, git-delta, gnupg, openssh-client
  ```

- Arch Linux

  ```
  git, git-delta, gnupg, openssh-client
  ```

### Dependencies for i3status-rust dotfiles

Installed manually:

- [i3status-rust] has to be manually installed by building the source code on
  Debian or Ubuntu.
- [bbolt] used to access `cliphist` database quickly; available on Fedora from
  the `golang-etcd-bbolt` package, but has to be built from the source code on
  Debian/Ubuntu or Arch Linux (Go required).
- [cliphist] (xeorain fork, Go is required to build the source code)
- [mpdris2-rs]
- [xeo-utils-desktop dotfiles](#dependencies-for-xeo-utils-desktop-dotfiles)

Installed via distro package manager:

- Fedora

  ```
  golang-etcd-bbolt, i3status-rust, mpd, mpc, pipewire-utils, sway, swaylock
  ```

  The `i3status-rust` is provided by the COPR repo:
  [atim/i3status-rust](https://copr.fedorainfracloud.org/coprs/atim/i3status-rust)

- Debian/Ubuntu

  ```
  mpd, mpc, pipewire-utils, sway, swaylock
  ```

- Arch Linux

  ```
  i3status-rust, mpd, mpc, pipewire-utils, sway, swaylock
  ```

### Dependencies for sway dotfiles

Installed manually:

- [xeo-utils-desktop dotfiles](#dependencies-for-xeo-utils-desktop-dotfiles)
- [i3status-rust dotfiles](#dependencies-for-i3status-rust-dotfiles)
- [autotiling-rs] (bspwm-style auto-tiling)
- [mpdris2-rs]
- [satty] and [wiremix] has to be manually installed by building source code on
  Debian or Ubuntu.

Installed via distro package manager:

- Fedora

  ```
  dunst, gpu-screen-recorder, jq, kanshi, lxqt-policykit, mpd, mpc, satty sway,
  swaybg, swayidle, swaylock, udiskie, wiremix
  ```

  The `gpu-screen-recorder` package is provided by the COPR repo:
  [brycensranch/gpu-screen-recorder-git](https://copr.fedorainfracloud.org/coprs/brycensranch/gpu-screen-recorder-git/)

  The `satty` package is provided by the COPR repo:
  [mineiro/satty](https://copr.fedorainfracloud.org/coprs/mineiro/satty)

- Debian/Ubuntu

  ```
  dunst, gpu-screen-recorder,jq, kanshi, lxqt-policykit, mpd, mpc, sway, swaybg,
  swayidle, swaylock, udiskie
  ```

  The `gpu-screen-recorder` package is provided by the third-party
  [deb.griffo.io] repository.

- Arch Linux

  ```
  dunst, gpu-screen-recorder, jq, kanshi, lxqt-policykit, mpd, mpc, satty, sway,
  swaybg, swayidle, swaylock, udiskie, wiremix
  ```

### Dependencies for swayimg dotfiles

Installed by distro package manager:

```
swayimg (>= 5.0), wl-clipboard
```

The Lua configuration only supports [swayimg] 5.0 or newer versions, so it would
have to be built from source code if the package shipped in the Linux distro is
older than version 5.0.

### Dependencies for xeo-utils-desktop dotfiles

This dotfile package contains helper and utility programs mainly used in
wlroots-based Wayland desktop environments. Programs in
`xeo-utils-desktop/dot-local/libexec/xeo-utils-desktop` are intended to be
invoked internally by other applications rather than by end users.

Installed manually:

- [cliphist] (xeorain fork, Go is required to build the source code)
- [rofi-wayland] (required for Wayland if the official `rofi` shipped in the
  Linux distro is older than version 2.0)
- [mpdris2-rs]

Installed via distro package manager:

- Fedora

  ```
  brightnessctl (>= 0.5.1-11), gpu-screen-recorder, grim, jq mpd, mpc,
  pipewire-pulseaudio, pipewire-utils, pulseaudio-utils, rofi (>= 2.0) or
  rofi-wayland, slurp, udiskie, wayland-utils, wl-clipboard, wlr-randr,
  wireplumber, wob
  ```

  See [Dependencies for Sway dotfiles](#dependencies-for-sway-dotfiles) for how
  to get `gpu-screen-recorder` in Fedora.

- Debian/Ubuntu

  ```
  brightnessctl (>= 0.5.1-11), gpu-screen-recorder, grim, jq, mpd, mpc,
  pipewire-pulse, pipewire-utils, pulseaudio-utils, rofi (>= 2.0), slurp,
  udiskie, wayland-utils, wl-clipboard, wlr-randr, wireplumber, wob
  ```

  See [Dependencies for Sway dotfiles](#dependencies-for-sway-dotfiles) for how
  to get `gpu-screen-recorder` in Debian or Ubuntu.

- Arch Linux

  ```
  brightnessctl (>= 0.5.1-11), gpu-screen-recorder, grim, jq, mpd, mpc,
  pipewire-pulse, pipewire-utils, libpulse, rofi (>= 2.0) or rofi-wayland,
  slurp, udiskie, wayland-utils, wl-clipboard, wlr-randr, wireplumber, wob
  ```

### Dependencies for xeo-utils-extra dotfiles

This dotfiles package contains extra utilities for highly personal xeo extra
features.

The `xeo-utils-extra/dot-local/libexec/xeo-utils-desktop/xeo-switch-theme-mode`
utility script has the following _weak_ dependencies:

- delta dotfiles
- foot dotfiles
- kitty dotfiles and [kitty]
- ghostty dotfiles and [Ghostty]
- shell dotifiles

### Dependencies for zsh dotfiles

Installed manually:

- shell dotfiles
- [xeo-utils-extra](dependencies-for-xeo-utils-extra-deotfiles) (optionally
needed for some key bindings to work)

Installed via distro package manager:

```
bat, fzf
```

Third-party plugins as Git submodules:

- [powerlevel10k](https://github.com/romkatv/powerlevel10k.git)
- [zsh-completions](https://github.com/zsh-users/zsh-completions.git)
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search.git)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)

[autotiling-rs]: https://github.com/ammgws/autotiling-rs
[bbolt]: https://github.com/etcd-io/bbolt#getting-started
[cliphist]: https://github.com/xeorain/cliphist
[Ghostty]: https://ghostty.org/
[gpu-screen-recorder]: https://git.dec05eba.com/gpu-screen-recorder
[i3status-rust]: https://github.com/greshake/i3status-rust
[kitty]: https://sw.kovidgoyal.net/kitty/
[mpdris2-rs]: https://github.com/szclsya/mpdris2-rs
[rofi-wayland]: https://github.com/lbonn/rofi
[satty]: https://github.com/Satty-org/Satty
[stow]: https://www.gnu.org/software/stow/
[swayimg]: https://github.com/artemsen/swayimg
[wiremix]: https://crates.io/crates/wiremix
[deb.griffo.io]: https://deb.griffo.io/
