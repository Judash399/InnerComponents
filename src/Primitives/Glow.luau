--[[
A primitive component used by other component like buttons that creates a glow effect.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Dependencys).Fusion
local Theme = require(Root.Utils.Theme)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(Scope: Fusion.Scope<any>)
    return function(props: {
        Parent: UsedAs<Instance>,
        Enabled: Fusion.Value<any, boolean>,
        Color: UsedAs<Theme.Theme>,
        Size: UsedAs<Vector2>,
        Position: UsedAs<Vector2>,
    })
        local scope = Scope:innerScope()

        return scope:New "ImageLabel" {
            Parent = props.Parent,
            Size = scope:Spring(scope:Computed(function(use)
                local enabled = use(props.Enabled)
                local size = use(props.Size)

                if enabled == true then
                    return UDim2.new(0, size.X, 0, size.Y)
                else
                    return UDim2.new(0, 0, 0, 0)
                end
            end), 25, 1),
            BackgroundTransparency = 1,
            ZIndex = -1,
            AnchorPoint = Vector2.new(.5, .5),

            --Inside a computed so it can adapt to color changes if the prop is changed.
            ImageColor3 = scope:Computed(function(use)
                return use(Theme:GetTheme(use(props.Color)))
            end), 
            Image = "http://www.roblox.com/asset/?id=5538771868", --TODO: Should probably at somepoint expose this value so the user can define there own glow image.
            
            ImageTransparency = scope:Spring(scope:Computed(function(use)
                local enabled = use(props.Enabled)

                return if enabled then 0.95 else 1
            end), 25, 1),
            Position = scope:Computed(function(use)
                local position = use(props.Position)

                return position
            end)
        }
    end
end