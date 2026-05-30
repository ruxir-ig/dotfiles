hl.config({
  input = {
    kb_layout = "us",
    numlock_by_default = true,
    touchpad = {
      natural_scroll = true,
      disable_while_typing = true,
      clickfinger_behavior = true,
      tap_to_click = true,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "vertical",
  action = "workspace",
})

hl.gesture({
  fingers = 4,
  direction = "pinch",
  action = "special",
  workspace_name = "magic",
})
