--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

--Refrences
local Children, OnEvent, peek, Out, OnChange = Fusion.Children, Fusion.OnEvent, Fusion.peek, Fusion.Out, Fusion.OnChange

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Parent: Instance,
        enabled: UsedAs<boolean>?,
        Position: UsedAs<UDim2>?,
    })
        local scope = scope:innerScope()

        local Corner = require(Root.Primitives.Corner)(scope)
        local Padding = require(Root.Layout.Padding)(scope)

        local enabled = props.enabled or scope:Value(false)


        local position = scope:Spring(scope:Computed(function(use)
            local enabled = use(enabled)

            if enabled then
                return UDim2.new(1, 0, .5, 0)
            else
                return UDim2.new(0, 0, 0.5, 0)
            end
        end), 80, 1)

        local anchorPoint = scope:Spring(scope:Computed(function(use)
            local enabled = use(enabled)

            if enabled then
                return Vector2.new(1, .5)
            else
                return Vector2.new(0, .5)
            end
        end), 80, 1)

        local size = scope:Spring(scope:Computed(function(use)
            local position = use(position):: UDim2

            local multipler = 1 - (((position.X.Scale - .5) * 2) ^ 2)

            local shrinkOffset = 5 * multipler

            return UDim2.new(0, 14 + (8 * multipler), 0, 14 - shrinkOffset)
        end), 500, 1)

        local color = scope:Spring(scope:Computed(function(use)
            local enabled = use(enabled)

            if enabled == true then
                return use(Theme:GetTheme("Primary"))
            else
                return use(Theme:GetTheme("SwitchShade"))
            end
        end), 80, 1)

        return scope:New "TextButton" {
            Size = UDim2.new(0, 45, 0, 29),
            Position = props.Position,
            Parent = props.Parent,
            BackgroundTransparency = 1,

            [OnEvent "Activated"] = function()
                enabled:set(not peek(enabled))
            end,

            [Children] = {
                scope:New "Frame" {
                    Position = UDim2.new(.5, 0, .5, 0),
                    AnchorPoint = Vector2.new(.5, .5),
                    Size = UDim2.new(0, 35, 0, 19),
                    BackgroundColor3 = color,

                    [Children] = {
                        scope:New "UICorner" {
                            CornerRadius = UDim.new(0.5, 0)
                        },
                        Padding {Amount = UDim.new(0, 3)},
                        scope:New "Frame" {
                            Position = position,
                            AnchorPoint = anchorPoint,
                            Size = size,
                            BackgroundColor3 = scope:Computed(function(use)
                                if use(Theme:IsLight()) then
                                    return use(Theme:GetTheme("Background"))
                                else
                                    return Color3.new(1, 1, 1)
                                end
                            end),

                            [Children] = {
                                scope:New "UICorner" {
                                    CornerRadius = UDim.new(0.5, 0)
                                },
                            }
                        }
                    }
                }
            }
        }
    end
end