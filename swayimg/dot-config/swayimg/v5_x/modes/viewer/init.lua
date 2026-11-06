-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Main configuration for swayimg (v5.1+) viewer mode.

require("v5_x.modes.viewer.text")
require("v5_x.modes.viewer.bindings")

swayimg.viewer.default_scale = "optimal"
-- Disable auto-centering to allow manual panning
swayimg.viewer.autopos = "free" -- v5.7
swayimg.viewer.autocenter = false -- v5.5 ~ v5.6
if swayimg.viewer.enable_centering then -- v5.1 ~ v5.4
	swayimg.viewer.enable_centering(false)
end
swayimg.viewer.set_window_background(0xff111111)
swayimg.viewer.set_image_background(0xff111111)
swayimg.viewer.mark_color = 0xffffffff
