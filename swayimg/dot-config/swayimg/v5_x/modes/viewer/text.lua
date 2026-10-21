-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Text overlay configutration for swayimg (v5.1+) viewer mode.

swayimg.viewer.text = {
  topleft = {
    "{name}",
    "{format}",
    "{sizehr}",
    "{time}",
    "{meta.Exif.Photo.DateTimeOriginal}",
    "{meta.Exif.Image.Model}",
  },
  topright = {
    "{list.index}/{list.total}",
  },
  bottomleft = {
    "{frame.index}/{frame.total}",
    "{frame.width}x{frame.height}",
    "{scale}",
  },
  bottomright = { "{path}" },
}
