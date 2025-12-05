--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Color: Theme.ThemeColor?,
        Thickness: UsedAs<number>?,
        Transparency: UsedAs<number>?
    })
        return scope:New "UIStroke" {
            Thickness = props.Thickness or 3,
            Color = Theme:GetTheme(props.Color or "Outline"),
            Transparency = props.Transparency or 0,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            BorderStrokePosition = Enum.BorderStrokePosition.Inner
        }
    end
end