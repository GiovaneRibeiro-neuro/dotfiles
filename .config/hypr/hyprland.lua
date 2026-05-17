--
--
--
--

-- My programs

local terminal = "alacritty"

--
-- INPUTS
--
require("inputs")

--
-- KEYBINDINGS
--
-- see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + X", hl.dsp.window.close())

hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))


