local Fusion = require(script.Parent.fusion)

local Interaction = script.Interaction
local Layout = script.Layout
local Content = script.Content
local Plugin = script.Plugin

local Theme = require(script.Utils.Theme)

local components = {
    --Components that take some sort of input from the user.
    Interaction = {
        BaseButton = require(Interaction.BaseButton),
        TextButton = require(Interaction.TextButton),
        IconButton = require(Interaction.IconButton),
        TextBox = require(Interaction.TextBox),
        Toggle = require(Interaction.Toggle),
    },

    --Components that define the layout of a UI.
    Layout = {
        Frame = require(Layout.Frame),
        Padding = require(Layout.Padding),
        Scroller = require(Layout.Scroller)
    },

    --Components that define the content of a UI.
    Content = {
        Text = require(Content.Text),
        ImageIcon = require(Content.ImageIcon),
    },

    --Components that are intended for use specificly within plugins.
    Plugin = {
        VerticalView = require(Plugin.VerticalPlugin),
    },

    SetAcent = Theme.SetAcent
}

return components