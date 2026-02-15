local Interaction = script.Interaction
local Layout = script.Layout
local Content = script.Content
local Plugin = script.Plugin

local Theme = require(script.Utils.Theme)

local components = {
    --Interaction - Components that take some sort of input from the user.
    BaseButton = require(Interaction.BaseButton),
    TextButton = require(Interaction.TextButton),
    IconButton = require(Interaction.IconButton),
    TextBox = require(Interaction.TextBox),
    Toggle = require(Interaction.Toggle),
    SegmentedControl = require(Interaction.SegmentedControl),
    SegmentedControlItem = require(Interaction.SegmentedControlItem),

    --Layout - Components that define the layout of a UI.
    Frame = require(Layout.Frame),
    Padding = require(Layout.Padding),
    Scroller = require(Layout.Scroller),

    --Content - Components that define the content of a UI.
    Text = require(Content.Text),
    Paragraph = require(Content.Paragraph),
    Header = require(Content.Header),
    ImageIcon = require(Content.ImageIcon),
    Tooltip = require(Content.Tooltip),

    --Plugin - Components that are intended for use specificly within plugins.
    VerticalView = require(Plugin.VerticalPlugin),

    Methods = {
        Grab = require(script.Utils.Grabber).Grab
    },

    SetAcent = Theme.SetAcent
}

return components