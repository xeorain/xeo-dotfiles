# Custom Key Bindings for Sway

## Settings

| Keybind   | Description           |
| --------- | --------------------- |
| `Super+b` | Set horizontal splits |
| `Super+v` | Set vertical splits   |

## Navigation

| Keybind              | Description                                     |
| -------------------- | ----------------------------------------------- |
| `Super+h`            | Move focus left                                 |
| `Super+j`            | Move focus below                                |
| `Super+k`            | Move focus up                                   |
| `Super+l`            | Move focus right                                |
| `Super+Shift+h`      | Move focused window left                        |
| `Super+Shift+j`      | Move focused window below                       |
| `Super+Shift+k`      | Move focused window up                          |
| `Super+Shift+l`      | Move focused window right                       |
| `Super+Ctrl+h`       | Swap focused container with left one            |
| `Super+Ctrl+j`       | Swap focused container with lower one           |
| `Super+Ctrl+k`       | Swap focused container with upper one           |
| `Super+Ctrl+l`       | Swap focused container with right one           |
| `Super+Ctrl+Shift+h` | Move focused workspace to output left           |
| `Super+Ctrl+Shift+j` | Move focused workspace to output below          |
| `Super+Ctrl+Shift+k` | Move focused workspace to output upper          |
| `Super+Ctrl+Shift+l` | Move focused workspace to output right          |
| `Super+1`            | Switch to workspace 1                           |
| `Super+2`            | Switch to workspace 2                           |
| `Super+3`            | Switch to workspace 3                           |
| `Super+4`            | Switch to workspace 4                           |
| `Super+5`            | Switch to workspace 5                           |
| `Super+6`            | Switch to workspace 6                           |
| `Super+7`            | Switch to workspace 7                           |
| `Super+8`            | Switch to workspace 8                           |
| `Super+9`            | Switch to workspace 9                           |
| `Super+0`            | Switch to workspace 10                          |
| `Super+Tab`          | Switch back and forth between workspaces        |
| `Super+comma`        | Switch to previous workspace on current display |
| `Super+period`       | Switch to next workspace on current display     |
| `Super+a`            | Move focus to parent container                  |
| `Super+Shift+a`      | Move focus to last-focused child container      |

## Actions

### Core actions

| Keybind              | Description                                                    |
| -------------------- | -------------------------------------------------------------- |
| `Super+Shift+q`      | Kill focused window                                            |
| `Super+Shift+r`      | Reload Sway configuration                                      |
| `Super+Shift+1`      | Move focused container to workspace 1                          |
| `Super+Shift+2`      | Move focused container to workspace 2                          |
| `Super+Shift+3`      | Move focused container to workspace 3                          |
| `Super+Shift+4`      | Move focused container to workspace 4                          |
| `Super+Shift+5`      | Move focused container to workspace 5                          |
| `Super+Shift+6`      | Move focused container to workspace 6                          |
| `Super+Shift+7`      | Move focused container to workspace 7                          |
| `Super+Shift+8`      | Move focused container to workspace 8                          |
| `Super+Shift+9`      | Move focused container to workspace 9                          |
| `Super+Shift+0`      | Move focused container to workspace 10                         |
| `Super+Shift+comma`  | Move focused container to previous workspace                   |
| `Super+Shift+period` | Move focused container to next workspace                       |
| `Super+Alt+1`        | Move focused container to workspace 1, and switch to it        |
| `Super+Alt+2`        | Move focused container to workspace 2, and switch to it        |
| `Super+Alt+3`        | Move focused container to workspace 3, and switch to it        |
| `Super+Alt+4`        | Move focused container to workspace 4, and switch to it        |
| `Super+Alt+5`        | Move focused container to workspace 5, and switch to it        |
| `Super+Alt+6`        | Move focused container to workspace 6, and switch to it        |
| `Super+Alt+7`        | Move focused container to workspace 7, and switch to it        |
| `Super+Alt+8`        | Move focused container to workspace 8, and switch to it        |
| `Super+Alt+9`        | Move focused container to workspace 9, and switch to it        |
| `Super+Alt+0`        | Move focused container to workspace 10, and switch to it       |
| `Super+Alt+comma`    | Move focused container to previous workspace, and switch to it |
| `Super+Alt+period`   | Move focused container to next workspace, and switch to it     |
| `Super+s`            | Switch to stacking layout                                      |
| `Super+w`            | Switch to tabbed layout                                        |
| `Super+e`            | Switch to tiling (split) layout                                |
| `Super+f`            | Toggle fullscreen on focused window                            |
| `Super+Shift+f`      | Toggle fullscreen globally                                     |
| `Super+Shift+s`      | Toggle sticky on focused window                                |
| `Super+Shift+space`  | Toggle focused window between tiling and floating mode         |
| `Super+space`        | Swap focus between tiling area and floating area               |
| `Super+o`            | Cycle through scratchpad windows                               |
| `Super+Shift+o`      | Move focused window to scratchpad                              |
| `Super+Ctrl+c`       | Center focused floating window                                 |
| `Super+Ctrl+/`       | Move mouse cursor far away                                     |

