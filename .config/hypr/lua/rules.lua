local function window(name, match, effects)
  effects.name = name
  effects.match = match
  hl.window_rule(effects)
end

local function layer(name, namespace, effects)
  effects.name = name
  effects.match = { namespace = namespace }
  hl.layer_rule(effects)
end

-- Single source-of-truth for every browser class.
-- Add new browsers here and all rules below update automatically.
local browsers = table.concat({
  -- Primary
  "zen",
  "helium", "helium-browser",
  -- Firefox family
  "firefox", "librewolf", "floorp", "waterfox", "mercury-browser",
  -- Chromium family
  "google-chrome", "google-chrome-stable", "google-chrome-beta", "google-chrome-unstable",
  "chromium", "chromium-browser",
  "brave-browser", "brave-browser-beta", "brave-browser-nightly",
  "microsoft-edge", "microsoft-edge-stable", "microsoft-edge-beta",
  "vivaldi-stable", "vivaldi",
  "opera", "opera-developer",
  "thorium-browser",
  "ungoogled-chromium",
  -- GNOME / KDE
  "epiphany", "org.gnome.Epiphany",
  "falkon",
}, "|")
local browser_class = "^(" .. browsers .. ")$"

window("file-manager-opacity", { class = "^(thunar|nemo|nautilus|org\\.gnome\\.Nautilus)$" }, { opacity = "0.8" })

window("gnome-rounding", { class = "^(org\\.gnome\\.).*$" }, { rounding = 12 })
window("gnome-no-decoration", { class = "^(org\\.gnome\\.).*$" }, { decorate = false })

window("gnome-control-center-tile", { class = "^(gnome-control-center)$" }, { tile = true })
window("pavucontrol-tile", { class = "^(pavucontrol)$" }, { tile = true })
window("nm-connection-editor-tile", { class = "^(nm-connection-editor)$" }, { tile = true })

window("gnome-calculator-float", { class = "^(gnome-calculator)$" }, { float = true })
window("galculator-float", { class = "^(galculator)$" }, { float = true })
window("blueman-manager-float", { class = "^(blueman-manager)$" }, { float = true })
window("nautilus-float", { class = "^(org\\.gnome\\.Nautilus)$" }, { float = true })
window("steam-float", { class = "^(steam)$" }, { float = true })
window("xdg-desktop-portal-float", { class = "^(xdg-desktop-portal)$" }, { float = true })

window("wezterm-no-decoration", { class = "^(org\\.wezfurlong\\.wezterm)$" }, { decorate = false })
window("alacritty-no-decoration", { class = "^(Alacritty)$" }, { decorate = false })
window("zen-no-decoration", { class = "^(zen)$" }, { decorate = false })
window("ghostty-no-decoration", { class = "^(com\\.mitchellh\\.ghostty)$" }, { decorate = false })
window("kitty-no-decoration", { class = "^(kitty)$" }, { decorate = false })

window("pip-float", { class = browser_class, title = "^(Picture[- ][Ii]n[- ][Pp]icture)$" }, { float = true })
window("pip-pin",  { class = browser_class, title = "^(Picture[- ][Ii]n[- ][Pp]icture)$" }, { pin = true })
window("pip-size", { class = browser_class, title = "^(Picture[- ][Ii]n[- ][Pp]icture)$" }, { size = { 480, 270 } })
window("zoom-float", { class = "^(zoom)$" }, { float = true })

