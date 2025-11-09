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
        local Frame = StudioComponents.Layout.Frame(props.scope)
        local Button = StudioComponents.Interaction.TextButton(props.scope)
        local Padding = StudioComponents.Layout.Padding(props.scope)

        --TODO: Make this
        return Frame {
            Size = UDim2.new(0, 300, 0, 40),
            Level = 1.5,
            Children = {
                Padding {},
                Button {
                    Text = "Test!",
                    Size = UDim2.new(0, 100, 0, 30),
                }
            }
        }
    end
}

return story