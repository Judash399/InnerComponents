--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>, props: {
    theme: Theme.ThemeColor?,
    parent: Instance?,
    Size: UsedAs<UDim2>?,
    Pressed: () -> (),
    IconName: UsedAs<string>?,
    Background: boolean?,
    IconPadding: number?,
    IconTransparency: UsedAs<number>?,
    AspectRatio: UsedAs<number>?,
})
    local scope = scope:innerScope({
        ImageIcon = require(Root.Content.ImageIcon),
        BaseButton = require(Root.Interaction.BaseButton)
    })
    
    local button = scope:BaseButton {
        theme = props.theme,
        parent = props.parent,
        Size = props.Size or UDim2.new(0, 30, 0, 30),
        Pressed = props.Pressed,
        Background = props.Background,

        Children = scope:ImageIcon {
            IconName = props.IconName,
            Size = UDim2.new(1, (props.IconPadding or 5) * -1, 1, (props.IconPadding or 5) * -1),
            Transparency = props.IconTransparency,
        }
    }

    if props.AspectRatio then
        scope:New "UIAspectRatioConstraint" {
            AspectRatio = props.AspectRatio,
            Parent = button
        }
    end

    return button
end