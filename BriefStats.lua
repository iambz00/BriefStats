local addonName, shareTable = ...
local Addon = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
Addon.name = addonName
Addon.version = GetAddOnMetadata(Addon.name, "Version")
_G[Addon.name] = Addon

local GS = shareTable.gs

local dbDefault = {
	profile = {
		anchorFrame = "PlayerStatFrameLeftDropDown",
		anchorFrameAnchor = "TOPLEFT",
		anchor = "BOTTOMLEFT",
		offsetX = 20,
		offsetY = 4,
		string = "",
		default = true,
	}
}

-- FrameXML/PaperDollframe.lua
local c = {
	["감소"] = "reduction",
	reduction = function()
		local _, effectiveArmor = UnitArmor("player")
		return format("%.2f", PaperDollFrame_GetArmorReduction(effectiveArmor, UnitLevel("player")))
	end,
	["보스감소"] = "bossreduction",
	bossreduction = function()
		local _, effectiveArmor = UnitArmor("player")
		return format("%.2f", PaperDollFrame_GetArmorReduction(effectiveArmor, 83))
	end,
	["공격력증가"] = "damage",
	damage = function()
		local _,_,_,_,_,_,percent = UnitDamage("player")
		return floor(percent*100+0.5)
	end,
	["피치명"] = "critavoid",
	critavoid = function() return format("%.2f", GetDodgeBlockParryChanceFromDefense() + GetCombatRatingBonus(CR_RESILIENCE_CRIT_TAKEN)) end,
	["완방"] = "avoidance",
	avoidance = function() return format("%.2f", 5 + GetDodgeBlockParryChanceFromDefense() + GetDodgeChance() + GetParryChance()) end,
	["방어합"] = "totalavoid",
	totalavoid = function() return format("%.2f", 5 + GetDodgeBlockParryChanceFromDefense() + GetDodgeChance() + GetParryChance() + GetBlockChance()) end,
	["방피"] = "blockvalue",
	blockvalue = function() return GetShieldBlock() end,
	["근접적중"] = "mhit",
	mhit = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_MELEE)) end,
	["근접치명"] = "mcrit",
	mcrit = function() return format("%.2f", GetCritChance()) end,
	["근접가속"] = "mhaste",
	mhaste = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_MELEE)) end,
	["방무"] = "apen",
	["방관"] = "apen",
	apen = function() return format("%.2f", GetArmorPenetration()) end,
	["원거리적중"] = "rhit",
	rhit = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_RANGED)) end,
	["원거리치명"] = "rcrit",
	rcrit = function() return format("%.2f", GetRangedCritChance()) end,
	["원거리가속"] = "rhaste",
	rhaste = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_RANGED)) end,
	["신성"] = "sholy",
	sholy = function() return "|cffffe57f"..GetSpellBonusDamage(2).."|r" end,
	["화염"] = "sfire",
	sfire = function() return "|cffff7f00"..GetSpellBonusDamage(3).."|r" end,
	["자연"] = "snature",
	snature = function() return "|cff4cff4c"..GetSpellBonusDamage(4).."|r" end,
	["냉기"] = "sfrost",
	sfrost = function() return "|cff7fffff"..GetSpellBonusDamage(5).."|r" end,
	["암흑"] = "sshadow",
	sshadow = function() return "|cff7f7fff"..GetSpellBonusDamage(6).."|r" end,
	["비전"] = "sarcane",
	sarcane = function() return "|cffff7fff"..GetSpellBonusDamage(7).."|r" end,
	["신성극대"] = "choly",
	choly = function() return format("|cffffe57f%.2f|r", GetSpellCritChance(2)) end,
	["화염극대"] = "cfire",
	cfire = function() return format("|cffff7f00%.2f|r", GetSpellCritChance(3)) end,
	["자연극대"] = "cnature",
	cnature = function() return format("|cff4cff4c%.2f|r", GetSpellCritChance(4)) end,
	["냉기극대"] = "cfrost",
	cfrost = function() return format("|cff7fffff%.2f|r", GetSpellCritChance(5)) end,
	["암흑극대"] = "cshadow",
	cshadow = function() return format("|cff7f7fff%.2f|r", GetSpellCritChance(6)) end,
	["비전극대"] = "carcane",
	carcane = function() return format("|cffff7fff%.2f|r", GetSpellCritChance(7)) end,
	["치증"] = "heal",
	heal = function() return GetSpellBonusHealing() end,
	["주문적중"] = "shit",
	shit = function() return format("%.2f", GetCombatRatingBonus(CR_HIT_SPELL)) end,
	["주문가속"] = "shaste",
	shaste = function() return format("%.2f", GetCombatRatingBonus(CR_HASTE_SPELL)) end,
	["주문관통"] = "spen",
	spen = function() return GetSpellPenetration() end,
	["이속"] = "speed",
	speed = function()	-- Returns best speed
		local _, run, fly = GetUnitSpeed("player")
		return (run > fly) and ceil(run/7*100) or ceil(fly/7*100)
	end,
	["아이템레벨"] = "ilvl",
	["템렙"] = "ilvl",
	ilvl = function()
		local _, ilvl = GS:GetScore()
		return format("%.1f", ilvl)
	end,
	["기어스코어"] = "gearscore",
	["기코"] = "gearscore",
	gearscore = function()
		local score, _ = GS:GetScore()
		local r,g,b = GS:GetQuality(score)
		return string.format("|cff%.2x%.2x%.2x%d|r", r*255, g*255, b*255, score)
	end,
}

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

