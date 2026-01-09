--[[
A component that creates a text label styling to look like a paragraph.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>, props: {
    --Main
    Text: UsedAs<string>?,

    --Layout
    Size: UsedAs<UDim2>?,
    Children: UsedAs<{Instance}>?,
    AutomaticSize: UsedAs<Enum.AutomaticSize>?,
    LayoutOrder: UsedAs<number>?,
    Wraps: UsedAs<boolean>?,

    --Styling
    XAlign: Enum.TextXAlignment?,
    YAlign: Enum.TextYAlignment?,
})
    local scope = scope:innerScope({
        Text = require(Root.Content.Text)
    })

    return scope:Text {
        Text = props.Text,

        --Layout
        Size = props.Size,
        Children = props.Children,
        AutomaticSize = props.AutomaticSize,
        LayoutOrder = props.LayoutOrder,
        Wraps = props.Wraps,

        --Styling
        Weight = Enum.FontWeight.Regular,
        TextSize = 16,

        XAlign = props.XAlign,
        YAlign = props.YAlign,
    }

end