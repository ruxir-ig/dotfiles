local env = {
  { "GDK_BACKEND", "wayland,x11" },
  { "QT_QPA_PLATFORM", "wayland;xcb" },
  { "SDL_VIDEODRIVER", "wayland" },
  { "CLUTTER_BACKEND", "wayland" },

  { "XDG_CURRENT_DESKTOP", "Hyprland" },
  { "XDG_SESSION_TYPE", "wayland" },
  { "XDG_SESSION_DESKTOP", "Hyprland" },

  { "QT_WAYLAND_DISABLE_WINDOWDECORATION", "1" },
  { "QT_QPA_PLATFORMTHEME", "qt6ct" },
  { "ELECTRON_OZONE_PLATFORM_HINT", "auto" },

  { "LIBVA_DRIVER_NAME", "nvidia" },
  { "NVD_BACKEND", "direct" },
  { "WLR_NO_HARDWARE_CURSORS", "1" },

  { "HYPRCURSOR_THEME", "macos-tahoe-cursor" },
  { "XCURSOR_THEME", "macos-tahoe-cursor" },
  { "HYPRCURSOR_SIZE", "24" },
  { "XCURSOR_SIZE", "24" },
}

for _, item in ipairs(env) do
  hl.env(item[1], item[2])
end
