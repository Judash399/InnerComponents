--[[
A component that creates a text-box with text input.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Dependencys).Fusion

local Theme = require(Root.Utils.Theme)
local Only = require(Root.Utils.Only)

--Refrences
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local OnChange = Fusion.OnChange

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>, props: {
    Parent: Instance?,
    Size: UDim2?,
    PlaceholderText: UsedAs<string>?,
    Text: string?,
    Flex: boolean?,
    OnChange: (string) -> (),
    Icon: UsedAs<string>?,
})
    local scope = scope:innerScope({
        Corner = require(script.Parent.Parent.Primitives.Corner),
        Stroke = require(script.Parent.Parent.Primitives.Stroke),
    })

    local Focused = scope:Value(false)
    local Hovering = scope:Value(false)

    local thickness = scope:Spring(scope:Computed(function(use)
        local focused = use(Focused)
        local hovering = use(Hovering)

        if focused == true then
            return 1.5 
        elseif hovering == true then
            return 1
        else
            return 0
        end
    end), 25, 1)

    local transparency = scope:Spring(scope:Computed(function(use)
        local focused = use(Focused)
        local hovering = use(Hovering)

        if focused == true then
            return 0 
        elseif hovering == true then
            return .5
        else
            return 1
        end
    end), 25, 1)

    local UsesIcon = scope:Computed(function(use)
        if use(props.Icon) ~= nil then
            return true
        else
            return false
        end
    end)

    return scope:New "CanvasGroup" {
        Parent = props.Parent,
        Size = props.Size or UDim2.new(0, 200, 0, 30),

        [Children] = {
            scope:Corner {},
            scope:Stroke {
                Color = "Primary",
                Thickness = thickness,
                Transparency = transparency
            },
            scope:Computed(Only(
                props.Flex,
                scope:New "UIFlexItem" {
                FlexMode = Enum.UIFlexMode.Fill,
                }
            )),
            scope:New "TextBox" {
                Size = UDim2.new(1, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                PlaceholderText = props.PlaceholderText,
                BackgroundColor3 = Theme:GetTheme(Enum.StudioStyleGuideColor.InputFieldBackground),
                TextColor3 = Theme:GetTheme("MainText"),
                ClipsDescendants = true,
                [OnEvent "Focused"] = function()
                    Focused:set(true)
                end,
                [OnEvent "FocusLost"] = function()
                    Focused:set(false)
                end,

                [OnEvent "MouseEnter"] = function()
                    Hovering:set(true)
                end,

                [OnEvent "MouseLeave"] = function()
                    Hovering:set(false)
                end,
                
                Text = props.Text,
                [Out "Text"] = props.Text,
                [OnChange "Text"] = props.OnChange,

                [Children] = {
                    scope:New "Frame" {
                        BackgroundColor3 = Theme:GetTheme(Enum.StudioStyleGuideColor.InputFieldBackground),
                        Size = scope:Spring(scope:Computed(function(use)
                            local visible = use(UsesIcon)

                            return if visible then UDim2.new(0, 35, 1, 10) else UDim2.new(0, 15, 1, 10)
                        end), 25, 1),
                        Position = scope:Computed(function(use)
                            local visible = use(UsesIcon)

                            if visible then
                                return UDim2.new(0, -30, 0, -5)
                            else
                                return UDim2.new(0, -10, 0, -5)
                            end
                        end),
                        Name = "LeftGradiant",
                        [Children] = {
                            scope:New "UIGradient" {
                                Transparency = scope:Computed(function(use)
                                    if use(UsesIcon) then
                                        return NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.6, 0), NumberSequenceKeypoint.new(1, 1)})
                                    else
                                        return NumberSequence.new(0, 1)
                                    end
                                end),
                                Rotation = 0,
                            }
                        },
                        ZIndex = 2
                    },
                    scope:New "Frame" {
                        BackgroundColor3 = Theme:GetTheme(Enum.StudioStyleGuideColor.InputFieldBackground),
                        Size = UDim2.new(0, 15, 1, 30),
                        Position = UDim2.new(1, 5, 0, 0),
                        AnchorPoint = Vector2.new(1, 0),
                        Name = "LeftGradiant",
                        [Children] = {
                            scope:New "UIGradient" {
                                Transparency = NumberSequence.new(1, 0),
                                Rotation = 0,
                            }
                        },
                        ZIndex = 2
                    },
                    scope:Computed(Only(UsesIcon, scope:ImageIcon {
                        IconName = scope:Computed(function(use)
                            if use(props.Icon) ~= nil then
                                return use(props.Icon)
                            else
                                return "diamond"
                            end
                        end),
                        Position = UDim2.new(0, -17.5, 0.5, 0),
                        Size = UDim2.new(1, -3, 1, -3),
                        ZIndex = 2,
                    })),
                    scope:Padding {
                        LeftAmount = scope:Computed(function(use)
                            if use(UsesIcon) then
                                return UDim.new(0, 30)
                            else
                                return UDim.new(0, 10)
                            end
                        end)
                    },
                }
            }
        }
    }
end