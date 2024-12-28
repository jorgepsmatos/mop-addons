--[[--------------------------------------------------------------------
    Copyright (C) 2012, 2013 Sidoine De Wispelaere.
    Copyright (C) 2012, 2013, 2014 Johnny C. Lam.
    See the file LICENSE.txt for copying permission.
--]]--------------------------------------------------------------------

-- Ovale options and UI

local addonName, Ovale = ...
local OvaleOptions = Ovale:NewModule("OvaleOptions", "AceConsole-3.0", "AceEvent-3.0")
Ovale.OvaleOptions = OvaleOptions

--<private-static-properties>
local L = Ovale.L

-- Forward declarations for module dependencies.
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local LibDataBroker = LibStub("LibDataBroker-1.1", true)
local OvaleScripts = nil
local OvaleSpellBook = nil
local OvaleState = nil

local format = string.format
local strgmatch = string.gmatch
local strgsub = string.gsub
local tinsert = table.insert
local API_CreateFrame = CreateFrame
local API_EasyMenu = EasyMenu
local API_GetSpellInfo = GetSpellInfo
local API_GetTime = GetTime
local API_UnitClass = UnitClass

-- Player's class.
local _, self_class = API_UnitClass("player")

-- Class icon textures.
local self_classIcons = {
	["DEATHKNIGHT"] = "Interface\\Icons\\ClassIcon_DeathKnight",
	["DRUID"] = "Interface\\Icons\\ClassIcon_Druid",
	["HUNTER"] = "Interface\\Icons\\ClassIcon_Hunter",
	["MAGE"] = "Interface\\Icons\\ClassIcon_Mage",
	["MONK"] = "Interface\\Icons\\ClassIcon_Monk",
	["PALADIN"] = "Interface\\Icons\\ClassIcon_Paladin",
	["PRIEST"] = "Interface\\Icons\\ClassIcon_Priest",
	["ROGUE"] = "Interface\\Icons\\ClassIcon_Rogue",
	["SHAMAN"] = "Interface\\Icons\\ClassIcon_Shaman",
	["WARLOCK"] = "Interface\\Icons\\ClassIcon_Warlock",
	["WARRIOR"] = "Interface\\Icons\\ClassIcon_Warrior",
}

