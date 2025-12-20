--!nocheck

--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
    direction = "bottom",
    offset = 1
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)

        InnerComponents.SetAcent(12)

        local frame = props.scope:New "Frame" {
            Parent = props.target,
            Position = UDim2.new(.5, 0, .5, 0),
            Size = UDim2.new(0, 100, 0, 100),
        }

        InnerComponents.Content.Tooltip(props.scope, {
            Parent = props.target,
            Target = frame,
            Direction = props.controls.direction,
            Offset = props.controls.offset,

            Children = {
                InnerComponents.Content.Header(props.scope) {
                    Text = "Tooltip"
                },
                InnerComponents.Content.Pargraph(props.scope) {
                    Text = "This is a very cool test tooltip."
                }
            }
        })
    end
}

return story