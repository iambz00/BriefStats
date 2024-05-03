local addonName, shareTable = ...
local Addon = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
Addon.name = addonName
--Addon.version = GetAddOnMetadata(Addon.name, "Version")
Addon.version = "2.2.0"
_G[Addon.name] = Addon
local L = LibStub("AceLocale-3.0"):GetLocale(Addon.name, true)
local class, engClass = UnitClass("player")

local LibGearScore = LibStub("LibGearScore.1000", true)

--[[    TOPLEFT         TOPRIGHT
        [Pane1]         [Pane2]

            Character Frame

        [Pane3]         [Pane4]
        BOTTOMLEFT      BOTTOMRIGHT
]]
local dbDefault = {
    profile = {
        pane = {
            [1] = {
                anchorFrame = "CharacterModelScene",
                anchorFrameAnchor = "TOPLEFT",
                anchor = "TOPLEFT",
                justfyV = "TOP", justfyH = "LEFT",
                offsetX = 20,
                offsetY = -30,
                str = "",
            },
            [2] = {
                anchorFrame = "CharacterModelScene",
                anchorFrameAnchor = "TOPRIGHT",
                anchor = "TOPRIGHT",
                justfyV = "TOP", justfyH = "RIGHT",
                offsetX = -20,
                offsetY = -30,
                str = "",
            },
            [3] = {
                anchorFrame = "CharacterModelScene",
                anchorFrameAnchor = "BOTTOMLEFT",
                anchor = "BOTTOMRIGHT",
                justfyV = "BOTTOM", justfyH = "LEFT",
                offsetX = 20,
                offsetY = 30,
                str = L["DEFAULT_L_STRING_"..engClass],
            },
            [4] = {
                anchorFrame = "CharacterModelScene",
                anchorFrameAnchor = "BOTTOMRIGHT",
                anchor = "BOTTOMRIGHT",
                justfyV = "BOTTOM", justfyH = "RIGHT",
                offsetX = -20,
                offsetY = 30,
                str = L["DEFAULT_R_STRING"],
            },
        }
    }
}

local function _GetGearScore()
    local _, gearScore = LibGearScore:GetScore("player")
    gearScore = gearScore or { AvgItemLevel = 0, GearScore = 0 }
    if gearScore.GearScore == 0 then
        LibGearScore:PLAYER_ENTERING_WORLD()
        _, gearScore = LibGearScore:GetScore("player")
    end
    return gearScore
end

local normalize_base = {
    ["ARMOR"]       = "ARMOR",
    ["REDUCTION"]   = "REDUCE",
    ["BOSS"]        = "BOSS",
    ["DAMAGE"]      = "DMG",
    ["AVOIDANCE"]   = "AVOID",
    ["MITIGATION"]  = "MIT",
    ["DODGE"]       = "DODGE",
    ["PARRY"]       = "PARRY",
    ["BLOCK"]       = "BLOCK",
    ["RESLIENCE"]   = "RES",
    ["MELEE"]       = "M",
    ["RANGED"]      = "R",
    ["ATTACKPOWER"] = "AP"
    ["SPELL"]       = "S",
    ["HOLY"]        = "HOLY",
    ["FIRE"]        = "FIRE",
    ["NATURE"]      = "NATURE",
    ["FROST"]       = "FROST",
    ["SHADOW"]      = "SHADOW",
    ["ARCANE"]      = "ARCANE",
    ["HEAL"]        = "HEAL",
    ["CRITICAL"]    = "CRIT",
    ["HASTE"]       = "HAS",
    ["MASTERY"]     = "MAS",
    ["PENETRATION"] = "PEN",
    ["MASTERY"]     = "MAS",
    ["RATING"]      = "R",
    ["ITEMLEVEL"]   = "ILVL",
    ["GEARSCORE"]   = "GS",
    ["SPEED"]       = "SPEED"
}
local normal_word = { }
-- Expand table to words
for k, v in pairs(normalize_base) do
    local word = L[k]
    if type(word) == "table" then
        for _, w in pairs(word) do
            normal_word[w] = v
        end
    else
        normal_word[word] = v
    end
end

