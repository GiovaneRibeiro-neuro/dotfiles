--
--
--
--

-- My programs

local terminal = "alacritty"

--
-- AUTOSTART
--
hl.on("hyprland.start", function()
    --hl.exec_cmd(terminal)
    hl.exec_cmd("fnott & waybar") -- daemon notifications
    hl.exec_cmd("systemctl --user start hyprpolkitagent") -- polkit agent
    hl.exec_cmd("systemctl --user start pipewire-pulse.service") -- polkit agent
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("pamixer --set-volume 30")
    hl.exec_cmd("nm-applet")
end)

--
-- INPUTS
--
require("inputs")

--
-- KEYBINDINGS
--
-- see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + X", hl.dsp.window.close())

hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("alacritty -e vifm"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
-- Keyboard backlight
hl.bind(mainMod .. " + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set +33%"))
hl.bind(mainMod .. " + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 33%-"))
-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -m"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))

hl.bind("Print", function()
    hl.plugin.hyprcapture.open()
end)

hl.bind("SHIFT + Print", function()
    hl.plugin.hyprcapture.open("window")
end)

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

for j = 1, 10 do
    local w = j % 10

    if j <= 5 then
        hl.workspace_rule({ workspace = "" .. w, monitor = "eDP-1", default = true })
    end
end
