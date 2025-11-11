--!nocheck

--Services

local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local StudioComponents = require(Packages.StudioComponents)

local controls = {
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)
        local Frame = StudioComponents.Layout.Frame(props.scope)
        local Button = StudioComponents.Interaction.TextButton(props.scope)
        local Padding = StudioComponents.Layout.Padding(props.scope)
        local Text = StudioComponents.Content.Text(props.scope)

        --TODO: Make this
        return Frame {
            Size = UDim2.new(0, 300, 0, 40),
            Level = 1.5,
            Children = {
                Padding {},
                
                props.scope:New "UIListLayout" {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                },

                StudioComponents.Content.ImageIcon(props.scope) {
                    IconName = "alert-triangle",
                    Size = UDim2.new(1, -10, 1, -10),
                },

                Text {
                    Text = "Test Alert!",
                    Size = UDim2.new(0, 0, 0, 30),
                    Children = {
                        props.scope:New "UIFlexItem" {
                            FlexMode = Enum.UIFlexMode.Fill
                        }
                    }
                },

                StudioComponents.Interaction.IconButton(props.scope) {
                    IconName = "x",
                    Background = false,
                }
            }
        }
    end
}

return story