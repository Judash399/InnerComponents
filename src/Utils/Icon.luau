--Modules
local Lucide = require(script.Parent.Parent.Parent["lucide-icons"])

local module = {}

function module.GetIcon(IconName: string, resolution: number?)

    --Looks weird but exists for custom warning and fallback icon.

    local success, value = pcall(function()
        return Lucide.GetAsset(IconName, resolution)
    end)

    if success then
        return value
    end
end

return module