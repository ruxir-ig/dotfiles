local mod = "SUPER"

local function sh(keys, cmd, opts)
  hl.bind(keys, hl.dsp.exec_cmd(cmd), opts)
end

local function dispatch(keys, cmd, opts)
  sh(keys, "hyprctl dispatch " .. cmd, opts)
end

sh(mod .. " + Return", "ghostty")
sh("ALT + Return", "limux")
sh(mod .. " + E", "nemo")
sh("ALT + E", "dolphin")
sh(mod .. " + B", "zen-browser")
sh(mod .. " + SHIFT + B", "helium-browser")
sh(mod .. " + C", "t3code")
sh(mod .. " + Z", "~/.local/zed.app/bin/zed")

sh(mod .. " + space", "vicinae toggle")
sh(mod .. " + V", "vicinae vicinae://launch/clipboard/history")
sh(mod .. " + period", "vicinae vicinae://launch/core/search-emojis")

sh("ALT + space", "dms ipc call spotlight toggle")
sh("ALT + V", "dms ipc call clipboard toggle")
sh(mod .. " + comma", "dms ipc call settings focusOrToggle")
sh(mod .. " + N", "dms ipc call notifications toggle")
sh(mod .. " + Y", "dms ipc call dankdash wallpaper")
sh(mod .. " + TAB", "vicinae vicinae://launch/wm/switch-windows")
sh("ALT + comma", "dms ipc call control-center toggle")
sh(mod .. " + SHIFT + escape", "dms ipc call processlist toggle")
sh(mod .. " + SHIFT + Slash", "dms ipc call keybinds toggle hyprland")

sh(mod .. " + ALT + L", "dms ipc call lock lock")
hl.bind(mod .. " + SHIFT + E", hl.dsp.exit())
sh(mod .. " + escape", "dms ipc call powermenu toggle")
sh("CTRL + ALT + Delete", "dms ipc call processlist focusOrToggle")

sh("XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", { locked = true })
sh("XF86AudioMicMute", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", { locked = true })
sh("XF86AudioRaiseVolume", "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", { locked = true, repeating = true })
sh("XF86AudioLowerVolume", "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", { locked = true, repeating = true })

sh("XF86MonBrightnessUp", "dms ipc call brightness increment 5 \"\"", { locked = true, repeating = true })
sh("XF86MonBrightnessDown", "dms ipc call brightness decrement 5 \"\"", { locked = true, repeating = true })

sh("XF86AudioNext", "playerctl next", { locked = true })
sh("XF86AudioPause", "playerctl play-pause", { locked = true })
sh("XF86AudioPlay", "playerctl play-pause", { locked = true })
sh("XF86AudioPrev", "playerctl previous", { locked = true })

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen(1))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen(0))
hl.bind(mod .. " + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + W", hl.dsp.group.toggle())
sh(mod .. " + X", "hyprctl kill")

for _, dir in ipairs({ "left", "down", "up", "right" }) do
  local vim_key = ({ left = "H", down = "J", up = "K", right = "L" })[dir]
  hl.bind(mod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
  hl.bind(mod .. " + " .. vim_key, hl.dsp.focus({ direction = dir }))
  hl.bind(mod .. " + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
  hl.bind(mod .. " + SHIFT + " .. vim_key, hl.dsp.window.move({ direction = dir }))
end

dispatch(mod .. " + Home", "focuswindow first")
dispatch(mod .. " + End", "focuswindow last")

for _, dir in ipairs({ "left", "right" }) do
  local vim_key = ({ left = "H", right = "L" })[dir]
  dispatch(mod .. " + CTRL + " .. dir, "focusmonitor " .. dir:sub(1, 1))
  dispatch(mod .. " + CTRL + " .. vim_key, "focusmonitor " .. dir:sub(1, 1))
end

for _, dir in ipairs({ "down", "up" }) do
  local vim_key = ({ down = "J", up = "K" })[dir]
  dispatch(mod .. " + CTRL + " .. vim_key, "focusmonitor " .. dir:sub(1, 1))
end

for _, dir in ipairs({ "left", "down", "up", "right" }) do
  local vim_key = ({ left = "H", down = "J", up = "K", right = "L" })[dir]
  dispatch(mod .. " + SHIFT + CTRL + " .. dir, "movewindow mon:" .. dir:sub(1, 1))
  dispatch(mod .. " + SHIFT + CTRL + " .. vim_key, "movewindow mon:" .. dir:sub(1, 1))
end

for _, key in ipairs({ "Page_Down", "U" }) do
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = "e+1" }))
  dispatch(mod .. " + CTRL + " .. key:gsub("Page_Down", "down"), "movetoworkspace e+1")
  dispatch(mod .. " + SHIFT + " .. key, "movetoworkspace e+1")
end

for _, key in ipairs({ "Page_Up", "I" }) do
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = "e-1" }))
  dispatch(mod .. " + CTRL + " .. key:gsub("Page_Up", "up"), "movetoworkspace e-1")
  dispatch(mod .. " + SHIFT + " .. key, "movetoworkspace e-1")
end

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
dispatch(mod .. " + CTRL + mouse_down", "movetoworkspace e-1")
dispatch(mod .. " + CTRL + mouse_up", "movetoworkspace e+1")

for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mod .. " + bracketleft", hl.dsp.layout("preselect l"))
hl.bind(mod .. " + bracketright", hl.dsp.layout("preselect r"))
hl.bind(mod .. " + R", hl.dsp.layout("togglesplit"))
dispatch(mod .. " + CTRL + F", "resizeactive exact 100%")

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

dispatch(mod .. " + code:20", "resizeactive -100 0", { repeating = true, description = "Expand window left" })
dispatch(mod .. " + code:21", "resizeactive 100 0", { repeating = true, description = "Shrink window left" })
dispatch(mod .. " + minus", "resizeactive -10% 0", { repeating = true })
dispatch(mod .. " + equal", "resizeactive 10% 0", { repeating = true })
dispatch(mod .. " + SHIFT + minus", "resizeactive 0 -10%", { repeating = true })
dispatch(mod .. " + SHIFT + equal", "resizeactive 0 10%", { repeating = true })

sh("SUPER + P", "flameshot gui --raw | wl-copy")
sh("SUPER + SHIFT + P", "flameshot gui -d 2000")
sh("Print", "flameshot full -p ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png")

sh("CAPS + I", "wtype -k up")
sh("CAPS + J", "wtype -k left")
sh("CAPS + K", "wtype -k down")
sh("CAPS + L", "wtype -k right")
sh("CAPS + U", "wtype -k Page_Up")
sh("CAPS + O", "wtype -k Page_Down")
