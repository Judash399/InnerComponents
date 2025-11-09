local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children = Fusion.Children

type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Parent: Instance?,
    })
        local PaddingAmount = UDim.new(0, 5)
        local scope = scope:innerScope()
        
        return scope:New "UIPadding" {
            Parent = props.Parent,
            PaddingBottom = PaddingAmount,
            PaddingTop = PaddingAmount,
            PaddingRight = PaddingAmount,
            PaddingLeft = PaddingAmount,
        }
    end
end