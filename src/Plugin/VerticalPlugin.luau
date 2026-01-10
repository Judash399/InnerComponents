--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Dependencys).Fusion
local Theme = require(Root.Utils.Theme)

--Refrences
local Children = Fusion.Children

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>, props: {
    TopbarChildren: UsedAs<{Instance}>?,
    ContentChildren: UsedAs<{Instance}>?,
    AddContentList: boolean?,
    AddTopbarList: boolean?,
})
    local scope = scope:innerScope({
        Scroller = require(Root.Layout.Scroller)
    })

    return scope:New "Frame" {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme:GetTheme(Enum.StudioStyleGuideColor.MainBackground),
        Name = "VerticalPluginView",

        [Children] = {
            --Titlebar
            scope:New "Frame" {
                BackgroundColor3 = Theme:GetTheme(Enum.StudioStyleGuideColor.Titlebar),
                Size = UDim2.new(1, 0, 0, 30),

                [Children] = {
                    scope:New "UIListLayout" {
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, 3),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    },

                    scope:New "UIPadding" {
                        PaddingBottom = UDim.new(0, 5),
                        PaddingLeft = UDim.new(0, 5),
                        PaddingRight = UDim.new(0, 5),
                    },

                    props.TopbarChildren
                }
            },

            --Content view
            scope:Scroller {
                Position = UDim2.new(0, 0, 0, 30),
                Size = UDim2.new(1, 0, 1, -30),
                BackgroundColor3 = Theme:GetTheme(Enum.StudioStyleGuideColor.MainBackground),
                Scaled = true,

                Children = {
                    scope:New "UIListLayout" {
                        FillDirection = Enum.FillDirection.Vertical,
                        Padding = UDim.new(0, 5)
                    },

                    props.ContentChildren
                }
            }
        }
    }
end