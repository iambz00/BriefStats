local addonName, shareTable = ...
local Addon = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
Addon.name = addonName
--Addon.version = GetAddOnMetadata(Addon.name, "Version")
Addon.version = "2.1.1"
_G[Addon.name] = Addon
local L = LibStub("AceLocale-3.0"):GetLocale(Addon.name, true)
local class, engClass = UnitClass("player")
--local GS = shareTable.gs

local LibGearScore = LibStub("LibGearScore.1000", true)

local dbDefault = {
    profile = {
        l_AnchorFrame = "PlayerStatFrameLeftDropDown",
        l_AnchorFrameAnchor = "TOPLEFT",
        l_Anchor = "BOTTOMLEFT",
        l_OffsetX = 20,
        l_OffsetY = 4,
        l_String = L["DEFAULT_L_STRING_"..engClass],
        r_AnchorFrame = "PlayerStatFrameRightDropDown",
        r_AnchorFrameAnchor = "TOPRIGHT",
        r_Anchor = "BOTTOMRIGHT",
        r_OffsetX = -20,
        r_OffsetY = 4,
        r_String = L["DEFAULT_R_STRING"],
    }
}

-- FrameXML/PaperDollframe.lua
local c = {
    RDC1  = function()
        local _, effectiveArmor = UnitArmor("player")
        return format("%.2f", PaperDollFrame_GetArmorReduction(effectiveArmor, UnitLevel("player")))
    end,
    RDC2  = function()
        local _, effectiveArmor = UnitArmor("player")
        return format("%.2f", PaperDollFrame_GetArmorReduction(effectiveArmor, 83))
    end,
    DMGM  = function()
        local _,_,_,_,_,_,percent = UnitDamage("player")
        return floor(percent*100+0.5)
    end,
    CRIAV = function() return format("%.2f", GetDodgeBlockParryChanceFromDefense() + GetCombatRatingBonus(CR_RESILIENCE_CRIT_TAKEN)) end,
    TRUEA = function() return format("%.2f", 5 + GetDodgeBlockParryChanceFromDefense() + GetDodgeChance() + GetParryChance()) end,
    AVOID = function() return format("%.2f", 5 + GetDodgeBlockParryChanceFromDefense() + GetDodgeChance() + GetParryChance() + GetBlockChance()) end,
    BV    = function() return GetShieldBlock() end,
    MHIT  = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_MELEE)) end,
    MCRI  = function() return format("%.2f", GetCritChance()) end,
    MHAS  = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_MELEE)) end,
    APEN  = function() return format("%.2f", GetArmorPenetration()) end,
    APENR = function() return GetCombatRating(CR_ARMOR_PENETRATION) end,
    RHIT  = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_RANGED)) end,
    RCRI  = function() return format("%.2f", GetRangedCritChance()) end,
    RHAS  = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_RANGED)) end,
    SPHO  = function() return "|cffffe57f"..GetSpellBonusDamage(2).."|r" end,
    SPFI  = function() return "|cffff7f00"..GetSpellBonusDamage(3).."|r" end,
    SPNA  = function() return "|cff4cff4c"..GetSpellBonusDamage(4).."|r" end,
    SPFR  = function() return "|cff7fffff"..GetSpellBonusDamage(5).."|r" end,
    SPSH  = function() return "|cff7f7fff"..GetSpellBonusDamage(6).."|r" end,
    SPAR  = function() return "|cffff7fff"..GetSpellBonusDamage(7).."|r" end,
    SCHO  = function() return format("|cffffe57f%.2f|r", GetSpellCritChance(2)) end,
    SCFI  = function() return format("|cffff7f00%.2f|r", GetSpellCritChance(3)) end,
    SCNA  = function() return format("|cff4cff4c%.2f|r", GetSpellCritChance(4)) end,
    SCFR  = function() return format("|cff7fffff%.2f|r", GetSpellCritChance(5)) end,
    SCSH  = function() return format("|cff7f7fff%.2f|r", GetSpellCritChance(6)) end,
    SCAR  = function() return format("|cffff7fff%.2f|r", GetSpellCritChance(7)) end,
    SHEAL = function() return GetSpellBonusHealing() end,
    SHIT  = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_SPELL)) end,
    SHAS  = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_SPELL)) end,
    SPEN  = function() return GetSpellPenetration() end,
    SPEED = function()	-- Returns best speed
        local _, run, fly = GetUnitSpeed("player")
        return (run > fly) and ceil(run/7*100) or ceil(fly/7*100)
    end,
    ILVL  = function()
        local _, gearScore = LibGearScore:GetScore("player")
        gearScore = gearScore or {}
        local ilvl = gearScore.AvgItemLevel or 0
        return format("%.1f", ilvl)
    end,
    GS    = function()
        local _, gearScore = LibGearScore:GetScore("player")
        gearScore = gearScore or {}
        local score = gearScore.GearScore or 0
        local color = gearScore.Color or CreateColor(0.8, 0.8, 0.8)
        return color:WrapTextInColorCode(score)
    end,
    [L["RDC1" ] ] = "RDC1" ,    [L["RDC2" ] ] = "RDC2" ,
    [L["DMGM" ] ] = "DMGM" ,    [L["CRIAV"] ] = "CRIAV",
    [L["TRUEA"] ] = "TRUEA",    [L["AVOID"] ] = "AVOID",    [L["BV"   ] ] = "BV"   ,
    [L["MHIT" ] ] = "MHIT" ,    [L["MCRI" ] ] = "MCRI" ,    [L["MHAS" ] ] = "MHAS" ,
    [L["APEN" ] ] = "APEN" ,    [L["APENR"] ] = "APENR",
    [L["RHIT" ] ] = "RHIT" ,    [L["RCRI" ] ] = "RCRI" ,    [L["RHAS" ] ] = "RHAS" ,
    [L["SPHO" ] ] = "SPHO" ,    [L["SPFI" ] ] = "SPFI" ,    [L["SPNA" ] ] = "SPNA" ,
    [L["SPFR" ] ] = "SPFR" ,    [L["SPSH" ] ] = "SPSH" ,    [L["SPAR" ] ] = "SPAR" ,
    [L["SCHO" ] ] = "SCHO" ,    [L["SCFI" ] ] = "SCFI" ,    [L["SCNA" ] ] = "SCNA" ,
    [L["SCFR" ] ] = "SCFR" ,    [L["SCSH" ] ] = "SCSH" ,    [L["SCAR" ] ] = "SCAR" ,
    [L["SHEAL"] ] = "SHEAL",
    [L["SHIT" ] ] = "SHIT" ,    [L["SHAS "] ] = "SHAS" ,    [L["SPEN" ] ] = "SPEN" ,
    [L["SPEED"] ] = "SPEED",    [L["ILVL" ] ] = "ILVL" ,    [L["GS"   ] ] = "GS"   ,
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

    LibGearScore:PLAYER_ENTERING_WORLD()
