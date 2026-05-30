local once = {
  "dbus-update-activation-environment --systemd --all",
  "systemctl --user start hyprland-session.target",
  "bash -c \"wl-paste --watch cliphist store &\"",
  "gnome-keyring-daemon --start --components=secrets,ssh",
  "hyprctl setcursor macos-tahoe-cursor 32",
  "vicinae server",
  "flameshot",
}

hl.on("hyprland.start", function()
  for _, cmd in ipairs(once) do
    hl.exec_cmd(cmd)
  end
end)