-- Title-based centering: matches transient/dialog windows by their title.
-- These fire regardless of which app spawns them, so they cover browser
-- sign-in popups, OS dialogs, third-party apps, etc.
local centered_popups = {
  -- Auth / identity
  ".*[Ss]ign[ -]?[Ii]n.*",
  ".*[Ll]og[ -]?[Ii]n.*",
  ".*[Aa]uthentication.*",
  ".*[Aa]uthori[sz]ation.*",
  ".*[Vv]erification.*",
  ".*[Pp]assword.*",
  ".*[Pp]assphrase.*",
  ".*[Uu]nlock.*",
  ".*[Bb]iometric.*",
  ".*[Ff]ace [Ii][Dd].*",
  ".*[Tt]wo[- ]?[Ff]actor.*",
  ".*2[Ff][Aa].*",
  ".*OAuth.*",
  ".*[Pp][Ii][Nn].*",
  -- Passkeys / WebAuthn / FIDO
  ".*[Pp]asskey.*",
  ".*[Pp]ass[- ]?[Kk]ey.*",
  ".*WebAuthn.*",
  ".*FIDO.*",
  ".*[Ss]ecurity [Kk]ey.*",
  ".*[Aa]uthenticator.*",
  ".*[Ff]ingerprint.*",
  ".*[Tt]ouch [Ii][Dd].*",

  -- Password managers
  ".*[Bb]itwarden.*",
  ".*1[Pp]assword.*",
  ".*[Kk]eePass.*",
  ".*[Dd]ashLane.*",
  ".*[Ll]astPass.*",
  ".*[Nn]ord[Pp]ass.*",

  -- File dialogs
  ".*[Oo]pen [Ff]ile.*",
  ".*[Ss]ave [Ff]ile.*",
  ".*[Ss]ave [Aa]s.*",
  ".*[Ff]ile [Uu]pload.*",
  ".*[Cc]hoose [Ff]ile.*",
  ".*[Ss]elect [Ff]ile.*",
  ".*[Ss]elect [Ff]older.*",
  ".*[Ss]elect [Dd]irectory.*",
  ".*[Cc]hoose.*",

  -- App settings / prefs
  ".*[Pp]references.*",
  ".*[Ss]ettings.*",
  ".*[Cc]onfiguration.*",
  ".*[Oo]ptions.*",

  -- About / info / version dialogs
  ".*[Aa]bout.*",
  ".*[Vv]ersion [Ii]nfo.*",
  ".*[Ww]hat's [Nn]ew.*",
  ".*[Rr]elease [Nn]otes.*",
  ".*[Cc]hangelog.*",

  -- Updates / installs
  ".*[Uu]pdate.*",
  ".*[Uu]pgrade.*",
  ".*[Ii]nstall.*",
  ".*[Uu]ninstall.*",
  ".*[Rr]emove.*[Pp]ackage.*",
  ".*[Pp]ackage [Mm]anager.*",
  ".*[Ss]oftware [Uu]pdate.*",

  -- Confirm / warn / error dialogs
  ".*[Cc]onfirm.*",
  ".*[Aa]re [Yy]ou [Ss]ure.*",
  ".*[Ww]arning.*",
  ".*[Ee]rror.*",
  ".*[Cc]aution.*",
  ".*[Aa]lert.*",
  ".*[Cc]rash [Rr]eport.*",
  ".*[Bb]ug [Rr]eport.*",
  ".*[Ff]eedback.*",

  -- Permissions / access
  ".*[Pp]ermission.*",
  ".*[Aa]ccess [Rr]equest.*",
  ".*[Gg]rant [Aa]ccess.*",
  ".*[Rr]equests? [Aa]ccess.*",
  ".*[Kk]eychain [Aa]ccess.*",
  ".*[Aa]llow.*",

  -- Print / share / export
  ".*[Pp]rint.*",
  ".*[Ss]hare.*",
  ".*[Ee]xport.*",
  ".*[Ss]end [Tt]o.*",

  -- Colour / font / icon pickers
  ".*[Cc]olo[u]?r [Cc]hooser.*",
  ".*[Cc]olo[u]?r [Pp]icker.*",
  ".*[Ff]ont [Cc]hooser.*",
  ".*[Ff]ont [Ss]elector.*",
  ".*[Ii]con [Pp]icker.*",

  -- Network / VPN prompts
  ".*[Cc]onnect.*[Nn]etwork.*",
  ".*[Nn]etwork [Pp]assword.*",
  ".*[Vv][Pp][Nn].*",
  ".*[Pp]roxy.*",

  -- SSH / GPG / key prompts
  ".*SSH.*",
  ".*GPG.*",
  ".*[Kk]ey[- ][Pp]assphrase.*",
  ".*[Ee]nter [Pp]assphrase.*",
  ".*[Pp]IN [Ee]ntry.*",

  -- Misc
  ".*[Pp]roperties.*",
  ".*[Ii]nformation.*",
  ".*[Dd]etails.*",
  ".*[Ss]ummary.*",
  ".*[Rr]eview.*",
  ".*[Nn]ew [Pp]rofile.*",
  ".*[Cc]reate [Aa]ccount.*",
  ".*[Rr]egister.*",
  ".*[Ss]ubscribe.*",
}

for index, title in ipairs(centered_popups) do
  window("centered-popup-" .. index, { title = title }, {
    float = true,
    center = true,
  })
end

-- ─── Class-based centering ────────────────────────────────────────────────────
-- These apps are known to spawn small, transient windows that should always
-- be centered, regardless of their window title.

-- XDG desktop portals (file pickers, screen share, etc.)
window("xdg-portals-centered", { class = "^(xdg-desktop-portal|xdg-desktop-portal-gtk|xdg-desktop-portal-gnome|xdg-desktop-portal-kde|xdg-desktop-portal-wlr)$" }, {
  float = true,
  center = true,
})

