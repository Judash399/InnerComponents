local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)
local Icon = require(Root.Utils.Icon)  

local Children = Fusion.Children


return function(scope: Fusion.Scope<any>)
    return function(props: {
        IconName: string,
        Theme: Theme.ThemeColor?,
        AnchorPoint: Vector2?,
        Position: UDim2?,
        Size: UDim2?,
        Parent: Instance?,
        Transparency: Fusion.UsedAs<number>?
    })

        local IconInfo = Icon.GetIcon(props.IconName)

        return scope:New "ImageLabel" {
            Size = props.Size or UDim2.new(1, -5, 1, -5),
            Position = props.Position or UDim2.new(.5, 0, .5, 0),
            AnchorPoint = props.AnchorPoint or Vector2.new(.5, .5),
            Image = IconInfo.Url,
            ImageRectSize = IconInfo.ImageRectSize,
            ImageRectOffset = IconInfo.ImageRectOffset,
            BackgroundTransparency = 1,
            ImageTransparency = props.Transparency or 0,
            ImageColor3 = Theme:GetTheme(props.Theme or "MainText"),
            Parent = props.Parent,
            [Children] = {
                scope:New "UIAspectRatioConstraint" {},
            }
        }
    end
end