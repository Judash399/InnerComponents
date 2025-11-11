local Fusion = require(script.Parent.Parent.Parent.fusion)

--Types
export type ThemeColor = "Main" | "ButtonText"

local Theme = {}

local Scope = Fusion.scoped(Fusion)

local CurrentTheme = Scope:Value({

})

function Theme:ChangeTheme(Theme)
    CurrentTheme:set(Theme)
end

function Theme:GetTheme(ThemeColor: ThemeColor)
    return Fusion.Computed(Scope, function(use, scope)
        return use(CurrentTheme)[ThemeColor]
    end)

end

Theme:ChangeTheme({
Main = Color3.new(1, 0, 0),

--Button Colors
ButtonText = Color3.new(1, 1, 1),
ButtonIcon = Color3.new(1, 1, 1),
Button = Color3.new(0.223529, 0.592156, 0.803921),
ButtonOutline = Color3.new(0.294117, 0.643137, 0.843137),

Outline = Color3.new(.9, .9, .9),

--Hierarchy
Frame = Color3.new(0.141176, 0.141176, 0.176470),

--Content
Text = Color3.new(1, 1, 1),
})

return Theme