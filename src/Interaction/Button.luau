local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children, OnEvent = Fusion.Children, Fusion.OnEvent


type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        theme: Theme.ThemeColor?,
        parent: Instance?,
        Size: UsedAs<UDim2>?,
        Filled: UsedAs<boolean>?,
        Text: UsedAs<string>?,

    })
        local scope = scope:innerScope()

        local Stroke = require(Root.Primitives.Stroke)(scope)
        local Corner = require(Root.Primitives.Corner)(scope)

        return scope:New "TextButton" {
            Parent = props.parent,
            Name = "TestButton!",
            Size = props.Size or UDim2.new(0, 200, 0, 50),
            BackgroundColor3 = Theme:GetTheme(props.theme or "Button"),
            BackgroundTransparency = scope:Computed(function(use)
                if use(props.Filled) == true then
                    return 0
                else
                    return 1
                end
            end),

            Text = props.Text or "Text Button",
            FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
            TextColor3 = scope:Computed(function(use)
                if use(props.Filled) == true then
                    return Fusion.peek(Theme:GetTheme("ButtonText"))
                else
                    return Fusion.peek(Theme:GetTheme(props.theme or "Button"))
                end
            end),

            [Children] = {
                Stroke {},
                Corner {},
            }
        }
    end
end