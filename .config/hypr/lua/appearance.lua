hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 5,
    border_size = 0,
    col = {
      active_border = "rgba(707070ff)",
      inactive_border = "rgba(d0d0d0ff)",
    },
    layout = "scrolling",
  },

  decoration = {
    rounding = 6,
    rounding_power = 7,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    shadow = {
      enabled = true,
      range = 30,
      render_power = 5,
      offset = { 0, 5 },
      color = "rgba(00000055)",
      color_inactive = "rgba(30486077)",
    },
    blur = {
      enabled = true,
      size = 10,
      passes = 2,
      ignore_opacity = true,
      new_optimizations = true,
      noise = 0.05,
      contrast = 1.5,
      brightness = 0.8,
      popups = true,
    },
  },
})