-- Polkit authentication agents (pkexec, GNOME/KDE polkit agents)
window("polkit-agents-centered", { class = "^(polkit-gnome-authentication-agent-1|org\\.gnome\\.PolicyKit1\\.AuthenticationAgent|lxpolkit|kdesu|kdesudo|org\\.kde\\.kdesu)$" }, {
  float = true,
  center = true,
})

-- GPG / SSH / secret-service PIN entry dialogs
window("pinentry-centered", { class = "^(pinentry|pinentry-gtk|pinentry-gnome3|pinentry-qt|pinentry-qt5|gcr-prompter|gcr-viewer|gnome-keyring-prompt)$" }, {
  float = true,
  center = true,
})

-- GNOME keyring / secret service dialogs
window("gnome-keyring-centered", { class = "^(gnome-keyring-ask|org\\.gnome\\.seahorse\\.Application|seahorse)$" }, {
  float = true,
  center = true,
})

-- System update / package manager GUIs
window("update-managers-centered", { class = "^(update-manager|gnome-software|pamac-manager|pamac|octopi|discover|mintupdate|muon|synaptic|gdebi)$" }, {
  float = true,
  center = true,
})

-- GNOME control center and system settings
window("system-settings-centered", { class = "^(gnome-control-center|unity-control-center|cinnamon-settings|xfce4-settings-manager|systemsettings5|systemsettings|plasma-settings)$" }, {
  float = true,
  center = true,
})

-- Network / wifi / VPN managers
window("network-managers-centered", { class = "^(nm-connection-editor|nm-applet|wicd-gtk|wpa_gui|vpn-ui)$" }, {
  float = true,
  center = true,
})

-- Bluetooth managers
window("bluetooth-managers-centered", { class = "^(blueman-manager|blueberry|bluetooth-sendto)$" }, {
  float = true,
  center = true,
})

-- Printer / scanner dialogs
window("print-dialogs-centered", { class = "^(system-config-printer|gnome-printer|simple-scan|xsane|skanlite)$" }, {
  float = true,
  center = true,
})

-- Disk / partition tools (when opened as dialogs)
window("disk-tools-centered", { class = "^(gparted|gnome-disks|org\\.gnome\\.DiskUtility|baobab|filelight)$" }, {
  float = true,
  center = true,
})

-- Screenshot / screen recorder tools
window("screenshot-tools-centered", { class = "^(flameshot|gnome-screenshot|ksnip|spectacle|obs)$" }, {
  float = true,
  center = true,
})

-- Calendar / reminder popups
window("calendar-popups-centered", { class = "^(gnome-calendar|org\\.gnome\\.Calendar|gsimplecal|calcurse)$" }, {
  float = true,
  center = true,
})

-- Credential / secrets / keychain UIs
window("credential-uis-centered", { class = "^(1password|bitwarden|keepassxc|keepass2|keeweb|dashlane|enpass)$" }, {
  float = true,
  center = true,
})

-- App-store / installer dialogs
window("app-install-dialogs-centered", { class = "^(software-center|snap-store|flatpak-installer|AppImageLauncher)$" }, {
  float = true,
  center = true,
})

-- Font / theme / cursor choosers (standalone)
window("font-theme-choosers-centered", { class = "^(font-manager|gnome-font-viewer|lxappearance|nwg-look|kvantum|qt5ct|qt6ct)$" }, {
  float = true,
  center = true,
})

-- Virtualisation / containers quick-dialogs
window("vm-dialogs-centered", { class = "^(virt-manager|gnome-boxes|org\\.gnome\\.Boxes)$" }, {
  float = true,
  center = true,
})

-- Browser popup windows that should always be centered.
-- Covers extension popups, Bitwarden passkey/autofill/save prompts,
-- permission requests, and any other small browser-spawned dialog.
local browser_popup_titles = {
  -- Generic extension/addon UI
  ".*[Ee]xtension.*",
  ".*[Aa]dd[-]?[Oo]n.*",
  -- Bitwarden specific window titles
  ".*[Bb]itwarden.*",
  ".*[Ss]ave [Ll]ogin.*",
  ".*[Ss]ave [Pp]assword.*",
  ".*[Aa]utofill.*",
  ".*[Aa]uto[- ][Ff]ill.*",
  ".*[Uu]pdate [Ll]ogin.*",
  ".*[Uu]pdate [Pp]assword.*",
  -- Passkey prompts (Bitwarden, browser native, OS)
  ".*[Pp]asskey.*",
  ".*WebAuthn.*",
  ".*FIDO.*",
  ".*[Ss]ecurity [Kk]ey.*",
  ".*[Aa]uthenticator.*",
  -- Browser-native permission / credential dialogs
  ".*[Pp]ermission.*",
  ".*[Aa]ccess [Rr]equest.*",
  ".*[Ss]hare [Ss]creen.*",
  ".*[Ss]hare [Tt]ab.*",
  ".*[Cc]amera.*[Aa]ccess.*",
  ".*[Mm]icrophone.*[Aa]ccess.*",
  ".*[Nn]otification.*",
}

