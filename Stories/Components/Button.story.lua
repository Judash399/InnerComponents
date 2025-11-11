--!nocheck

--Services

local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
    Text = "Button",
    Icon = "http://www.roblox.com/asset/?id=8517323790",
    UsesIcon = true,
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)

        local FinalIcon = props.scope:Computed(function(use)
            local icon = use(props.controls.Icon)
            local usesIcon = use(props.controls.UsesIcon)

            if usesIcon == false then
                return ""
            else
                return icon
            end
        end)
        InnerComponents.Interaction.TextButton(props.scope) {
            theme = "Button",
            parent = props.target,
            Text = props.controls.Text,
            Size = UDim2.new(0, 100, 0, 30),
            IconID = FinalIcon
        }
    end
}

return story