### Additional actions

This actions require additional helpers or external programs to work.

| Keybind                    | Description                                    |
| -------------------------- | ---------------------------------------------- |
| `Super+Shift+b`            | Update all blocks in i3status-rs status bar    |
| `Super+Alt+b`              | Restart i3status-rs status bar                 |
| `Super+Alt+i`              | Inhibit idle                                   |
| `Super+equal`              | Raise audio output volume by 1%                |
| `XF86AudioRaiseVolume`     | Raise audio output volume by 1%                |
| `Super+minus`              | Lower audio output volume by 1%                |
| `XF86AudioLowerVolume`     | Lower audio output volume by 1%                |
| `Super+Shift+equal`        | Raise audio output volume by 5%                |
| `Super+Shift+minus`        | Lower audio output volume by 5%                |
| `Super+backspace`          | Mute audio output                              |
| `$XF86AudioMute`           | Mute audio output                              |
| `Super+Alt+equal`          | Raise audio input volume by 1%                 |
| `Alt+XF86AudioRaiseVolume` | Raise audio input volume by 1%                 |
| `Super+Alt+minus`          | Lower audio input volume by 1%                 |
| `Alt+XF86AudioLowerVolume` | Lower audio input volume by 1%                 |
| `Super+Alt+Shift+equal`    | Raise audio input volume by 5%                 |
| `Super+Alt+Shift+minus`    | Lower audio input volume by 5%                 |
| `Super+Alt+backspace`      | Mute audio input                               |
| `Alt+$XF86AudioMute`       | Mute audio input                               |
| `Super+Alt+bracketleft`    | Lower brightness by 1%                         |
| `XF86MonBrightnessDown`    | Lower brightness by 1%                         |
| `Super+bracketright`       | Raise brightness by 1%                         |
| `XF86MonBrightnessUp`      | Raise brightness by 1%                         |
| `Super+Shift+bracketleft`  | Lower brightness by 10%                        |
| `Super+Shift+bracketright` | Raise brightness by 10%                        |
| `Super+Alt+bracketleft`    | Lower brightness to 0                          |
| `Super+Alt+bracketright`   | Raise brightness to 100%                       |
| `Alt+Ctrl+space`           | Switch input method                            |
| `Super+n`                  | Pop up historical notifications                |
| `Super+Shift+n`            | Close the latest notification in view          |
| `Super+Ctrl+Shift+n`       | Close all notifications in view                |
| `Super+y`                  | Take a screenshot of all screens combined      |
| `Super+Shift+y`            | Take a screenshot of a selected screen         |
| `Super+Alt+y`              | Take a screenshot of a selected window         |
| `Super+Ctrl+y`             | Take a screenshot of a selected region         |
| `Print`                    | Take a screenshot of all screens combined      |
| `Shift+Print`              | Take a screenshot of a selected screen         |
| `Alt+Print`                | Take a screenshot of a selected window         |
| `Ctrl+Print`               | Take a screenshot of a custom rectangle region |
| `Super+Ctrl+n`             | play next song                                 |
| `XF86AudioNext`            | play next song                                 |
| `Super+Ctrl+p`             | play previous song                             |
| `XF86AudioPrev`            | play previous song                             |
| `Super+Ctrl+Space`         | pause/resume music playback                    |
| `XF86AudioPlay`            | pause/resume music playback                    |
| `Super+Ctrl+Shift+Space`   | stop music playback                            |
| `XF86AudioStop`            | stop music playback                            |

## Launchers

