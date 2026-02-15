--!nocheck

--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
    Text = "Button",
    Icon = "search",
    UsesIcon = true,
    hue = 0,
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)

        local scope = props.scope:innerScope(InnerComponents)

        InnerComponents.SetAcent(props.controls.hue)

        local FinalIcon = scope:Computed(function(use)
            local icon = use(props.controls.Icon)
            local usesIcon = use(props.controls.UsesIcon)

            if usesIcon == false then
                return ""
            else
                return icon
            end
        end)
        
        scope:TextButton {
            theme = "Button",
            Parent = props.target,
            Text = props.controls.Text,
            Icon = props.controls.Icon,
            Size = UDim2.new(0, 100, 0, 30),
            IconID = FinalIcon,
            Primary = true,
        }
    end
}

return story