local c = {
    ARMOR = function() return UnitArmor("player") end,
    REDUCE = function()
        local _, effectiveArmor = UnitArmor("player")
        return format("%.2f", PaperDollFrame_GetArmorReduction(effectiveArmor, UnitLevel("player")))
    end,
    BOSSREDUCE = function()
        local _, effectiveArmor = UnitArmor("player")
        return format("%.2f", PaperDollFrame_GetArmorReduction(effectiveArmor, 88))
    end,
    DMG  = function()
        local _,_,_,_,_,_,percent = UnitDamage("player")
        return floor(percent*100+0.5)
    end,
    AVOID = function() return format("%.2f", BASE_MISS_CHANCE_PHYSICAL[0] + GetDodgeChance() + GetParryChance()) end,
    MIT   = function() return format("%.2f", BASE_MISS_CHANCE_PHYSICAL[0] + GetDodgeChance() + GetParryChance() + GetBlockChance()) end,
    DODGE = function() return format("%.2f", GetDodgeChance()) end,
    PARRY = function() return format("%.2f", GetParryChance()) end,
    BLOCK = function() return format("%.2f", GetBlockChance()) end,
    RES   = function() return format("%.2f", GetCombatRatingBonus(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)) end,
    RESR  = function() return format("%.2f", GetCombatRating(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)) end,
    MAP   = function()  -- Melee AP
        local base, posBuff, negBuff = UnitAttackPower("player")
        ap = base + posBuff + negBuff
        return (ap > 0) and ap or 0
    end,
    RAP   = function()  -- Ranged AP
        local base, posBuff, negBuff = UnitRangedAttackPower("player")
        ap = base + posBuff + negBuff
        return (ap > 0) and ap or 0
    end,
    MHIT  = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_MELEE)) end,
    MHITR = function() return format("%d", GetCombatRating(CR_HIT_MELEE)) end,
    MCRIT = function() return format("%.2f", GetCritChance()) end,
    MHAS  = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_MELEE)) end,
    MHASR = function() return format("%d", GetCombatRating(CR_HASTE_MELEE)) end,
    RHIT  = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_RANGED)) end,
    RHITR = function() return format("%d", GetCombatRating(CR_HIT_RANGED)) end,
    RCRIT = function() return format("%.2f", GetRangedCritChance()) end,
    RHAS  = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_RANGED)) end,
    RHASR = function() return format("%d", GetCombatRating(CR_HASTE_RANGED)) end,
    HOLY   = function() return "|cffffe57f"..GetSpellBonusDamage(2).."|r" end,
    FIRE   = function() return "|cffff7f00"..GetSpellBonusDamage(3).."|r" end,
    NATURE = function() return "|cff4cff4c"..GetSpellBonusDamage(4).."|r" end,
    FROST  = function() return "|cff7fffff"..GetSpellBonusDamage(5).."|r" end,
    SHADOW = function() return "|cff7f7fff"..GetSpellBonusDamage(6).."|r" end,
    ARCANE = function() return "|cffff7fff"..GetSpellBonusDamage(7).."|r" end,
    HOLYCRIT   = function() return format("|cffffe57f%.2f|r", GetSpellCritChance(2)) end,
    FIRECRIT   = function() return format("|cffff7f00%.2f|r", GetSpellCritChance(3)) end,
    NATURECRIT = function() return format("|cff4cff4c%.2f|r", GetSpellCritChance(4)) end,
    FROSTCRIT  = function() return format("|cff7fffff%.2f|r", GetSpellCritChance(5)) end,
    SHADOWCRIT = function() return format("|cff7f7fff%.2f|r", GetSpellCritChance(6)) end,
    ARCANECRIT = function() return format("|cffff7fff%.2f|r", GetSpellCritChance(7)) end,
    SHEAL = "HEAL",
    HEAL  = function() return GetSpellBonusHealing() end,
    SHIT  = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_SPELL)) end,
    SHITR = function() return format("%d", GetCombatRating(CR_HIT_SPELL)) end,
    SHAS  = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_SPELL)) end,
    SHASR = function() return format("%d", GetCombatRating(CR_HASTE_SPELL)) end,
    SPEN  = function() return GetSpellPenetration() end,
    MAS   = function() return GetCombatRatingBonus(CR_MASTERY) end,
    MASR  = function() return GetCombatRating(CR_MASTERY) end,
    SPEED = function()	-- Returns current speed
        return ceil(GetUnitSpeed("player") / BASE_MOVEMENT_SPEED * 100)
    end,
    ILVL  = function()
        local gearScore = _GetGearScore() or {}
        local ilvl = gearScore.AvgItemLevel or 0
        return format("%.1f", ilvl)
    end,
    GS    = function()
        local gearScore = _GetGearScore() or {}
        local score = gearScore.GearScore or 0
        local color = gearScore.Color or CreateColor(0.8, 0.8, 0.8)
        return color:WrapTextInColorCode(score)
    end,
}
for k, v in pairs(shareTable[GetLocale()] or {}) do
    c[k] = c[v] -- or v
end
local _mt = {
    __call = function(t, k)
        local v = t[k]
        if v then
            if type(v) == "function" then
                return v()
            else
                return t(v)
            end
        else
            return k
        end
    end
}
setmetatable(c, _mt)

