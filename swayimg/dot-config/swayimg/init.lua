-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- User configuration for swayimg.
--
-- See /usr/share/swayimg/swayimg.lua and /usr/share/swayimg/example.lua for a
-- complete reference.
--
-- NOTE:
-- * swayimg started supporting Lua scripting since version 5.0.
-- * swayimg 5.0 version uses its own specific short-lived function-setter-style
--   APIs.
-- * swayimg 5.1 and later versions use refactored table-property-style APIs.
--
-- Requires:    swayimg (>= 5.0)

-- In swayimg version 5.0.x, keyboard event listening was global. The function
-- to hook a keypress was attached right to the top-level root module namespace
-- as swayimg.on_key()
IS_V5_0 = swayimg.on_key ~= nil

if IS_V5_0 then
  require("v5_0.init")
  require("v5_0.modes.viewer.init")
  require("v5_0.modes.gallery.init")
  require("v5_0.modes.slideshow.init")
else
  require("v5_x.init")
  require("v5_x.modes.viewer.init")
  require("v5_x.modes.gallery.init")
  require("v5_x.modes.slideshow.init")
end
