--
-- outputs.lua
-- == Configs for monitors, audio, video, etc.
--

for j = 1, 10 do
    local w = j % 10

    if j <= 5 then
        hl.workspace_rule({ workspace = "" .. w, monitor = "eDP-1", default = true })
    end
end

-- monitor
hl.monitor({
        output = "eDP-1",
        mode = "1920x1200@60.00Hz",
        position = "0x0",
        scale = "1",
    })
