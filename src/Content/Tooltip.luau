--[[
A component that creates a tooltip thats attached to a Target.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)

local Theme = require(Root.Utils.Theme)
local Grabber = require(Root.Utils.Grabber)

local Only = require(Root.Utils.Only)
local Otherwise = require(Root.Utils.Otherwise)
local Map = require(Root.Utils.Map)

--Components
local Corner = require(Root.Primitives.Corner)
local Padding = require(Root.Layout.Padding)

--Refrences
local Children = Fusion.Children
local Out = Fusion.Out

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<typeof(Fusion)>, props: {
    Parent: UsedAs<Instance>?,
    Target: UsedAs<Instance>?,
    BackgroundColor: UsedAs<Theme.Theme>?,
    Children: UsedAs<{Instance}>?,
    Flex: UsedAs<boolean>?,
    Direction: UsedAs<"left" | "right" | "top" | "bottom">?,
    Offset: UsedAs<number>?,

    AutoLayout: UsedAs<boolean>?,
    LayoutPadding: UsedAs<UDim>?,
})
    local parent = scope:Value(props.Parent)
    local target = scope:Computed(Otherwise(props.Target, nil))

    local props = Grabber.ConvertProps(scope, {
        Parent = parent,
        Target = target,
    }, props)

    local backgroundColorTheme = scope:Computed(Otherwise(props.BackgroundColor, "Tooltip"))
    local direction = scope:Computed(Otherwise(props.Direction, "right"))
    local offset = scope:Computed(Otherwise(props.Offset, .5))
    local size = scope:Value(Vector2.new(0, 0))

    local offsetRange = scope:Computed(function(use)
        local offset =  use(offset)
        local size = use(size)
        local direction = use(direction)

        local axisSize
        if direction == "right" or direction == "left" then
            axisSize = size.Y
        elseif direction == "top" or direction == "bottom" then
            axisSize = size.X
        end

        local value = axisSize * offset

        return value
    end)

    local Finaloffset = scope:Computed(Otherwise(offsetRange, 0))

    local clampedOffset = scope:Computed(function(use)
        local direction = use(direction)
        local size = use(size)

        local axisSize
        if direction == "right" or direction == "left" then
            axisSize = use(size).Y
        elseif direction == "top" or direction == "bottom" then
            axisSize = use(size).X
        end

        return math.clamp(use(Finaloffset), 15, math.max(axisSize - 15, 15))
    end)

    local ClampedAmount = scope:Computed(function(use)
        local value = use(Finaloffset) - use(clampedOffset)

        return value
    end)

    local Position = scope:Computed(function(use, scope)
        local parent = use(parent)
        if parent == nil then return end

        local target = use(target)
        if target == nil then return end

        --Looks messy, but theres no way to easily get values
        --from pre-existing instances and put it into a value object. I tried Hydrate()
        local tarPos = scope:Value(target.AbsolutePosition)
        local tarSize = scope:Value(target.AbsoluteSize)
        local ParPos = scope:Value(parent.AbsolutePosition)
        table.insert(scope, target:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
            tarPos:set(target.AbsolutePosition)
        end))
        table.insert(scope, target:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            tarSize:set(target.AbsoluteSize)
        end))
        table.insert(scope, parent:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
            ParPos:set(parent.AbsolutePosition)
        end))

        local position =  (use(tarPos) + (use(tarSize) / 2)) - use(ParPos)

        local direction = use(direction)
        
        local offset
        if direction == "bottom" then
            offset = Vector2.new(0, (use(tarSize).Y / 2)) + Vector2.new(0, 15) - Vector2.new(use(Finaloffset), 0) + Vector2.new(use(ClampedAmount), 0)
        elseif direction == "top" then
            offset = Vector2.new(0, -(use(tarSize).Y / 2)) - Vector2.new(0, 15) - Vector2.new(use(Finaloffset), 0) + Vector2.new(use(ClampedAmount), 0)
        elseif direction == "left" then
            offset = Vector2.new(-(use(tarSize).X / 2)) - Vector2.new(15, 0) - Vector2.new(1, use(Finaloffset)) + Vector2.new(0, use(ClampedAmount))
        elseif direction == "right" then
            offset = Vector2.new((use(tarSize).X / 2), 0) + Vector2.new(15, 0) - Vector2.new(1, use(Finaloffset)) + Vector2.new(0, use(ClampedAmount))
        end

        local finalPos = position + offset

        return UDim2.new(0, finalPos.X, 0, finalPos.Y)
    end)

    local tooltip = scope:New "Frame" {
        Parent = props.Parent,
        Position = scope:Computed(Otherwise(Position,  UDim2.new(.5, 0, .5, 0))),
        Name = "Tooltip",
        [Out "Parent"] = parent,
        BackgroundColor3 = scope:Computed(function(use)
            return use(Theme:GetTheme(use(backgroundColorTheme)))
        end),

        --AutomaticSize = Enum.AutomaticSize.XY,
        Size = scope:Computed(function(use)
            return UDim2.new(0, use(size).X, 0, use(size).Y)
        end),
        AnchorPoint = scope:Computed(Map(direction, {
            ["right"] = Vector2.new(0, 0),
            ["left"] = Vector2.new(1, 0),
            ["bottom"] = Vector2.new(0, 0),
            ["top"] = Vector2.new(0, 1),
        })),

        [Children] = {
            Corner(scope) {Level = 1},
            scope:New "Frame" {
                Name = "Arrow",
                Size = UDim2.new(0, 12, 0, 12),
                BackgroundColor3 = scope:Computed(function(use)
                    return use(Theme:GetTheme(use(backgroundColorTheme)))
                end),
                AnchorPoint = scope:Computed(Map(direction, {
                    ["right"] = Vector2.new(.3, .5),
                    ["left"] = Vector2.new(.7, .5),
                    ["bottom"] =  Vector2.new(.5, .3),
                    ["top"] = Vector2.new(.5, .7),
                })),
                Position = scope:Computed(Map(direction, {
                    ["right"] = scope:Computed(function(use)
                        return UDim2.new(0, 0, 0, use(clampedOffset))
                    end),
                    ["left"] = scope:Computed(function(use)
                        return UDim2.new(1, 0, 0, use(clampedOffset))
                    end),
                    ["bottom"] = scope:Computed(function(use)
                        return UDim2.new(0, use(clampedOffset), 0, 0)
                    end),
                    ["top"] = scope:Computed(function(use)
                        return UDim2.new(0, use(clampedOffset), 1, 0)
                    end),
                })),
                Rotation = 45,

                [Children] = {
                    Corner(scope) {Level = .5},
                }
            },
            scope:New "Frame" {
                Name = "Content",
                Size = UDim2.new(0, 0, 0, 0),
                [Out "AbsoluteSize"] = size,
                BackgroundTransparency = 1,
                AutomaticSize = scope:Computed(Otherwise(props.Flex, Enum.AutomaticSize.XY)),

                [Children] = {
                    scope:Computed(Only(scope:Computed(Otherwise(props.AutoLayout, true)), scope:New "UIListLayout" {
                        Name = "AutoLayout",
                        
                        Padding = scope:Computed(Otherwise(props.LayoutPadding, UDim.new(0, 5))),
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                    })),
                    Padding(scope) {

                    },

                    props.Children,
                },
            },
        },
    }

    Grabber.Export(tooltip, props)
end