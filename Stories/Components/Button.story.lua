--!nocheck

--Services

local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local StudioComponents = require(Packages.StudioComponnents)

local controls = {
    Text = "Text Button",
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)
        StudioComponents.Interaction.Button(props.scope) {
            theme = "Button",
            parent = props.target,
            Text = props.controls.Text,
            Size = UDim2.new(0, 35, 0, 35)
        }
    end
}

return story