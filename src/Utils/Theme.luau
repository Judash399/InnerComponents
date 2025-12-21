--Modules
local Fusion = require(script.Parent.Parent.Parent.fusion)
local OklabConverter = require(script.Parent.OklabConverter)

--Refrences
local Studio = settings().Studio:: Studio

--Types
export type ThemeColor = "Main" | "ButtonText"

export type Theme = ThemeColor | Enum.StudioStyleGuideColor

local Theme = {}

local Scope = Fusion.scoped(Fusion)

local CurrentTheme = Scope:Value()
local light

local function SetTheme(ThemeColors)
    CurrentTheme:set(ThemeColors)
end

function Theme.SetAcent(Accent: Fusion.UsedAs<number>)
    --TODO: This does need to have a light theme.

    local observer = Scope:Observer(Accent)

    local theme = Scope:Value(Studio.Theme)
    Studio.ThemeChanged:Connect(function()
        theme:set(Studio.Theme)
    end)

    light = Scope:Computed(function(use)
        local theme: StudioTheme = use(theme)

        local backgroundColor = theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)

        local light = (backgroundColor.R + backgroundColor.G + backgroundColor.B) / 3 > .5

        return light
    end)

    CurrentTheme = Scope:Computed(function(use)
        local AccentHue = use(Accent)
        local theme: StudioTheme = use(theme)

        
        local colors = {
            Primary = OklabConverter.OklchToRGB({ L = if light then .7 else .75, C = .12, H = AccentHue}),
            Success = theme:GetColor(Enum.StudioStyleGuideColor.InfoText),
            Error = theme:GetColor(Enum.StudioStyleGuideColor.ErrorText),
            Warning = theme:GetColor(Enum.StudioStyleGuideColor.WarningText),

            Background = theme:GetColor(Enum.StudioStyleGuideColor.MainBackground),
            CardBackground = theme:GetColor(Enum.StudioStyleGuideColor.Item),
            InnerCardBackground = theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground), --Basicly so you can have cards inside cards.

            MainText = theme:GetColor(Enum.StudioStyleGuideColor.MainText),
            TextSecondary = theme:GetColor(Enum.StudioStyleGuideColor.SubText),

            SwitchShade = theme:GetColor(Enum.StudioStyleGuideColor.Dark),

            --Buttons
            PrimaryButtonHighlight = OklabConverter.OklchToRGB({L = if light then .75 else .8, C = .1, H = AccentHue}),
            PrimaryButtonPress = OklabConverter.OklchToRGB({L = if light then .6 else .65, C = .1, H = AccentHue}),
            PrimaryButtonGlow = Color3.new(1, 1, 1),
            PrimaryContent = Color3.new(1, 1, 1),
            
            
            SecondaryButton = theme:GetColor(if light then Enum.StudioStyleGuideColor.Button else Enum.StudioStyleGuideColor.Midlight),
            SecondaryButtonHighlight = theme:GetColor(if light then Enum.StudioStyleGuideColor.Dark else Enum.StudioStyleGuideColor.Light),
            SecondaryButtonPress = theme:GetColor(if light then Enum.StudioStyleGuideColor.Button else Enum.StudioStyleGuideColor.Dark),
            SecondaryButtonGlow = if light then Color3.new(0, 0, 0) else Color3.new(1, 1, 1),
            SecondaryContent = theme:GetColor(Enum.StudioStyleGuideColor.ButtonText),

            Tooltip =  theme:GetColor(Enum.StudioStyleGuideColor.Tooltip)
        }

        return colors
    end)
end

function Theme:IsLight()
    return light
end

function Theme:GetTheme(ThemeColor: ThemeColor | Enum.StudioStyleGuideColor)
    return Fusion.Computed(Scope, function(use, scope)
        local currentTheme = use(CurrentTheme)
        if typeof(ThemeColor) == "EnumItem" then
            return Studio.Theme:GetColor(ThemeColor)
        else
            return currentTheme[ThemeColor]
        end
    end)
end

return Theme