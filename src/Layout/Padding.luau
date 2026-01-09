--[[
A component that creates a UIPadding component with defaults.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Otherwise = require(Root.Utils.Otherwise)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>, props: {
    Parent: UsedAs<Instance>?,
    Amount: UsedAs<UDim>?,
    LeftAmount: UsedAs<UDim>?,
    RightAmount: UsedAs<UDim>?,
    TopAmount: UsedAs<UDim>?,
    BottomAmount: UsedAs<UDim>?,
})
    local scope = scope:innerScope()

    local PaddingAmount = scope:Computed(Otherwise(props.Amount, UDim.new(0, 5)))
    
    return scope:New "UIPadding" {
        Parent = props.Parent,
        PaddingBottom = scope:Computed(Otherwise(props.BottomAmount, PaddingAmount)),
        PaddingTop = scope:Computed(Otherwise(props.TopAmount, PaddingAmount)),
        PaddingRight = scope:Computed(Otherwise(props.RightAmount, PaddingAmount)),
        PaddingLeft = scope:Computed(Otherwise(props.LeftAmount, PaddingAmount)),
    }
end