local _, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "ovale_paladin_spells"
	local desc = "[5.4.7] Ovale: Paladin spells"
	local code = [[
# Paladin spells and functions.

Define(ancient_power_buff 86700)
	SpellInfo(ancient_power_buff duration=30)
Define(ardent_defender 31850)
	SpellInfo(ardent_defender cd=180)
	SpellInfo(ardent_defender addcd=-60 itemset=T14_tank itemcount=2)
	SpellInfo(ardent_defender buff_cdr=cooldown_reduction_tank_buff)
Define(avengers_shield 31935)
	SpellInfo(avengers_shield holy=0 buff_holy=grand_crusader_buff cd=15)
	SpellInfo(avengers_shield cd_haste=melee if_spell=sanctity_of_battle)
	SpellAddBuff(avengers_shield grand_crusader_buff=0)
Define(avenging_wrath 31884)
	SpellInfo(avenging_wrath cd=180)
	SpellInfo(avenging_wrath addcd=-65 itemset=T14_melee itemcount=4)
	SpellInfo(avenging_wrath buff_cdr=cooldown_reduction_strength_buff specialization=retribution)
	SpellInfo(avenging_wrath buff_cdr=cooldown_reduction_tank_buff specialization=protection)
	SpellAddBuff(avenging_wrath avenging_wrath_buff=1)
Define(avenging_wrath_buff 31884)
	SpellInfo(avenging_wrath_buff duration=20)
	SpellInfo(avenging_wrath_buff addduration=10 talent=sanctified_wrath_talent)
Define(bastion_of_glory_buff 114637)
	SpellInfo(bastion_of_glory_buff duration=20 maxstacks=5)
Define(bastion_of_power_buff 144569)
	SpellInfo(bastion_of_power_buff duration=20)
Define(beacon_of_light 53563)
	SpellInfo(beacon_of_light cd=3)
	SpellInfo(beacon_of_light gcd=0 glyph=glyph_of_beacon_of_light)
	SpellAddTargetBuff(beacon_of_light beacon_of_light_buff=1)
Define(beacon_of_light_buff 53563)
Define(blessing_of_kings 20217)
Define(blessing_of_might 19740)
Define(blinding_light 115750)
	SpellInfo(blinding_light cd=120)
Define(consecration 26573)
	SpellInfo(consecration cd=9)
	SpellInfo(consecration cd_haste=melee haste=melee if_spell=sanctity_of_battle)
Define(consecration_debuff 26573)
	SpellInfo(consecration_debuff duration=9 tick=1)
	SpellInfo(consecration_debuff haste=melee if_spell=sanctity_of_battle)
Define(consecration_glyphed 116467)
Define(crusader_strike 35395)
	SpellInfo(crusader_strike holy=-1 cd=4.5)
	SpellInfo(crusader_strike cd_haste=melee if_spell=sanctity_of_battle)
	SpellAddTargetDebuff(crusader_strike weakened_blows=1 specialization=protection)
Define(daybreak 88821)
Define(daybreak_buff 88819)
	SpellInfo(daybreak_buff duration=10 maxstacks=2)
Define(devotion_aura 31821)
	SpellInfo(devotion_aura cd=180)
	SpellInfo(devotion_aura addcd=-60 glyph=glyph_of_devotion_aura)
Define(divine_crusader_buff 144595)
	SpellInfo(divine_crusader_buff duration=12)
Define(divine_favor 31842)
	SpellInfo(divine_favor cd=180)
Define(divine_light 82326)
Define(divine_plea 54428)
	SpellInfo(divine_plea cd=120)
	SpellInfo(divine_plea cd=60 glyph=glyph_of_divine_plea)
Define(divine_protection 498)
	SpellInfo(divine_protection cd=60)
	SpellInfo(divine_protection cd=30 talent=unbreakable_spirit_talent)
	SpellInfo(divine_protection buff_cdr=cooldown_reduction_strength_buff specialization=retribution)
	SpellInfo(divine_protection buff_cdr=cooldown_reduction_tank_buff specialization=protection)
	SpellAddBuff(divine_protection divine_protection_buff=1)
Define(divine_protection_buff 498)
	SpellInfo(divine_protection_buff duration=10)
Define(divine_purpose_buff 90174)
	SpellInfo(divine_purpose_buff duration=8)
Define(divine_purpose_talent 15)
Define(divine_shield 642)
	SpellInfo(divine_shield cd=300)
	SpellInfo(divine_shield cd=150 talent=unbreakable_spirit_talent)
	SpellInfo(divine_shield buff_cdr=cooldown_reduction_strength_buff specialization=retribution)
	SpellInfo(divine_shield buff_cdr=cooldown_reduction_tank_buff specialization=protection)
	SpellAddDebuff(divine_shield forbearance_debuff=1)
Define(divine_storm 53385)
	SpellInfo(divine_storm holy=3)
	SpellInfo(divine_storm buff_holy_none=divine_crusader_buff itemset=T16_melee itemcount=2)
	SpellAddBuff(divine_storm divine_crusader_buff=0 itemset=T16_melee itemcount=2)
	SpellAddBuff(divine_storm divine_purpose_buff=0 talent=divine_purpose_talent)
Define(emancipate 121783)
Define(eternal_flame 114163)
	SpellInfo(eternal_flame holy=finisher max_holy=3)
	SpellInfo(eternal_flame buff_holy_none=divine_purpose_buff talent=divine_purpose_talent)
	SpellInfo(eternal_flame buff_holy_none=word_of_glory_no_holy_power_buff if_spell=shield_of_the_righteous)
	SpellAddBuff(eternal_flame bastion_of_glory_buff=0 if_spell=shield_of_the_righteous)
	SpellAddBuff(eternal_flame bastion_of_power_buff=0 if_spell=shield_of_the_righteous itemset=T16_tank itemcount=4)
	SpellAddBuff(eternal_flame divine_purpose_buff=0 talent=divine_purpose_talent)
	SpellAddTargetBuff(eternal_flame eternal_flame_buff=1)
Define(eternal_flame_buff 114163)
	SpellInfo(eternal_flame_buff duration=30 haste=spell tick=3)
Define(eternal_flame_talent 8)
Define(execution_sentence 114157)
	SpellInfo(execution_sentence cd=60)
Define(execution_sentence_talent 18)
Define(exorcism 879)
	SpellInfo(exorcism holy=-1 cd=15)
	SpellInfo(exorcism cd_haste=melee if_spell=sanctity_of_battle specialization=retribution)
Define(exorcism_glyphed 122032)
	SpellInfo(exorcism_glyphed holy=-1 cd=15)
	SpellInfo(exorcism_glyphed cd_haste=melee if_spell=sanctity_of_battle specialization=retribution)
Define(fist_of_justice 105593)
	SpellInfo(fist_of_justice cd=30)
Define(fist_of_justice_talent 4)
Define(forbearance_debuff 25771)
	SpellInfo(forbearance_debuff duration=60)
Define(glyph_of_beacon_of_light 63218)
Define(glyph_of_consecration 54928)
Define(glyph_of_devotion_aura 146955)
Define(glyph_of_divine_plea 63223)
Define(glyph_of_divinity 54939)
Define(glyph_of_mass_exorcism 122028)
Define(grand_crusader_buff 85416)
	SpellInfo(grand_crusader_buff duration=6)
Define(guardian_of_ancient_kings_heal 86669)
	SpellInfo(guardian_of_ancient_kings_heal cd=180)
Define(guardian_of_ancient_kings_melee 86698)
	SpellInfo(guardian_of_ancient_kings_melee cd=180)
	SpellInfo(guardian_of_ancient_kings_melee buff_cdr=cooldown_reduction_strength_buff)
Define(guardian_of_ancient_kings_tank 86659)
	SpellInfo(guardian_of_ancient_kings_tank cd=180)
	SpellInfo(guardian_of_ancient_kings_tank buff_cdr=cooldown_reduction_tank_buff)
	SpellAddBuff(guardian_of_ancient_kings_tank guardian_of_ancient_kings_tank_buff=1)
Define(guardian_of_ancient_kings_tank_buff 86659)
	SpellInfo(guardian_of_ancient_kings_tank_buff duration=12)
Define(hammer_of_justice 853)
	SpellInfo(hammer_of_justice cd=60)
Define(hammer_of_the_righteous 53595)
	SpellInfo(hammer_of_the_righteous holy=-1 cd=4.5)
	SpellInfo(hammer_of_the_righteous cd_haste=melee if_spell=sanctity_of_battle)
Define(hammer_of_wrath 24275)
	SpellInfo(hammer_of_wrath cd=6)
	SpellInfo(hammer_of_wrath cd_haste=melee if_spell=sanctity_of_battle)
	SpellInfo(hammer_of_wrath holy=-1 specialization=retribution)
Define(hand_of_freedom 1044)
	SpellInfo(hand_of_freedom cd=25)
	SpellInfo(hand_of_freedom buff_cdr=cooldown_reduction_strength_buff specialization=retribution)
Define(hand_of_protection 1022)
	SpellInfo(hand_of_protection cd=300)
	SpellInfo(hand_of_protection buff_cdr=cooldown_reduction_strength_buff specialization=retribution)
	SpellInfo(hand_of_protection buff_cdr=cooldown_reduction_tank_buff specialization=protection)
	SpellAddTargetDebuff(hand_of_protection forbearance_debuff=1)
Define(holy_avenger 105809)
	SpellInfo(holy_avenger cd=120)
Define(holy_avenger_buff 105809)
	SpellInfo(holy_avenger_buff duration=18)
Define(holy_avenger_talent 13)
Define(holy_prism 114165)
	SpellInfo(holy_prism cd=20)
Define(holy_prism_talent 16)
Define(holy_radiance 82327)
	SpellInfo(holy_radiance holy=-1)
	SpellAddBuff(holy_radiance daybreak_buff=1 if_spell=daybreak)
	SpellAddBuff(holy_radiance selfless_healer_buff=0 specialization=holy talent=selfless_healer_talent)
Define(holy_shock 20473)
	SpellInfo(holy_shock cd=6 holy=-1)
	SpellInfo(holy_shock cd=5 itemset=T14_heal itemcount=4)
	SpellInfo(holy_shock cd_haste=melee if_spell=sanctity_of_battle)
	SpellAddBuff(holy_shock daybreak_buff=-1 if_spell=daybreak)
Define(holy_wrath 119072)
	SpellInfo(holy_wrath cd=9)
	SpellInfo(holy_wrath cd_haste=melee if_spell=sanctity_of_battle)
Define(inquisition 84963)
	SpellInfo(inquisition holy=finisher max_holy=3)
	SpellInfo(inquisition buff_holy_none=divine_purpose_buff talent=divine_purpose_talent)
	SpellAddBuff(inquisition inquisition_buff=1)
	SpellAddBuff(inquisition divine_purpose_buff=0 talent=divine_purpose_talent)
Define(inquisition_buff 84963)
	SpellInfo(inquisition_buff duration=20)
Define(judgment 20271)
	SpellInfo(judgment cd=6)
	SpellInfo(judgment cd_haste=melee if_spell=sanctity_of_battle)
	SpellInfo(judgment holy=-1 specialization=holy talent=selfless_healer_talent)
	SpellInfo(judgment holy=-1 if_spell=judgments_of_the_bold)
	SpellInfo(judgment holy=-1 if_spell=judgments_of_the_wise)
	SpellInfo(judgment holy=-1 buff_holy=avenging_wrath_buff if_spell=judgments_of_the_wise talent=sanctified_wrath_talent)
	SpellAddBuff(judgment selfless_healer_buff=1 specialization=holy talent=selfless_healer_talent)
Define(judgments_of_the_bold 111529)
Define(judgments_of_the_wise 105424)
Define(lay_on_hands 633)
	SpellInfo(lay_on_hands cd=600)
	SpellInfo(lay_on_hands cd=720 glyph=glyph_of_divinity)
	SpellInfo(lay_on_hands cd=300 talent=unbreakable_spirit_talent)
	SpellInfo(lay_on_hands cd=360 glyph=glyph_of_divinity talent=unbreakable_spirit_talent)
	SpellAddTargetDebuff(lay_on_hands forbearance_debuff=1)
Define(light_of_dawn 85222)
	SpellInfo(light_of_dawn holy=finisher max_holy=3)
	SpellInfo(light_of_dawn buff_holy_none=divine_purpose_buff talent=divine_purpose_talent)
	SpellAddBuff(light_of_dawn divine_purpose_buff=0 talent=divine_purpose_talent)
Define(lights_hammer 114158)
	SpellInfo(lights_hammer cd=60)
Define(lights_hammer_talent 17)
Define(rebuke 96231)
	SpellInfo(rebuke cd=15)
Define(righteous_fury 25780)
Define(sacred_shield 20925)
	SpellInfo(sacred_shield cd=6)
	SpellAddBuff(sacred_shield sacred_shield_buff=1)
Define(sacred_shield_buff 20925)
	SpellInfo(sacred_shield duration=30 haste=spell tick=6)
Define(sacred_shield_holy 148039)
	SpellAddTargetBuff(sacred_shield_holy sacred_shield_holy_buff=1)
Define(sacred_shield_holy_buff 148039)
	SpellInfo(sacred_shield_holy duration=30 haste=spell tick=6)
Define(sacred_shield_talent 9)
Define(sanctified_wrath_talent 14)
Define(sanctity_of_battle 25956)
Define(seal_of_insight 20165)
	SpellInfo(seal_of_insight to_stance=paladin_seal_of_insight)
Define(seal_of_righteousness 20154)
	SpellInfo(seal_of_righteousness to_stance=paladin_seal_of_righteousness)
Define(seal_of_truth 31801)
	SpellInfo(seal_of_truth to_stance=paladin_seal_of_truth)
Define(selfless_healer_buff 114250)
	SpellInfo(selfless_healer_buff duration=15)
Define(selfless_healer_talent 7)
Define(shield_of_the_righteous 53600)
	SpellInfo(shield_of_the_righteous cd=1.5 holy=3)
	SpellInfo(shield_of_the_righteous cd_haste=melee haste=melee if_spell=sanctity_of_battle)
	SpellInfo(shield_of_the_righteous buff_holy_none=divine_purpose_buff talent=divine_purpose_talent)
	SpellAddBuff(shield_of_the_righteous bastion_of_glory_buff=1 shield_of_the_righteous_buff=1)
	SpellAddBuff(shield_of_the_righteous divine_purpose_buff=0 talent=divine_purpose_talent)
Define(shield_of_the_righteous_buff 132403)
	SpellInfo(shield_of_the_righteous_buff duration=3)
Define(templars_verdict 85256)
	SpellInfo(templars_verdict holy=3)
	SpellInfo(templars_verdict buff_holy_none=divine_purpose_buff talent=divine_purpose_talent)
	SpellAddBuff(templars_verdict divine_purpose_buff=0 talent=divine_purpose_talent)
	SpellAddBuff(templars_verdict tier15_4pc_melee_buff=0 itemset=T15_melee itemcount=4)
Define(tier15_4pc_melee_buff 138169)
Define(unbreakable_spirit_talent 11)
Define(word_of_glory 85673)
	SpellInfo(word_of_glory holy=finisher max_holy=3)
	SpellInfo(word_of_glory buff_holy_none=divine_purpose_buff talent=divine_purpose_talent)
	SpellInfo(word_of_glory buff_holy_none=word_of_glory_no_holy_power_buff if_spell=shield_of_the_righteous)
	SpellAddBuff(word_of_glory bastion_of_glory_buff=0 if_spell=shield_of_the_righteous)
	SpellAddBuff(word_of_glory bastion_of_power_buff=0 if_spell=shield_of_the_righteous itemset=T16_tank itemcount=4)
	SpellAddBuff(word_of_glory divine_purpose_buff=0 talent=divine_purpose_talent)
SpellList(word_of_glory_no_holy_power_buff bastion_of_power_buff divine_purpose_buff)
]]

	OvaleScripts:RegisterScript("PALADIN", name, desc, code, "include")
end