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
        local IconButton = InnerComponents.Interaction.IconButton(props.scope)

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
            Size = UDim2.new(0, 300, 0, 500),
            Level = 0,

            Children = {
                props.scope:New "UIListLayout" {
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                },


                Frame {
                    Hidden = true,
                    Size = UDim2.new(1, 0, 0, 25),

                    Children = {
                        InnerComponents.Layout.Padding(props.scope) {
                            Amount = UDim.new(0, 2)
                        },

                        props.scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Horizontal,
                            Padding = UDim.new(0, 2.5),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        },
                        
                        InnerComponents.Interaction.TextBox(props.scope) {
                            PlaceholderText = "Search for a controller",
                            Fill = true,
                            Size = UDim2.new(0, 0, 0, 25)
                        },

                        IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                    }
                },

                Frame {
                    Hidden = true,
                    Size = UDim2.new(1, 0, 1, 0),

                    Children = {
                        props.scope:New "UIFlexItem" {
                            FlexMode = Enum.UIFlexMode.Fill  
                        },

                        props.scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Vertical,
                            Padding = UDim.new(0, 5),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        },

                        Frame {
                            Size = UDim2.new(1, 0, 1, 0),
                            Hidden = true,

                            Children = {
                                props.scope:New "UIListLayout" {
                                    FillDirection = Enum.FillDirection.Vertical,
                                    Padding = UDim.new(0, 5),
                                    SortOrder = Enum.SortOrder.LayoutOrder,
                                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                    VerticalAlignment = Enum.VerticalAlignment.Center,
                                },

                                Text {
                                    Text = "Oops!",
                                    Size = UDim2.new(1, 0, 0, 30),
                                    TextSize = 25,
                                    Weight = Enum.FontWeight.Bold,
                                    XAlign = Enum.TextXAlignment.Center
                                },

                                Text {
                                    Text = "You seem to not have any controllers! Try creating one!",
                                    Size = UDim2.new(1, 0, 0, 0),
                                    AutomaticSize = Enum.AutomaticSize.Y,
                                    Wraps = true,
                                    XAlign = Enum.TextXAlignment.Center
                                },
                            }
                        },
                    },
                },
            }
        }
    end
}

return story