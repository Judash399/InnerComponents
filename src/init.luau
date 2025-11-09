local Fusion = require(script.Parent.fusion)

local Interaction = script.Interaction

local components = {
    Interaction = {
        BaseButton = require(Interaction.BaseButton),
        TextButton = require(Interaction.TextButton),
        IconButton = require(Interaction.IconButton),
    }
}

return components