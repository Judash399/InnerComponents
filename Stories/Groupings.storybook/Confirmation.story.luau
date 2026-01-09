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
        local scope = props.scope:innerScope(InnerComponents)

        InnerComponents.SetAcent(props.controls.hue)

        local text = props.scope:Value("")
        local enabled = props.scope:Computed(function(use)
            local text = use(text)
            if not text then
                return false
            end

            if text == "judash399" then
                return true
            else
                return false
            end
        end)

        scope:Frame {
            Size = UDim2.new(0, 300, 0, 0),
            Level = 1.5,
            AutoSize = Enum.AutomaticSize.Y,
            Parent = props.target,
            LayoutPadding = UDim.new(0, 5),

            Children = {
                scope:Padding {
                    LeftAmount = UDim.new(0, 10),
                    BottomAmount = UDim.new(0, 0),
                },

                scope:Header {
                    Text = "Confirm Action",
                    Size = UDim2.new(0, 0, 0, 30),
                },

                scope:Paragraph {
                    Text = "To confirm, please enter your username and press continue.",
                    Wraps = true,
                    Size = UDim2.new(1, 0, 0, 30),
                    AutomaticSize = Enum.AutomaticSize.Y,
                },

                --Padding
                scope:Frame {
                    Blank = true,
                    Size = UDim2.new(1, 0, 0, 2)
                },

                scope:TextBox {
                    PlaceholderText = "ExampleUsername123",
                    Text = text,
                    Icon = "user"
                },

                --Padding
                scope:Frame {
                    Blank = true,
                    Size = UDim2.new(1, 0, 0, 10)
                },

                scope:Frame {
                    Blank = true,
                    Size = UDim2.new(1, 0, 0, 40),
                    AutoLayout = false,
                    Children = {
                         props.scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Horizontal,
                            Padding = UDim.new(0, 5),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        },

                        scope:TextButton {
                            Text = "Back",
                            Primary = false,
                            Size = UDim2.new(0, 80, 0, 30)
                        },

                        scope:TextButton {
                            Text = "Continue",
                            Primary = true,
                            Size = UDim2.new(0, 80, 0, 30),
                            Enabled = enabled
                        },
                    }
                }
            }
        }
    end
}

return story