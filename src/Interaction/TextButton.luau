local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Button = require(script.Parent.BaseButton)
local Theme = require(Root.Utils.Theme)

local Children, OnEvent, peek, Out = Fusion.Children, Fusion.OnEvent, Fusion.peek, Fusion.Out

type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        theme: Theme.ThemeColor?,
        parent: Instance?,
        Size: UsedAs<UDim2>?,
        Text: UsedAs<string>?,
        Pressed: () -> (),
        TextTheme: Theme.ThemeColor?,
        IconID: UsedAs<string>?
    })
        local scope = scope:innerScope()

        local button = Button(scope) {
            theme = props.theme,
            parent = props.parent,
            Size = props.Size,
            Pressed = props.Pressed,
        }

        local content = scope:New "Frame" {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Parent = button,
            [Children] = {
                scope:New "UIListLayout" {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                },
                scope:New "TextLabel" {
                    Size = UDim2.new(0, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
                    TextSize = 17,
                    Text = props.Text,
                    TextColor3 = Theme:GetTheme(props.TextTheme or "ButtonText")
                },
                scope:New "ImageLabel" {
                    Size = UDim2.new(0, 13, 0, 13),
                    Image = props.IconID or "",
                    BackgroundTransparency = 1,
                    ImageColor3 = Theme:GetTheme("ButtonIcon"),
                    Visible = scope:Computed(function(use)
                        local image = use(props.IconID)

                        if image == nil or image == "" then
                            return false
                        else
                            return true
                        end
                    end)
                }
            }
        }
        

        return button
    end
end