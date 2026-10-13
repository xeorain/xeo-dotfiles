-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Main configuration for swayimg (v5.1+).

swayimg.text.timeout = 0
swayimg.text.visible = false
swayimg.text.font = "sans-serif"
swayimg.text.size = 20
swayimg.text.padding = 2
swayimg.text.color = 0xffdddddd
swayimg.text.shadow = 0xff222222

swayimg.mode = "viewer"  -- default mode
swayimg.imagelist.order = "none"

-- Register a callback to the window resize event
swayimg.on_window_resize(function()
	if swayimg.mode == "viewer" then
		swayimg.viewer.set_fix_scale("optimal")
	elseif swayimg.mode == "slideshow" then
		swayimg.slideshow.set_fix_scale("optimal")
	end
end)
