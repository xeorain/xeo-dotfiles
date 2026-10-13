-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Key bindings for swayimg (v5.1+) viewer mode.

swayimg.viewer.bind_reset()

local util = require("util.viewer")

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
	swayimg.mode = "gallery"
end)
-- switch to slideshow mode
swayimg.viewer.on_key("s", function()
	swayimg.viewer.animation = true
	swayimg.mode = "slideshow"
	swayimg.slideshow.animation = true
end)

-- Toggling ===================================================================
-- toggle anti-aliasing
swayimg.viewer.on_key("a", function()
  swayimg.antialiasing = not swayimg.antialiasing
end)
-- toggle animation
swayimg.viewer.on_key("space", function()
  swayimg.viewer.animation = not swayimg.viewer.animation
end)
-- show/hide text overlay
swayimg.viewer.on_key("t", function()
  swayimg.text.visible = not swayimg.text.visible
end)
-- toogle fullscreen
swayimg.viewer.on_key("f", function()
	swayimg.fullscreen = not swayimg.fullscreen
end)
-- mark/unmark current image
swayimg.viewer.on_key("m", swayimg.viewer.mark_image)
-- toggle chessboard
swayimg.viewer.on_key("c", toggle_viewer_chessboard)

-- Animation ==================================================================
-- next_frame
swayimg.viewer.on_key("period", function()
	swayimg.viewer.frame = swayimg.viewer.frame + 1
end)
-- prev_frame
swayimg.viewer.on_key("comma", function()
  local frame = swayimg.viewer.frame
  if frame >0 then
    swayimg.viewer.frame = frame - 1
  end
end)

-- Navigation =================================================================
-- next_file
swayimg.viewer.on_key("n", function()
	swayimg.viewer.open("next")
end)
-- prev_file
swayimg.viewer.on_key("p", function()
	swayimg.viewer.open("prev")
end)
-- first_file
swayimg.viewer.on_key("g", function()
	swayimg.viewer.open("first")
end)
-- last_file
swayimg.viewer.on_key("Shift+g", function()
	swayimg.viewer.open("last")
end)
-- next_dir
swayimg.viewer.on_key("Ctrl+n", function()
	swayimg.viewer.open("next_dir")
end)
-- prev_dir
swayimg.viewer.on_key("Ctrl+p", function()
	swayimg.viewer.open("prev_dir")
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
	local scale = swayimg.viewer.scale
	swayimg.viewer.set_abs_scale(scale + scale / 10)
end)
-- zoom -10
swayimg.viewer.on_key("o", function()
	local scale = swayimg.viewer.scale
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
