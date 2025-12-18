--[[
A component that creates a frame instance with pre-defined styling intended for use within layouts.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Only = require(Root.Utils.Only)
local Otherwise = require(Root.Utils.Otherwise)

local Grabber = require(Root.Utils.Grabber)

--Components
local Corner = require(Root.Primitives.Corner)


--Refrences
local Children = Fusion.Children
local Out = Fusion.Out

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Size: UsedAs<UDim2>?,
        Position: UsedAs<UDim2>?,
        Children: {Instance}?,
        Level: UsedAs<number>?,
        AutoSize: Enum.AutomaticSize?,
        Parent: Instance?,
        AutoLayout: UsedAs<boolean>?,
        LayoutPadding: UsedAs<UDim>?,
        BackgroundColor: UsedAs<Theme.Theme>?,
    })
        local scope = scope:innerScope()

        local parent = scope:Value(nil)

        local props = Grabber.ConvertProps(scope, {
            Parent = parent
        }, props)

        local Level = scope:Computed(Otherwise(props.Level, 1))
        local AutoSize = scope:Computed(Otherwise(props.AutoSize, Enum.AutomaticSize.None))
        local AutoLayout = scope:Computed(Otherwise(props.AutoLayout, true))

        local frame = scope:New "Frame" {
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
            [Out "Parent"] = parent,

            [Children] = {
                Corner(scope) {Level = Level},

                scope:Computed(Only(AutoLayout, scope:New "UIListLayout" {
                    Name = "AutoLayout",
                    Padding = props.LayoutPadding,
                })),

                props.Children
            },
        }

        Grabber.Export(frame, props)

        return frame
    end
end