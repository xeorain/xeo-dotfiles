-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Key bindings for swayimg (v5.0.x) slideshow mode.

swayimg.slideshow.bind_reset()

local util = require("util.slideshow")

_G.is_slideshow_animation_on = true
local function toggle_slideshow_animation()
	if _G.is_slideshow_animation_on then
		swayimg.slideshow.animation_stop()
		_G.is_slideshow_animation_on = false
	else
		swayimg.slideshow.animation_resume()
		_G.is_slideshow_animation_on = true
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

local is_slideshow_chessboard = false
local function toggle_slideshow_chessboard()
	if is_slideshow_chessboard then
		swayimg.slideshow.set_image_background(0xff111111)
		is_slideshow_chessboard = false
	else
		swayimg.slideshow.set_image_chessboard(8, 0xff666666, 0xff999999)
		is_slideshow_chessboard = true
	end
end

local function toggle_text()
	if swayimg.text.visible() then
		swayimg.text.hide()
	else
		swayimg.text.show()
	end
end

-- Set timeout
for n = 1, 9 do
  swayimg.slideshow.on_key(tostring(n), function()
    swayimg.slideshow.set_timeout(n)
  end)
end

-- Quit swayimg
swayimg.slideshow.on_key("q", function()
	swayimg.exit(0)
end)
swayimg.slideshow.on_key("escape", function()
	swayimg.exit(0)
end)

-- Mode switching =============================================================
-- switch to gallery mode
swayimg.slideshow.on_key("return", function()
	swayimg.set_mode("gallery")
end)
-- switch to viewer mode
swayimg.slideshow.on_key("s", function()
	_G.is_slideshow_animation_on = true
	swayimg.set_mode("viewer")
	_G.is_viewer_animation_on = true
end)

-- Toggling ===================================================================
-- toggle anti-aliasing
swayimg.slideshow.on_key("a", toggle_antialiasing)
-- toggle animation
swayimg.slideshow.on_key("space", toggle_slideshow_animation)
-- show/hide text overlay
swayimg.slideshow.on_key("t", toggle_text)
-- toggle fullscreen
swayimg.slideshow.on_key("f", function()
	swayimg.toggle_fullscreen()
end)
-- mark/umark current image
swayimg.slideshow.on_key("m", swayimg.slideshow.mark_image)
-- toggle chessboard
swayimg.slideshow.on_key("c", toggle_slideshow_chessboard)

-- Animation ==================================================================
-- next_frame
swayimg.slideshow.on_key("period", function()
	swayimg.slideshow.next_frame()
end)
-- prev_frame
swayimg.slideshow.on_key("comma", function()
	swayimg.slideshow.prev_frame()
end)

-- Navigation =================================================================
-- next_file
swayimg.slideshow.on_key("n", function()
	swayimg.slideshow.switch_image("next")
end)
-- prev_file
swayimg.slideshow.on_key("p", function()
	swayimg.slideshow.switch_image("prev")
end)
-- first_file
swayimg.slideshow.on_key("g", function()
	swayimg.slideshow.switch_image("first")
end)
-- last_file
swayimg.slideshow.on_key("Shift+g", function()
	swayimg.slideshow.switch_image("last")
end)
-- next_dir
swayimg.slideshow.on_key("Ctrl+n", function()
	swayimg.slideshow.switch_image("next_dir")
end)
-- prev_dir
swayimg.slideshow.on_key("Ctrl+p", function()
	swayimg.slideshow.switch_image("prev_dir")
end)

-- Position ===================================================================
-- step_left 10
swayimg.slideshow.on_key("h", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.slideshow.get_position()
	swayimg.slideshow.set_abs_position(math.floor(pos.x + win.width / 10), pos.y)
end)
swayimg.slideshow.on_key("Left", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.slideshow.get_position()
	swayimg.slideshow.set_abs_position(math.floor(pos.x + win.width / 10), pos.y)
end)
-- step_down 10
swayimg.slideshow.on_key("j", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.slideshow.get_position()
	swayimg.slideshow.set_abs_position(pos.x, math.floor(pos.y - win.height / 10))
end)
swayimg.slideshow.on_key("Down", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.slideshow.get_position()
	swayimg.slideshow.set_abs_position(pos.x, math.floor(pos.y - win.height / 10))
end)
-- step_up 10
swayimg.slideshow.on_key("k", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.slideshow.get_position()
	swayimg.slideshow.set_abs_position(pos.x, math.floor(pos.y + win.height / 10))
end)
swayimg.slideshow.on_key("Up", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.slideshow.get_position()
	swayimg.slideshow.set_abs_position(pos.x, math.floor(pos.y + win.height / 10))
end)
-- step_right 10
swayimg.slideshow.on_key("l", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.slideshow.get_position()
	swayimg.slideshow.set_abs_position(math.floor(pos.x - win.width / 10), pos.y)
end)
swayimg.slideshow.on_key("Right", function()
	local win = swayimg.get_window_size()
	local pos = swayimg.slideshow.get_position()
	swayimg.slideshow.set_abs_position(math.floor(pos.x - win.width / 10), pos.y)
end)

-- Rotation ===================================================================
-- rotate_right
swayimg.slideshow.on_key("r", function()
	swayimg.slideshow.rotate(90)
end)
-- rotate_left
swayimg.slideshow.on_key("Shift+r", function()
	swayimg.slideshow.rotate(270)
end)
-- flip_vertical
swayimg.slideshow.on_key("v", function()
	swayimg.slideshow.flip_vertical()
end)
-- flip_horizontal
swayimg.slideshow.on_key("Shift+v", function()
	swayimg.slideshow.flip_horizontal()
end)

-- Zooming ====================================================================
-- zoom +10
swayimg.slideshow.on_key("i", function()
	local scale = swayimg.slideshow.get_scale()
	swayimg.slideshow.set_abs_scale(scale + scale /10)
end)
-- zoom -10
swayimg.slideshow.on_key("o", function()
	local scale = swayimg.slideshow.get_scale()
	swayimg.slideshow.set_abs_scale(scale - scale / 10)
end)
-- zoom width
swayimg.slideshow.on_key("w", function()
  swayimg.slideshow.set_fix_scale("width")
end)
-- zoom height
swayimg.slideshow.on_key("e", function()
  swayimg.slideshow.set_fix_scale("height")
end)
-- zoom fill
swayimg.slideshow.on_key("Shift+f", function()
  swayimg.slideshow.set_fix_scale("fill")
end)
-- zoom fit
swayimg.slideshow.on_key("z", function()
  swayimg.slideshow.reset()
end)
-- position and zoom reset
swayimg.slideshow.on_key("Shift+z", function()
  swayimg.slideshow.reset()
end)

-- File operations ============================================================
-- Delete image
swayimg.slideshow.on_key("Ctrl+d", util.delete)
-- Rename image
swayimg.slideshow.on_key("Ctrl+r", util.rename)
-- QR scan image
swayimg.slideshow.on_key("Ctrl+s", util.qrscan)
-- Invert color
swayimg.slideshow.on_key("Ctrl+i", util.invert)
-- Set wallpaper
--swayimg.slideshow.on_key("Ctrl+w", util.set_wallpaper)
