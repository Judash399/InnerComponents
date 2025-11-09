local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Level: number?
    })
        local Level = props.Level or 1
        return scope:New "UICorner" {
            CornerRadius = UDim.new(0, 10 * Level)
        }
    end
end