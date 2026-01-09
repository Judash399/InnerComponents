--!nocheck

--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
    direction = "bottom",
    offset = 1,
    Enabled = false,
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)

        local scope = props.scope:innerScope(InnerComponents)

        InnerComponents.SetAcent(12)

        local frame = scope:New "Frame" {
            Parent = props.target,
            Position = UDim2.new(.5, 0, .5, 0),
            Size = UDim2.new(0, 100, 0, 100),
        }

        scope:Tooltip {
            Parent = props.target,
            Target = frame,
            Direction = props.controls.direction,
            Offset = props.controls.offset,
            Active = props.controls.Enabled,

            Children = {
                scope:Header {
                    Text = "Tooltip"
                },
                scope:Paragraph {
                    Text = "This is a very cool test tooltip."
                }
            }
        }
    end
}

return story