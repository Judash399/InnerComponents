local Fusion = require(script.Parent.fusion)

local Interaction = script.Interaction
local Layout = script.Layout

local components = {
    Interaction = {
        BaseButton = require(Interaction.BaseButton),
        TextButton = require(Interaction.TextButton),
        IconButton = require(Interaction.IconButton),
    },

    Layout = {
        Frame = require(Layout.Frame),
        Padding = require(Layout.Padding)
    }
}

return components