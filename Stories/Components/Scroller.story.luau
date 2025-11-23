--!nocheck

--Services

local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local InnerComponents = require(Packages.InnerComponents)

local controls = {
    hue = 0,
}

local story = {
    fusion = Fusion,
    controls = controls,

    story = function(props)
        
        InnerComponents.SetAcent(props.controls.hue)

        InnerComponents.Layout.Frame(props.scope) {
            Size = UDim2.new(0, 200, 0, 300),
            Parent = props.target,
            Children = {
                InnerComponents.Layout.Scroller(props.scope) {
                    
                }
            }
        }

    end
}

return story