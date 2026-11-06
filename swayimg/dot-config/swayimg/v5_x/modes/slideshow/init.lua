-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Main configuration for swayimg (v5.1+) slideshow mode.

require("v5_x.modes.slideshow.text")
require("v5_x.modes.slideshow.bindings")

swayimg.slideshow.set_image_background(0xff111111)
swayimg.slideshow.mark_color = 0xffffffff
-- Disable auto-centering to allow manual panning
swayimg.viewer.autopos = "free" -- v5.7
swayimg.viewer.autocenter = false -- v5.5 ~ v5.6
if swayimg.viewer.enable_centering then -- v5.1 ~ v5.4
	swayimg.viewer.enable_centering(false)
end
