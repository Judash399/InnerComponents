--Modules
local Lucide = require(script.Parent.Parent.Parent["lucide-icons"])

local module = {}

function module.GetIcon(IconName: string, resolution: number?)
    return Lucide.GetAsset(IconName, resolution)
end

return module