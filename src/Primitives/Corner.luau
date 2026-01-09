--[[
A primitive component that creates a UICorner instance with pre-set values.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)

local Otherwise = require(Root.Utils.Otherwise)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>, props: {
    Level: UsedAs<number>?
})
    local Level = scope:Computed(Otherwise(props.Level, 1))

    return scope:New "UICorner" {
        CornerRadius = scope:Computed(function(use)
            return UDim.new(0, 6 * use(Level))
        end)
    }
end