--!nocheck

--Services

local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local StudioComponents = require(Packages.StudioComponnents)

local controls = {
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)
        --TODO: Make this
    end
}

return story