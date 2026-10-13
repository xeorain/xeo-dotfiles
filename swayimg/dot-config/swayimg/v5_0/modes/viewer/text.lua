-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Text overlay configutration for swayimg (v5.0.x) viewer mode.

swayimg.viewer.set_text("topleft", {
  "{name}",
  "{format}",
  "{sizehr}",
  "{time}",
  "{meta.Exif.Photo.DateTimeOriginal}",
  "{meta.Exif.Image.Model}"
})
swayimg.viewer.set_text("topright", {
  "{list.index}/{list.total}"
})
swayimg.viewer.set_text("bottomleft", {
  "{frame.index}/{frame.total}",
  "{frame.width}x{frame.height}",
  "{scale}"
})
swayimg.viewer.set_text("bottomright", {
  "{path}"
})
