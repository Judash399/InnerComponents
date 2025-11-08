--!nocheck

--Services

local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local StudioComponents = require(Packages.StudioComponnents)

local controls = {
    Filled = true,
    Text = "Text Button",
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)
        StudioComponents.Interaction.Button(props.scope) {
            theme = "Main",
            parent = props.target,
            Filled = props.controls.Filled,
            Text = props.controls.Text
        }
    end
}

return story