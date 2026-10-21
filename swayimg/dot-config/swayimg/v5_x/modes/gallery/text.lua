-- SPDX-License-Identifier: MIT
--
-- Copyright (c) 2026 Jerry Xeo
--
-- Text overlay configutration for swayimg (v5.1+) gallery mode.

swayimg.gallery.text = {
  topleft = {
    "{name}",
    "{format}",
    "{sizehr}",
    "{time}",
  },
  topright = {
    "{list.index}/{list.total}",
  },
  bottomleft = {},
  bottomright = { "{dir}" },
}
