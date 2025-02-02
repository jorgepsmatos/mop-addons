local _, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "ovale_druid_spells"
	local desc = "[5.4.7] Ovale: Druid spells"
	local code = [[
# Druid spells and functions.

Define(astral_communion 127663)
	SpellInfo(astral_communion channel=4)
Define(astral_storm 106996)
	SpellInfo(astral_storm arcane=1 channel=10 haste=spell)
Define(barkskin 22812)
	SpellInfo(barkskin cd=60)
	SpellInfo(barkskin buff_cdr=cooldown_reduction_agility_buff specialization=feral)
	SpellInfo(barkskin buff_cdr=cooldown_reduction_tank_buff specialization=guardian)
	SpellInfo(barkskin addcd=-15 if_spell=malfurions_gift)
Define(bear_form 5487)
	SpellInfo(bear_form rage=-10 to_stance=druid_bear_form)
Define(berserk_bear 50334)
	SpellInfo(berserk_bear cd=180)
	SpellInfo(berserk_bear buff_cdr=cooldown_reduction_tank_buff specialization=guardian)
	SpellAddBuff(berserk_bear berserk_bear_buff=1)
Define(berserk_bear_buff 50334)
	SpellInfo(berserk_bear_buff duration=10)
Define(berserk_cat 106951)
	SpellInfo(berserk_cat cd=180)
	SpellInfo(berserk_cat buff_cdr=cooldown_reduction_agility_buff specialization=feral)
	SpellAddBuff(berserk_cat berserk_cat_buff=1)
Define(berserk_cat_buff 106951)
	SpellInfo(berserk_cat duration=15)
Define(cat_form 768)
	SpellInfo(cat_form to_stance=druid_cat_form)
Define(celestial_alignment 112071)
	SpellInfo(celestial_alignment cd=180)
	SpellAddBuff(celestial_alignment celestial_alignment_buff=1)
Define(celestial_alignment_buff 112071)
	SpellInfo(celestial_alignment_buff duration=15)
Define(cenarion_ward 102351)
	SpellInfo(cenarion_ward cd=30)
Define(cenarion_ward_talent 6)
Define(chosen_of_elune_buff 102560)
	SpellInfo(chosen_of_elune_buff duration=30)
Define(dash 1850)
	SpellInfo(dash cd=180)
	SpellInfo(dash addcd=-60 glyph=glyph_of_dash)
	SpellInfo(dash buff_cdr=cooldown_reduction_agility_buff specialization=feral)
Define(displacer_beast 102280)
	SpellInfo(displacer_beast cd=30)
Define(displacer_beast_talent 2)
Define(dream_of_cenarius_caster_buff 145151)
	SpellInfo(dream_of_cenarius_caster_buff duration=30)
Define(dream_of_cenarius_melee_buff 145152)
	SpellInfo(dream_of_cenarius_melee_buff duration=30 maxstacks=2)
Define(dream_of_cenarius_tank_buff 145162)
	SpellInfo(dream_of_cenarius_tank_buff duration=20)
Define(dream_of_cenarius_talent 17)
Define(enrage 5229)
	SpellInfo(enrage cd=60 rage=-20)
Define(faerie_fire 770)
	SpellInfo(faerie_fire nature=1)
	SpellInfo(faerie_fire cd=6 if_stance=druid_bear_form)
	SpellInfo(faerie_fire cd=6 if_stance=druid_cat_form)
	SpellInfo(faerie_fire cd=15 glyph=glyph_of_fae_silence if_stance=druid_bear_form)
	SpellAddTargetDebuff(faerie_fire weakened_armor=3)
Define(faerie_swarm 102355)
	SpellInfo(faerie_swarm nature=1)
	SpellInfo(faerie_swarm cd=6 if_stance=druid_bear_form)
	SpellInfo(faerie_swarm cd=6 if_stance=druid_cat_form)
	SpellInfo(faerie_swarm cd=15 glyph=glyph_of_fae_silence if_stance=druid_bear_form)
	SpellAddTargetDebuff(faerie_swarm weakened_armor=3)
Define(faerie_swarm_talent 7)
Define(feral_fury_buff 48848)
	SpellInfo(feral_fury_buff duration=6)
Define(feral_rage_buff 146874)
	SpellInfo(feral_rage_buff duration=20)
Define(ferocious_bite 22568)
	SpellInfo(ferocious_bite combo=finisher energy=25 physical=1)
	SpellInfo(ferocious_bite buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(ferocious_bite buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellInfo(ferocious_bite damage=FeralFerociousBiteDamage specialization=feral)
	SpellAddBuff(ferocious_bite omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
Define(force_of_nature_caster 33831)
	SpellInfo(force_of_nature_caster gcd=0 nature=1)
Define(force_of_nature_heal 102693)
	SpellInfo(force_of_nature_heal gcd=0)
Define(force_of_nature_melee 102703)
	SpellInfo(force_of_nature_melee gcd=0)
Define(force_of_nature_talent 12)
Define(force_of_nature_tank 102706)
	SpellInfo(force_of_nature_tank gcd=0)
Define(frenzied_regeneration 22842)
	SpellInfo(frenzied_regeneration cd=1.5)
	SpellInfo(frenzied_regeneration rage=finisher max_rage=60 glyph=!glyph_of_frenzied_regeneration)
	SpellInfo(frenzied_regeneration rage=50 glyph=glyph_of_frenzied_regeneration)
Define(genesis 145518)
Define(glyph_of_blooming 121840)
Define(glyph_of_dash 59219)
Define(glyph_of_efflorescence 145529)
Define(glyph_of_fae_silence 114237)
Define(glyph_of_frenzied_regeneration 54810)
Define(glyph_of_might_of_ursoc 116238)
Define(glyph_of_regrowth 116218)
Define(glyph_of_savagery 127540)
Define(glyph_of_skull_bash 116216)
Define(glyph_of_survival_instincts 114223)
Define(glyph_of_wild_growth 62970)
Define(harmony 77495)
Define(harmony_buff 100977)
	SpellInfo(harmony_buff duration=20)
Define(healing_touch 5185)
	SpellAddBuff(healing_touch dream_of_cenarius_caster_buff=1 specialization=balance talent=dream_of_cenarius_talent)
	SpellAddBuff(healing_touch dream_of_cenarius_melee_buff=2 specialization=feral talent=dream_of_cenarius_talent)
	SpellAddBuff(healing_touch dream_of_cenarius_tank_buff=0 specialization=guardian talent=dream_of_cenarius_talent)
	SpellAddBuff(healing_touch harmony_buff=1 if_spell=harmony)
	SpellAddBuff(healing_touch natures_swiftness_buff=0 if_spell=natures_swiftness)
	SpellAddBuff(healing_touch omen_of_clarity_heal_buff=0 if_spell=omen_of_clarity_heal)
	SpellAddBuff(healing_touch predatory_swiftness_buff=0 if_spell=predatory_swiftness)
	SpellAddBuff(healing_touch sage_mender_buff=0 itemset=T16_heal itemcount=2)
	SpellAddTargetBuff(healing_touch lifebloom_buff=refresh if_spell=lifebloom)
Define(heart_of_the_wild_caster 108291)
	SpellInfo(heart_of_the_wild_caster cd=360)
Define(heart_of_the_wild_heal 108294)
	SpellInfo(heart_of_the_wild_heal cd=360)
Define(heart_of_the_wild_melee 108292)
	SpellInfo(heart_of_the_wild_melee cd=360)
Define(heart_of_the_wild_talent 16)
Define(hurricane 16914)
	SpellInfo(hurricane channel=10 haste=spell nature=1)
Define(incarnation 106731)
	SpellInfo(incarnation cd=180)
Define(incarnation_caster 102560)
	SpellInfo(incarnation_caster cd=180)
	SpellAddBuff(incarnation_caster chosen_of_elune_buff=1)
Define(incarnation_heal 33891)
	SpellInfo(incarnation_heal cd=180 forcecd=incarnation)
	SpellAddBuff(incarnation_heal tree_of_life_buff=1)
Define(incarnation_melee 102543)
	SpellInfo(incarnation_melee cd=180)
	SpellAddBuff(incarnation_melee king_of_the_jungle_buff=1)
Define(incarnation_tank 102558)
	SpellInfo(incarnation_tank cd=180)
	SpellAddBuff(incarnation_tank son_of_ursoc_buff=1)
Define(incarnation_talent 11)
Define(innervate 29166)
	SpellInfo(innervate cd=180)
Define(ironbark 102342)
	SpellInfo(ironbark cd=90)
Define(king_of_the_jungle_buff 102543)
	SpellInfo(king_of_the_jungle_buff duration=30)
Define(lifebloom 33763)
	SpellAddTargetBuff(lifebloom lifebloom_buff=1)
Define(lacerate 33745)
	SpellInfo(lacerate cd=3)
	SpellAddTargetDebuff(lacerate lacerate_debuff=1)
Define(lacerate_debuff 33745)
	SpellInfo(lacerate_debuff duration=15 tick=3)
Define(lifebloom 33763)
	SpellAddTargetBuff(lifebloom lifebloom_buff=1)
Define(lifebloom_buff 33763)
	SpellInfo(lifebloom_buff duration=15 haste=spell tick=1 maxstacks=3)
	SpellInfo(lifebloom_buff addduration=-5 glyph=glyph_of_blooming)
Define(lunar_eclipse_buff 48518)
Define(maim 22570)
	SpellInfo(maim cd=10 combo=finisher energy=35 physical=1)
	SpellInfo(maim buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(maim buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellAddBuff(maim omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
Define(malfurions_gift 92364)
Define(mangle_bear 33878)
	SpellInfo(mangle_bear buffnocd=mangle_no_cooldown_buff cd=6 rage=-5)
	SpellInfo(mangle_bear rage=-8 talent=soul_of_the_forest_talent)
Define(mangle_cat 33876)
	SpellInfo(mangle_cat combo=1 energy=35 physical=1)
	SpellInfo(mangle_cat critcombo=1 if_spell=primal_fury)
	SpellInfo(mangle_cat buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(mangle_cat buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellInfo(mangle_cat damage=FeralMangleCatDamage specialization=feral)
	SpellAddBuff(mangle_cat omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
SpellList(mangle_no_cooldown_buff berserk_bear_buff son_of_ursoc_buff)
Define(mark_of_the_wild 1126)
Define(maul 6807)
	SpellInfo(maul cd=3 rage=30)
	SpellAddBuff(maul omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
Define(might_of_ursoc 106922)
	SpellInfo(might_of_ursoc cd=180)
	SpellInfo(might_of_ursoc addcd=120 glyph=glyph_of_might_of_ursoc)
	SpellInfo(might_of_ursoc addcd=-60 itemset=T14_tank itemcount=2)
	SpellInfo(might_of_ursoc buff_cdr=cooldown_reduction_tank_buff specialization=guardian)
Define(mighty_bash 5211)
	SpellInfo(mighty_bash cd=50)
Define(mighty_bash_talent 15)
Define(moonfire 8921)
	SpellInfo(moonfire arcane=1)
	SpellAddTargetDebuff(moonfire moonfire_debuff=1)
Define(moonfire_debuff 8921)
	SpellInfo(moonfire_debuff arcane=1 duration=14 haste=spell tick=2)
	SpellInfo(moonfire_debuff addduration=2 itemset=T14_caster itemcount=4)
	SpellInfo(moonfire_debuff damage=BalanceMoonfireTickDamage specialization=balance)
	SpellInfo(moonfire_debuff lastEstimatedDamage=BalanceMoonfireTickLastDamage specialization=balance)
Define(moonkin_form 24858)
	SpellInfo(moonkin_form to_stance=druid_moonkin_form)
Define(natures_grace_buff 16886)
	SpellInfo(natures_grace_buff duration=15)
Define(natures_swiftness 132158)
	SpellInfo(natures_swiftness cd=60)
	SpellAddBuff(natures_swiftness natures_swiftness_buff=1)
Define(natures_swiftness_buff 132158)
Define(natures_vigil 124974)
	SpellInfo(natures_vigil cd=90)
Define(natures_vigil_talent 18)
Define(nourish 50464)
	SpellAddBuff(nourish harmony_buff=1 if_spell=harmony)
	SpellAddBuff(nourish natures_swiftness_buff=0 if_spell=natures_swiftness)
	SpellAddBuff(nourish omen_of_clarity_heal_buff=0 if_spell=omen_of_clarity_heal)
	SpellAddTargetBuff(nourish lifebloom_buff=refresh if_spell=lifebloom)
Define(omen_of_clarity_heal 113043)
Define(omen_of_clarity_heal_buff 16870)
	SpellInfo(omen_of_clarity_heal_buff duration=15)
Define(omen_of_clarity_melee 16864)
Define(omen_of_clarity_melee_buff 135700)
	SpellInfo(omen_of_clarity_melee_buff duration=15)
Define(predatory_swiftness 16974)
Define(predatory_swiftness_buff 69369)
	SpellInfo(predatory_swiftness_buff duration=8)
Define(prowl 5215)
Define(rake 1822)
	SpellInfo(rake combo=1 energy=35 physical=1)
	SpellInfo(rake critcombo=1 if_spell=primal_fury)
	SpellInfo(rake buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(rake buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellAddBuff(rake omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
	SpellAddTargetDebuff(rake rake_debuff=1)
Define(rake_debuff 1822)
	SpellInfo(rake_debuff duration=15 tick=3)
	SpellInfo(rake_debuff damage=FeralRakeTickDamage specialization=feral)
	SpellInfo(rake_debuff lastEstimatedDamage=FeralRakeTickLastDamage specialization=feral)
	SpellDamageBuff(rake_debuff dream_of_cenarius_melee_buff=1.3)
Define(ravage 6785)
	SpellInfo(ravage combo=1 energy=45 physical=1)
	SpellInfo(ravage critcombo=1 if_spell=primal_fury)
	SpellInfo(ravage buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(ravage buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellInfo(ravage damage=FeralRavageDamage specialization=feral)
	SpellAddBuff(ravage omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
Define(rebirth 20484)
	SpellInfo(rebirth cd=600)
	SpellAddBuff(rebirth dream_of_cenarius_tank_buff=0 specialization=guardian talent=dream_of_cenarius_talent)
	SpellAddBuff(rebirth predatory_swiftness_buff=0 if_spell=predatory_swiftness)
Define(regrowth 8936)
	SpellAddBuff(regrowth harmony_buff=1 if_spell=harmony)
	SpellAddBuff(regrowth natures_swiftness_buff=0 if_spell=natures_swiftness)
	SpellAddBuff(regrowth omen_of_clarity_heal_buff=0 if_spell=omen_of_clarity_heal)
	SpellAddTargetBuff(regrowth regrowth_buff=1 glyph=!glyph_of_regrowth)
	SpellAddTargetBuff(regrowth lifebloom_buff=refresh if_spell=lifebloom)
Define(regrowth_buff 8936)
	SpellInfo(regrowth_buff duration=6 haste=spell tick=2)
Define(rejuvenation 774)
	SpellAddTargetBuff(rejuvenation rejuvenation_buff=1)
Define(rejuvenation_buff 774)
	SpellInfo(rejuvenation_buff duration=12 haste=spell tick=3)
Define(renewal 108238)
	SpellInfo(renewal cd=120)
Define(renewal_talent 5)
Define(rip 1079)
	SpellInfo(rip combo=finisher energy=30)
	SpellAddTargetDebuff(rip rip_debuff=1)
	SpellInfo(rip buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(rip buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellAddBuff(rip omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
Define(rip_debuff 1079)
	SpellInfo(rip_debuff duration=16 resetcounter=ripshreds tick=2)
	SpellInfo(rip_debuff addduration=4 itemset=T14_melee itemcount=4)
	SpellInfo(rip_debuff base=14.125 bonuscp=40 bonusapcp=0.0484)
	SpellInfo(rip_debuff damage=FeralRipTickDamage specialization=feral)
	SpellInfo(rip_debuff lastEstimatedDamage=FeralRipTickLastDamage specialization=feral)
	SpellDamageBuff(rip_debuff dream_of_cenarius_damage_buff=1.3)
Define(rune_of_reorigination_buff 139120)
	SpellInfo(rune_of_reorigination_buff duration=10)
Define(sage_mender_buff 144871)
	SpellInfo(sage_mender_buff duration=60 maxstacks=5)
Define(savage_defense 62606)
	SpellInfo(savage_defense rage=60)
	SpellAddBuff(savage_defense savage_defense_buff=1)
Define(savage_defense_buff 132402)
	SpellInfo(savage_defense_buff duration=6)
Define(savage_roar 52610)
	SpellInfo(savage_roar combo=finisher energy=25 min_combo=1)
	SpellInfo(savage_roar duration=12 adddurationcp=6)
	SpellInfo(savage_roar buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(savage_roar buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellAddBuff(savage_roar savage_roar=1)
	SpellAddBuff(savage_roar omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
Define(savage_roar_glyphed 127538)
	SpellInfo(savage_roar_glyphed combo=finisher energy=25)
	SpellInfo(savage_roar_glyphed duration=12 adddurationcp=6)
	SpellInfo(savage_roar_glyphed buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(savage_roar_glyphed buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellAddBuff(savage_roar_glyphed savage_roar_glyphed=1)
	SpellAddBuff(savage_roar_glyphed omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
SpellList(savage_roar_buff savage_roar savage_roar_glyphed)
Define(shred 5221)
	SpellInfo(shred combo=1 energy=40 physical=1)
	SpellInfo(shred critcombo=1 if_spell=primal_fury)
	SpellInfo(shred buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(shred buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellInfo(shred damage=FeralShredDamage specialization=feral)
	SpellAddBuff(shred omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
Define(shooting_stars_buff 93400)
	SpellInfo(shooting_stars_buff duration=12)
Define(skull_bash_bear 106839)
	SpellInfo(skull_bash_bear cd=15)
	SpellInfo(skull_bash_bear addcd=5 glyph=glyph_of_skull_bash)
Define(skull_bash_cat 80965)
	SpellInfo(skull_bash_cat cd=15)
	SpellInfo(skull_bash_cat addcd=5 glyph=glyph_of_skull_bash)
Define(solar_beam 78675)
	SpellInfo(solar_beam cd=60)
Define(solar_eclipse_buff 48517)
Define(son_of_ursoc_buff 102558)
	SpellInfo(son_of_ursoc_buff duration=30)
Define(soul_of_the_forest_talent 10)
Define(starfall 48505)
	SpellInfo(starfall arcane=1 cd=90)
	SpellAddBuff(starfall starfall_buff=1)
Define(starfall_buff 48505)
	SpellInfo(starfall_buff duration=10)
Define(starfire 2912)
	SpellInfo(starfire arcane=1 eclipse=20)
Define(starsurge 78674)
	SpellInfo(starsurge arcane=1 cd=15 eclipse=20 eclipsedir=1 nature=1)
	SpellAddBuff(starsurge shooting_stars_buff=0)
Define(sunfire 93402)
	SpellInfo(sunfire nature=1)
	SpellAddTargetDebuff(sunfire sunfire_debuff=1)
Define(sunfire_debuff 93402)
	SpellInfo(sunfire_debuff duration=14 haste=spell nature=1 tick=2)
	SpellInfo(sunfire_debuff addduration=2 itemset=T14_caster itemcount=4)
	SpellInfo(sunfire_debuff damage=BalanceSunfireTickDamage specialization=balance)
	SpellInfo(sunfire_debuff lastEstimatedDamage=BalanceSunfireTickLastDamage specialization=balance)
Define(survival_instincts 61336)
	SpellInfo(survival_instincts cd=180)
	SpellInfo(survival_instincts addcd=-60 glyph=glyph_of_survival_instincts)
	SpellInfo(survival_instincts buff_cdr=cooldown_reduction_agility_buff specialization=feral)
	SpellInfo(survival_instincts buff_cdr=cooldown_reduction_tank_buff specialization=guardian)
	SpellAddBuff(survival_instincts survival_instincts=1)
Define(swiftmend 18562)
	SpellInfo(swiftmend cd=15)
	SpellAddBuff(swiftmend harmony_buff=1 if_spell=harmony)
Define(swipe_bear 779)
	SpellInfo(swipe_bear cd=3 rage=15)
Define(swipe_cat 62078)
	SpellInfo(swipe_cat combo=1 energy=45 physical=1)
	SpellInfo(swipe_cat buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(swipe_cat buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellInfo(swipe_cat damage=FeralSwipeCatDamage specialization=feral)
	SpellAddBuff(swipe_cat omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
Define(symbiosis_mirror_image 110621)
	SpellInfo(symbiosis_mirror_image cd=180)
Define(thrash_bear 77758)
	SpellInfo(thrash_bear cd=6)
	SpellAddTargetDebuff(thrash_bear thrash_bear_debuff=1 weakened_blows=1)
Define(thrash_bear_debuff 77758)
	SpellInfo(thrash_bear duration=16 tick=2)
Define(thrash_cat 106830)
	SpellInfo(thrash_cat energy=50 physical=1)
	SpellInfo(thrash_cat buff_energy_half=berserk_cat_buff if_stance=druid_cat_form)
	SpellInfo(thrash_cat buff_energy_none=omen_of_clarity_melee_buff if_spell=omen_of_clarity_melee)
	SpellInfo(thrash_cat damage=FeralThrashCatDamage specialization=feral)
	SpellAddBuff(thrash_cat omen_of_clarity_melee_buff=0 if_spell=omen_of_clarity_melee)
	SpellAddTargetDebuff(thrash_cat thrash_cat_debuff=1)
Define(thrash_cat_debuff 106830)
	SpellInfo(thrash_cat_debuff duration=15 tick=3 physical=1)
Define(tigers_fury 5217)
	SpellInfo(tigers_fury cd=30 energy=-60)
	SpellInfo(tigers_fury buff_cdr=cooldown_reduction_agility_buff specialization=feral)
	SpellAddBuff(tigers_fury tigers_fury_buff=1)
Define(tigers_fury_buff 5217)
	SpellInfo(tigers_fury duration=6)
Define(tooth_and_claw_buff 135286)
	SpellInfo(tooth_and_claw_buff duration=10)
Define(tooth_and_claw_debuff 135601)
	SpellInfo(tooth_and_claw_debuff duration=15)
Define(tranquility 740)
	SpellInfo(tranquility channel=4 cd=480 haste=spell)
	SpellInfo(tranquility cd=180 if_spell=malfurions_gift)
Define(tree_of_life_buff 33891)
	SpellInfo(tree_of_life_buff duration=30)
Define(typhoon 132469)
	SpellInfo(typhoon cd=30 nature=1)
Define(typhoon_talent 9)
Define(wild_charge 102401)
	SpellInfo(wild_charge cd=15)
Define(wild_charge_bear 16979)
	SpellInfo(wild_charge_bear cd=15)
Define(wild_charge_cat 49376)
	SpellInfo(wild_charge_cat cd=15)
Define(wild_charge_moonkin 102383)
	SpellInfo(wild_charge_moonkin cd=15)
Define(wild_charge_talent 3)
Define(wild_growth 48438)
	SpellInfo(wild_growth cd=8)
	SpellInfo(wild_growth addcd=2 glyph=glyph_of_wild_growth)
Define(wild_growth_buff 48438)
	SpellInfo(wild_growth_buff duration=7 haste=spell tick=1)
Define(wild_mushroom_bloom 102791)
	SpellInfo(wild_mushroom_bloom cd=3 sharedcd=mushroom)
Define(wild_mushroom_caster 88747)
	SpellInfo(wild_mushroom_caster gcd=1)
Define(wild_mushroom_detonate 88751)
	SpellInfo(wild_mushroom_detonate cd=10 gcd=0 nature=1)
Define(wild_mushroom_heal 145205)
	SpellInfo(wild_mushroom_heal cd=3 sharedcd=mushroom)
Define(wrath 5176)
	SpellInfo(wrath eclipse=-15 nature=1)

### Moonfire
AddFunction BalanceMoonfireTickDamage asValue=1
{
	{ 263 + 0.24 * Spellpower() } * DamageMultiplier(moonfire_debuff) * { 1 + SpellCritChance() / 100 }
}
AddFunction BalanceMoonfireTickLastDamage asValue=1
{
	{ 263 + 0.24 * target.DebuffSpellpower(moonfire_debuff) } * target.DebuffDamageMultiplier(moonfire_debuff) * { 1 + target.DebuffSpellCritChance(moonfire_debuff) / 100 }
}

### Sunfire
AddFunction BalanceSunfireTickDamage asValue=1
{
	{ 263 + 0.24 * Spellpower() } * DamageMultiplier(sunfire_debuff) * { 1 + SpellCritChance() / 100 }
}
AddFunction BalanceSunfireTickLastDamage asValue=1
{
	{ 263 + 0.24 * target.DebuffSpellpower(sunfire_debuff) } * target.DebuffDamageMultiplier(sunfire_debuff) * { 1 + target.DebuffSpellCritChance(moonfire_debuff) / 100 }
}

AddFunction FeralMasteryDamageMultiplier asValue=1 { 1 + MasteryEffect() / 100 }

### Ferocious Bite.
AddFunction FeralFerociousBiteDamage asValue=1
{
	# The "2" at the end is from assuming that FB is always cast at 50 energy, with the extra 25 energy
	# increasing damage by 100%.
	{ 500 + { 762 + 0.196 * AttackPower() } * ComboPoints() } * target.DamageMultiplier(ferocious_bite) * 2
}

### Mangle (cat).
AddFunction FeralMangleCatDamage asValue=1
{
	{ 78 + WeaponDamage() } * 5 * target.DamageMultiplier(mangle_cat)
}

### Rake.
AddFunction FeralRakeTickDamage asValue=1
{
	{ 99 + 0.3 * AttackPower() } * target.DamageMultiplier(rake_debuff) * FeralMasteryDamageMultiplier()
}
AddFunction FeralRakeTickLastDamage asValue=1
{
	{ 99 + 0.3 * target.DebuffAttackPower(rake_debuff) } * target.DebuffDamageMultiplier(rake_debuff) * { 1 + target.DebuffMasteryEffect(rake_debuff) / 100 }
}

### Ravage
AddFunction FeralRavageDamage asValue=1
{
	{ 78 + WeaponDamage() } * 9.5 * target.DamageMultiplier(ravage)
}

### Rip.
AddFunction FeralRipTickDamage asValue=1
{
	{ 136 + { { 384 + 0.05808 * AttackPower() } * ComboPoints() } } * target.DamageMultiplier(rip_debuff) * FeralMasteryDamageMultiplier()
}
AddFunction FeralRipTickLastDamage asValue=1
{
	{ 136 + { { 384 + 0.05808 * target.DebuffAttackPower(rip_debuff) } * target.DebuffComboPoints(rip_debuff) } } * target.DebuffDamageMultiplier(rip_debuff) * { 1 + target.DebuffMasteryEffect(rip_debuff) / 100 }
}

### Shred.
AddFunction FeralShredDamage asValue=1
{
	# The "1.2" at the end is from assuming that Shred is only cast against bleeding targets.
	FeralMangleCatDamage() * 1.2
}

### Swipe (cat)
AddFunction FeralSwipeCatDamage asValue=1
{
	# The "1.2" at the end is from assuming that Swipe is only cast against bleeding targets (usually with Thrash debuff)
	WeaponDamage() * 1.4 * target.DamageMultiplier(swipe_cat) * 1.2
}

### Thrash (cat)
AddFunction FeralThrashCatHitDamage asValue=1
{
	{ 1232 + 0.191 * AttackPower() } * target.DamageMultiplier(thrash_cat) * FeralMasteryDamageMultiplier()
}
]]

	OvaleScripts:RegisterScript("DRUID", name, desc, code, "include")
end
