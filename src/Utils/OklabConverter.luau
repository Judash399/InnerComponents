local module = {}

local function srgb_to_linear(c)
    if c <= 0.04045 then
        return c / 12.92
    else
        return ((c + 0.055) / 1.055) ^ 2.4
    end
end

function module.To_Oklab(RGB: Color3): {L: number, A: number, B: number}
    local r = srgb_to_linear(RGB.R)
    local g = srgb_to_linear(RGB.G)
    local b = srgb_to_linear(RGB.B)

    local l = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
    local m = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
    local s = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b

    local l_ = l^(1/3)
    local m_ = m^(1/3)
    local s_ = s^(1/3)

    return {
        L = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
        A = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
        B = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_,
    }
end


local function linear_to_srgb(c)
    if c <= 0.0031308 then
        return 12.92 * c
    else
        return 1.055 * c^(1/2.4) - 0.055
    end
end



function module.To_RGB(Oklab)
    local l_ = Oklab.L + 0.3963377774 * Oklab.A + 0.2158037573 * Oklab.B
    local m_ = Oklab.L - 0.1055613458 * Oklab.A - 0.0638541728 * Oklab.B
    local s_ = Oklab.L - 0.0894841775 * Oklab.A - 1.2914855480 * Oklab.B

    local l = l_^3
    local m = m_^3
    local s = s_^3

    local r = 4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s
    local g = -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s
    local b = -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s

    r = math.clamp(linear_to_srgb(r), 0, 1)
    g = math.clamp(linear_to_srgb(g), 0, 1)
    b = math.clamp(linear_to_srgb(b), 0, 1)

    return Color3.new(r, g, b)
end

function module.OklabToOklch(Oklab)
    local C = math.sqrt(Oklab.A^2 + Oklab.B^2)
    local h = math.deg(math.atan2(Oklab.B, Oklab.A)) % 360
    return { L = Oklab.L, C = C, H = h }
end

function module.OklchToOklab(Oklch)
    local rad = math.rad(Oklch.H)
    local A = Oklch.C * math.cos(rad)
    local B = Oklch.C * math.sin(rad)
    return { L = Oklch.L, A = A, B = B }
end

-- Optional: direct Color3 ↔ Oklch
function module.To_Oklch(RGB: Color3)
    local lab = module.To_Oklab(RGB)
    return module.OklabToOklch(lab)
end

function module.OklchToRGB(Oklch)
    local lab = module.OklchToOklab(Oklch)
    return module.To_RGB(lab)
end

return module