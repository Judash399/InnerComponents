local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Color: Theme.ThemeColor
    })
        return scope:New "UIStroke" {
            Thickness = 3,
            Color = Theme:GetTheme(props.Color or "Outline"),
            Transparency = 0,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            BorderStrokePosition = Enum.BorderStrokePosition.Inner
        }
    end
end