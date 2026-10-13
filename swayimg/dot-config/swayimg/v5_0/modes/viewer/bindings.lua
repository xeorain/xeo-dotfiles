-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Key bindings for swayimg (v5.0.x) viewer mode.

swayimg.viewer.bind_reset()

local util = require("util.viewer")

_G.is_viewer_animation_on = true
local function toggle_viewer_animation()
	if _G.is_viewer_animation_on then
		swayimg.viewer.animation_stop()
		_G.is_viewer_animation_on = false
	else
		swayimg.viewer.animation_resume()
		_G.is_viewer_animation_on = true
	end
end

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

local is_viewer_chessboard = false
local function toggle_viewer_chessboard()
	if is_viewer_chessboard then
		swayimg.viewer.set_image_background(0xff111111)
		is_viewer_chessboard = false
	else
		swayimg.viewer.set_image_chessboard(8, 0xff666666, 0xff999999)
		is_viewer_chessboard = true
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
swayimg.viewer.on_key("q", function()
	swayimg.exit(0)
end)
swayimg.viewer.on_key("escape", function()
	swayimg.exit(0)
end)

-- Mode switching =============================================================
-- switch to gallery mode
swayimg.viewer.on_key("return", function()
	swayimg.set_mode("gallery")
end)
-- switch to slideshow mode
swayimg.viewer.on_key("s", function()
	_G.is_slideshow_animation_on = true
	swayimg.set_mode("slideshow")
	_G.is_viewer_animation_on = true
end)

-- Toggling ===================================================================
-- toggle anti-aliasing
swayimg.viewer.on_key("a", toggle_antialiasing)
-- toggle animation
swayimg.viewer.on_key("space", toggle_viewer_animation)
-- show/hide text overlay
swayimg.viewer.on_key("t", toggle_text)
-- toggle fullscreen
swayimg.viewer.on_key("f", function()
	swayimg.toggle_fullscreen()
end)
-- mark/umark current image
swayimg.viewer.on_key("m", swayimg.viewer.mark_image)
-- toggle chessboard
swayimg.viewer.on_key("c", toggle_viewer_chessboard)

-- Animation ==================================================================
-- next_frame
swayimg.viewer.on_key("period", function()
	swayimg.viewer.next_frame()
end)
-- prev_frame
swayimg.viewer.on_key("comma", function()
	swayimg.viewer.prev_frame()
end)

-- Navigation =================================================================
-- next_file
swayimg.viewer.on_key("n", function()
	swayimg.viewer.switch_image("next")
end)
-- prev_file
swayimg.viewer.on_key("p", function()
	swayimg.viewer.switch_image("prev")
end)
-- first_file
swayimg.viewer.on_key("g", function()
	swayimg.viewer.switch_image("first")
end)
-- last_file
swayimg.viewer.on_key("Shift+g", function()
	swayimg.viewer.switch_image("last")
end)
-- next_dir
swayimg.viewer.on_key("Ctrl+n", function()
	swayimg.viewer.switch_image("next_dir")
end)
-- prev_dir
swayimg.viewer.on_key("Ctrl+p", function()
	swayimg.viewer.switch_image("prev_dir")
end)

-- Position ===================================================================
-- step_left 10
swayimg.viewer.on_key("h", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(math.floor(pos.x + win.width / 10), pos.y)
end)
swayimg.viewer.on_key("Left", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(math.floor(pos.x + win.width / 10), pos.y)
end)
-- step_down 10
swayimg.viewer.on_key("j", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(pos.x, math.floor(pos.y - win.height / 10))
end)
swayimg.viewer.on_key("Down", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(pos.x, math.floor(pos.y - win.height / 10))
end)
-- step_up 10
swayimg.viewer.on_key("k", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(pos.x, math.floor(pos.y + win.height / 10))
end)
swayimg.viewer.on_key("Up", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(pos.x, math.floor(pos.y + win.height / 10))
end)
-- step_right 10
swayimg.viewer.on_key("l", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(math.floor(pos.x - win.width / 10), pos.y)
end)
swayimg.viewer.on_key("Right", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(math.floor(pos.x - win.width / 10), pos.y)
end)

-- Rotation ===================================================================
-- rotate_right
swayimg.viewer.on_key("r", function()
	swayimg.viewer.rotate(90)
end)
-- rotate_left
swayimg.viewer.on_key("Shift+r", function()
	swayimg.viewer.rotate(270)
end)
-- flip_vertical
swayimg.viewer.on_key("v", function()
	swayimg.viewer.flip_vertical()
end)
-- flip_horizontal
swayimg.viewer.on_key("Shift+v", function()
	swayimg.viewer.flip_horizontal()
end)

-- Zooming ====================================================================
-- zoom +10
swayimg.viewer.on_key("i", function()
	local scale = swayimg.viewer.get_scale()
	swayimg.viewer.set_abs_scale(scale + scale / 10)
end)
-- zoom -10
swayimg.viewer.on_key("o", function()
	local scale = swayimg.viewer.get_scale()
	swayimg.viewer.set_abs_scale(scale - scale /10)
end)
-- zoom width
swayimg.viewer.on_key("w", function()
  swayimg.viewer.set_fix_scale("width")
end)
-- zoom height
swayimg.viewer.on_key("e", function()
  swayimg.viewer.set_fix_scale("height")
end)
-- zoom fill
swayimg.viewer.on_key("Shift+f", function()
  swayimg.viewer.set_fix_scale("fill")
end)
-- zoom fit
swayimg.viewer.on_key("z", function()
  swayimg.viewer.set_fix_scale("fit")
end)
-- position and zoom reset
swayimg.viewer.on_key("Shift+z", function()
  swayimg.viewer.reset()
end)

-- File operations ============================================================
-- Delete image
swayimg.viewer.on_key("Ctrl+d", util.delete)
-- Rename image
swayimg.viewer.on_key("Ctrl+r", util.rename)
-- QR scan image
swayimg.viewer.on_key("Ctrl+s", util.qrscan)
-- Invert color
swayimg.viewer.on_key("Ctrl+i", util.invert)
-- Set wallpaper
--swayimg.viewer.on_key("Ctrl+w", util.set_wallpaper)
