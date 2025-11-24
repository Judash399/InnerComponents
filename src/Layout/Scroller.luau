local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children, peek = Fusion.Children, Fusion.peek

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Parent: Instance?,
        BackgroundColor: Fusion.UsedAs<Color3>?,
        Children: {Instance}?
    })
        local backgroundColor = props.BackgroundColor or Theme:GetTheme("CardBackground")

        local canvasPosition = scope:Value(Vector2.new(0, 0))

        local IconButton = require(Root.Interaction.IconButton)(scope)
        local BaseButton = require(Root.Interaction.BaseButton)(scope)
        local Frame = require(Root.Layout.Frame)(scope)
        local Corner = require(Root.Primitives.Corner)(scope)

        local AbsoluteSize = scope:Value(Vector2.new(100, 100))
        local VisibleSize = scope:Value(Vector2.new(100, 100))

        local MouseHold = scope:Value(false)

        return scope:New "Frame" {
            Name = "Scroller",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            
            [Children] = {

                --Top and bottom gradients
                scope:New "Frame" {
                    BackgroundColor3 = backgroundColor,
                    Size = UDim2.new(1, 0, 0, 10),
                    Name = "TopGradiant",
                    [Children] = {
                        scope:New "UIGradient" {
                            Transparency = NumberSequence.new(0, 1),
                            Rotation = 90,
                        }
                    },
                    ZIndex = 2
                },
                scope:New "Frame" {
                    BackgroundColor3 = backgroundColor,
                    Size = UDim2.new(1, 0, 0, 10),
                    Position = UDim2.new(0, 0, 1, 0),
                    AnchorPoint = Vector2.new(0, 1),
                    Name = "BottomGradiant",
                    [Children] = {
                        scope:New "UIGradient" {
                            Transparency = NumberSequence.new(0, 1),
                            Rotation = -90,
                        }
                    },
                    ZIndex = 2
                },


                --Scrollbar
                scope:New "Frame" {
                    Name = "Scrollbar",
                    Size = UDim2.new(0, 15, 1, 0),
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    ZIndex = 3,

                    [Children] = {
                        scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Vertical,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        },

                        IconButton {
                            IconName = "chevron-up",
                            Background = false,
                            Size = UDim2.new(1, 0, 0, 25),
                            IconPadding = 0,

                            Pressed = function()
                                local added = 0
                                local startY = peek(canvasPosition).Y
                                local targetStep = 80
                                local connection
                                connection = RunService.RenderStepped:Connect(function(delta)
                                    added += delta * 500
                                    local t = math.clamp(added / targetStep, 0, 1)

                                    -- Ease-in-out cubic
                                    local ease = t < 0.5 and 4 * t^3 or 1 - (-2 * t + 2)^3 / 2

                                    canvasPosition:set(Vector2.new(0, startY - targetStep * ease))

                                    if t >= 1 then
                                        connection:Disconnect()
                                    end
                                end)
                            end
                        },

                        BaseButton {
                            Size = UDim2.new(1, 0, 1, 0),
                            
                            CanvasGroupChildren = {
                                scope:New "UIFlexItem" {
                                    FlexMode = Enum.UIFlexMode.Fill
                                },
                            },

                            MouseHolding = MouseHold,
                            
                            Children = {
                                scope:New "Frame" {
                                    Name = "Thumb",
                                    AnchorPoint = Vector2.new(0.5, 0.5),
                                    Size = scope:Computed(function(use)
                                        return UDim2.new(1, 0, use(VisibleSize).Y / use(AbsoluteSize).Y, 0)
                                    end),
                                    Position = scope:Computed(function(use)
                                        local maxScroll = use(AbsoluteSize).Y - use(VisibleSize).Y
                                        local thumbSize = use(VisibleSize).Y / use(AbsoluteSize).Y
                                        
                                        local scrollAlpha = math.clamp(use(canvasPosition).Y / maxScroll, 0, 1)

                                        local pos = scrollAlpha * (1 - thumbSize)
                                        local centerPos = pos + thumbSize/2

                                        return UDim2.new(.5, 0, centerPos, 0)
                                    end),
                                    BackgroundColor3 = Theme:GetTheme("MainText"),

                                    [Children] = {
                                        Corner {

                                        }
                                    }
                                }
                            }
                        },

                        IconButton {
                            IconName = "chevron-down",
                            Background = false,
                            Size = UDim2.new(1, 0, 0, 25),
                            IconPadding = 0,

                            Pressed = function()
                                local added = 0
                                local startY = peek(canvasPosition).Y
                                local targetStep = 80
                                local connection
                                connection = RunService.RenderStepped:Connect(function(delta)
                                    added += delta * 500
                                    local t = math.clamp(added / targetStep, 0, 1)

                                    -- Ease-in-out cubic
                                    local ease = t < 0.5 and 4 * t^3 or 1 - (-2 * t + 2)^3 / 2

                                    canvasPosition:set(Vector2.new(0, startY + targetStep * ease))

                                    if t >= 1 then
                                        connection:Disconnect()
                                    end
                                end)
                            end

                        },
                    }
                },

                scope:New "ScrollingFrame" {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    ScrollBarThickness = 0,

                    CanvasPosition = canvasPosition,
                    [Fusion.Out "CanvasPosition"] = canvasPosition,
                    [Fusion.Out "AbsoluteCanvasSize"] = AbsoluteSize,
                    [Fusion.Out "AbsoluteSize"] = VisibleSize,

                    [Children] = props.Children
                }
            }
        }
    end
end