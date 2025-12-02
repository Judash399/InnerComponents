--!nocheck

--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
    hue = 0,
    size = 300
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)
        
        InnerComponents.SetAcent(props.controls.hue)

        local IconButton = InnerComponents.Interaction.IconButton(props.scope)
        local Frame = InnerComponents.Layout.Frame(props.scope)

        InnerComponents.Layout.Frame(props.scope) {
            Size = props.scope:Computed(function(use)
                local size = use(props.controls.size)

                return UDim2.new(0, 200, 0, size)
            end),
            Parent = props.target,
            Children = {
                props.scope:New "UIListLayout" {
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
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
                    },
                },

                InnerComponents.Layout.Scroller(props.scope) {
                    Children = {
                        props.scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Vertical,
                            Padding = UDim.new(0, 2.5),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        },
                        IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                        IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                        IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },

                        IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                        IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                        IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                        IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                    },
                    Flex = true,
                    Scaled = true,
                }
            }
        }

    end
}

return story