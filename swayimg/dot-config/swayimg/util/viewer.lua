-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Utility functions for swayimg viewer mode.
--
-- Requires:    ImageMagick, libnotify, rofi (>= 2.0) or rofi-wayland,
--              qrtool (https://github.com/sorairolake/qrtool),
--              ~/.local/bin/xeo-util,
--              ~/.local/libexec/xeo-utils-extra/xeo-set-wallpaper

local M = {}

function M.delete()
	local img = swayimg.viewer.get_image()
	if not img or not img.path then
		return
	end

	local p = io.popen("printf 'no\nyes' | rofi -dmenu -p '[swayimg] Delete image?'", "r")
	if not p then
		return
	end
	local choice = p:read("*a")
	p:close()
	choice = choice:match("^%s*(.-)%s*$")
	if choice ~= "yes" then
		return
	end

	if not os.remove(img.path) then
		os.execute(string.format("notify-send -t 1100 -u low -r 3301 'swayimg' 'Failed to remove %s'", img.path))
		return
	end
	-- NOTE: swayimg.imagelist.size is only available since swayimg v5.5
	local num_items = swayimg.imagelist.size or #swayimg.imagelist.get()
	if num_items > 1 then
		if not IS_V5_0 then
			swayimg.viewer.open("next")
		else
			swayimg.viewer.switch_image("next")
		end
	end
	swayimg.imagelist.remove(img.path)
	os.execute(string.format("notify-send -t 1100 -u low -r 3301 'swayimg' 'Removed %s'", img.path))
end

function M.rename()
	local img = swayimg.viewer.get_image()
	if not img or not img.path then
		return
	end

	local p = io.popen("rofi -dmenu -p '[swayimg] New name: ' < /dev/null", "r")
	if not p then
		return
	end
	local new_name = p:read("*a"):gsub("\n$", "") or ""
	p:close()
	if new_name == "" then
		return
	end

	local dir, old_name = img.path:match("^(.+/)([^/]+)$")
	if not dir then
		dir = "."
	end
	local newpath = dir .. new_name
	if not os.rename(img.path, newpath) then
		os.execute(string.format("notify-send -t 1100 -u low -r 3301 'swayimg' 'Failed to rename %s'", old_name))
		return
	end

	-- NOTE: swayimg.imagelist.size is only available since swayimg v5.5
	local num_items = swayimg.imagelist.size or #swayimg.imagelist.get()
	if num_items > 1 then
		swayimg.imagelist.add(newpath)
		swayimg.imagelist.remove(img.path)
	end
	swayimg.viewer.open_path(newpath)
	os.execute(string.format("notify-send -t 1100 -u low -r 3301 'swayimg' 'Renamed to %s'", new_name))
end

function M.qrscan()
	local img = swayimg.viewer.get_image()
	if not img or not img.path then
		return
	end

	local fpath = "'" .. img.path:gsub("'", "'\\''") .. "'"
	local ok, _, _ = os.execute(string.format("qrtool decode %s | wl-copy", fpath))
	if ok then
		os.execute("notify-send -t 1100 -u low -r 3301 'swayimg' 'QR code copied to clipboard'")
	end
end

function M.set_wallpaper()
	local img = swayimg.viewer.get_image()
	if not img or not img.path then
		return
	end

	local fpath = "'" .. img.path:gsub("'", "'\\''") .. "'"
	local fname = img.path:match("([^/]+)$") or img.path
	local ok, _, _ = os.execute(string.format("~/.local/bin/xeo-util set-wallpaper '%s'", fpath))
	if ok then
		os.execute(string.format("notify-send -r 107 -u low 'swayimg' '%s is set as wallpaper'", fname))
	end
end

function M.invert()
	local img = swayimg.viewer.get_image()
	if not img or not img.path then
		return
	end

	local fpath = "'" .. img.path:gsub("'", "'\\''") .. "'"
	os.execute(string.format("convert %s -channel RGB -negate - | swayimg -", fpath))
end

return M
