local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Button = require(Root.Interaction.BaseButton)
local Theme = require(Root.Utils.Theme)
local ImageIcon = require(Root.Content.ImageIcon)  

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

        ImageIcon(scope) {
            IconName = props.IconName,
            Parent = button,
        }

        return button
    end
end