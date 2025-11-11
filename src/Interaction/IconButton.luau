local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Button = require(script.Parent.BaseButton)
local Theme = require(Root.Utils.Theme)
local Icon = require(Root.Utils.Icon)  

local Children, OnEvent, peek, Out = Fusion.Children, Fusion.OnEvent, Fusion.peek, Fusion.Out

type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        theme: Theme.ThemeColor?,
        parent: Instance?,
        Size: UsedAs<UDim2>?,
        Pressed: () -> (),
        IconName: UsedAs<string>?,
        Background: boolean?
    })
        local scope = scope:innerScope()
        local button = Button(scope) {
            theme = props.theme,
            parent = props.parent,
            Size = props.Size or UDim2.new(0, 30, 0, 30),
            Pressed = props.Pressed,
            Background = props.Background,
        }

        
        scope:New "ImageLabel" {
            Size = UDim2.new(1, -5, 1, -5),
            Position = UDim2.new(.5, 0, .5, 0),
            AnchorPoint = Vector2.new(.5, .5),
            Image =  Icon.GetIcon(props.IconName),
            BackgroundTransparency = 1,
            ImageColor3 = Theme:GetTheme("ButtonIcon"),
            Parent = button,
        }

        return button
    end
end