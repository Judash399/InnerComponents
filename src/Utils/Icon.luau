--local RawIcons = require(script.Parent.RawIcons)
local Lucide = require(script.Parent.Parent.Parent["lucide-icons"])

local module = {}

function module.GetIcon(IconName: string, resolution: number?): string
    return Lucide.GetAsset(IconName, resolution).Url
end

return module