function bsPaperDollFrame_UpdateStats()
--	if Addon.oldPaperDollFrame_UpdateStats then Addon.oldPaperDollFrame_UpdateStats() end
	local parse = Addon.db.profile.string or ""
	parse = parse:gsub("%[([^]^[]*)%]", function(s) return c(s) end)
	Addon.text:SetText(parse)
end

function Addon:InitDB()
	local class, engClass = UnitClass("player")

	self.db = LibStub("AceDB-3.0"):New(self.name.."DB", dbDefault, class) -- defaultProfileName: class name
	local db = self.db.profile

	if db.default then
		db.default = false
		if engClass == "WARRIOR" then
			db.string = "[기코] [템렙]\n방관 [방관]%\n공격 [공격력증가]%\n적중 [근접적중]%\n가속 [근접가속]%\n\n탄력 [피치명]%\n이속 [이속]%"
		elseif engClass == "ROGUE" then
			db.string = "[기코] [템렙]\n방관 [방관]%\n공격 [공격력증가]%\n적중 [근접적중]%\n가속 [근접가속]%\n\n탄력 [피치명]%\n이속 [이속]%"
		elseif engClass == "MAGE" then
			db.string = "[기코] [템렙]\n공격 [공격력증가]%\n비전 [비전] [비전극대]%\n냉기 [냉기] [냉기극대]%\n\n적중 [주문적중]%\n가속 [주문가속]%\n관통 [주문관통]\n탄력 [피치명]%"
		elseif engClass == "PRIEST" then
			db.string = "[기코] [템렙]\n공격 [공격력증가]%\n암흑 [암흑] [암흑극대]%\n치유 [치유]\n\n적중 [주문적중]%\n가속 [주문가속]%\n관통 [주문관통]\n탄력 [피치명]"
		elseif engClass == "DRUID" then
			db.string = "[기코] [템렙]\n방관 [방관]%\n공격 [공격력증가]%\n자연 [자연] [자연극대]%\n적중 [근접적중]% [주문적중]%\n가속 [근접가속]% [주문가속]%\n\n탄력 [피치명]%\n이속 [이속]%"
		elseif engClass == "SHAMAN" then
			db.string = "[기코] [템렙]\n방관 [방관]%\n공격 [공격력증가]%\n자연 [자연] [자연극대]%\n적중 [근접적중]% [주문적중]%\n가속 [근접가속]% [주문가속]%\n\n탄력 [피치명]%\n이속 [이속]%"
		elseif engClass == "HUNTER" then
			db.string = "[기코] [템렙]\n방관 [방관]%\n공격 [공격력증가]%\n적중 [원거리적중]%\n가속 [원거리가속]%\n\n탄력 [피치명]%\n이속 [이속]%"
		elseif engClass == "PALADIN" then
			db.string = "[기코] [템렙]\n공격 [공격력증가]%\n신성 [신성] [신성극대]%\n적중 [근접적중]% [주문적중]%\n\n완방 [완방]%\n방어합 [방어합]%\n탄력 [피치명]%\n이속 [이속]%"
		elseif engClass == "DEATHKNIGHT" then
			db.string = "[기코] [템렙]\n방관 [방관]%\n공격 [공격력증가]%\n적중 [근접적중]% [주문적중]%\n가속 [근접가속]%\n\n완방 [완방]%\n탄력 [피치명]%\n이속 [이속]%"
		end
	end
