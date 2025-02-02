
local CopyTable = TidyPlatesUtility.copyTable

TidyPlatesHubCache = {}
TidyPlatesHubSettings = {}

TidyPlatesHubDefaults = {
	-- Profile
	---------------------------------------
	UseGlobalSet = false,

	-- Style
	---------------------------------------
	ColorEnemyBarMode =  2,
	ColorEnemyNameMode = 1,
	ColorEnemyStatusTextMode = 1,

	ColorFriendlyBarMode =  2,
	ColorFriendlyNameMode = 1,
	ColorFriendlyStatusTextMode = 1,

	TextShowOnlyOnActive = false,


	-- Headline
	---------------------------------------
	StyleEnemyMode = 1,
	StyleFriendlyMode = 1,

	HeadlineEnemyColor = 4,
	HeadlineFriendlyColor = 4,
	TextPlateFieldMode = 3,

	-- Opacity
	---------------------------------------
	OpacityTarget = 1,
	OpacityNonTarget = .5,
	--OpacitySpotlightMode = 1,




	EnemyAlphaSpotlightMode = 1,
	FriendlyAlphaSpotlightMode = 1,

	OpacitySpotlight = 1,
	OpacityFullNoTarget = true,				-- Use full opacity when No Target

	--OpacityFullSpell = false,				-- Deprecated 6.13
	--OpacityFullMouseover = false,			-- Deprecated 6.13

	OpacitySpotlightSpell = false,			-- Added 6.14
	OpacitySpotlightMouseover = false,		-- Added 6.14
	OpacitySpotlightRaidMarked = false,		-- Added 6.14

	-- Unit Spotlight
	---------------------------------------
	UnitSpotlightOpacity = 1,
	UnitSpotlightScale = 1.4,
	UnitSpotlightColor = {r = .8, g = 0, b = 0,},
	UnitSpotlightOpacityEnable = true,
	UnitSpotlightScaleEnable = true,
	UnitSpotlightBarEnable = true,
	UnitSpotlightGlowEnable = true,
	UnitSpotlightList = "",
	UnitSpotlightLookup = {},

	-- Filter
	---------------------------------------
	OpacityFiltered = 0,
	ScaleFiltered = .8,
	FilterScaleLock = false,

	OpacityFilterNeutralUnits = false,		-- OpacityHideNeutral = false,
	OpacityFilterNonElite = false,			-- OpacityHideNonElites = false,
	OpacityFilterNPC = false,
	OpacityFilterPlayers = false,
	OpacityFilterFriendlyNPC = false,
	OpacityFilterInactive = false,
	OpacityFilterMini = false,
	OpacityFilterList = "Fanged Pit Viper",
	OpacityFilterLookup = {},

	-- Scale
	---------------------------------------
	ScaleStandard = 1,
	ScaleSpotlight = 1.2,
	ScaleSpotlightMode = 4,
	ScaleIgnoreNeutralUnits = false,
	ScaleIgnoreNonEliteUnits = false,
	ScaleIgnoreInactive = false,
	ScaleCastingSpotlight = false,
	ScaleTargetSpotlight = false,
	ScaleMiniMobs = true,

	-- Text
	---------------------------------------
	TextShowLevel = false,
	TextUseBlizzardFont = false,
	TextHealthTextMode = 1,
	TextShowOnlyOnTargets = false,

	-- Color
	---------------------------------------
	ColorHealthBarMode = 3,
	ColorDangerGlowMode = 2,
	TextNameColorMode = 1,
	ClassColorPartyMembers = false,
	ColorEnableOffTank = false,

	-- Threat
	---------------------------------------
	ThreatMode = 1,
	ThreatGlowEnable = true,
	ColorAttackingMe = {r = .8, g = 0, b = 0,},		-- Orange
	ColorAggroTransition = {r = 255/255, g = 160/255, b = 0},	-- Yellow
	ColorAttackingOthers = {r = 15/255, g = 150/255, b = 230/255},	-- Bright Blue
	ColorAttackingOtherTank = {r = 15/255, g = 170/255, b = 200/255},	-- Bright Blue
	ColorShowPartyAggro = false,
	ColorPartyAggro = {r = 255/255, g = 0, b = .4,},
	ColorPartyAggroBar = false,
	ColorPartyAggroGlow = true,
	ColorPartyAggroText = false,


	-- Reaction
	---------------------------------------
	ColorFriendlyNPC = {r = 0, g = 1, b = 0,},
	ColorFriendlyPlayer = {r = 0, g = 0, b = 1,},
	ColorNeutral = {r = 1, g = 1, b = 0,},
	ColorHostileNPC = {r = 1, g = 0, b = 0,},
	ColorHostilePlayer = {r = 1, g = 0, b = 0,},
	ColorGuildMember = {r = 60/255, g = 168/255, b = 255/255,},

	TextColorFriendlyNPC = {r = 96/255, g = 224/255, b = 37/255,},
	TextColorFriendlyPlayer = {r = 60/255, g = 168/255, b = 255/255,},
	TextColorNeutral = {r = 252/255, g = 180/255, b = 27/255,},
	TextColorHostileNPC = {r = 255/255, g = 51/255, b = 32/255,},
	TextColorHostilePlayer = {r = 255/255, g = 51/255, b = 32/255,},
	TextColorGuildMember = {r = 60/255, g = 168/255, b = 255/255,},

	ColorTapped = {r = 110/255, g = 110/255, b = 110/255,},

	-- Casting
	---------------------------------------
	ColorNormalSpellCast = { r = 252/255, g = 140/255, b = 0, },
	ColorUnIntpellCast = { r = 0.5137243866920471, g = 0.7529395222663879, b = 0.7647042274475098, },
	SpellCastEnableFriendly = false,

	-- Status Text
	---------------------------------------
	StatusTextLeft = 8,
	StatusTextCenter = 5,
	StatusTextRight = 7,

	StatusTextLeftColor = true,
	StatusTextCenterColor = true,
	StatusTextRightColor = true,



	-- Health
	---------------------------------------
	HighHealthThreshold = .7,
	LowHealthThreshold = .3,
	ColorLowHealth = {r = 1, g = 0, b = 0,},		-- Orange
	ColorMediumHealth = {r = 1, g = 1, b = 0},	-- Yellow
	ColorHighHealth = {r = 0, g = 1, b = .2},	-- Bright Blue

	-- Widgets
	---------------------------------------
	WidgetTargetHighlight = true,
	WidgetEliteIndicator = true,
	ClassEnemyIcon = false,
	ClassPartyIcon = false,
	WidgetsTotemIcon = false,
	WidgetsComboPoints = true,
	WidgetsThreatIndicator = true,
	WidgetsThreatIndicatorMode = 1,
	WidgetsRangeIndicator = false,
	WidgetsRangeMode = 1,
	WidgetsEnableExternal = true,

	-- Aura Widget
	---------------------------------------
	WidgetsDebuff = true,
	WidgetsDebuffStyle = 1,
	WidgetsAuraMode = 1,
	WidgetsMyDebuff = true,
	WidgetsMyBuff = false,
	WidgetsDebuffTrackList = "My Rake\nMy Rip\nMy Moonfire\nAll 339\nMy Regrowth\nMy Rejuvenation\nNot Facepalm Bolt",
	WidgetsDebuffLookup = {},
	WidgetsDebuffPriority = {},
	WidgetAuraTrackDispelFriendly = false,
	WidgetAuraTrackCurse = true,
	WidgetAuraTrackDisease = true,
	WidgetAuraTrackMagic = true,
	WidgetAuraTrackPoison = true,

	-- Frame
	---------------------------------------
	FrameVerticalPosition = .7,
	AdvancedEnableUnitCache = true,
	--AdvancedHealthTextList = [[return unit.health]],
}

TidyPlatesHubGlobal = CopyTable(TidyPlatesHubDefaults)