-- AceDB options table.
local self_options = 
{ 
	type = "group",
	args = 
	{
		apparence =
		{
			name = L["Apparence"],
			type = "group",
			-- Generic getter/setter for options.
			get = function(info)
				return OvaleOptions.db.profile.apparence[info[#info]]
			end,
			set = function(info, value)
				OvaleOptions.db.profile.apparence[info[#info]] = value
				OvaleOptions:SendMessage("Ovale_OptionChanged", info[#info - 1])
			end,
			args =
			{
				verrouille =
				{
					order = 10,
					type = "toggle",
					name = L["Verrouiller position"],
				},
				clickThru =
				{
					order = 20,
					type = "toggle",
					name = L["Ignorer les clics souris"],
				},
				visibility =
				{
					order = 30,
					type = "group",
					name = L["Visibilité"],
					args =
					{
						enCombat =
						{
							type = "toggle",
							name = L["En combat uniquement"],
						},
						avecCible =
						{
							type = "toggle",
							name = L["Si cible uniquement"],
						},
						targetHostileOnly =
						{
							type = "toggle",
							name = L["Cacher si cible amicale ou morte"],
						},
						hideVehicule =
						{
							type = "toggle",
							name = L["Cacher dans les véhicules"],
						},
						hideEmpty =
						{
							type = "toggle",
							name = L["Cacher bouton vide"],
						},
					},
				},
				iconAppearance =
				{
					order = 40,
					type = "group",
					name = L["Icône"],
					args =
					{
						iconScale =
						{
							type = "range",
							name = L["Taille des icônes"],
							desc = L["La taille des icônes"],
							min = 0.1, max = 16, step = 0.1,
						},
						smallIconScale =
						{
							type = "range",
							name = L["Taille des petites icônes"],
							desc = L["La taille des petites icônes"],
							min = 0.1, max = 16, step = 0.1,
						},
						fontScale =
						{
							type = "range",
							name = L["Taille des polices"],
							desc = L["La taille des polices"],
							min = 0.1, max = 2, step = 0.1,
						},
						alpha =
						{
							type = "range",
							name = L["Opacité des icônes"],
							min = 0, max = 100, step = 5,
						},
						raccourcis =
						{
							type = "toggle",
							name = L["Raccourcis clavier"],
							desc = L["Afficher les raccourcis clavier dans le coin inférieur gauche des icônes"],
						},
						numeric =
						{
							type = "toggle",
							name = L["Affichage numérique"],
							desc = L["Affiche le temps de recharge sous forme numérique"],
						},
						highlightIcon =
						{
							type = "toggle",
							name = L["Illuminer l'icône"],
							desc = L["Illuminer l'icône quand la technique doit être spammée"],
						},
						flashIcon =
						{
							type = "toggle",
							name = L["Illuminer l'icône quand le temps de recharge est écoulé"],
						},
						targetText =
						{
							type = "input",
							name = L["Caractère de portée"],
							desc = L["Ce caractère est affiché dans un coin de l'icône pour indiquer si la cible est à portée"],
						},
						updateInterval =
						{
							type = "range",
							name = "Update interval",
							desc = "Maximum time to wait (in milliseconds) before refreshing icons.",
							min = 0, max = 500, step = 10,
							get = function(info)
								return OvaleOptions.db.profile.apparence.updateInterval * 1000
							end,
							set = function(info, value)
								OvaleOptions.db.profile.apparence.updateInterval = value / 1000
								self:SendMessage("Ovale_OptionChanged")
							end
						},
					},
				},
				iconGroupAppearance =
				{
					order = 50,
					type = "group",
					name = L["Groupe d'icônes"],
					args =
					{
						moving =
						{
							type = "toggle",
							name = L["Défilement"],
							desc = L["Les icônes se déplacent"],
						},
						vertical =
						{
							type = "toggle",
							name = L["Vertical"],
						},
						margin =
						{
							type = "range",
							name = L["Marge entre deux icônes"],
							min = -16, max = 64, step = 1,
						},
					},
				},
				optionsAppearance =
				{
					order = 60,
					type = "group",
					name = L["Options"],
					args =
					{
						iconShiftX =
						{
							type = "range",
							name = L["Décalage horizontal des options"],
							min = -256, max = 256, step = 1,
						},
						iconShiftY =
						{
							type = "range",
							name = L["Décalage vertical des options"],
							min = -256, max = 256, step = 1,
						},
						optionsAlpha =
						{
							type = "range",
							name = L["Opacité des options"],
							min = 0, max = 100, step = 5,
							get = function(info)
								return OvaleOptions.db.profile.apparence.optionsAlpha * 100
							end,
							set = function(info, value)
								OvaleOptions.db.profile.apparence.optionsAlpha = value / 100
								Ovale.frame.content:SetAlpha(value/100)
								self:SendMessage("Ovale_OptionChanged")
							end
						},
					},
				},
				predictiveIcon =
				{
					order = 70,
					type = "group",
					name = L["Prédictif"],
					args =
					{
						predictif =
						{
							type = "toggle",
							name = L["Prédictif"],
							desc = L["Affiche les deux prochains sorts et pas uniquement le suivant"],
						},
						secondIconScale =
						{
							type = "range",
							name = L["Taille du second icône"],
							min = 0.2, max = 1, step = 0.1,
						},
					},
				},
				advanced = {
					order = 80,
					type = "group",
					name = "Advanced",
					args =
					{
						auraLag =
						{
							order = 100,
							type = "range",
							name = L["Aura lag"],
							desc = L["Lag (in milliseconds) between when an spell is cast and when the affected aura is applied or removed"],
							min = 100, max = 700, step = 10,
						},
					},
				},
			},
		},
		code =
		{
			name = L["Code"],
			type = "group",
			args = 
			{
				source = {
					order = 10,
					type = "select",
					name = L["Script"],
					width = "double",
					values = function(info)
						local scriptType = not OvaleOptions.db.profile.showHiddenScripts and "script"
						return OvaleScripts:GetDescriptions(scriptType)
					end,
					get = function(info)
						return OvaleOptions.db.profile.source
					end,
					set = function(info, v)
						OvaleOptions:SetScript(v)
					end,
				},
				code = 
				{
					order = 20,
					type = "input",
					multiline = 25,
					name = L["Code"],
					width = "full",
					disabled = function()
						return OvaleOptions.db.profile.source ~= "custom"
					end,
					get = function(info)
						local source = OvaleOptions.db.profile.source
						local code
						if source and OvaleScripts.script[source] then
							code = OvaleScripts.script[source].code
						else
							code = ""
						end
						return strgsub(code, "\t", "    ")
					end,
					set = function(info, v)
						OvaleScripts:RegisterScript(self_class, "custom", L["Script personnalisé"], v, "script")
						OvaleOptions.db.profile.code = v
						OvaleOptions:SendMessage("Ovale_ScriptChanged")
					end,
				},
				copy =
				{
					order = 30,
					type = "execute",
					name = L["Copier sur Script personnalisé"],
					disabled = function()
						return OvaleOptions.db.profile.source == "custom"
					end,
					confirm = function()
						return L["Ecraser le Script personnalisé préexistant?"]
					end,
					func = function()
						local source = OvaleOptions.db.profile.source
						local code
						if source and OvaleScripts.script[source] then
							code = OvaleScripts.script[source].code
						else
							code = ""
						end
						OvaleScripts.script["custom"].code = code
						OvaleOptions.db.profile.source = "custom"
						OvaleOptions.db.profile.code = code
						OvaleOptions:SendMessage("Ovale_ScriptChanged")
					end,
				},
				showHiddenScripts = {
					order = 40,
					type = "toggle",
					name = L["Show hidden"],
					get = function(info) return OvaleOptions.db.profile.showHiddenScripts end,
					set = function(info, value) OvaleOptions.db.profile.showHiddenScripts = value end
				},
			},
		},
		debug =
		{
			name = "Debug",
			type = "group",
			args =
			{
				toggles =
				{
					name = "Options",
					type = "group",
					order = 10,
					args =
					{
						-- Node names must match the names of the debug flags.
						action_bar =
						{
							name = "Action bars",
							desc = L["Debug action bars"],
							type = "toggle",
						},
						aura =
						{
							name = "Auras",
							desc = L["Debug aura"],
							type = "toggle",
						},
						combo_points =
						{
							name = "Combo points",
							desc = L["Debug combo points"],
							type = "toggle",
						},
						compile =
						{
							name = "Compile",
							desc = L["Debug compile"],
							type = "toggle",
						},
						damage_taken =
						{
							name = "Damage taken",
							desc = L["Debug damage taken"],
							type = "toggle",
						},
						enemy =
						{
							name = "Enemies",
							desc = L["Debug enemies"],
							type = "toggle",
						},
						guid =
						{
							name = "GUIDs",
							desc = L["Debug GUID"],
							type = "toggle",
						},
						missing_spells =
						{
							name = "Missing spells",
							desc = L["Debug missing spells"],
							type = "toggle",
						},
						paper_doll =
						{
							name = "Paper doll updates",
							desc = L["Debug paper doll"],
							type = "toggle",
						},
						snapshot =
						{
							name = "Snapshot updates",
							desc = L["Debug stat snapshots"],
							type = "toggle",
						},
						unknown_spells =
						{
							name = "Unknown spells",
							desc = L["Debug unknown spells"],
							type = "toggle",
						},
					},
					get = function(info) return OvaleOptions.db.profile.debug[info[#info]] end,
					set = function(info, value) OvaleOptions.db.profile.debug[info[#info]] = value end,
				},
				trace =
				{
					name = "Trace",
					type = "group",
					order = 20,
					args =
					{
						trace =
						{
							order = 10,
							type = "execute",
							name = "Trace next frame",
							func = function()
								Ovale:ClearLog()
								Ovale.trace = true
								Ovale:Logf("=== Trace @%f", API_GetTime())
							end,
						},
						traceSpellId =
						{
							order = 20,
							type = "input",
							dialogControl = "Aura_EditBox",
							name = "Trace spellcast",
							desc = "Names or spell IDs of spellcasts to watch, separated by semicolons.",
							get = function(info)
								local OvaleFuture = Ovale.OvaleFuture
								if OvaleFuture then
									local t = OvaleFuture.traceSpellList or {}
									local s = ""
									for k, v in pairs(t) do
										if type(v) == "boolean" then
											if string.len(s) == 0 then
												s = k
											else
												s = s .. "; " .. k
											end
										end
									end
									return s
								else
									return ""
								end
							end,
							set = function(info, value)
								local OvaleFuture = Ovale.OvaleFuture
								if OvaleFuture then
									local t = {}
									for s in strgmatch(value, "[^;]+") do
										-- strip leading and trailing whitespace
										s = strgsub(s, "^%s*", "")
										s = strgsub(s, "%s*$", "")
										if string.len(s) > 0 then
											local v = tonumber(s)
											if v then
												s = API_GetSpellInfo(v)
												if s then
													t[v] = true
													t[s] = v
												end
											else
												t[s] = true
											end
										end
									end
									if next(t) then
										OvaleFuture.traceSpellList = t
									else
										OvaleFuture.traceSpellList = nil
									end
								end
							end,
						},
					},
				},
				traceLog = {
					name = L["Trace Log"],
					type = "group",
					order = 30,
					args = {
						traceLog = {
							name = L["Trace Log"],
							type = "input",
							multiline = 25,
							width = "full",
							get = function() return Ovale:TraceLog() end,
						},
					},
				},
			},
		},
		actions =
		{
			name = "Actions",
			type = "group",
			args = 
			{
				show =
				{
					order = -1,
					type = "execute",
					name = L["Afficher la fenêtre"],
					guiHidden = true,
					func = function()
						OvaleOptions.db.profile.display = true
						Ovale:UpdateVisibility()
					end
				},
				hide =
				{
					order = -2,
					type = "execute",
					name = L["Cacher la fenêtre"],
					guiHidden = true,
					func = function()
						OvaleOptions.db.profile.display = false
						Ovale.frame:Hide()	
					end
				},
				config  =
				{
					name = "Configuration",
					type = "execute",
					func = function() AceConfigDialog:SetDefaultSize("Ovale Apparence", 500, 550); AceConfigDialog:Open("Ovale Apparence") end
				},
				code  =
				{
					name = "Code",
					type = "execute",
					func = function() AceConfigDialog:SetDefaultSize("Ovale", 700, 550); AceConfigDialog:Open("Ovale") end
				},
				debug =
				{
					name = "Debug",
					type = "execute",
					func = function() AceConfigDialog:SetDefaultSize("Ovale Debug", 800, 550); AceConfigDialog:Open("Ovale Debug") end
				},
				power =
				{
					order = -3,
					name = "Power",
					type = "execute",
					func = function()
						OvaleState.state:DebugPower()
					end
				},
				talent =
				{
					order = -4,
					name = "List talent id",
					type = "execute",
					func = function() OvaleSpellBook:DebugTalents() end
				},
				targetbuff =
				{
					order = -5,
					name = "List target buffs and debuffs",
					type = "execute",
					func = function()
						OvaleState.state:PrintUnitAuras("target", "HELPFUL")
						OvaleState.state:PrintUnitAuras("target", "HARMFUL")
					end
				},
				buff =
				{
					order = -6,
					name = "List player buffs and debuffs",
					type = "execute",
					func = function()
						OvaleState.state:PrintUnitAuras("player", "HELPFUL")
						OvaleState.state:PrintUnitAuras("player", "HARMFUL")
					end
				},
				glyph =
				{
					order = -7,
					name = "List player glyphs",
					type = "execute",
					func = function() OvaleSpellBook:DebugGlyphs() end
				},
				spell =
				{
					order = -8,
					name = "List player spells",
					type = "execute",
					func = function() OvaleSpellBook:DebugSpells() end
				},
				stance =
				{
					order = -9,
					name = "List stances",
					type = "execute",
					func = function()
						if Ovale.OvaleStance then Ovale.OvaleStance:DebugStances() end
					end
				},
				profilestart = {
					order = -10,
					name = "Start gathering profiling stats",
					type = "execute",
					func = function() Ovale.Profiler:Enable(nil, true) end,
				},
				profilestop = {
					order = -11,
					name = "Stop gathering profiling stats",
					type = "execute",
					func = function() Ovale.Profiler:Disable(nil, true) end,
				},
				profilereset = {
					order = -12,
					name = "Reset profiling stats",
					type = "execute",
					func = function() Ovale.Profiler:Reset() end,
				},
				profile = {
					order = -13,
					name = "Print profiling stats",
					type = "execute",
					func = function() Ovale.Profiler:Info() end,
				},
				version = {
					order = -14,
					name = "Show version number",
					type = "execute",
					func = function() Ovale:Print(Ovale.version) end,
				},
				ping = {
					order = -15,
					name = "Ping for Ovale users in group",
					type = "execute",
					func = function() Ovale:VersionCheck() end,
				},
			},
		},
	},
}

local ldbMenuFrame = nil
--</private-static-properties>

--<public-static-properties>
OvaleOptions.db = nil
OvaleOptions.broker = nil
--</public-static-properties>

--<public-static-methods>
function OvaleOptions:OnInitialize()
	-- Resolve module dependencies.
	OvaleScripts = Ovale.OvaleScripts
	OvaleSpellBook = Ovale.OvaleSpellBook
	OvaleState = Ovale.OvaleState

	self.db = LibStub("AceDB-3.0"):New("OvaleDB",
	{
		profile = 
		{
			display = true,
			showHiddenScripts = false,
			source = "Ovale",
			code = "",
			left = 500,
			top = 500,
			check = {},
			list = {},
			debug = {},
			apparence = {
				enCombat = false,
				iconScale = 1,
				secondIconScale = 1,
				margin = 4,
				fontScale = 1,
				iconShiftX = 0,
				iconShiftY = 0,
				smallIconScale = 0.8,
				raccourcis = true,
				numeric = false,
				avecCible = false,
				verrouille = false,
				vertical = false,
				predictif = false,
				highlightIcon = true,
				clickThru = false,
				hideVehicule = false,
				flashIcon = true,
				targetText = "●",
				alpha = 1,
				optionsAlpha = 1,
				updateInterval = 0.1,
				auraLag = 400,
			}
		}
	})

	self_options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

	-- Add dual-spec support
	local LibDualSpec = LibStub("LibDualSpec-1.0",true)
	if LibDualSpec then
		LibDualSpec:EnhanceDatabase(self.db, "Ovale")
		LibDualSpec:EnhanceOptions(self_options.args.profile, self.db)
	end
	
	AceConfig:RegisterOptionsTable("Ovale", self_options.args.code)
	AceConfig:RegisterOptionsTable("Ovale Actions", self_options.args.actions, "Ovale")
	AceConfig:RegisterOptionsTable("Ovale Profile", self_options.args.profile)
	AceConfig:RegisterOptionsTable("Ovale Apparence", self_options.args.apparence)
	AceConfig:RegisterOptionsTable("Ovale Debug", self_options.args.debug)

	AceConfigDialog:AddToBlizOptions("Ovale", "Ovale")
	AceConfigDialog:AddToBlizOptions("Ovale Profile", "Profile", "Ovale")
	AceConfigDialog:AddToBlizOptions("Ovale Apparence", L["Apparence"], "Ovale")
	AceConfigDialog:AddToBlizOptions("Ovale Debug", "Debug", "Ovale")

	self.db.RegisterCallback( self, "OnNewProfile", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileReset", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileChanged", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileCopied", "HandleProfileChanges" )

	OvaleScripts:RegisterScript(self_class, "custom", L["Script personnalisé"], self.db.profile.code)

	-- LDB dataobject
	if LibDataBroker then
		local broker = {
			type = "data source",
			text = "",
			icon = self_classIcons[self_class],
			OnClick = function(frame, button)
				if button == "LeftButton" then
					local menu = {
						{ text = L["Script"], isTitle = true },
					}
					local scriptType = not OvaleOptions.db.profile.showHiddenScripts and "script"
					local descriptions = OvaleScripts:GetDescriptions(scriptType)
					for name, description in pairs(descriptions) do
						local menuItem = {
							text = description,
							func = function() OvaleOptions:SetScript(name) end,
						}
						tinsert(menu, menuItem)
					end
					ldbMenuFrame = ldbMenuFrame or API_CreateFrame("Frame", addonName .. "MenuFrame", UIParent, "UIDropDownMenuTemplate")
					API_EasyMenu(menu, ldbMenuFrame, "cursor", 0, 0, "MENU")
				elseif button == "RightButton" then
					OvaleOptions:ToggleConfig()
				end
			end,
			OnTooltipShow = function(tooltip)
				tooltip:SetText(addonName .. " " .. Ovale.version)
				tooltip:AddLine(L["Click to select the script."])
				tooltip:AddLine(L["Right-Click for options."])
			end,
		}
		self.broker = LibDataBroker:NewDataObject(addonName, broker)
	end
end

function OvaleOptions:OnEnable()
	self:RegisterMessage("Ovale_ScriptChanged")
	self:HandleProfileChanges()
end

function OvaleOptions:Ovale_ScriptChanged()
	-- Update the LDB dataobject.
	if self.broker then
		self.broker.text = self.db.profile.source
	end
end

function OvaleOptions:HandleProfileChanges()
	self:SendMessage("Ovale_ScriptChanged")
end

function OvaleOptions:GetProfile()
	return self.db.profile
end

function OvaleOptions:SetScript(name)
	local oldSource = self.db.profile.source
	if oldSource ~= name then
		self.db.profile.source = name
		self:SendMessage("Ovale_ScriptChanged")
	end
end

function OvaleOptions:ToggleConfig()
	local frameName = "Ovale Apparence"
	if AceConfigDialog.OpenFrames[frameName] then
		AceConfigDialog:Close(frameName)
	else
		AceConfigDialog:Open(frameName)
	end
end
--</public-static-methods>
