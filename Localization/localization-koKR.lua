local addonName, shareTable = ...

local L = LibStub('AceLocale-3.0'):NewLocale(addonName, "koKR")
if not L then return end

L["Display string"] = "표시 정보"
L["Left Pane"] = "왼쪽 패널"
L["Right Pane"] = "오른쪽 패널"
L["Position"] = "위치"
L["AnchorFrame"] = "기준 프레임"
L["Set AnchorFrame"] = "프레임 선택"
L["AnchorFrame Anchor"] = "프레임 기준점"
L["Pane Anchor"] = "패널 기준점"
L["x Offset"] = "x이동"
L["y Offset"] = "y이동"

L["Usage"] =
[[사용 키워드 (띄어쓰기 무시)
[기어스코어] [기코] [아이템레벨] [템렙]
[특화] [특화도] [탄력] [탄력도]
[공격력] [데미지] |cffcccccc공격력 증가 %|r
[감소] [보스감소] |cffcccccc방어도 데미지 감소율(동렙 / 보스)|r
[방어도] [회피] [무막] [방막]
[완방] |cffcccccc빗나감+무막+회피|r  [방합] |cffcccccc완방+방막|r
[근접/원거리 적중/치명/가속/전투력]
[근접/원거리 적중도/가속도]
[주문 적중/가속/관통] [주문 적중도/가속도] [치유]
|cffffe57f[신성] [신성 극대]|r  |cffff7f00[화염] [화염 극대]|r  |cff4cff4c[자연] [자연 극대]|r
|cff7fffff[냉기] [냉기 극대]|r  |cff7f7fff[암흑] [암흑 극대]|r  |cffff7fff[비전] [비전 극대]|r
(극대=치명 혼용 가능)
[이동속도]=[이속] ]]
L["ARMOR"]      = "방어도"
L["REDUCTION"]  = "감소"
L["BOSS"]       = "보스"
L["DAMAGE"]     = { "데미지", "대미지", "공격력" }
L["AVOIDANCE"]  = "완방"
L["MITIGATION"] = { "방어합", "방합" }
L["DODGE"]      = "회피"
L["PARRY"]      = "무막"
L["BLOCK"]      = "방막"
L["RESLIENCE"]  = "탄력"
L["MELEE"]      = "근접"
L["RANGED"]     = "원거리"
L["ATTACKPOWER"]= "전투력"
L["SPELL"]      = "주문력"
L["HOLY"]       = "신성"
L["FIRE"]       = "화염"
L["NATURE"]     = "자연"
L["FROST"]      = "냉기"
L["SHADOW"]     = "어둠"
L["ARCANE"]     = "비전"
L["HEAL"]       = { "치유", "치증" }
L["CRITICAL"]   = { "치명", "극대" }
L["HASTE"]      = "가속"
L["MASTERY"]    = "특화"
L["PENETRATION"]= "관통"
L["RATING"]     = "도"
L["ITEMLEVEL"]  = { "아이템레벨", "템렙" }
L["GEARSCORE"]  = { "기어스코어", "기코" }
L["SPEED"]      = { "이동속도", "이속" }

L["DEFAULT_L_STRING_WARRIOR"] =
[[적중 [근접 적중]% [근접 적중도]
치명 [근접 치명]%
가속 [근접 가속]%
특화 [특화]%

방어도 [방어도]
완방 [완방]%
방합 [방어합]%]]
L["DEFAULT_L_STRING_HUNTER"] = 
[[적중 [원거리 적중]% [원거리 적중도]
치명 [원거리 치명]%
가속 [원거리 가속]%
특화 [특화]%]]
L["DEFAULT_L_STRING_SHAMAN"] = 
[[자연 [자연] [자연 극대]%
적중 [근접 적중]% [주문 적중]%
치명 [근접 치명]% [주문 치명]%
가속 [근접 가속]% [주문 가속]%
특화 [특화]%]]
L["DEFAULT_L_STRING_DEATHKNIGHT"] = 
[[적중 [근접 적중]% [근접 적중도]
치명 [근접 치명]%
가속 [근접 가속]%
특화 [특화]%

방어도 [방어도]
완방 [완방]%
방합 [방어합]%]]
L["DEFAULT_L_STRING_ROGUE"] = 
[[적중 [근접 적중]% [근접 적중도]
치명 [근접 치명]%
가속 [근접 가속]%
특화 [특화]%]]
L["DEFAULT_L_STRING_MAGE"] = 
[[화염 [화염] [화염 극대]%
적중 [주문 적중]% [주문 적중도]
가속 [주문 가속]%
특화 [특화]%]]
L["DEFAULT_L_STRING_DRUID"] = 
[[적중 [근접 적중]% [근접 적중도]
치명 [근접 치명]%
가속 [근접 가속]%
특화 [특화]%

방어도 [방어도]
완방 [완방]%]]
L["DEFAULT_L_STRING_PALADIN"] = 
[[치유 [치유] [신성 극대]%
적중 [근접 적중]% [근접 적중도]
치명 [근접 치명]%
가속 [근접 가속]%
특화 [특화]%

방어도 [방어도]
완방 [완방]%
방합 [방어합]%]]
L["DEFAULT_L_STRING_PRIEST"] = 
[[암흑 [암흑] [암흑 극대]%
치유 [치유] [신성 극대]%
적중 [주문 적중]%
가속 [주문 가속]%
특화 [특화]%]]
L["DEFAULT_L_STRING_WARLOCK"] = 
[[암흑 [암흑] [암흑 극대]%
적중 [주문 적중]%
가속 [주문 가속]%
특화 [특화]%]]
L["DEFAULT_R_STRING"] = 
[[[템렙]
[기코]
[이속]%]]