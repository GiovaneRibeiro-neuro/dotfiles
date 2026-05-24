--
--
-- Main file for hyprland configurations
--

--
-- AUTOSTART
--
hl.on("hyprland.start", function()
    --hl.exec_cmd(terminal)
    hl.exec_cmd("fnott & waybar & hypridle") -- daemon notifications + bar + idle management
    hl.exec_cmd("systemctl --user start hyprpolkitagent") -- polkit agent
    hl.exec_cmd("systemctl --user start pipewire-pulse.service") -- polkit agent
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("pamixer --set-volume 30")
    hl.exec_cmd("nm-applet")
end)

require("inputs")
require("bindings")
require("outputs")

