--!nocheck

--Services
local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
    hue = 0,
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)
        InnerComponents.SetAcent(props.controls.hue)

        
        InnerComponents.Interaction.Toggle(props.scope) {
            Parent = props.target
        }
    end
}

return story