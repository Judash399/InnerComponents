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

        local scope = props.scope:innerScope(InnerComponents)
        
        InnerComponents.SetAcent(props.controls.hue)

        scope:Frame {
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
                scope:Frame {
                    Hidden = true,
                    Size = UDim2.new(1, 0, 0, 25),

                    Children = {
                        scope:Padding {
                            Amount = UDim.new(0, 2)
                        },

                        scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Horizontal,
                            Padding = UDim.new(0, 2.5),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        },
                        
                        scope:TextBox {
                            PlaceholderText = "Search for a controller",
                            Fill = true,
                            Size = UDim2.new(0, 0, 0, 25)
                        },

                        scope:IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                    },
                },

                scope:Scroller {
                    Children = {
                        scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Vertical,
                            Padding = UDim.new(0, 2.5),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        },
                        scope:IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                        scope:IconButton {
                            IconName = "settings",
                            Size = UDim2.new(0, 25, 0, 25),
                            Background = false,
                        },
                        scope:IconButton {
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