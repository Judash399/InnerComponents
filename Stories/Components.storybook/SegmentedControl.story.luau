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
        InnerComponents.SetAcent(props.controls.hue)

        local scope = props.scope:innerScope(InnerComponents)
        
        scope:SegmentedControl {
            Parent = props.target,

            Children = {
                scope:SegmentedControlItem {
                    
                }
            }
        }
    end
}

return story