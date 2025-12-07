--[[
A base component that creates a text label with some pre-defined styling.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

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
            TextSize = scope:Computed(function(use)
                return use(props.TextSize) or 16
            end),
            TextColor3 = Theme:GetTheme(props.TextTheme or "MainText"),
            TextXAlignment = scope:Computed(function(use)
                return use(props.XAlign) or Enum.TextXAlignment.Left
            end),
            TextYAlignment = scope:Computed(function(use)
                return use(props.YAlign) or Enum.TextYAlignment.Center
            end),
            AutomaticSize = props.AutomaticSize,
            TextWrapped = scope:Computed(function(use)
                return use(props.Wraps) or false
            end),
            BackgroundTransparency = 1,
            LayoutOrder = props.LayoutOrder,
            [Children] = props.Children,
        }
    end
end