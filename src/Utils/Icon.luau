local RawIcons = require(script.Parent.RawIcons)

local module = {}

function module.GetIcon(IconName:string): string
   return RawIcons.assets[IconName] or ""
end

return module