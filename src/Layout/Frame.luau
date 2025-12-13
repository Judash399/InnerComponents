--[[
A component that creates a frame instance with pre-defined styling intended for use within layouts. (If your just creating a raw frame and customizing the props don't use this! Blank is planning on being removed!)
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
        Children: {Instance}?,
        Level: number?,
        AutoSize: Enum.AutomaticSize?,
        Blank: boolean?,
        Transparency: UsedAs<number>?,
        Parent: Instance?,
        ZIndex: number?,
        AutoLayout: UsedAs<boolean>?,
        LayoutPadding: UsedAs<UDim>?,
    })
        local Level = props.Level or 1
        local scope = scope:innerScope()

        local AutoSize = props.AutoSize or Enum.AutomaticSize.None
        
        local Corner = require(Root.Primitives.Corner)(scope)

        local autoLayout = scope:Computed(Otherwise(props.AutoLayout, true))


        if props.Blank then
            return scope:New "Frame" {
                Size = props.Size,
                AutomaticSize = AutoSize,
                BackgroundTransparency = props.Transparency or 1,
                [Children] = props.Children,
                Parent = props.Parent,
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

                scope:Computed(Only(autoLayout, scope:New "UIListLayout" {
                    Name = "AutoLayout",
                    Padding = props.LayoutPadding,
                })),

                props.Children
            },

            --TODO: Add the rest of the props.
        }
    end
end