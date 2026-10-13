-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Main configuration for swayimg (v5.0.x).

swayimg.text.set_overall_timer(0)
swayimg.text.hide()
swayimg.text.set_font("sans-serif")
swayimg.text.set_size(20)
swayimg.text.set_padding(2)
swayimg.text.set_foreground(0xffdddddd)
swayimg.text.set_shadow(0xff222222)

swayimg.set_mode("viewer")  -- default mode
swayimg.imagelist.set_order("none")

-- Register a callback to the window resize event
swayimg.on_window_resize(function()
	local mode = swayimg.get_mode()
	if mode == "viewer" then
		swayimg.viewer.set_fix_scale("optimal")
	elseif mode == "slideshow" then
		swayimg.slideshow.set_fix_scale("optimal")
	end
end)
