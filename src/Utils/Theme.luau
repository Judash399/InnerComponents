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
ButtonText = Color3.new(1, 1, 1),
})

return Theme