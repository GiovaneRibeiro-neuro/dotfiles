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
