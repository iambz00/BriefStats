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
[[사용 키워드 - 모두 % 수치(일부 예외)
[기어스코어]=[기코]  [아이템레벨]=[템렙]
[감소] [보스감소] |cffcccccc방어도 데미지 감소율(동렙 / 83렙)|r
[공격력증가] |cffcccccc공격력 %|r  [피치명]
[완방] |cffcccccc빗나감+무막+회피|r  [방어합] |cffcccccc완방+방막|r [방피]
[방어구관통]=[방관] |cffcccccc%|r [방어구관통도]=[방관도] |cffcccccc수치|r
|cffcccccc근접|r   [근접적중] [근접치명] [근접가속] 
|cffcccccc원거리|r [원거리적중] [원거리치명] [원거리가속] 
|cffcccccc주문|r   [주문적중] [주문가속] [치유]=[치증] [주문관통]=[주관]
|cffffe57f[신성] [신성극대]|r  |cffff7f00[화염] [화염극대]|r  |cff4cff4c[자연] [자연극대]|r
|cff7fffff[냉기] [냉기극대]|r  |cff7f7fff[암흑] [암흑극대]|r  |cffff7fff[비전] [비전극대]|r
[이동속도]=[이속] ]]
L["RDC1" ] = "감소"
L["RDC2" ] = "보스감소"
L["DMGM" ] = "공격력증가"
L["CRIAV"] = "피치명"
L["TRUEA"] = "완방"
L["AVOID"] = "방어합"
L["BV"   ] = "방피"
L["MHIT" ] = "근접적중"
L["MCRI" ] = "근접치명"
L["MHAS" ] = "근접가속"
L["APEN" ] = "방어구관통"
L["APENR"] = "방어구관통도"
L["RHIT" ] = "원거리적중"
L["RCRI" ] = "원거리치명"
L["RHAS" ] = "원거리가속"
L["SPHO" ] = "신성"
L["SPFI" ] = "화염"
L["SPNA" ] = "자연"
L["SPFR" ] = "냉기"
L["SPSH" ] = "암흑"
L["SPAR" ] = "비전"
L["SCHO" ] = "신성극대"
L["SCFI" ] = "화염극대"
L["SCNA" ] = "자연극대"
L["SCFR" ] = "냉기극대"
L["SCSH" ] = "암흑극대"
L["SCAR" ] = "비전극대"
L["SHEAL"] = "치유"
L["SHIT" ] = "주문적중"
L["SHAS "] = "주문가속"
L["SPEN" ] = "주문관통"
L["SPEED"] = "이동속도"
L["ILVL" ] = "아이템레벨"
L["GS"   ] = "기어스코어"
shareTable.koKR = {
    ["치증"  ] = "치유",
    ["방관도"] = "방어구관통도",
    ["방관"  ] = "방어구관통",
    ["이속"  ] = "이동속도",
    ["템렙"  ] = "아이템레벨",
    ["기코"  ] = "기어스코어",
    ["주관"  ] = "주문관통",
}

L["DEFAULT_L_STRING_WARRIOR"] =
[[관통 [방관]%
적중 [근접적중]%
가속 [근접가속]%

완방 [완방]%
방합 [방어합]% [방피]
피치 [피치명]%]]
L["DEFAULT_L_STRING_HUNTER"] = 
[[방관 [방관]%
적중 [원거리적중]%
가속 [원거리가속]%

피치 [피치명]%]]
L["DEFAULT_L_STRING_SHAMAN"] = 
[[방관 [방관]%
자연 [자연] [자연극대]%
적중 [근접적중]% [주문적중]%
가속 [근접가속]% [주문가속]%

피치 [피치명]%]]
L["DEFAULT_L_STRING_DEATHKNIGHT"] = 
[[적중 [근접적중]% [주문적중]%
가속 [근접가속]%

완방 [완방]%
피치 [피치명]%]]
L["DEFAULT_L_STRING_ROGUE"] = 
[[방관 [방관]%
적중 [근접적중]%
가속 [근접가속]%

피치 [피치명]%]]
L["DEFAULT_L_STRING_MAGE"] = 
[[비전 [비전] [비전극대]%
냉기 [냉기] [냉기극대]%
적중 [주문적중]%
가속 [주문가속]%

관통 [주문관통]
피치 [피치명]%]]
L["DEFAULT_L_STRING_DRUID"] = 
[[방관 [방관]%
자연 [자연] [자연극대]%
적중 [근접적중]% [주문적중]%
가속 [근접가속]% [주문가속]%

피치 [피치명]%]]
L["DEFAULT_L_STRING_PALADIN"] = 
[[신성 [신성] [신성극대]%
적중 [근접적중]% [주문적중]%

완방 [완방]%
방합 [방어합]%
피치 [피치명]%]]
L["DEFAULT_L_STRING_PRIEST"] = 
[[암흑 [암흑] [암흑극대]%
치유 [치유]
적중 [주문적중]%
가속 [주문가속]%

피치 [피치명]%]]
L["DEFAULT_L_STRING_WARLOCK"] = 
[[암흑 [암흑] [암흑극대]%
적중 [주문적중]%
가속 [주문가속]%

피치 [피치명]%]]
L["DEFAULT_R_STRING"] = 
[[[템렙]
[기코]
[이속]%]]