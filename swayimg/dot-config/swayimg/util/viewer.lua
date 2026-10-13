-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Utility functions for swayimg viewer mode.
--
-- Requires:    ImageMagick, libnotify, rofi (>= 2.0) or rofi-wayland,
--              qrtool (https://github.com/sorairolake/qrtool),
--              xeo-setwallpaper

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
	if choice == "yes" then
		os.remove(img.path)
		os.execute(string.format("notify-send -t 1100 -u low -r 3301 'swayimg' 'Deleted %s'", img.path))
    if not IS_V5_0 then
      swayimg.viewer.reload()
    else
      swayimg.viewer.switch_image("next")
    end
	end
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

	local name = p:read("*a")
	p:close()
	name = name:match("^(.-)\n$")

	if name ~= "" then
		local dir = img.path.match("^(.*/)") or "."
		local newpath = dir .. name
		local ok = os.rename(img.path, newpath)
		if ok then
			os.execute(string.format("notify-send -t 1100 -u low -r 3301 'swayimg' 'Renamed to %s'", name))
      if not IS_V5_0 then
        swayimg.viewer.reload()
      else
        swayimg.viewer.switch_image("next")
      end
		else
			os.execute("notify-send -t 1100 -u low -r 3301 'swayimg' 'Renam failed'")
		end
	end
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
	local ok, _, _ = os.execute(string.format("~/.local/bin/xeo-setwallpaper", fpath))
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
