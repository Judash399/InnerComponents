local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children, OnEvent, peek, Out, OnChange = Fusion.Children, Fusion.OnEvent, Fusion.peek, Fusion.Out, Fusion.OnChange


type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Parent: Instance?,
        Size: UDim2?,
        PlaceholderText: UsedAs<string>?,
        Text: string?,
        Fill: boolean?,
        OnChange: (string) -> (),
    })
        local scope = scope:innerScope()

        local Stroke = require(Root.Primitives.Stroke)(scope)
        local Corner = require(Root.Primitives.Corner)(scope)
        local Padding = require(Root.Layout.Padding)(scope)

        local focused = scope:Value(false)
        local hovering = scope:Value(false)

        local thickness = scope:Spring(scope:Computed(function(use)
            local focused = use(focused)
            local hovering = use(hovering)

            if focused == true then
                return 1.5 
            elseif hovering == true then
                return 1
            else
                return 0
            end
        end), 25, 1)

        local transparency = scope:Spring(scope:Computed(function(use)
            local focused = use(focused)
            local hovering = use(hovering)

            if focused == true then
                return 0 
            elseif hovering == true then
                return .5
            else
                return 1
            end
        end), 25, 1)

        local textBox = scope:New "TextBox" {
            Parent = props.Parent,
            Size = props.Size or UDim2.new(0, 200, 0, 30),
            TextXAlignment = Enum.TextXAlignment.Left,
            PlaceholderText = props.PlaceholderText,
            BackgroundColor3 = Theme:GetTheme("InnerCardBackground"),
            TextColor3 = Theme:GetTheme("MainText"),
            ClipsDescendants = true,
            [OnEvent "Focused"] = function()
                focused:set(true)
            end,
            [OnEvent "FocusLost"] = function()
                focused:set(false)
            end,

            [OnEvent "MouseEnter"] = function()
                hovering:set(true)
            end,

            [OnEvent "MouseLeave"] = function()
                hovering:set(false)
            end,
            
            Text = props.Text,
            [Out "Text"] = props.Text,
            [OnChange "Text"] = props.OnChange,

            [Children] = {
                Corner {},
                Padding {},
                Stroke {
                    Color = "Primary",
                    Thickness = thickness,
                    Transparency = transparency
                },
            }
        }

        if props.Fill then
            scope:New "UIFlexItem" {
                  Parent = textBox,
                  FlexMode = Enum.UIFlexMode.Fill  
            }
        end
        
        return textBox
    end
end