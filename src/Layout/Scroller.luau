--Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

--Refrences
local Children = Fusion.Children
local peek = Fusion.peek
local OnEvent = Fusion.OnEvent

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Parent: Instance?,
        BackgroundColor: UsedAs<Color3>?,
        Children: {Instance}?,
        Scaled: UsedAs<boolean>?,
        Flex: boolean?,
        CanvasSize: UsedAs<UDim2>?,
        Size: UsedAs<UDim2>?,
        Position: UsedAs<UDim2>?
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

        local MouseInside = scope:Value(false)

        local barAbsSize = scope:Value(Vector2.new(100, 100))
        local barMousePosition = scope:Value(Vector2.new(0, 0))

        local scrollbarVisible = scope:Computed(function(use)
            local abs = use(AbsoluteSize)
            local vis = use(VisibleSize)
            if abs.Y > vis.Y then
                return true
            else
                return false
            end
        end)

        local buttonAnchorPoint = scope:Spring(scope:Computed(function(use)
            local inside = use(MouseInside)

            if inside then
                return UDim2.new(0, 0, 0, 0)
            else
                return UDim2.new(1, 0, 0, 0)
            end
        end), 75, 1)

        return scope:New "Frame" {
            Name = "Scroller",
            Size = props.Size or UDim2.new(1, 0, 1, 0),
            Position = props.Position,
            BackgroundTransparency = 1,
            
            [Children] = {

                --Flex thingy
                scope:New "UIFlexItem" {
                    FlexMode = scope:Computed(function(use)
                        local flex = use(props.Flex)

                        if flex == true then
                            return Enum.UIFlexMode.Fill
                        else
                            return Enum.UIFlexMode.None
                        end
                    end)
                },

                --Top and bottom gradients
                scope:New "Frame" {
                    BackgroundColor3 = backgroundColor,
                    Size = scope:Spring(scope:Computed(function(use)
                        local visible = use(scrollbarVisible)

                        return if visible then UDim2.new(1, 0, 0, 25) else UDim2.new(1, 0, 0, 10)
                    end), 25, 1),
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
                    Size = scope:Spring(scope:Computed(function(use)
                        local visible = use(scrollbarVisible)

                        return if visible then UDim2.new(1, 0, 0, 25) else UDim2.new(1, 0, 0, 10)
                    end), 25, 1),
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
                    Visible = scrollbarVisible,

                    [OnEvent "MouseEnter"] = function()
                        MouseInside:set(true)
                    end,

                    [OnEvent "MouseLeave"] = function()
                        MouseInside:set(false)
                    end,

                    [Children] = {
                        scope:New "UIListLayout" {
                            FillDirection = Enum.FillDirection.Vertical,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        },

                        scope:New "Frame" {
                            Size = UDim2.new(1, 0, 0, 25),
                            BackgroundTransparency = 1,
                            ClipsDescendants = true,

                            [Children] = {
                                scope:New "Frame" {
                                    Size = UDim2.new(1, 0, 1, 0),
                                    Position = buttonAnchorPoint,
                                    BackgroundTransparency = 1,

                                    [Children] = {
                                        IconButton {
                                            IconName = "chevron-up",
                                            Background = false,
                                            Size = UDim2.new(1, 0, 0, 25),
                                            IconPadding = 0,
                                            IconTransparency = 0,

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
                                    }
                                }
                            }
                        },

                        BaseButton {
                            Size = UDim2.new(1, 0, 1, 0),
                            Background = false,
                            
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

                                    Size = scope:Spring(scope:Computed(function(use)
                                        local hovering = use(MouseInside)
                                        local VisibleSize = use(VisibleSize)
                                        local AbsoluteSize = use(AbsoluteSize)

                                        local ratio = VisibleSize.Y / AbsoluteSize.Y

                                        if ratio ~= ratio then
                                           ratio = 0 
                                        end

                                        if hovering then
                                           return UDim2.new(1, -5, ratio, 0) 
                                        else
                                            return UDim2.new(0, 5, ratio, 0) 
                                        end
                                    end), 75, 1),
                                    Position = scope:Computed(function(use)
                                        local maxScroll = use(AbsoluteSize).Y - use(VisibleSize).Y
                                        local thumbSize = use(VisibleSize).Y / use(AbsoluteSize).Y
                                        
                                        local scrollAlpha = math.clamp(use(canvasPosition).Y / maxScroll, 0, 1)

                                        local pos = scrollAlpha * (1 - thumbSize)
                                        local centerPos = pos + thumbSize/2

                                        return UDim2.new(.5, 0, centerPos, 0)
                                    end),
                                    BackgroundColor3 = Theme:GetTheme(Enum.StudioStyleGuideColor.ScrollBar),
                                    Transparency = 0,

                                    [Children] = {
                                        Corner {

                                        }
                                    }
                                }
                            }
                        },

                        scope:New "Frame" {
                            Size = UDim2.new(1, 0, 0, 25),
                            BackgroundTransparency = 1,
                            ClipsDescendants = true,

                            [Children] = {
                                scope:New "Frame" {
                                    Size = UDim2.new(1, 0, 1, 0),
                                    Position = buttonAnchorPoint,
                                    BackgroundTransparency = 1,

                                    [Children] = {
                                        IconButton {
                                            IconName = "chevron-down",
                                            Background = false,
                                            Size = UDim2.new(1, 0, 0, 25),
                                            IconPadding = 0,
                                            IconTransparency = 0,


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
                                }
                            }
                        },
                    }
                },

                scope:New "ScrollingFrame" {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    ScrollBarThickness = 0,
                    CanvasSize = props.CanvasSize or UDim2.new(0, 0, .9, 0),
                    AutomaticCanvasSize = scope:Computed(function(use)
                        local scaled = use(props.Scaled)

                        if scaled then
                            return Enum.AutomaticSize.Y
                        else
                            return Enum.AutomaticSize.None
                        end
                    end),

                    CanvasPosition = canvasPosition,
                    [Fusion.Out "CanvasPosition"] = canvasPosition,
                    [Fusion.Out "AbsoluteCanvasSize"] = AbsoluteSize,
                    [Fusion.Out "AbsoluteSize"] = VisibleSize,

                    [Children] = scope:New "Frame" {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,

                        [Children] = {
                            scope:New "UIPadding" {
                                PaddingRight = UDim.new(0, 5),
                                PaddingLeft = UDim.new(0, 5)
                            },
                            props.Children
                        }
                    }
                }
            }
        }
    end
end