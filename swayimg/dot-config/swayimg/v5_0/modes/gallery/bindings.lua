-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Key bindings for swayimg (v5.0.x) gallery mode.

swayimg.gallery.bind_reset()

local util = require("util.gallery")

local is_antialiasing = true
local function toggle_antialiasing()
	if is_antialiasing then
		swayimg.enable_antialiasing(false)
		is_antialiasing = false
	else
		swayimg.enable_antialiasing(true)
		is_antialiasing = true
	end
end

local function toggle_text()
	if swayimg.text.visible() then
		swayimg.text.hide()
	else
		swayimg.text.show()
	end
end

-- Quit swayimg
swayimg.gallery.on_key("q", function()
	swayimg.exit(0)
end)
swayimg.gallery.on_key("escape", function()
	swayimg.exit(0)
end)

-- Mode switching =============================================================
-- switch to viewer mode
swayimg.gallery.on_key("return", function()
	swayimg.set_mode("viewer")
end)
-- switch to slideshow mode
swayimg.gallery.on_key("s", function()
	swayimg.set_mode("slideshow")
end)

-- Toggling ===================================================================
-- toggle anti-aliasing
swayimg.gallery.on_key("a", toggle_antialiasing)
-- show/hide text overlay
swayimg.gallery.on_key("t", toggle_text)
-- toggle fullscreen
swayimg.gallery.on_key("f", function()
	swayimg.toggle_fullscreen()
end)
-- mark/umark current image
swayimg.gallery.on_key("m", swayimg.gallery.mark_image)

-- Navigation =================================================================
-- first_file
swayimg.gallery.on_key("g", function()
	swayimg.gallery.switch_image("first")
end)
-- last_file
swayimg.gallery.on_key("Shift+g", function()
	swayimg.gallery.switch_image("last")
end)
-- step_left
swayimg.gallery.on_key("h", function()
  swayimg.gallery.switch_image("left")
end)
swayimg.gallery.on_key("Left", function()
  swayimg.gallery.switch_image("left")
end)
-- step_down
swayimg.gallery.on_key("j", function()
  swayimg.gallery.switch_image("down")
end)
swayimg.gallery.on_key("Down", function()
  swayimg.gallery.switch_image("down")
end)
-- step_up
swayimg.gallery.on_key("k", function()
  swayimg.gallery.switch_image("up")
end)
swayimg.gallery.on_key("Up", function()
  swayimg.gallery.switch_image("up")
end)
-- step_right
swayimg.gallery.on_key("l", function()
  swayimg.gallery.switch_image("right")
end)
swayimg.gallery.on_key("Right", function()
  swayimg.gallery.switch_image("right")
end)
-- step_pgdown
swayimg.gallery.on_key("n", function()
	swayimg.gallery.switch_image("pgdown")
end)
-- step_pgup
swayimg.gallery.on_key("p", function()
	swayimg.gallery.switch_image("pgup")
end)

-- Zooming ====================================================================
-- thumb +10
swayimg.gallery.on_key("i", function()
	local cursz = swayimg.gallery.get_thumb_size()
	swayimg.gallery.set_thumb_size(cursz + 10)
end)
-- thumb -10
swayimg.gallery.on_key("o", function()
	local cursz = swayimg.gallery.get_thumb_size()
	swayimg.gallery.set_thumb_size(cursz - 10)
end)
swayimg.gallery.on_key("z", function()
  swayimg.gallery.set_thumb_size(200)
end)

-- File operations ============================================================
-- Delete image
swayimg.gallery.on_key("Ctrl+d", util.delete)
-- Rename image
swayimg.gallery.on_key("Ctrl+r", util.rename)
-- QR scan image
swayimg.gallery.on_key("Ctrl+s", util.qrscan)
-- Invert color
swayimg.gallery.on_key("Ctrl+i", util.invert)
-- Set wallpaper
--swayimg.gallery.on_key("Ctrl+w", util.set_wallpaper)
