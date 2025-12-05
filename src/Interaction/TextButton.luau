--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Button = require(script.Parent.BaseButton)
local Text = require(Root.Content.Text)

--Refrences
local Children = Fusion.Children

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Primary: boolean?,
        parent: Instance?,
        Size: UsedAs<UDim2>?,
        Text: UsedAs<string>?,
        Pressed: () -> (),
        Icon: string,
        Enabled: UsedAs<boolean>?
    })
        local scope = scope:innerScope()

        local button = Button(scope) {
            Primary = props.Primary,
            parent = props.parent,
            Size = props.Size,
            Pressed = props.Pressed,
            Enabled = props.Enabled,
        }

        local textTheme
        if props.Primary == true then
            textTheme = "PrimaryContent"
        else
            textTheme = "SecondaryContent"
        end

        local content = scope:New "Frame" {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Parent = button,
            [Children] = {
                scope:New "UIListLayout" {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                },
                Text(scope) {
                    Size = UDim2.new(0, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 17,
                    Text = props.Text,
                    TextTheme = textTheme,
                    XAlign = Enum.TextXAlignment.Center
                },
            }
        }
        
        return button
    end
end