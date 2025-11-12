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

        --TODO: Make this
        return Frame {
            Size = UDim2.new(0, 300, 0, 0),
            Level = 1.5,
            AutoSize = Enum.AutomaticSize.Y,

            Children = {
                Padding {
                    LeftAmount = UDim.new(0, 10),
                    BottomAmount = UDim.new(0, 0),
                },
                
                props.scope:New "UIListLayout" {
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                },

                Text {
                    Text = "Confirm Action",
                    Size = UDim2.new(0, 0, 0, 30),
                    TextSize = 25,
                    Weight = Enum.FontWeight.Bold,
                },

                Text {
                    Text = "To confirm, please enter your username and press continue.",
                    Wraps = true,
                    Size = UDim2.new(1, 0, 0, 30),
                    AutomaticSize = Enum.AutomaticSize.Y,
                },

                --Padding
                Frame {
                    Blank = true,
                    Size = UDim2.new(1, 0, 0, 2)
                },

                InnerComponents.Interaction.TextBox(props.scope) {
                    PlaceholderText = "ExampleUsername123",
                    Text = text
                },

                --Padding
                Frame {
                    Blank = true,
                    Size = UDim2.new(1, 0, 0, 10)
                },

                Frame {
                    Blank = true,
                    Size = UDim2.new(1, 0, 0, 40),
                    Children = {
                         props.scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Horizontal,
                            Padding = UDim.new(0, 5),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        },

                        InnerComponents.Interaction.TextButton(props.scope) {
                            Text = "Back",
                            Primary = false,
                            Size = UDim2.new(0, 80, 0, 30)
                        },

                        InnerComponents.Interaction.TextButton(props.scope) {
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