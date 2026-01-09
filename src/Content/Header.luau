--[[
A component that creates a text label styling to look like a header.
]]

--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)

local Otherwise = require(Root.Utils.Otherwise)

--Refrences

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
    HeaderLevel: UsedAs<number>?,
    XAlign: Enum.TextXAlignment?,
    YAlign: Enum.TextYAlignment?,
})
    local scope = scope:innerScope({
        Text = require(script.Parent.Text)
    })

    local Level = scope:Computed(Otherwise(props.HeaderLevel, 1))

    local Boldness = scope:Computed(function(use)
        local level = use(Level)

        return if level == 1 then Enum.FontWeight.Bold
        elseif level == 2 then Enum.FontWeight.ExtraBold
        elseif level == 3 then Enum.FontWeight.Bold
        else Enum.FontWeight.Bold
    end)

    local Size = scope:Computed(function(use)
        local level = use(Level)

        return if level == 1 then 25
        elseif level == 2 then 22
        elseif level == 3 then 19
        else 25
    end)

    return scope:Text {
        Text = props.Text,

        --Layout
        Size = props.Size,
        Children = props.Children,
        AutomaticSize = props.AutomaticSize,
        LayoutOrder = props.LayoutOrder,
        Wraps = props.Wraps,

        --Styling
        Weight = Boldness,
        TextSize = Size,

        XAlign = props.XAlign,
        YAlign = props.YAlign,
    }

end