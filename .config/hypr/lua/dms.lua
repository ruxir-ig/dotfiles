-- Mirrors the current DMS-generated snippets in dms/*.conf.
-- DMS may still rewrite those legacy files; keep user overrides here.

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 4,
    border_size = 0,
    col = {
      active_border = "rgb(ffb4a4)",
      inactive_border = "rgb(a08c88)",
    },
  },

  decoration = {
    rounding = 8,
  },
})
