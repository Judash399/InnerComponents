--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Dependencys).Fusion

--Refrences
local Children = Fusion.Children

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>, props: {
    Primary: UsedAs<boolean>?,
    Parent: Instance?,
    Size: UsedAs<UDim2>?,
    Text: UsedAs<string>?,
    Pressed: () -> (),
    Icon: string,
    Enabled: UsedAs<boolean>?
})
    local scope = scope:innerScope({
        Text = require(Root.Content.Text),
        BaseButton = require(script.Parent.BaseButton)
    })

    local textTheme = scope:Computed(function(use)
        if use(props.Primary) == true then
            return "PrimaryContent"
        else
            return "SecondaryContent"
        end
    end)

    local button = scope:BaseButton {
        Primary = props.Primary,
        Parent = props.Parent,
        Size = props.Size,
        Pressed = props.Pressed,
        Enabled = props.Enabled,

        Children = {
            scope:New "Frame" {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                [Children] = {
                    scope:New "UIListLayout" {
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                    },
                    scope:Text {
                        Size = UDim2.new(0, 0, 1, 0),
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 17,
                        Text = props.Text,
                        TextColor = textTheme,
                        XAlign = Enum.TextXAlignment.Center
                    },
                }
            }
        }
    }

    return button
end