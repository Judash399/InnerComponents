local TextService = game:GetService("TextService")
local Root = script.Parent.Parent
local Fusion = require(Root.Parent.fusion)
local Theme = require(Root.Utils.Theme)

local Children, OnEvent, peek, Out, OnChange = Fusion.Children, Fusion.OnEvent, Fusion.peek, Fusion.Out, Fusion.OnChange

return function(scope: Fusion.Scope<any>)
    return function(props: {
        Parent: Instance,
    })
        local scope = scope:innerScope()

        local Corner = require(Root.Primitives.Corner)(scope)
        local Padding = require(Root.Layout.Padding)(scope)

        local enabled = scope:Value(false)


        return scope:New "TextButton" {
            Size = UDim2.new(0, 50, 0, 35),
            Parent = props.Parent,
            BackgroundTransparency = .5,

            [Children] = {
                scope:New "Frame" {
                    Position = UDim2.new(.5, 0, .5, 0),
                    AnchorPoint = Vector2.new(.5, .5),
                    Size = UDim2.new(0, 35, 0, 19),

                    [Children] = {
                        Corner {Level = 0.9523809524},
                        Padding {Amount = UDim.new(0, 2.5)},
                        scope:New "Frame" {
                            Position = UDim2.new(0, 0, 0, 0),
                            AnchorPoint = Vector2.new(0, 0),
                            Size = UDim2.new(0, 15, 0, 15),
                            BackgroundColor3 = Color3.new(),

                            [Children] = {
                                Corner {Level = .7},
                            }
                        }
                    }
                }
            }
        }
    end
end