--!nocheck

--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)

        InnerComponents.SetAcent(12)

        InnerComponents.Content.Tooltip(props.scope, {
            Parent = props.target
        })
    end
}

return story