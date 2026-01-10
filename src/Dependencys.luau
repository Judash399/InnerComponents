local Root = script.Parent
local RootFolder = Root.Parent

local module = {}

if RootFolder.Parent.Name == "_Index" then
    --Inside a wally package
    module.Fusion = require(RootFolder.Parent.Parent.fusion)
    module.lucideIcons = require(RootFolder.Parent.Parent["lucide-icons"])
else
    --Not inside a wally package
    module.Fusion = require(Root.Parent.fusion)
    module.lucideIcons = require(Root.Parent["lucide-icons"])
end

return module