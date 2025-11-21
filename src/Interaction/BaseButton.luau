local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children, OnEvent, peek, Out = Fusion.Children, Fusion.OnEvent, Fusion.peek, Fusion.Out


type UsedAs<T> = Fusion.UsedAs<T>

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Primary: boolean?,
        parent: Instance?,
        Size: UsedAs<UDim2>?,
        Pressed: () -> (),
        Background: boolean?,
        Enabled: UsedAs<boolean>?,
    })
        local scope = scope:innerScope()

        local Corner = require(Root.Primitives.Corner)(scope)


        local Hovering = scope:Value(false)
        local Pressed = scope:Value(false)
	    local MousePos = scope:Value(Vector2.new(0, 0))

        local Enabled = props.Enabled or true

        local DimSpring = scope:Spring(scope:Computed(function(use)
            if use(Enabled) == true then
                return 1
            else
                return .5
            end
        end), 25, 1)

        local theme
        if props.Primary then
            theme = "Primary"
        else
            theme = "SecondaryButton"
        end

        local hoverTheme
        if props.Primary then
            hoverTheme = "PrimaryButtonHighlight"
        else
            hoverTheme = "SecondaryButtonHighlight"
        end

        local pressedTheme
        if props.Primary then
            pressedTheme = "PrimaryButtonPress"
        else
            pressedTheme = "SecondaryButtonPress"
        end

        local highlightTheme
        if props.Primary then
            highlightTheme = "PrimaryButtonGlow"
        else
            highlightTheme = "SecondaryButtonGlow"
        end

        local color = Theme:GetTheme(theme)

        local FinalColor = scope:Spring(scope:Computed(function(use)
            local color = use(color)

            local Pressed = use(Pressed)
            
            if use(props.Background) == false then
                return Color3.new(1, 1, 1)
            end


            if Pressed then
                return peek(Theme:GetTheme(pressedTheme))
            end            

            if use(Hovering) and use(Enabled) then
                return peek(Theme:GetTheme(hoverTheme))
            else
                return color
            end
        end), 50, 1)

        local Frame = require(Root.Layout.Frame)(scope)

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

        local frame = Frame {
            Blank = true,
            Transparency = DimSpring,
            Parent = canvasGroup,
            ZIndex = 99999,
            Color = Color3.new(0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0)
        }

        local button = scope:New "TextButton" {
            Parent = canvasGroup,
            Name = "Button",
            Size = props.Size or UDim2.new(0, 200, 0, 50),
            BackgroundColor3 = FinalColor,
            ClipsDescendants = true,
            Active = Enabled,

            [OnEvent "MouseEnter"] = function()
			    Hovering:set(true)
		    end,
            [OnEvent "MouseLeave"] = function()
                Hovering:set(false)
                Pressed:set(false)
            end,
            
            [OnEvent "MouseMoved"] = function(x, y)
                MousePos:set(Vector2.new(x, y))
            end,

            [OnEvent "Activated"] = function()
                if peek(Enabled) then
                    if props.Pressed then
                       props.Pressed() 
                    end
                end
            end,

            [OnEvent "MouseButton1Down"] = function()
                Pressed:set(true)
            end,

            [OnEvent "MouseButton1Up"] = function()
                Pressed:set(false)
            end,

            BackgroundTransparency = scope:Computed(function(use)
                local hover = use(Hovering)
                if props.Background == true or props.Background == nil then
                    return 0
                else
                    if hover then
                        return .97
                    else 
                        return 1
                    end
                end
            end),

            [Children] = {
                Corner {},
            }
        }

        local highlight = scope:New "ImageLabel" {
            Parent = button,
            Size = UDim2.new(0, 150, 0, 150),
            BackgroundTransparency = 1,
            ZIndex = -1,
            AnchorPoint = Vector2.new(.5, .5),
            ImageColor3 = Theme:GetTheme(highlightTheme),
            Image = "http://www.roblox.com/asset/?id=5538771868",
            ImageTransparency = scope:Computed(function(use)
                local Hovering = use(Hovering)
                local Pressed = use(Pressed)
                local Primary = use(props.Primary)

                if use(Enabled) == false then
                    return 1
                end

                if Hovering == true and Pressed == false and Primary == false then
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