end

function bsPaperDollFrame_UpdateStats()
--	if Addon.oldPaperDollFrame_UpdateStats then Addon.oldPaperDollFrame_UpdateStats() end
    local l_text = Addon.db.profile.l_String or ""
    l_text = l_text:gsub("%[([^]^[]*)%]", function(s) return c(s:upper()) end)
    Addon.leftText:SetText(l_text)
    local r_text = Addon.db.profile.r_String or ""
    r_text = r_text:gsub("%[([^]^[]*)%]", function(s) return c(s:upper()) end)
    Addon.rightText:SetText(r_text)
end

function Addon:InitDB()
    self.db = LibStub("AceDB-3.0"):New(self.name.."DB", dbDefault, engClass) -- defaultProfileName: class name

    if self.db.profile.default or not self.db.global.version or self.db.global.version < "2.0.0" then
        self.db:ResetDB(engClass)
        self.db.global.version = Addon.version
    end
end

function Addon:InitUI()
    local db = self.db.profile
    local ui = CreateFrame("Frame", self.name.."LeftFrame", _G[db.l_AnchorFrame])
    ui:EnableMouse(false)
    ui:EnableMouseWheel(false)
    ui:SetWidth(200)
    ui:SetHeight(300)
    self.leftPane = ui
    local text = ui:CreateFontString()
    text:SetAllPoints()
    text:SetFontObject("GameFontNormalSmall")
    text:SetJustifyH("LEFT")
    text:SetJustifyV("BOTTOM")
    text:SetTextColor(1, 1, 1)
    text:SetText(self.name)
    self.leftText = text

    ui = CreateFrame("Frame", self.name.."RightFrame", _G[db.r_AnchorFrame])
    ui:EnableMouse(false)
    ui:EnableMouseWheel(false)
    ui:SetWidth(200)
    ui:SetHeight(200)
    self.rightPane = ui
    text = ui:CreateFontString()
    text:SetAllPoints()
    text:SetFontObject("GameFontNormalSmall")
    text:SetJustifyH("RIGHT")
    text:SetJustifyV("BOTTOM")
    text:SetTextColor(1, 1, 1)
    text:SetText(self.name)
    self.rightText = text

    local btn = CreateFrame("Button", self.name.."ConfigButton", _G[db.l_AnchorFrame], "UIPanelButtonTemplate")
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
        GameTooltip:SetOwner(btn, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:AddLine(self.name.." Options")
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    self.btn = btn

    self.leftPane:Show()
    self.rightPane:Show()
    self:RefreshUI()
end

function Addon:RefreshUI()
    local db = self.db.profile
    self.leftPane:SetParent(_G[db.l_AnchorFrame])
    self.leftPane:ClearAllPoints()
    self.leftPane:SetPoint(db.l_Anchor, db.l_AnchorFrame, db.l_AnchorFrameAnchor, db.l_OffsetX, db.l_OffsetY)
    self.btn:SetPoint(db.l_Anchor, db.l_AnchorFrame, db.l_AnchorFrameAnchor, db.l_OffsetX, db.l_OffsetY)
    self.rightPane:SetParent(_G[db.r_AnchorFrame])
    self.rightPane:ClearAllPoints()
    self.rightPane:SetPoint(db.r_Anchor, db.r_AnchorFrame, db.r_AnchorFrameAnchor, db.r_OffsetX, db.r_OffsetY)
    bsPaperDollFrame_UpdateStats()
end

function Addon:BuildOptions()
self.optionsTable = {
    name = Addon.name .. " option",
    type = 'group',
    get = function(info) return self.db.profile[info[#info]] end,
    set = function(info, value) self.db.profile[info[#info]] = value Addon:RefreshUI() end,
    args = {
        settings = {
            name = L["Display string"],
            type = "group",
            order = 11,
            args = {
                l_String = {
                    name = L["Left Pane"],
                    type = "input",
                    multiline = 8,
                    width = "double",
                    order = 101,
                },
                r_String = {
                    name = L["Right Pane"],
                    type = "input",
                    multiline = 3,
                    width = "double",
                    order = 102,
                },
                usage = {
                    name = L["Usage"],
                    type = "description",
                    order = 201,
                },

            },
        },
        anchor = {
            name = L["Position"],
            type = "group",
            order = 21,
            args = {
                l_Title = {
                    name = L["Left Pane"],
                    type = "header",
                    order = 200,
                },
                l_AnchorFrame = {
                    name = L["AnchorFrame"],
                    type = "input",
                    order = 201,
                },
                l_AnchorFramseChooser = {
                    name = L["Set AnchorFrame"],
                    type = "execute",
                    func = function() self:StartFrameChooser("l_AnchorFrame") end,
                    order = 202,
                },
                l_AnchorFrameAnchor = {
                    name = L["AnchorFrame Anchor"],
                    type = "input",
                    order = 203,
                },
                l_Anchor = {
                    name = L["Pane Anchor"],
                    type = "input",
                    order = 204,
                },
                l_OffsetX = {
                    name = L["x Offset"],
                    type = "range",
                    softMin = -200,
                    softMax = 200,
                    bigStep = 10,
                    order = 211,
                },
                l_OffsetY = {
                    name = L["y Offset"],
                    type = "range",
                    softMin = -200,
                    softMax = 200,
                    bigStep = 10,
                    order = 212,
                },
                r_Title = {
                    name = L["Right Pane"],
                    type = "header",
                    order = 300,
                },
                r_AnchorFrame = {
                    name = L["AnchorFrame"],
                    type = "input",
                    order = 301,
                },
                r_AnchorFramseChooser = {
                    name = L["Set AnchorFrame"],
                    type = "execute",
                    func = function() self:StartFrameChooser("r_AnchorFrame") end,
                    order = 302,
                },
                r_AnchorFrameAnchor = {
                    name = L["AnchorFrame Anchor"],
                    type = "input",
                    order = 303,
                },
                r_Anchor = {
                    name = L["Pane Anchor"],
                    type = "input",
                    order = 304,
                },
                r_OffsetX = {
                    name = L["x Offset"],
                    type = "range",
                    softMin = -200,
                    softMax = 200,
                    bigStep = 10,
                    order = 311,
                },
                r_OffsetY = {
                    name = L["y Offset"],
                    type = "range",
                    softMin = -200,
                    softMax = 200,
                    bigStep = 10,
                    order = 312,
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

-- idea from WeakAuras
local newFocus, oldFocus
function Addon:StartFrameChooser(option)
    local db = self.db.profile
    local oldValue = db[option]
    if not self.chooserFrame then
        self.chooserFrame = CreateFrame("frame")
        self.chooserBox = CreateFrame("frame", nil, self.chooserFrame, BackdropTemplateMixin and "BackdropTemplate")
        self.chooserBox:SetFrameStrata("TOOLTIP")
        self.chooserBox:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12,
            insets = {left = 0, right = 0, top = 0, bottom = 0}
        })
        self.chooserBox:SetBackdropBorderColor(0, 1, 0)
        self.chooserBox:Hide()
    end

    self.chooserFrame:SetScript("OnUpdate", function()
        if(IsMouseButtonDown("RightButton")) then
            self:StopFrameChooser()
            db[option] = oldValue
        elseif(IsMouseButtonDown("LeftButton") and oldFocus) then
            self:StopFrameChooser()
        else
            SetCursor("CAST_CURSOR")
            newFocus = GetMouseFocus()

            if newFocus and (newFocus ~= oldFocus) and self.chooserBox then
                self.chooserBox:ClearAllPoints()
                self.chooserBox:SetPoint("BOTTOMLEFT", newFocus, "BOTTOMLEFT", -4, -4)
                self.chooserBox:SetPoint("TOPRIGHT", newFocus, "TOPRIGHT", 4, 4)
                self.chooserBox:Show()

                db[option] = newFocus:GetName()
                LibStub("AceConfigRegistry-3.0"):NotifyChange(self.name)
                oldFocus = newFocus
            end
        end
    end)
end

function Addon:StopFrameChooser()
    if self.chooserFrame then
        self.chooserFrame:SetScript("OnUpdate", nil)
        self.chooserBox:Hide()
    end
    ResetCursor()
    LibStub("AceConfigRegistry-3.0"):NotifyChange(self.name)
    Addon:RefreshUI()
end
