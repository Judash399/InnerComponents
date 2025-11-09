local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children = Fusion.Children

type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Size: UsedAs<UDim2>?,
        Children: {Instance}?,
        Level: number?
    })
        local Level = props.Level or 1
        local scope = scope:innerScope()
        
        local Corner = require(Root.Primitives.Corner)(scope)

        return scope:New "Frame" {
            Size = props.Size,
            BackgroundColor3 = Theme:GetTheme("Frame"),

            [Children] = {
                Corner {Level = Level},

                props.Children
            },

            --TODO: Add the rest of the props.
        }
    end
end