function Addon:OnInitialize()
    self.c = c
    self:InitDB()
    self:InitUI()

    self:BuildOptions()
    self.optionsTable.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable(self.name, self.optionsTable)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(self.name, self.name, nil)

    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshUI")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshUI")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshUI")

    hooksecurefunc("PaperDollFrame_UpdateStats", bsPaperDollFrame_UpdateStats)
end

local function normalize(str)
    local s = str:gsub("[^%w]", ""):upper()
    for k, v in pairs(normal_word) do
        s = s:gsub(k, v)
    end
end

function bsPaperDollFrame_UpdateStats()
    for i, pane in ipairs(Addon.pane) do
        local text = Addon.db.profile.pane[i].str or ""
        text = test:gsub("%[([^]^[]*)%]", function(s) return c(normalize(s)) end)
        pane.text:SetText(text)
    end
end

function Addon:InitDB()
    self.db = LibStub("AceDB-3.0"):New(self.name.."DB", dbDefault, engClass) -- defaultProfileName: class name

    if self.db.profile.default or not self.db.global.version or self.db.global.version < "2.2" then
        self.db:ResetDB()
        self.db.global.version = Addon.version
    end
end

function Addon:InitUI()
    local db = self.db.profile
    self.pane = { }
    for i, pane in ipairs(db.pane) do
        local ui = CreateFrame("Frame", self.name.."Pane"..i, _G[pane.anchorFrame])
        ui:EnableMouse(false)
        ui:EnableMouseWheel(false)
        ui:SetWidth(200)
        ui:SetHeight(300)
        local text = ui:CreateFontString()
        text:SetAllPoints()
        text:SetFontObject("GameFontNormalSmall")
        text:SetJustifyH("LEFT")
        text:SetJustifyV("BOTTOM")
        text:SetTextColor(1, 1, 1)
        text:SetText(self.name)
        ui.text = text
        self.pane[i] = ui
    end

    -- Config Button is at Pane 1(Top Left), a Small Red Button
    local btn = CreateFrame("Button", self.name.."ConfigButton", _G[self.pane[1].anchorFrame], "UIPanelButtonTemplate")
    btn:EnableMouse(true)
    btn:SetWidth(18)
    btn:SetHeight(12)
    btn:SetScript("OnClick", function()
        if self.config then
            LibStub("AceConfigDialog-3.0"):Close(self.name)
            self.config = nil
        else
            LibStub("AceConfigDialog-3.0"):Open(self.name)
            self.config = true
        end
    end)
    btn:SetScript("OnEnter", function()
        GameTooltip:Hide()
        GameTooltip:SetOwner(btn, "ANCHOR_TOPRIGHT")
        GameTooltip:AddLine(self.name.." Options")
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    self.configButton = btn

    for _, pane in ipairs(self.pane) do
        pane:Show()
    end
    self:RefreshUI()
end

function Addon:RefreshUI()
    local db = self.db.profile
    for i, pane in ipairs(self.pane) do
        local pdb = db.pane[i]
        pane:SetParent(_G[pdb.anchorFrame])
        pane:ClearAllPoints()
        pane:SetPoint(pdb.anchor, pdb.anchorFrame, pdb.anchorFrameAnchor, pdb.offsetX, pdb.offsetY)
    end
    local p1db = db.pane[1]
    self.configButton:SetPoint(p1db.anchor, p1db.anchorFrame, p1db.anchorFrameAnchor, p1db.offsetX, p1db.offsetY)
    bsPaperDollFrame_UpdateStats()
end

function Addon:BuildOptions()
self.optionsTable = {
    name = Addon.name .. " option",
    type = 'group',
    get = function(info) return self.db.profile[info[#info]] end,
    set = function(info, value) self.db.profile[info[#info]] = value Addon:RefreshUI() end,
    args = {
        pane1 = {
            name = L["Pane 1(Top Left)"],
            type = "group",
            order = 11,
            get = function(info)
                local num = tonumber(info:sub(info:len()))
                info = info:sub(1, info:len()-1)
                return self.db.profile.pane[num][info]
            end,
            set = function(info, value)
                local num = tonumber(info:sub(info:len()))
                info = info:sub(1, info:len()-1)
                self.db.profile.pane[num][info] = value
            end,
            args = {
                offsetX1 = {
                    name = L["x Offset"],
                    type = "range", softMin = -200, softMax = 200, bigStep = 10,
                    order = 211,
                },
                offsetY1 = {
                    name = L["y Offset"],
                    type = "range", softMin = -200, softMax = 200, bigStep = 10,
                    order = 212,
                },
                str1 = {
                    type = "input", multiline = 5, width = "double",
                    order = 101,
                },
                usage = {
                    name = L["Usage"],
                    type = "description",
                    order = 201,
                },
            },
        },
        profiles = {
            name = "profiles",
            type = "group",
            args = {
            }
        },
    },
}
end

