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
    hl.exec_cmd(terminal)
    hl.exec_cmd("fnott & waybar") -- daemon notifications
    hl.exec_cmd("systemctl --user start hyprpolkitagent") -- polkit agent
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
hl.bind("Print", function()
    hl.plugin.hyprcapture.open()
end)

hl.bind("SHIFT + S", function()
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
