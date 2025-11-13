local Fusion = require(script.Parent.Parent.Parent.fusion)
local OklabConverter = require(script.Parent.OklabConverter)

--Types
export type ThemeColor = "Main" | "ButtonText"

local Theme = {}

local Scope = Fusion.scoped(Fusion)

local CurrentTheme = Scope:Value()

local function SetTheme(ThemeColors)
    CurrentTheme:set(ThemeColors)
end

function Theme.SetAcent(Accent: Fusion.UsedAs<number>)
    --TODO: This does need to have a light theme.

    local observer = Scope:Observer(Accent)

    observer:onBind(function()
        local AccentHue = Fusion.peek(Accent)

        local colors = {
        Primary = OklabConverter.OklchToRGB({L = .75, C = .12, H = AccentHue}),
        Success = Color3.fromRGB(39, 201, 101),
        Error = Color3.fromRGB(224, 85, 85),
        Warning = Color3.fromRGB(231, 203, 76),

        Background = Color3.fromRGB(15, 15, 21),
        CardBackground = Color3.fromRGB(21, 21, 27),
        InnerCardBackground = Color3.fromRGB(30, 30, 36), --Basicly so you can have cards inside cards.

        MainText = Color3.new(.95, .95, .95),
        TextSecondary = Color3.new(.5, .5, .5),

        SwitchShade = Color3.new(0.35, 0.35, 0.35),

        --Buttons
        PrimaryButtonHighlight = OklabConverter.OklchToRGB({L = .8, C = .1, H = AccentHue}),
        PrimaryButtonPress = OklabConverter.OklchToRGB({L = .36, C = .06, H = AccentHue}),
        PrimaryButtonGlow = Color3.new(1, 1, 1),
        PrimaryContent = Color3.new(1, 1, 1),
        
        
        SecondaryButton = Color3.fromRGB(37, 37, 37),
        SecondaryButtonHighlight = Color3.fromRGB(45, 45, 45),
        SecondaryButtonPress = OklabConverter.OklchToRGB({L = .5, C = .06, H = AccentHue}),
        SecondaryButtonGlow = Color3.new(0.486274, 0.486274, 0.486274),
        SecondaryContent = Color3.new(1, 1, 1),
    }

    SetTheme(colors)
    end)
end

function Theme:GetTheme(ThemeColor: ThemeColor)
    return Fusion.Computed(Scope, function(use, scope)
        return use(CurrentTheme)[ThemeColor]
    end)
end

return Theme