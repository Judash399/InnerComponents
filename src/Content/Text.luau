--[[
A base component that creates a text label with some pre-defined styling.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Otherwise = require(Root.Utils.Otherwise)

--Refrences
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        --Main
        Text: UsedAs<string>?,

        --Layout
        Size: UsedAs<UDim2>?,
        Children: UsedAs<{Instance}>?,
        AutomaticSize: UsedAs<Enum.AutomaticSize>?,
        LayoutOrder: UsedAs<number>?,
        Wraps: UsedAs<boolean>?,

        --Styling
        Weight: UsedAs<Enum.FontWeight>?,
        TextSize: UsedAs<number>?,
        Style: UsedAs<Enum.FontStyle>?,
        TextColor: UsedAs<Theme.Theme>?,
        XAlign: UsedAs<Enum.TextXAlignment>?,
        YAlign: UsedAs<Enum.TextYAlignment>?,
    })
        local scope = scope:innerScope()

        return scope:New "TextLabel" {
            Text = props.Text,
            Size = props.Size,
            FontFace = scope:Computed(function(use)
                local weight = use(props.Weight) or Enum.FontWeight.Regular
                local style = use(props.Style) or Enum.FontStyle.Normal

                return Font.new("rbxasset://fonts/families/Roboto.json", weight, style)
            end),
            TextSize = scope:Computed(Otherwise(props.TextSize, 16)),
            TextColor3 = scope:Computed(function(use)
                local theme = use(props.TextColor) or "MainText"

                if typeof(theme) == "Color3" then
                    return theme
                end

                return use(Theme:GetTheme(theme))
            end),
            TextXAlignment = scope:Computed(Otherwise(props.XAlign, Enum.TextXAlignment.Left)),
            TextYAlignment = scope:Computed(Otherwise(props.YAlign, Enum.TextYAlignment.Center)),
            AutomaticSize = props.AutomaticSize,
            TextWrapped = scope:Computed(Otherwise(props.Wraps, false)),
            BackgroundTransparency = 1,
            LayoutOrder = props.LayoutOrder,
            [Children] = props.Children,
        }
    end
end