--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Glow = require(Root.Primitives.Glow)

local Grabber = require(Root.Utils.Grabber)

--Refrences
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local Out = Fusion.Out

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function(Scope: Fusion.Scope<any>)
    return function(props: {
        
        --Important
        Enabled: UsedAs<boolean>?,

        --Layout
        Parent: Instance?,
        Size: UsedAs<UDim2>?,

        --Style
        Primary: boolean?,
        Background: boolean?,

        Children: {Instance}?,
        CanvasGroupChildren: {Instance}?,

        --Callbacks
        Pressed: () -> (),
        MouseEnter: () -> (),
        MouseLeave: () -> (),

        --Outputs
        MousePosition: Fusion.Value<any, Vector2>?,
        AbsSizeReturn: Fusion.Value<any, Vector2>?,
        MouseHolding: Fusion.Value<any, boolean>?,

        --Newer Outputs
        Hovering: Fusion.Value<any, boolean>?,
    })
        local scope = Scope:innerScope()

        local parent = scope:Value(nil)

        local Hovering = props.Hovering or scope:Value(false)

        local props = Grabber.ConvertProps(scope, {
            Parent = parent
        }, props)

        local Corner = require(Root.Primitives.Corner)(scope)

        local Pressed = scope:Value(false)
        local Enabled = props.Enabled or true
	    local MousePos = props.MousePosition or scope:Value(Vector2.new(0, 0))

        local HoverEffects = scope:Computed(function(use)
            if use(Enabled) == false then
                return false
            end

            if use(Pressed) == true then
                return false
            end

            if use(Hovering) == true then
                return true
            end

            return false
        end)

        local MouseHolding = props.MouseHolding or scope:Value(false)

        local DimSpring = scope:Spring(scope:Computed(function(use)
            local light = use(Theme:IsLight())

            if use(Enabled) == true then
                return 1
            else
                return if light then .7 else .5
            end
        end), 25, 1)

        local theme
        local hoverTheme
        local highlightTheme
        if peek(props.Primary) then
            theme = "Primary"
            hoverTheme = "PrimaryButtonHighlight"
            highlightTheme = "PrimaryButtonGlow"
        else
            theme = "SecondaryButton"
            hoverTheme = "SecondaryButtonHighlight"
            highlightTheme = "SecondaryButtonGlow"
        end

        local color = Theme:GetTheme(theme)

        local FinalColor = scope:Spring(scope:Computed(function(use)
            if use(props.Background) == false then
                return peek(Theme:GetTheme("SecondaryButtonHighlight"))
            end

            if use(Enabled) == false then
                return use(color)
            end

            if use(HoverEffects) then
                return peek(Theme:GetTheme(hoverTheme))
            elseif use(Pressed) then
                return peek(Theme:GetTheme(theme))
            else
                return use(color)
            end
        end), 50, 1)

        local Frame = require(Root.Layout.Frame)(scope)

        local canvasGroup = scope:New "CanvasGroup" {
            Size = props.Size or UDim2.new(0, 200, 0, 50),
            Parent = props.parent,
            BackgroundTransparency = 1,
            
            [Out "Parent"] = parent,

            [Children] = {
                Corner {
                    Level = 1,
                },
                props.CanvasGroupChildren
            },
        }

        local frame = scope:New "Frame" {
            Transparency = DimSpring,
            Parent = canvasGroup,
            ZIndex = 99999,
            BackgroundColor3 = Color3.new(0, 0, 0),
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
                if props.MouseEnter then
                   props.MouseEnter() 
                end
		    end,
            [OnEvent "MouseLeave"] = function()
                Hovering:set(false)
                Pressed:set(false)
                if props.MouseLeave then
                   props.MouseLeave() 
                end
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
                MouseHolding:set(true)
            end,

            [OnEvent "MouseButton1Up"] = function()
                Pressed:set(false)
                MouseHolding:set(false)
            end,

            [Out "AbsoluteSize"] = props.AbsSizeReturn,

            BackgroundTransparency = scope:Computed(function(use)
                local hover = use(HoverEffects)
                local background = use(props.Background)
                if background == nil then
                    background = true
                end

                if background == false then
                    if hover == true then
                        return 0.5
                    else
                        return 1
                    end
                elseif background == true then
                    return 0
                end
            end),

            [Children] = {
                Corner {},
                props.Children
            }
        }

        local highlight = Glow(scope) {
            Parent = button,
            Color = highlightTheme,
            Size = scope:Computed(function(use)
                local absoluteSize: Vector2 = button.AbsoluteSize

                if absoluteSize == nil then
                    return Vector2.new(0, 0)
                end

                local greater = if absoluteSize.Y > absoluteSize.X then absoluteSize.Y else absoluteSize.X
                    
                return Vector2.new(greater * 2, greater * 2)
            end),
            Position = scope:Computed(function(use)
                local position = use(MousePos)
                local absoluteOther = button.AbsolutePosition
                local pos = UDim2.new(0, position.X - absoluteOther.X, 0, position.Y - absoluteOther.Y)
                return pos
            end),
            Enabled = HoverEffects
        }

        Grabber.Export(canvasGroup, props)

        return canvasGroup
    end
end