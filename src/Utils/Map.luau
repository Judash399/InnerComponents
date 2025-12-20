--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function<V, T>(value: V, map: { [V]: T }): (Fusion.Use) -> T
    return function(use)
        local v = use(value)
        return use(map[v])
    end
end