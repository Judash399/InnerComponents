--[[
A component that creates a tooltip thats attached to a Target.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)

local Theme = require(Root.Utils.Theme)
local Grabber = require(Root.Utils.Grabber)

local Otherwise = require(Root.Utils.Otherwise)

--Components
local Corner = require(Root.Primitives.Corner)

--Refrences
local Children = Fusion.Children
local Out = Fusion.Out

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<typeof(Fusion)>, props: {
    Parent: UsedAs<Instance>?,
    BackgroundColor: UsedAs<Theme.Theme>?,
})
    local parent = scope:Value(nil)
    local target = Otherwise(props.Target, nil)

    local props = Grabber.ConvertProps(scope, {
        Parent = parent,
        Target = target,
    }, props)

    local backgroundColorTheme = scope:Computed(Otherwise(props.BackgroundColor, "Tooltip"))

    local tooltip = scope:New "Frame" {
        Parent = props.Parent,
        [Out "Parent"] = parent,
        BackgroundColor3 = scope:Computed(function(use)
            return use(Theme:GetTheme(use(backgroundColorTheme)))
        end),

        Size = UDim2.new(0, 10, 0, 25), --This is the minimum size it can be before looking weird at least on the left or right versions.

        [Children] = {
            Corner(scope) {Level = 1},
            scope:New "Frame" {
            Size = UDim2.new(0, 10, 0, 10),
            BackgroundColor3 = scope:Computed(function(use)
                return use(Theme:GetTheme(use(backgroundColorTheme)))
            end),
            AnchorPoint = Vector2.new(.3, .5),
            Position = UDim2.new(0, 0, .5, 0),
            Rotation = 45,

            [Children] = {
                Corner(scope) {Level = .5},
            }
        }
        },
    }

    Grabber.Export(tooltip, props)
end