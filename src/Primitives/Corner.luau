local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)

return function(scope: Fusion.Scope<any>)
    return function(props: {
    })
        return scope:New "UICorner" {
            CornerRadius = UDim.new(0, 5)
        }
    end
end