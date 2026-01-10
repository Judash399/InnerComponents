--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Dependencys).Fusion

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function<T, Y>(value: UsedAs<T>, otherwise: UsedAs<Y>): (Fusion.Use, Fusion.Scope<any>) -> (T | Y)
    return function(use)
        local value = use(value)
        local otherwise = use(otherwise)

        if value ~= nil then
            return use(value)
        else
            return use(otherwise)
        end
    end
end