end

function Addon:InitUI()
	local db = self.db.profile
	local ui = CreateFrame("Frame", self.name.."Frame", _G[db.anchorFrame])
	ui:EnableMouse(false)
	ui:EnableMouseWheel(false)
	ui:SetWidth(200)
	ui:SetHeight(300)
	self.ui = ui

	local text = ui:CreateFontString()
	text:SetAllPoints()
	text:SetFontObject("GameFontNormalSmall")
	text:SetJustifyH("LEFT")
	text:SetJustifyV("BOTTOM")
	text:SetTextColor(1, 1, 1)
	text:SetText(self.name)
	self.text = text

	local btn = CreateFrame("Button", self.name.."ConfigButton", _G[db.anchorFrame], "UIPanelButtonTemplate")
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
		GameTooltip:AddLine(self.name.." 설정")
		GameTooltip:Show()
	end)
	btn:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	self.btn = btn

	self.ui:Show()
	self:RefreshUI()
end

function Addon:RefreshUI()
	local db = self.db.profile
	self.ui:SetParent(_G[db.anchorFrame])
	self.ui:ClearAllPoints()
	self.ui:SetPoint(db.anchor, db.anchorFrame, db.anchorFrameAnchor, db.offsetX, db.offsetY)
	self.btn:SetPoint(db.anchor, db.anchorFrame, db.anchorFrameAnchor, db.offsetX, db.offsetY)
	bsPaperDollFrame_UpdateStats()
end

function Addon:TestColor()
    local myStringValue = ""
    local schoolColors = COMBATLOG_DEFAULT_COLORS.schoolColoring
	for key,value in pairs(schoolColors) do
		myStringValue = myStringValue .. string.format("|cff%.2x%.2x%.2x%s Spell|r\n", value.r*255, value.g*255, value.b*255, _G.CombatLog_String_SchoolString(key))
	end
    return myStringValue
end

function Addon:BuildOptions()
self.optionsTable = {
	name = Addon.name .. " option",
	type = 'group',
	get = function(info) return self.db.profile[info[#info]] end,
	set = function(info, value) self.db.profile[info[#info]] = value Addon:RefreshUI() end,
	args = {
		settings = {
			name = "표시정보",
			type = "group",
			order = 11,
			args = {
				string = {
					name = "String",
					type = "input",
					multiline = 8,
					width = "double",
					order = 101,
				},
				usage = {
					name = [[사용 키워드
[기어스코어] [기코]
[아이템레벨] [템렙]   평균 아이템레벨
[감소]    방어도 데미지 감소 % (동레벨)
[보스감소]    방어도 데미지 감소 % (해골몹)
[공격력증가]    공격력 %
[피치명]    피치명 %
[방어합]    방어합 %(완방+방막)
[완방]    완방 %(빗나감+무막+회피)
[방피]    방피량
[방관]    방어도관통
[근접적중] [원거리적중] [주문적중]
[근접가속] [원거리가속] [주문가속]
[근접치명] [원거리치명]    각 % 수치
|cffffe57f[신성]    [신성극대]%|r    |cffff7f00[화염]    [화염극대]%|r
|cff4cff4c[자연]    [자연극대]%|r    |cff7fffff[냉기]    [냉기극대]%|r
|cff7f7fff[암흑]    [암흑극대]%|r    |cffff7fff[비전]    [비전극대]%|r
[치증]    치유량
[주문관통]    주문 관통
[이속]    이동 속도 %]],
					type = "description",
					order = 102,
				},

			},
		},
		anchor = {
			name = "위치",
			type = "group",
			order = 21,
			args = {
				anchorFrame = {
					name = "기준프레임",
					type = "input",
					order = 201,
				},
				anchorFramseChooser = {
					name = "프레임선택",
					type = "execute",
					func = function() self:StartFrameChooser("anchorFrame") end,
					order = 202,
				},
				anchorFrameAnchor = {
					name = "프레임기준점",
					type = "input",
					order = 203,
				},
				anchor = {
					name = "기준점",
					type = "input",
					order = 204,
				},
				offsetX = {
					name = "x offset",
					type = "range",
					softMin = -200,
					softMax = 200,
					bigStep = 10,
					order = 211,
				},
				offsetY = {
					name = "y offset",
					type = "range",
					softMin = -200,
					softMax = 200,
					bigStep = 10,
					order = 212,
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
