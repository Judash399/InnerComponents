--!nocheck

--Services

local Packages = script.Parent.Parent.Parent.Packages
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

        InnerComponents.SetAcent(props.controls.hue)

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

                InnerComponents.Content.ImageIcon(props.scope) {
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

                InnerComponents.Interaction.IconButton(props.scope) {
                    IconName = "x",
                    Background = false,
                }
            }
        }
    end
}

return story