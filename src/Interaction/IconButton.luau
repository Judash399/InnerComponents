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
        Pressed: () -> (),
        IconID: UsedAs<string>?,
    })
        local scope = scope:innerScope()

        local button = Button(scope) {
            theme = props.theme,
            parent = props.parent,
            Size = props.Size,
            Pressed = props.Pressed,
        }

        
        scope:New "ImageLabel" {
            Size = UDim2.new(0, 13, 0, 13),
            Image = props.IconID or "",
            BackgroundTransparency = 1,
            ImageColor3 = Theme:GetTheme("ButtonIcon"),
            Parent = button,
        }

        return button
    end
end