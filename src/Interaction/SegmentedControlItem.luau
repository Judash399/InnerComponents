--[[
A component that creates an individual button part of a segmented control button.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Dependencys).Fusion
local Theme = require(Root.Utils.Theme)


--Components
local Glow = require(Root.Primitives.Glow)

--Refrences
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope, props: {
    Primary: boolean?,
})
    local scope = scope:innerScope(Fusion, {
        Glow = Glow
    })

    local button = scope:Value()

    local MousePos = scope:Value(Vector2.new(0, 0))

    local Hovering = scope:Value(false)

    local Pressed = scope:Value(false)
    local Enabled =  true

    local HoverEffects = scope:Computed(function(use)
        if use(Enabled) == false then
            return false
        end

        if use(Pressed) == true then
            return false
        end

        if use(Hovering) == true then
            return true
        end

        return false
    end)

    local FinalColor = scope:Spring(scope:Computed(function(use)
        if use(Enabled) == false then
            return use(Theme:GetTheme("SecondaryButton"))
        end

        if use(HoverEffects) then
            return peek(Theme:GetTheme(hoverTheme))
        elseif use(Pressed) then
            return peek(Theme:GetTheme(theme))
        else
            return use(color)
        end
    end), 50, 1)

    return button:set(scope:New "TextButton" {
        Size = UDim2.new(0, 50, 1, 0),
        BackgroundColor3 = FinalColor,

        [OnEvent "MouseMoved"] = function(x, y)
            MousePos:set(Vector2.new(x, y))
        end,

        [Children] = {
            scope:Glow {
                Color = "PrimaryButtonGlow",
                Size = scope:Computed(function(use)
                    if use(button) == nil then
                        return Vector2.new(0, 0)
                    end
                    local absoluteSize: Vector2 = use(button).AbsoluteSize

                    if absoluteSize == nil then
                        return Vector2.new(0, 0)
                    end

                    local greater = if absoluteSize.Y > absoluteSize.X then absoluteSize.Y else absoluteSize.X
                        
                    return Vector2.new(greater * 2, greater * 2)
                end),
                Position = scope:Computed(function(use)
                    if use(button) == nil then
                        return UDim2.new(0, 0, 0, 0)
                    end
                    local position = use(MousePos)
                    local absoluteOther = use(button).AbsolutePosition
                    local pos = UDim2.new(0, position.X - absoluteOther.X, 0, position.Y - absoluteOther.Y)
                    return pos
                end),
                Enabled = true
            }
        }
    })
end