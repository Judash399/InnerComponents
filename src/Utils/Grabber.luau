--[[
The system that powers the Grab function.
]]

--Services
local Root = script.Parent.Parent

local Fusion = require(Root.Dependencys).Fusion

local Grabber = {}

local values = setmetatable({}, { __mode = "v"})

function Grabber.ConvertProps<T>(scope: Fusion.Scope<any>, instanceSources: Instance, props: T): T
    --This function May look weird because "It isnt reactive" but its completely fine.
    --Normally in 99.9% of cases new keys shouldnt be added, and most components normally dont handle that anyway.
    --Whenever keys are "added" usually the key is just a stateObject thats equal to nil, which is still something.
    --So this is completely fine, because each key is a reactive state object.

    local newProps = {}
    
    for key, value in pairs(props) do
        newProps[key] = scope:Computed(function(use)
            local value = use(value)
        
            if type(value) ~= "table" then
                return value
            end

            if value._Inner_Type == "Grab" then
                local sourceName, keyName = value.KeyName:match("([^%-]+)%-(.+)")

                local instance = use(instanceSources[sourceName])

                if instance == nil then
                    --No instance for this source.
                    return nil
                end

                local returnValue = values[instance]

                if not returnValue then
                    --instance does not have any defined values.
                    return nil
                end

                return use(returnValue[value.KeyName])
            end

            return value
        end)
    end

    return newProps
end

function Grabber.Export<T>(instance: Instance, props: T): T
    values[instance] = props

    return props
end

function Grabber.Grab(KeyName: string)
    return {
        ["_Inner_Type"] = "Grab",
        ["KeyName"] = KeyName
    }
end

return Grabber