| Keybind              | Description                                                          |
| -------------------- | -------------------------------------------------------------------- |
| `Super+d`            | Launch application launcher (rofi)                                   |
| `Super+Return`       | Launch a terminal                                                    |
| `Super+Shift+Return` | Launch a terminal in floating mode                                   |
| `Super+Ctrl+Return`  | Launch a terminal with the same directory as in last terminal window |
| `Super+Ctrl+o`       | Launch scratchpad picker                                             |
| `Super+c`            | Pick and copy an item in clipboard history list                      |
| `Super+Shift+c`      | Launch cliphist binding mode                                         |
| `Super+Shift+m`      | Launch music binding mode                                            |
| `Super+Shift+r`      | Launch resize binding mode                                           |
| `Super+Shift+u`      | Launch utilities binding mode                                        |
| `Super+Shift+F9`     | Launch screen recording binding mode                                 |
| `Super+Shift+F10`    | Launch audio recording binding mode                                  |

## Modes

### Resizing binding mode

| Keybind   | Description              |
| --------- | ------------------------ |
| `h`       | shrink width by 10px     |
| `j`       | shrink height by 10px    |
| `k`       | grow height by 10px      |
| `l`       | grow width by 10px       |
| `Shift+h` | shrink width by 30px     |
| `Shift+j` | shrink height by 30px    |
| `Shift+k` | grow height by 30px      |
| `Shift+l` | grow width by 30px       |
| `minus`   | shrink gap by 2px        |
| `plus`    | grow gap by 2px          |
| `Return`  | Quit active binding mode |
| `Escape`  | Quit active binding mode |
| `Super+r` | Quit active binding mode |

### Cliphist binding mode

| Keybind         | Description                          |
| --------------- | ------------------------------------ |
| `c`             | Copy an item from the history list   |
| `d`             | Delete an item from the history list |
| `w`             | Wipe the history list                |
| `Return`        | Quit active binding mode             |
| `Escape`        | Quit active binding mode             |
| `Super+Shift+c` | Quit active binding mode             |

### Music binding mode

| Keybind         | Description                   |
| --------------- | ----------------------------- |
| `Super+Shift+m` | Launch/quit Music mode        |
| `s`             | Start MPD and mpDris2 service |
| `k`             | Kill MPD and mpDris2 service  |
| `p`             | Start `ncmpcpp` player        |
| `Return`        | Quit active binding mode      |
| `Escape`        | Quit active binding mode      |
| `Super+Shift+m` | Quit active binding mode      |

### Audio Recording binding mode

| Keybind           | Description              |
| ----------------- | ------------------------ |
| `s`               | Start audio recorder     |
| `k`               | Stop recording           |
| `Return`          | Quit active binding mode |
| `Escape`          | Quit active binding mode |
| `Super+Shift+F10` | Quit active binding mode |

### Screen Recording binding mode

| Keybind          | Description                                 |
| ---------------- | ------------------------------------------- |
| `k`              | Stop recording                              |
| `o`              | Record the currently focused display output |
| `w`              | Record the currently focused window         |
| `O`              | Record a selected display output            |
| `W`              | Record a selected window                    |
| `G`              | Record a selected rectangular region        |
| `Return`         | Quit active binding mode                    |
| `Escape`         | Quit active binding mode                    |
| `Super+Shift+F9` | Quit active binding mode                    |

### Power binding mode

| Keybind         | Description                     |
| --------------- | ------------------------------- |
| `l`             | Lock the current session        |
| `e`             | Logout from the current session |
| `r`             | Reboot the system               |
| `s`             | Suspend (sleep) the system      |
| `Shift+s`       | Power off the machine           |
| `Return`        | Quit active binding mode        |
| `Escape`        | Quit active binding mode        |
| `Super+Shift+e` | Quit active binding mode        |

### Utilities binding mode

| Keybind         | Description                                  |
| --------------- | -------------------------------------------- |
| `d`             | Use udiskie to mount/unmount removable disks |
| `m`             | Run audio mixer                              |
| `Return`        | Quit active binding mode                     |
| `Escape`        | Quit active binding mode                     |
| `Super+Shift+u` | Quit active binding mode                     |

## Auto-started background applications

- `/usr/libexec/lxqt-policykit-agent`: A graphical PolicyKit agent
- `autotiling-rs`: A bspwm-style auto-tiling plugin for Sway
- `fcitx5`: An input method framework
- `foot`: A super-fast terminal emulator for Wayland (server side)
- `kanshi`: A dynamic display output configuration manager
- `swayidle`: An idle manager for Wayland
- `wl-clip-persist`: A program that keeps Wayland clipboard for a program even
  after the program exits
- `~/.local/libexec/xeo-utils-desktop/wobd`: A script that runs `wob` in the background to
  visualize volume and brightness adjustment
- `~/.local/libexec/xeo-utils-desktop/clipboard-watcher`: A script that runs `wl-paste` in
  the background to monitor system clipboard and write new data to `cliphist`
  database
