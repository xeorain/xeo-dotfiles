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

-- Swayimg APIs change a lot across versions, and referencing deprecated options
-- or APIs will cause Swayimg to print warning messages to the terminal. Since
-- there is no documented way to suppress these deprecation warnings, we need to
-- use the appropriate options and APIs for each specific version.
-- Unfortunately, Swayimg does not expose any public interface to query its
-- version or determine whether an option or a function is deprecated.
--
-- This function attempts to extract the version number from `swayimg --version`
-- output.
local function get_swayimg_version()
	if not io.popen then
		return nil
	end

	local pipe = io.popen("swayimg --version 2>/dev/null")
	local line = pipe and pipe:read("*l")
	if pipe then
		pipe:close()
	end
	if not line then
		return
	end

	local ver = line and line:match("version%s+(%d+%.%d+)")
	if not ver then
		return
	end
	local major, minor = ver:match("(%d+)%.(%d+)")
	return tonumber(major), tonumber(minor)
end

local ver_major, ver_minor = get_swayimg_version()
if not (ver_major and ver_minor) then
	error("unable to determine Swayimg version")
end
SWAYIMG_VERSION = ver_major + ver_minor / 10

if SWAYIMG_VERSION == 5.0 then
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
