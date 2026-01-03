--[[
A component that creates a ImageLabel styling with the icon set to a lucide icon.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)
local Icon = require(Root.Utils.Icon)

local Otherwise = require(Root.Utils.Otherwise)


--Refrences
local Children = Fusion.Children

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        IconName: string,
        Theme: Theme.ThemeColor?,
        AnchorPoint: UsedAs<Vector2>?,
        Position: UsedAs<UDim2>?,
        Size: UsedAs<UDim2>?,
        Parent: Instance?,
        Transparency: UsedAs<number>?,
        ZIndex: UsedAs<number>?,
    })

        local IconInfo = scope:Computed(function(use)
            local icon = Icon.GetIcon(use(props.IconName))

            if not icon then
                warn(`[InnerComponents] the icon '{props.IconName}' is not an icon in the lucide icon set! Replacing with 'diamond'. Full icon list at lucide.dev`)
                icon = Icon.GetIcon("diamond")
            end

            return icon
        end)

        --Wrapper function, makes indexing a value easier.
        local function IndexValue(StateObject, key)
            return scope:Computed(function(use)
                return use(StateObject)[key]
            end)
        end

        return scope:New "ImageLabel" {
            Size = scope:Computed(Otherwise(props.Size, UDim2.new(1, -5, 1, -5))),
            Position = scope:Computed(Otherwise(props.Position, UDim2.new(.5, 0, .5, 0))),
            AnchorPoint = scope:Computed(Otherwise(props.AnchorPoint, Vector2.new(.5, .5))),
            Image = IndexValue(IconInfo, "Url"),
            ImageRectSize = IndexValue(IconInfo, "ImageRectSize"),
            ImageRectOffset = IndexValue(IconInfo, "ImageRectOffset"),
            BackgroundTransparency = 1,
            ZIndex = props.ZIndex,
            ImageTransparency = scope:Computed(Otherwise(props.Transparency, 0)),
            ImageColor3 = scope:Computed(function(use)
                return use(Theme:GetTheme(use(props.Theme) or "MainText"))
            end),
            Parent = props.Parent,
            [Children] = {
                scope:New "UIAspectRatioConstraint" {},
            }
        }
    end
end