local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Size: UsedAs<UDim2>?
    })
        local scope = scope:InnerScope()
        

        return scope:New "Frame" {
            Size = props.Size,

            --TODO: Add the rest of the props.
        }
    end
end