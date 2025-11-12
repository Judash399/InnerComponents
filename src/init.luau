local Fusion = require(script.Parent.fusion)

local Interaction = script.Interaction
local Layout = script.Layout
local Content = script.Content

local Theme = require(script.Utils.Theme)

local components = {
    Interaction = {
        BaseButton = require(Interaction.BaseButton),
        TextButton = require(Interaction.TextButton),
        IconButton = require(Interaction.IconButton),
        TextBox = require(Interaction.TextBox),
    },

    Layout = {
        Frame = require(Layout.Frame),
        Padding = require(Layout.Padding)
    },

    Content = {
        Text = require(Content.Text),
        ImageIcon = require(Content.ImageIcon),
    },

    SetAcent = Theme.SetAcent
}

return components