--!nocheck

--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
    hue = 0,
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)
        local Frame = InnerComponents.Layout.Frame(props.scope)
        local Button = InnerComponents.Interaction.TextButton(props.scope)
        local Padding = InnerComponents.Layout.Padding(props.scope)
        local Text = InnerComponents.Content.Text(props.scope)
        local Header = InnerComponents.Content.Header(props.scope)

        InnerComponents.SetAcent(props.controls.hue)

        props.scope:New "Frame" {
            Parent = props.target,
            Size = UDim2.new(2, 0, 1, 0),
            BackgroundColor3 = Color3.new(0, 0, 0),

            [Fusion.Children] = {
                InnerComponents.Interaction.Toggle(props.scope) {
                    Parent = props.target,
                    Position = UDim2.new(.5, 0, .5, 0)
                }
            },
        }
    end
}

return story