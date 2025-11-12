local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children, OnEvent, peek, Out = Fusion.Children, Fusion.OnEvent, Fusion.peek, Fusion.Out

type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Text: UsedAs<string>?,
        Size: UsedAs<UDim2>?,
        Weight: Enum.FontWeight?,
        Style: Enum.FontStyle?,
        TextSize: number?,
        TextTheme: Theme.ThemeColor?,
        XAlign: Enum.TextXAlignment?,
        YAlign: Enum.TextYAlignment?,
        Children: {Instance}?,
        AutomaticSize: Enum.AutomaticSize?,
        LayoutOrder: number?,
        Wraps: boolean?
    })
        local scope = scope:innerScope()

        return scope:New "TextLabel" {
            Text = props.Text,
            Size = props.Size,
            FontFace = Font.new("rbxasset://fonts/families/Roboto.json", props.Weight or Enum.FontWeight.Regular, props.Style or Enum.FontStyle.Normal),
            TextSize = props.TextSize or 16,
            TextColor3 = Theme:GetTheme(props.TextTheme or "MainText"),
            TextXAlignment = props.XAlign or Enum.TextXAlignment.Left,
            TextYAlignment = props.YAlign or Enum.TextYAlignment.Center,
            AutomaticSize = props.AutomaticSize,
            TextWrapped = props.Wraps or false,
            BackgroundTransparency = 1,
            LayoutOrder = props.LayoutOrder,
            [Children] = props.Children,
        }
    end
end