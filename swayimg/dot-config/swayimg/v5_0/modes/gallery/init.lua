-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Main configuration for swayimg (v5.0.x) gallery mode.

require("v5_0.modes.gallery.text")
require("v5_0.modes.gallery.bindings")

swayimg.gallery.set_selected_scale(1.2)
swayimg.gallery.set_aspect("keep")
swayimg.gallery.set_thumb_size(200)
swayimg.gallery.set_border_size(4)
swayimg.gallery.set_border_color(0xffeeeeee)
swayimg.gallery.set_mark_color(0xffffffff)
swayimg.gallery.enable_preload(true)
