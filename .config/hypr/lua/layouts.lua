hl.config({
  dwindle = {
    force_split = 2,
    preserve_split = true,
  },

  master = {
    allow_small_split = false,
    new_status = "slave",
    new_on_top = false,
    new_on_active = "before",
    smart_resizing = true,
    drop_at_cursor = true,
    always_keep_position = false,
  },

  scrolling = {
    fullscreen_on_one_column = true,
    column_width = 0.667,
    focus_fit_method = 1,
    follow_focus = true,
    follow_min_visible = 0.4,
    explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
    direction = "right",
  },

  xwayland = {
    force_zero_scaling = true,
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    vrr = 1,
  },
})
