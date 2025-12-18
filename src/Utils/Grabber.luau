--[[
The system that powers the Grab function.
]]

--Services
local Root = script.Parent.Parent

local Fusion = require(Root.Parent.fusion)

local Grabber = {}

local values = setmetatable({}, { __mode = "v"})

function Grabber.ConvertProps(scope: Fusion.Scope<any>, instanceSources: Instance, props: {any})
    return scope:ForValues(props, function(use, _, value)
        local value = use(value)
        
        if type(value) ~= "table" then
            return value
        end

        if value._Inner_Type == "Grab" then
            local sourceName, keyName = value.KeyName:match("([^%-]+)%-(.+)")

            local instance = instanceSources[sourceName]

            if instance == nil then
                --No instance for this source.
                return nil
            end

            local returnValue = values[instance.UniqueId]

            if not returnValue then
                --instance does not have any defined values.
                return nil
            end

            return use(returnValue[value.KeyName])
        end

        return value
    end)
end

function Grabber.Export<T>(instance: Instance, props: T): T
    values[instance.UniqueId] = props

    return props
end

function Grabber.Grab(KeyName: string)
    return {
        ["_Inner_Type"] = "Grab",
        ["KeyName"] = KeyName
    }
end

return Grabber