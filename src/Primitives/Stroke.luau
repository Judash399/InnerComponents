--[[
A primitive component that creates a UIStroke with pre-set values.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Otherwise = require(Root.Utils.Otherwise)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>, props: {
    Color: Theme.ThemeColor?,
    Thickness: UsedAs<number>?,
    Transparency: UsedAs<number>?
})
    return scope:New "UIStroke" {
        Thickness = scope:Computed(Otherwise(props.Thickness, 3)),
        Color = scope:Computed(function(use)
            return use(Theme:GetTheme(use(props.Color) or "Outline"))
        end),
        Transparency = props.Transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        BorderStrokePosition = Enum.BorderStrokePosition.Inner
    }
end