local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children, OnEvent, peek, Out = Fusion.Children, Fusion.OnEvent, Fusion.peek, Fusion.Out


type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        theme: Theme.ThemeColor?,
        parent: Instance?,
        Size: UsedAs<UDim2>?,
        Pressed: () -> ()
    })
        local scope = scope:innerScope()

        local Stroke = require(Root.Primitives.Stroke)(scope)
        local Corner = require(Root.Primitives.Corner)(scope)


        local Hovering = scope:Value(false)
	    local MousePos = scope:Value(Vector2.new(0, 0))

        local color = Theme:GetTheme(props.theme or "Button")

        local FinalColor = scope:Computed(function(use)
            local color = use(color)

            if use(Hovering) then
                return Color3.new(color.R + .04, color.G + .04, color.B + 0.04)
            else
                return color
            end
        end)

        local canvasGroup = scope:New "CanvasGroup" {
            Size = props.Size or UDim2.new(0, 200, 0, 50),
            Parent = props.parent,
            BackgroundTransparency = 1,

            [Children] = {
                Corner {
                    Level = 1,
                },
            }
        }

        local button = scope:New "TextButton" {
            Parent = canvasGroup,
            Name = "Button",
            Size = props.Size or UDim2.new(0, 200, 0, 50),
            BackgroundColor3 = FinalColor,
            ClipsDescendants = true,

            [OnEvent "MouseEnter"] = function()
			    Hovering:set(true)
		    end,
            [OnEvent "MouseLeave"] = function()
                Hovering:set(false)
            end,
            
            [OnEvent "MouseMoved"] = function(x, y)
                MousePos:set(Vector2.new(x, y))
            end,

            [OnEvent "Activated"] = props.Pressed,

            

            [Children] = {
                Stroke {
                    Color = "ButtonOutline"
                },
                Corner {},
            }
        }

        local highlight = scope:New "ImageLabel" {
            Parent = button,
            Size = UDim2.new(0, 150, 0, 150),
            BackgroundTransparency = 1,
            ZIndex = -1,
            AnchorPoint = Vector2.new(.5, .5),
            Image = "http://www.roblox.com/asset/?id=5538771868",
            ImageTransparency = scope:Computed(function(use)
                if use(Hovering) == true then
                    return .85
                else
                    return 1
                end
            end),
            Position = scope:Computed(function(use)
                local position = use(MousePos)
                local absoluteOther = button.AbsolutePosition
                local pos = UDim2.new(0, position.X - absoluteOther.X, 0, position.Y - absoluteOther.Y)
                return pos
            end)
        }

        return canvasGroup
    end
end