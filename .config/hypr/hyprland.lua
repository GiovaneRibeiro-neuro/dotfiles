--
--
-- Main file for hyprland configurations
--

--
-- AUTOSTART
--
hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle & hyprpaper") -- idle management + wallpaper process
    hl.exec_cmd("systemctl --user start hyprpolkitagent") -- polkit agent
    hl.exec_cmd("systemctl --user start pipewire-pulse.service") -- pipewire pulse
    hl.exec_cmd("~/.config/hypr/scripts/cliphist-watch.sh")
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh init")
    hl.exec_cmd("~/.config/hypr/scripts/pill-daemon.sh") -- everything else, including notifications
    hl.exec_cmd("pamixer --set-volume 30")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    --hl.exec_cmd("flock -n /tmp/battery_wallpaper.lock battery_wallpaper.sh")
end)

require("configs")
require("inputs")
require("bindings")
require("outputs")

