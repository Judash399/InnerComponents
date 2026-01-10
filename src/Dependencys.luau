local Root = script.Parent
local RootFolder = Root.Parent

local module = {}

module.Fusion = require(RootFolder.fusion)
module.lucideIcons = require(RootFolder["lucide-icons"])

return module