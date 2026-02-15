--[[
A component that creates a button group.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Dependencys).Fusion

--Components
local Corner = require(Root.Primitives.Corner)

--Refrences
local Children = Fusion.Children

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<>, props: {
    Parent: UsedAs<Instance>?,
    Children: {Instance}
})
    local scope = scope:innerScope(Fusion, {
        Corner = Corner
    })

    return scope:New "CanvasGroup" {
        Parent = props.Parent,
        BackgroundTransparency = 1,

        Size = UDim2.new(0, 0, 0, 30),
        AutomaticSize = Enum.AutomaticSize.X,

        [Children] = {
            scope:Corner {},

            props.Children
        }
    }
end