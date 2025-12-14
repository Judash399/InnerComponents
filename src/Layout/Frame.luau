--[[
A component that creates a frame instance with pre-defined styling intended for use within layouts.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Only = require(Root.Utils.Only)
local Otherwise = require(Root.Utils.Otherwise)

--Refrences
local Children = Fusion.Children

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Size: UsedAs<UDim2>?,
        Position: UsedAs<UDim2>?,
        Children: {Instance}?,
        Level: number?,
        AutoSize: Enum.AutomaticSize?,
        Parent: Instance?,
        AutoLayout: UsedAs<boolean>?,
        LayoutPadding: UsedAs<UDim>?,
        BackgroundColor: UsedAs<Theme.Theme>?,
    })
        local Level = props.Level or 1
        local scope = scope:innerScope()

        local AutoSize = props.AutoSize or Enum.AutomaticSize.None
        
        local Corner = require(Root.Primitives.Corner)(scope)

        local autoLayout = scope:Computed(Otherwise(props.AutoLayout, true))

        return scope:New "Frame" {
            Size = props.Size,
            Position = props.Position,
            BackgroundColor3 = scope:Computed(function(use)
                local theme = use(props.BackgroundColor) or "CardBackground"

                if typeof(theme) == "Color3" then
                    return theme
                end

                return use(Theme:GetTheme(theme))
            end),
            AutomaticSize = AutoSize,
            Parent = props.Parent,

            [Children] = {
                Corner {Level = Level},

                scope:Computed(Only(autoLayout, scope:New "UIListLayout" {
                    Name = "AutoLayout",
                    Padding = props.LayoutPadding,
                })),

                props.Children
            },
        }
    end
end