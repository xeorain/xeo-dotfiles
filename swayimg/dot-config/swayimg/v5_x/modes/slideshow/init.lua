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
if SWAYIMG_VERSION >= 5.7 then
	swayimg.viewer.autopos = "free" -- v5.7
elseif SWAYIMG_VERSION >= 5.5 then
	swayimg.viewer.autocenter = false -- v5.5 ~ v5.6
else
	swayimg.viewer.enable_centering(false)
end