for index, title in ipairs(browser_popup_titles) do
  window("browser-popup-" .. index, { class = browser_class, title = title }, {
    float = true,
    center = true,
  })
end

window("fullscreen-immediate", { fullscreen = true }, { immediate = true })
window("steam-game-immediate", { class = "^(steam_app_.*)$" }, { immediate = true })
window("steam-friends-float", { class = "^(steam)$", title = "^(Friends List)$" }, { float = true })
window("steam-news-float", { class = "^(steam)$", title = "^(Steam - News)$" }, { float = true })

window("quickshell-float", { class = "^(org.quickshell)$" }, { float = true })
window("unfocused-floating-opacity", { float = false, focus = false }, { opacity = "0.9 0.9" })

layer("quickshell-no-anim", "^(quickshell)$", { no_anim = true })
layer("waybar-ignore-alpha", "^(waybar)$", { ignore_alpha = 0.3 })
layer("shell-blur", "^(thunar|nemo|nautilus|vicinae|quickshell|waybar)$", { blur = true })
layer("shell-ignore-alpha", "^(quickshell|vicinae)$", { ignore_alpha = 0.3 })
layer("vicinae-no-anim", "^(vicinae)$", { no_anim = true })

layer("dms-blur", "^(dms:.*)$", { blur = true })
layer("dms-blur-popups", "^(dms:.*)$", { blur_popups = true })
layer("dms-ignore-alpha", "^(dms:.*)$", { ignore_alpha = 0 })
layer("dms-xray-off", "^(dms:.*)$", { xray = false })

-- ─── Dynamic title-based centering ────────────────────────────────────────────
-- Static window rules only fire once at window creation. Browsers set their
-- real title (e.g. "Sign in - Google Accounts") only after the page loads,
-- so a new window initially titled "Zen Browser" will never match a static
-- rule for "Sign in". This event handler watches for title changes and
-- applies float + center dynamically when a match is found.
-- It only acts on browser windows and only once per window.

-- Build a fast lookup set from the browser list.
local browser_set = {}
for b in browsers:gmatch("[^|]+") do
  browser_set[b] = true
end

-- Common OAuth / sign-in URL fragments that show up in browser window titles.
-- These are checked separately because the static title patterns are
-- word-oriented and wouldn't catch raw URLs.
local oauth_url_patterns = {
  "accounts%.google%.com",
  "login%.microsoftonline%.com",
  "login%.live%.com",
  "appleid%.apple%.com",
  "github%.com/login",
  "github%.com/sessions",
  "id%.atlassian%.com",
  "auth0%.com",
  "auth%..*%.com",
  "login%..*%.com",
  "signin%..*%.com",
  "sso%..*%.com",
  "account%..*%.com",
  "accounts%..*%.com",
  "oauth%..*%.com",
  "connect%..*%.com",
  "id%..*%.com",
  "identity%..*%.com",
  "passport%..*%.com",
  "cas%..*%.com",
  "idp%..*%.com",
}

-- Track windows we've already centered so we don't re-fire on every
-- subsequent title change (e.g. navigating away from the sign-in page).
local centered_windows = {}

hl.on("window.title", function(w)
  -- Bail fast if this isn't a browser or we've already handled it.
  if not w or not browser_set[w.class] then return end
  if centered_windows[w.address] then return end
  -- Already floating means a static rule already handled it.
  if w.floating then return end

  local title = w.title or ""
  local matched = false

  -- Check against the same patterns used by the static rules.
  for _, pat in ipairs(centered_popups) do
    if title:match(pat) then matched = true; break end
  end

  -- Check browser-specific popup patterns.
  if not matched then
    for _, pat in ipairs(browser_popup_titles) do
      if title:match(pat) then matched = true; break end
    end
  end

  -- Check OAuth URL patterns in window titles.
  if not matched then
    for _, pat in ipairs(oauth_url_patterns) do
      if title:match(pat) then matched = true; break end
    end
  end

  if matched then
    centered_windows[w.address] = true
    local addr = "address:" .. w.address
    hl.dispatch(hl.dsp.window.float({ action = "enable", window = addr }))
  end
end)
