--Modules
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)

--Types
type UsedAs<T> = Fusion.UsedAs<T>

return function<T>(condition: UsedAs<boolean>, value: UsedAs<T>): (Fusion.Use, Fusion.Scope<any>) -> (T?)
    return function(use)
        local condition = use(condition)
        local value = use(value)

        if condition == true then
            return value
        end
    end
end