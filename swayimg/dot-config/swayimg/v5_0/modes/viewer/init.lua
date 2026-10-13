-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Main configuration for swayimg (v5.0.x) viewer mode.

require("v5_0.modes.viewer.text")
require("v5_0.modes.viewer.bindings")

swayimg.viewer.set_default_scale("optimal")
swayimg.viewer.set_window_background(0xff111111)
swayimg.viewer.set_image_background(0xff111111)
swayimg.viewer.set_mark_color(0xffffffff)
