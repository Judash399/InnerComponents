local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children = Fusion.Children

type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Size: UsedAs<UDim2>?,
        Children: {Instance}?,
        Level: number?,
        AutoSize: Enum.AutomaticSize?,
        Blank: boolean?,
        Transparency: UsedAs<number>?,
        Parent: Instance?,
        Color: Color3?,
        ZIndex: number?,
    })
        local Level = props.Level or 1
        local scope = scope:innerScope()

        local AutoSize = props.AutoSize or Enum.AutomaticSize.None
        
        local Corner = require(Root.Primitives.Corner)(scope)


        if props.Blank then
            return scope:New "Frame" {
                Size = props.Size,
                AutomaticSize = AutoSize,
                BackgroundTransparency = props.Transparency or 1,
                [Children] = props.Children,
                Parent = props.Parent,
                BackgroundColor3 = props.Color,
                ZIndex = props.ZIndex
            }
        end

        return scope:New "Frame" {
            Size = props.Size,
            BackgroundColor3 = Theme:GetTheme("CardBackground"),
            AutomaticSize = AutoSize,
            BackgroundTransparency = props.Transparency or 0,
            Parent = props.Parent,

            [Children] = {
                Corner {Level = Level},

                props.Children
            },

            --TODO: Add the rest of the props.
        }
    end
end