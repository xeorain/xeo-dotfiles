-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Key bindings for swayimg (v5.1+) gallery mode.

swayimg.gallery.bind_reset()

local util = require("util.gallery")

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
	swayimg.mode = "viewer"
end)
-- switch to slideshow mode
swayimg.gallery.on_key("s", function()
	swayimg.mode = "slideshow"
end)

-- Toggling ===================================================================
-- toggle anti-aliasing
swayimg.gallery.on_key("a", function()
  swayimg.antialiasing = not swayimg.antialiasing
end)
-- show/hide text overlay
swayimg.gallery.on_key("t", function()
  swayimg.text.visible = not swayimg.text.visible
end)
-- toogle fullscreen
swayimg.gallery.on_key("f", function()
	swayimg.fullscreen = not swayimg.fullscreen
end)
-- mark/unmark current image
swayimg.gallery.on_key("m", swayimg.gallery.mark_image)

-- Navigation =================================================================
-- first_file
swayimg.gallery.on_key("g", function()
	swayimg.gallery.select("first")
end)
-- last_file
swayimg.gallery.on_key("Shift+g", function()
	swayimg.gallery.select("last")
end)
-- step_left
swayimg.gallery.on_key("h", function()
  swayimg.gallery.select("left")
end)
swayimg.gallery.on_key("Left", function()
  swayimg.gallery.select("left")
end)
-- step_down
swayimg.gallery.on_key("j", function()
  swayimg.gallery.select("down")
end)
swayimg.gallery.on_key("Down", function()
  swayimg.gallery.select("down")
end)
-- step_up
swayimg.gallery.on_key("k", function()
  swayimg.gallery.select("up")
end)
swayimg.gallery.on_key("Up", function()
  swayimg.gallery.select("up")
end)
-- step_right
swayimg.gallery.on_key("l", function()
  swayimg.gallery.select("right")
end)
swayimg.gallery.on_key("Right", function()
  swayimg.gallery.select("right")
end)
-- step_pgdown
swayimg.gallery.on_key("n", function()
	swayimg.gallery.select("pgdown")
end)
-- step_pgup
swayimg.gallery.on_key("p", function()
	swayimg.gallery.select("pgup")
end)

-- Zooming ====================================================================
-- thumb +10
swayimg.gallery.on_key("i", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size + 10
end)
-- thumb -10
swayimg.gallery.on_key("o", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size - 10
end)
swayimg.gallery.on_key("z", function()
  swayimg.gallery.thumb_size = 200
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
