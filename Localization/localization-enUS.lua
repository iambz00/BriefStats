local addonName, shareTable = ...

local L = LibStub('AceLocale-3.0'):NewLocale(addonName, "enUS", true)
if not L then return end

L["Display string"] = true
L["Left Pane"] = true
L["Right Pane"] = true
L["Position"] = true
L["AnchorFrame"] = true
L["Set AnchorFrame"] = true
L["AnchorFrame Anchor"] = true
L["Pane Anchor"] = true
L["x Offset"] = true
L["y Offset"] = true

L["Usage"] =
[[Keywords (Case insensitive, Ignore white space)
[GS] [GearScore]  [ILVL] [ItemLevel]
[Mastery] [Mastery Rating] [Mastery R] (R = Rating)
[Damage] |cffccccccDamage Mod %|r
[Reduction] [Boss Reduction] |cffccccccReduction from Armor(Same / Boss)|r
[Armor] [Dodge] [Parry] [Block]
[Avoidance] |cffccccccMiss+Parry+Dodge|r  [Mitigation] |cffccccccM+D+P+Block|r
[Melee/Ranged Hit/Crit/Haste/AP/AttackPower]
[Melee/Ranged Hit/Crit/Haste Rating]
[Spell Hit/Haste/Pen/Penetration] [Spell Hit/Haste Rating] [Heal]
|cffffe57f[Holy] [Holy Crit]|r    |cffff7f00[Fire] [Fire Crit]|r      |cff4cff4c[Nature] [Nature Crit]|r
|cff7fffff[Frost] [Frost Crit]|r  |cff7f7fff[Shadow] [Shadow Crit]|r  |cffff7fff[Arcane] [Arcane Crit]|r
[Speed] |cffccccccMovement Speed|r]]

L["ARMOR"]      = true
L["REDUCTION"]  = { "REDUCTION", "REDUCE" }
L["BOSS"]       = true
L["DAMAGE"]     = true
L["AVOIDANCE"]  = { "TRUEAVOIDANCE", "AVOIDANCE" }
L["MITIGATION"] = { "TOTALMITIGATION", "MITIGATION" }
L["DODGE"]      = true
L["PARRY"]      = true
L["BLOCK"]      = true
L["RESLIENCE"]  = true
L["MELEE"]      = true
L["RANGED"]     = true
L["ATTACKPOWER"]= { "ATTACKPOWER", "AP" }
L["SPELL"]      = true
L["HOLY"]       = true
L["FIRE"]       = true
L["NATURE"]     = true
L["FROST"]      = true
L["SHADOW"]     = true
L["ARCANE"]     = true
L["HEAL"]       = true
L["HIT"]        = true
L["CRITICAL"]   = { "CRITICAL", "CRIT" }
L["HASTE"]      = true
L["MASTERY"]    = true
L["PENETRATION"]= { "PENETRATION", "PEN" }
L["RATING"]     = true
L["ITEMLEVEL"]  = { "ITEMLEVEL", "ILVL" }
L["GEARSCORE"]  = { "GEARSCORE", "GS" }
L["SPEED"]      = true

L["DEFAULT_L_STRING_WARRIOR"] =
[[Hit [Melee Hit]% [Melee Hit Rating]
Crit [Melee Crit]%
Haste [Melee Haste]%
Mastery [Mastery]%

Armor [Armor]
Avoid [Avoidance]%
T.Mit [Mitigation]%]]
L["DEFAULT_L_STRING_HUNTER"] = 
[[Hit [Ranged Hit]% [Ranged Hit Rating]
Crit [Ranged Crit]%
Haste [Ranged Haste]%
Mastery [Mastery]%]]
L["DEFAULT_L_STRING_SHAMAN"] = 
[[Nature [Nature] [Nature Crit]%
Hit [Melee Hit]% [Spell Hit]%
Haste [Melee Haste]% [Spell Haste]%
Mastery [Mastery]%]]
L["DEFAULT_L_STRING_DEATHKNIGHT"] = 
[[Hit [Melee Hit]% [Melee Hit Rating]
Crit [Melee Crit]%
Haste [Melee Haste]%
Mastery [Mastery]%

Armor [Armor]
Avoid [Avoidance]%
T.Mit [Mitigation]%]]
L["DEFAULT_L_STRING_ROGUE"] = 
[[Hit [Melee Hit]% [Melee Hit Rating]
Crit [Melee Crit]%
Haste [Melee Haste]%
Mastery [Mastery]%]]
L["DEFAULT_L_STRING_MAGE"] = 
[[Fire [Fire] [Fire Crit]%
Hit [Spell Hit]% [Spell Hit Rating]
Has [Spell Haste]%
Mastery [Mastery]%]]
L["DEFAULT_L_STRING_DRUID"] = 
[[Hit [Melee Hit]% [Melee Hit Rating]
Crit [Melee Crit]
Haste [Melee Haste]%
Mastery [Mastery]%

Armor [Armor]
Avoid [Avoidance]%]]
L["DEFAULT_L_STRING_PALADIN"] = 
[[Heal [Heal] [Holy Crit]
Hit [Melee Hit]% [Melee Hit Rating]
Crit [Melee Crit]%
Haste [Melee Haste]%
Mastery [Mastery]%

Armor [Armor]
Avoid [Avoidance]%
T.Mit [Mitigation]%]]
L["DEFAULT_L_STRING_PRIEST"] = 
[[Shadow [Shadow] [Shadow Crit]%
Heal [Heal] [Holy Crit]%
Hit  [Spell Hit]% [Spell Hit Rating]
Has [Spell Haste]%
Mastery [Mastery]%]]
L["DEFAULT_L_STRING_WARLOCK"] = 
[[Shadow [Shadow] [Shadow Crit]%
Hit  [Spell Hit]% [Spell Hit Rating]
Has [Spell Haste]%
Mastery [Mastery]%]]
L["DEFAULT_R_STRING"] = 
[[[ILVL]
[GS]
[Speed]%]]