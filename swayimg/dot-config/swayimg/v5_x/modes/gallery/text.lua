-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Text overlay configutration for swayimg (v5.1+) gallery mode.

swayimg.gallery.set_text("topleft", {
  "{name}",
  "{format}",
  "{sizehr}",
  "{time}",
})
swayimg.gallery.set_text("topright", {
  "{list.index}/{list.total}"
})
swayimg.gallery.set_text("bottomleft", {})
swayimg.gallery.set_text("bottomright", { "{dir}" })
