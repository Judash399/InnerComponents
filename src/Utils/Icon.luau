--Modules
local Lucide = require(script.Parent.Parent.Parent["lucide-icons"])

local module = {}

local specialIcons = {}

local function normalizeAssetId(input)
    local s = tostring(input)

    s = s:gsub("^rbxassetid://", "")
    s = s:gsub("^http[s]?://www%.roblox%.com/asset/[?]?id=", "")

    s = s:match("%d+")

    return s or nil
end

function module.GetIcon(IconName: string, resolution: number?)

    --Looks weird but exists for custom warning and fallback icon.

    local success, value = pcall(function()
        return Lucide.GetAsset(IconName, resolution)
    end)

    if success == true then
        return value
    end

    local custom = specialIcons[IconName]

    if custom ~= nil then
        return custom
    end
end

function module.DefineIcon(Name: string, ImageID: string | number, Resolution: Vector2?)

    local id = normalizeAssetId(ImageID)

    if id == nil then
        warn("[InnerComponents]: Given assetID is inncorect.")
        return
    end

    local url = "rbxassetid://" .. id

    local success = pcall(function()
        return module.GetIcon(Name)
    end)

    if not success then
        warn("[InnerComponents]: Attempt to define a custom icon that is already defined! Check lucide.dev for pre-defined icons.")
        return
    end

    specialIcons[Name] = {
        IconName = Name,
        Id = id,
        Url = url,
        ImageRectSize = Resolution,
        ImageRectOffset = Vector2.new(0, 0),
    }
end

return module