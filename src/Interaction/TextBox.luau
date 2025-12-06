--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

--Refrences
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local OnChange = Fusion.OnChange

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Parent: Instance?,
        Size: UDim2?,
        PlaceholderText: UsedAs<string>?,
        Text: string?,
        Flex: boolean?,
        OnChange: (string) -> (),
    })
        local scope = scope:innerScope()

        local Stroke = require(Root.Primitives.Stroke)(scope)
        local Corner = require(Root.Primitives.Corner)(scope)
        local Padding = require(Root.Layout.Padding)(scope)

        local Focused = scope:Value(false)
        local Hovering = scope:Value(false)

        local thickness = scope:Spring(scope:Computed(function(use)
            local focused = use(Focused)
            local hovering = use(Hovering)

            if focused == true then
                return 1.5 
            elseif hovering == true then
                return 1
            else
                return 0
            end
        end), 25, 1)

        local transparency = scope:Spring(scope:Computed(function(use)
            local focused = use(Focused)
            local hovering = use(Hovering)

            if focused == true then
                return 0 
            elseif hovering == true then
                return .5
            else
                return 1
            end
        end), 25, 1)

        local textbox = scope:New "TextBox" {
            Parent = props.Parent,
            Size = props.Size or UDim2.new(0, 200, 0, 30),
            TextXAlignment = Enum.TextXAlignment.Left,
            PlaceholderText = props.PlaceholderText,
            BackgroundColor3 = Theme:GetTheme(Enum.StudioStyleGuideColor.InputFieldBackground),
            TextColor3 = Theme:GetTheme("MainText"),
            ClipsDescendants = true,
            [OnEvent "Focused"] = function()
                Focused:set(true)
            end,
            [OnEvent "FocusLost"] = function()
                Focused:set(false)
            end,

            [OnEvent "MouseEnter"] = function()
                Hovering:set(true)
            end,

            [OnEvent "MouseLeave"] = function()
                Hovering:set(false)
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

        if props.Flex then
            scope:New "UIFlexItem" {
                  Parent = textbox,
                  FlexMode = Enum.UIFlexMode.Fill,
            }
        end
        
        return textbox
    end
end