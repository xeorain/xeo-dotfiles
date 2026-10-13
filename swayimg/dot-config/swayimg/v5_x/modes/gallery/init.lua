-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Main configuration for swayimg (v5.1+) gallery mode.

require("v5_x.modes.gallery.text")
require("v5_x.modes.gallery.bindings")

swayimg.gallery.selected_scale = 1.2
swayimg.gallery.aspect = "keep"
swayimg.gallery.thumb_size = 200
swayimg.gallery.border_size = 4
swayimg.gallery.border_color = 0xffeeeeee
swayimg.gallery.mark_color = 0xffffffff
swayimg.gallery.preload = true
