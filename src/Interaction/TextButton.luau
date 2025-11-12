local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Button = require(script.Parent.BaseButton)
local Text = require(Root.Content.Text)
local ImageIcon = require(Root.Content.ImageIcon)
local Theme = require(Root.Utils.Theme)

local Children = Fusion.Children

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
                --[[
                scope:New "ImageLabel" {
                    Size = UDim2.new(0, 13, 0, 13),
                    Image = props.IconID or "",
                    BackgroundTransparency = 1,
                    ImageColor3 = Theme:GetTheme("Text"),
                    Visible = scope:Computed(function(use)
                        local image = use(props.IconID)

                        if image == nil or image == "" then
                            return false
                        else
                            return true
                        end
                    end)
                }
                ]]
            }
        }

        --TODO: Icon needs to be re-added to text button!

        --[[
        local icon = ImageIcon(scope) {
            Parent = content,
            Image = props.Icon,
            Size = UDim2.new(0, 13, 0, 13),
        }
        ]]
        

        return button
    end
end