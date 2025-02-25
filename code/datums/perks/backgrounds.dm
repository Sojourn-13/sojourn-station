/* This is a master file for all perks / traits that are given via background selection.area

This includes perks from:
- Career background selection
- Early-life background selection
- And other selections.

This is NOT for racial-specific perks, but rather specifically for general background perks for organizations sake.*/

/datum/perk/sure_step
	name = "Sure step"
	desc = "Years spent in hazardous areas have made you sure on your footing, you are more likely to avoid traps and less likely to trip while running on under-plating."
	icon_state = "mantrap"

/datum/perk/lungs_of_iron
	name = "Lungs of Iron"
	desc = "For whatever reason, be it natural evolution or simply spending too much time in space or low oxygen worlds your lungs are adapted to surviving with less oxygen."
	icon_state = "lungs" // https://game-icons.net/1x1/lorc/one-eyed.html

/datum/perk/space_asshole
	name = "Rough Life"
	desc = "Your past life has been one of turmoil and extremes and as a result has toughened you up severely. Environmental damage from falling or explosives have less of an effect on your toughened body."
	icon_state = "bomb" // https://game-icons.net

/datum/perk/space_asshole/assign(mob/living/L)
	..()
	holder.mob_bomb_defense += 25
	holder.falls_mod -= 0.4
	if(ishuman(holder))
		var/mob/living/carbon/human/H = holder
		H.sanity.view_damage_threshold += 20

/datum/perk/space_asshole/remove()
	holder.mob_bomb_defense -= 25
	holder.falls_mod += 0.4
	if(ishuman(holder))
		var/mob/living/carbon/human/H = holder
		H.sanity.view_damage_threshold -= 20
	..()

/datum/perk/linguist
	name = "Linguist"
	desc = "Having dedicated time to learn foreign tongues, you find yourself knowing an extra language. Be it from your upbringing or schooling, you're fluent in one more language than the average person!"
	icon_state = "linguist"
	active = FALSE
	passivePerk = FALSE
	var/anti_cheat = FALSE

/datum/perk/linguist/activate()
	..()
	if(anti_cheat)
		to_chat(holder, "Recalling more languages is not as easy for someone unskilled as you.")
		return FALSE
	anti_cheat = TRUE
	var/mob/M = usr
	var/list/options = list()
	options["Eurolang"] = LANGUAGE_EURO
	options["Jive"] = LANGUAGE_JIVE
	options["Jana"] = LANGUAGE_JANA
	options["Illyrian"] = LANGUAGE_ILLYRIAN
	options["Interslavic"] = LANGUAGE_CYRILLIC
	options["Lingua Romana"] = LANGUAGE_ROMANA
	options["Yassari"] = LANGUAGE_YASSARI
	options["Latin"] = LANGUAGE_LATIN
	options["Kriosan"] = LANGUAGE_KRIOSAN
	options["Akula"] = LANGUAGE_AKULA
	options["Narad Pidgin"] = LANGUAGE_MERP
	options["Crinos"] = LANGUAGE_SABLEKYNE
	var/choice = input(M,"Which language do you know?","Linguist Choice") as null|anything in options
	if(src && choice)
		M.add_language(choice)
		M.stats.removePerk(PERK_LINGUIST)
	anti_cheat = FALSE
	return TRUE

/datum/perk/linguist/remove()
	..()

/datum/perk/parkour
	name = "Raiders Leap"
	desc = "Life as a Void Wolf has given you amazing agility. You can climb railings, walls, and ladders much faster than others. In addition you can dodge, combat roll, and stand up from prone much \
	faster. Finally, your rough and tumble movement makes falling from high heights deal a lot less damage compared to others and you will always land on your feet."
	icon_state = "parkour" //https://game-icons.net/1x1/delapouite/jump-across.html

/datum/perk/parkour/assign(mob/living/L)
	..()
	holder.mod_climb_delay -= 0.95
	holder.falls_mod -= 0.8

/datum/perk/parkour/remove()
	holder.mod_climb_delay += 0.95
	holder.falls_mod += 0.8
	..()

/datum/perk/chaingun_smoker
	name = "Unclean Living"
	desc = "The bad conditions of your upbringing have led you to thrive in toxic environments, so much so that your body is dependent on having an unclean atmosphere. You feel tougher and slowly heal toxin damage when smoking."
	icon_state = "cigarette" // https://game-icons.net

/datum/perk/blood_of_lead
	name = "Lead Blood"
	desc = "Maybe you grew up on a world with a toxic atmosphere, maybe solar radiation was common, or maybe its just genetics but you're adapted well to dealing with toxins."
	icon_state = "liver" // https://game-icons.net

/datum/perk/greenthumb
	name = "Green Thumb"
	desc = "After growing plants for years (or at least being around those who do) you have become a botanical expert. You can get all information about plants, from stats \
	        to harvest reagents, by examining them."
	icon_state = "greenthumb" // https://game-icons.net/1x1/delapouite/farmer.html

	var/virtual_scanner = new /obj/item/device/scanner/plant/perk

/datum/perk/greenthumb/assign(mob/living/L)
	..()
	var/obj/item/device/scanner/V = virtual_scanner
	V.is_virtual = TRUE

/datum/perk/nihilist
	name = "Nihilist"
	desc = 	"You simply ran out of fucks to give at some point in your life. \
			This increases chance of positive breakdowns by 30% and negative breakdowns by 20%. Seeing someone die has a random effect on you: \
			sometimes you won’t take any sanity loss and you can even gain back sanity, or get a boost to your cognition."
	icon_state = "eye" //https://game-icons.net/1x1/lorc/tear-tracks.html

/datum/perk/nihilist/assign(mob/living/L)
	if(..() && ishuman(L))
		var/mob/living/carbon/human/H = L
		H.sanity.positive_prob += 30
		H.sanity.negative_prob += 20

/datum/perk/nihilist/remove()
	if(ishuman(holder))
		var/mob/living/carbon/human/H = holder
		H.sanity.positive_prob -= 30
		H.sanity.negative_prob -= 20
		H.stats.removeTempStat(STAT_COG, "Fate Nihilist")
	..()

/datum/perk/idealist
	name = "Idealist"
	icon_state = "moralist" //https://game-icons.net/
	desc = "A day may come when the courage of men fails, when we forsake our friends and break all bonds of fellowship. \
			But it is not this day. This day you fight! \
			Your Insight gain is faster when you are around sane people and they will recover sanity when around you. \
			When you are around people that are low on health or sanity, you will take sanity damage."

/datum/perk/noble
	name = "Wealthy Upbringing"
	icon_state = "family" //https://game-icons.net
	desc = "You came from a wealthy family of high stature, able to achieve a high education and spent most of your life capable of relaxing. \
			Start with an heirloom weapon, higher chance to be on contractor contracts and removed sanity cap. Stay clear of filth and danger."

/datum/perk/noble/assign(mob/living/carbon/human/H)
	if(!..() || !istype(H))
		return
	H.sanity.environment_cap_coeff -= 1
	if(!H.name)
		H.stats.removePerk(src.type)
		return
	var/turf/T = get_turf(H)
	var/obj/item/W
	var/picklist = list( //Total weight sum = 24
				/obj/item/tool/hammer/mace = 5,
				/obj/item/tool/knife/ritual = 3,
				/obj/item/tool/sword/saber = 6,
				/obj/item/tool/sword/katana = 4,
				/obj/item/tool/sword/machete = 4,
				/obj/item/tool/knife/dagger/ceremonial = 2,)

	if(is_neotheology_disciple(H)) //If someone's NT, they're likely to spawn with an NT weapon instead
		picklist += list( //Total weight sum = 34
				/obj/item/tool/sword/nt/longsword = 10,
				/obj/item/tool/sword/nt/shortsword = 12,
				/obj/item/tool/sword/nt/scourge = 2,
				/obj/item/tool/knife/dagger/nt = 10,)

	W = pickweight(picklist)
	H.sanity.valid_inspirations += W
	W = new W(T)
	W.desc += " It has been inscribed with the \"[H.name]\" family name."
	W.name = "[W] of [H.name]"
	var/oddities = rand(2,4) //Will boost 2-4 random stats
	var/list/stats = ALL_STATS_FOR_LEVEL_UP
	var/list/final_oddity = list()
	for(var/i = 1 to oddities)
		var/stat = pick(stats)
		stats.Remove(stat)
		final_oddity += stat
		final_oddity[stat] = rand(1,7) //Will boost each stat by 1-7
	W.AddComponent(/datum/component/inspiration, final_oddity, get_good_perk())
	W.AddComponent(/datum/component/atom_sanity, 1, "")
	W.sanity_damage -= 1
	W.price_tag += rand(1000, 2500)
	spawn(1)
		H.equip_to_storage_or_drop(W)

/datum/perk/noble/remove()
	if(ishuman(holder))
		var/mob/living/carbon/human/H = holder
		H.sanity.environment_cap_coeff += 1
	..()

/datum/perk/addict
	name = "Chem Addict"
	desc = "You've been an addict all your life, for whatever piss poor reason you've told yourself. Your body is able to handle a variety of drugs, more than the average person, but you get \
	easily addicted to all of them."
	icon_state = "chemaddict" // https://game-icons.net/1x1/lorc/overdose.html

/datum/perk/addict/assign(mob/living/L)
	..()
	if(ishuman(holder))
		var/mob/living/carbon/human/H = holder
		H.metabolism_effects.addiction_chance_multiplier = 2
		H.metabolism_effects.nsa_bonus += 20
		H.metabolism_effects.calculate_nsa()

/datum/perk/addict/remove()
	if(ishuman(holder))
		var/mob/living/carbon/human/H = holder
		H.metabolism_effects.addiction_chance_multiplier = 1
		H.metabolism_effects.nsa_bonus -= 20
		H.metabolism_effects.calculate_nsa()
	..()

/datum/perk/no_obfuscation
	name = "Exact Values"
	desc = "Unlike most people you can fully visualize your own stats, owing to your greater grasp of the concepts. \
	This is in addition to knowing exactly how likely you were to fail after failing some tasks. \
	This ability does not extend to medical matters, wounds or similar. "
	icon_state = "obfuscation_ranking"

/datum/perk/blood_lust
	name = "Bloodlust Aura"
	desc = "Your killing intent and wish for combat are felt by anything that attacks by instinct. \
	When more simple-minded combatives evaluate you, they will target you immediately!" //this is how it works in code as the time this perks made
	icon_state = "blood_lust"
	active = FALSE
	passivePerk = FALSE

/datum/perk/blood_lust/assign(mob/living/L)
	if(..())
		holder.target_dummy = TRUE //We want to be targeted first so on assign toggle it

/datum/perk/blood_lust/activate()
	var/mob/living/user = usr
	if(!istype(user))
		return ..()
	if(world.time < cooldown_time)
		to_chat(usr, SPAN_NOTICE("It takes a single moment to collect yourself."))
		return FALSE

	//Disable and enableing target dummy
	user.target_dummy = !user.target_dummy
	cooldown_time = world.time + 1 // Not accually meant to have a real cooldown, just a toggle
	if(user.target_dummy)
		user.visible_message("<b><font color='red'>[user] begins leaking a killing intent!</font><b>", "<b><font color='red'>KILL EM.</font><b>", "<b><font color='red'>The air becomes more heavy around you!</font><b>")
	else
		user.visible_message("<b><font color='red'>[user] begins controlling their killing intent!</font><b>", "<b><font color='red'>You weaken your intent, making simple-minded combatives less likely to target you.</font><b>", "<b><font color='red'>The air thins a little!</font><b>")

	log_and_message_admins("used their [src] perk.")


	return ..()

/datum/perk/natural_style
	name = "Natural Style"
	desc = "Due to your intense training and upbringing you already know how to use the sheath arts, as well as how to handle the mind. \
	All melee weapons that attack at range have a little bit extra reach when you wield them."
	icon_state = "paintbrush"

/datum/perk/natural_style/assign(mob/living/L)
	if(..() && ishuman(L))
		var/mob/living/carbon/human/H = L
		H.sanity.view_damage_threshold  -= 15
		H.sanity.change_max_level(50)

/datum/perk/natural_style/remove()
	if(ishuman(holder))
		var/mob/living/carbon/human/H = holder
		H.sanity.view_damage_threshold += 15
		H.sanity.change_max_level(-50)
	..()

/datum/perk/map_maker
	name = "Map Maker"
	desc = "When holding paper and a box of crayons (must have at least 1 crayon) or a multi-colour pen you can from time to time create a complex map of the area around you in a 20 range.  \
	This map will show humanoids and non-humanoids. With constant work you should be able to increase your range of map making."
	icon_state = "map"

	active = FALSE
	passivePerk = FALSE

/datum/perk/map_maker/activate()
	var/mob/living/carbon/human/user = usr
	if(!istype(user))
		return ..()
	var/obj/I = user.get_active_hand()
	var/obj/II = user.get_inactive_hand()
	var/can_map = FALSE
	var/crayon_check = FALSE
	var/obj/item/storage/fancy/crayons/C
	var/obj/item/paper/P
	if(istype(I, /obj/item/storage/fancy/crayons))
		C = I
		if(C.contents)
			crayon_check = TRUE

	if(istype(II, /obj/item/storage/fancy/crayons))
		C = II
		if(C.contents)
			crayon_check = TRUE

	if(istype(I, /obj/item/pen/multi))
		crayon_check = TRUE

	if(istype(II, /obj/item/pen/multi))
		crayon_check = TRUE

	if(crayon_check)
		if(istype(I, /obj/item/paper))
			P = I
			can_map = TRUE
		if(istype(II, /obj/item/paper))
			P = II
			can_map = TRUE

	if(!can_map)
		to_chat(usr, SPAN_NOTICE("You are missing something to make a map with. Ensure you have paper and the *full* box of crayons in both hands!"))
		return FALSE


	if(world.time < cooldown_time)
		to_chat(usr, SPAN_NOTICE("It is too early to make another map, you have to wait a bit until you can accurately depict your surroundings again."))
		return FALSE
	cooldown_time = world.time + 5 MINUTES
	user.visible_message("<b><font color='red'>[user] taps the ground and draws on some paper!</font><b>", "<b><font color='red'>You tap the ground, as you create a map from scratch</font><b>", "<b><font color='red'>You hear something scribbling!</font><b>")
	log_and_message_admins("used their [src] perk.")
	qdel(P)

	var/range = 20
	if(isliving(user))
		var/mob/living/L = user
		var/tasklevel = L.learnt_tasks.get_task_mastery_level("MAP_CRAFTING")
		range += tasklevel
		L.learnt_tasks.attempt_add_task_mastery(/datum/task_master/task/map_crafting, "MAP_CRAFTING", skill_gained = 1, learner = L)

	var/icon/mineralmapss = new("icons/480x480.dmi","black")
	mineralmapss.Scale(world.maxx-TRANSITIONEDGE,world.maxy-TRANSITIONEDGE)
	for(var/turf/T in trange(range,user))
		if(T.x >= world.maxx-TRANSITIONEDGE || T.x <= TRANSITIONEDGE)	continue
		if(T.y >= world.maxy-TRANSITIONEDGE || T.y <= TRANSITIONEDGE)	continue

		if(istype(T, /turf/simulated/wall))
			var/turf/simulated/wall/TA = T
			mineralmapss.DrawBox(rgb(135,132,132),TA.x,TA.y,TA.x, TA.y)
			if(istype(T, /turf/simulated/wall/r_wall))
				mineralmapss.DrawBox(rgb(104, 105, 104),TA.x,TA.y,TA.x, TA.y)
		if(istype(T, /turf/simulated/floor))
			var/turf/simulated/floor/TA = T
			mineralmapss.DrawBox(rgb(255,248,220),TA.x,TA.y,TA.x, TA.y)
			for(var/obj/structure/catwalk/CW in TA.contents)
				mineralmapss.DrawBox(rgb(186,142,35),CW.x,CW.y,CW.x, CW.y)
			for(var/obj/structure/window/WD in TA.contents)
				mineralmapss.DrawBox(rgb(175,227,255),WD.x,WD.y,WD.x, WD.y)
			for(var/obj/structure/scrap/DS in TA.contents)
				mineralmapss.DrawBox(rgb(183,110,121),DS.x,DS.y,DS.x, DS.y)
			for(var/obj/structure/salvageable/PS in TA.contents)
				mineralmapss.DrawBox(rgb(183,110,121),PS.x,PS.y,PS.x, PS.y)
			for(var/obj/structure/closet/MS in TA.contents)
				mineralmapss.DrawBox(rgb(183,110,121),MS.x,MS.y,MS.x, MS.y)
			for(var/mob/M in TA.contents)
				if(ishuman(M))
					mineralmapss.DrawBox(rgb(57,255,20),M.x,M.y,M.x, M.y)
				else
					mineralmapss.DrawBox(rgb(129,2,3),M.x,M.y,M.x, M.y)

			for(var/obj/machinery/porta_turret/PT in TA.contents)
				mineralmapss.DrawBox(rgb(255,165,0),PT.x,PT.y,PT.x, PT.y)
			for(var/obj/machinery/power/os_turret/OS in TA.contents)
				mineralmapss.DrawBox(rgb(255,165,0),OS.x,OS.y,OS.x, OS.y)
			for(var/obj/item/spider_shadow_trap/SST in TA.contents)
				mineralmapss.DrawBox(rgb(0,255,255),SST.x,SST.y,SST.x, SST.y)

			for(var/obj/item/beartrap/RT in TA.contents)
				mineralmapss.DrawBox(rgb(255,0,0),RT.x,RT.y,RT.x, RT.y)
			for(var/obj/item/emp_mine/RT in TA.contents)
				mineralmapss.DrawBox(rgb(255,0,0),RT.x,RT.y,RT.x, RT.y)
			for(var/obj/item/mine/RT in TA.contents)
				mineralmapss.DrawBox(rgb(255,0,0),RT.x,RT.y,RT.x, RT.y)
			for(var/obj/structure/wire_splicing/RT in TA.contents)
				mineralmapss.DrawBox(rgb(255,0,0),RT.x,RT.y,RT.x, RT.y)

			continue
		if(istype(T, /turf/space) || istype(T, /turf/simulated/open))
			var/turf/TA = T
			mineralmapss.DrawBox(rgb(0,0,0),TA.x,TA.y,TA.x, TA.y)
			for(var/obj/structure/catwalk/CW in TA.contents)
				mineralmapss.DrawBox(rgb(186,142,35),CW.x,CW.y,CW.x, CW.y)

			continue
		if(istype(T, /turf/simulated/mineral))
			var/turf/simulated/mineral/MW = T
			mineralmapss.DrawBox(rgb(96, 70, 15),MW.x,MW.y,MW.x, MW.y)

	mineralmapss.Scale((world.maxx-TRANSITIONEDGE )* 6,(world.maxy-TRANSITIONEDGE) * 6)
	sleep(0)
	var/obj/item/paper/G = new(user.loc)
	G.name = "Area Map"
	G.info = "[icon2html(mineralmapss,world)] <br> Legend:<br>"
	G.info += "<font color='#39FF14'>People</font> Neon Green<br>"
	G.info += "<font color='#810203'>Life (Not-Plants)</font> Brick Red<br>"
	G.info += "<font color='#878484'>R-Wall</font> Shadow Gray<br>"
	G.info += "<font color='#BDBAA2'>Flooring</font> Clay Gray<br>"
	G.info += "<font color='#60460F'>Mineral Wall</font> Mud Brown<br>"
	G.info += "<font color='#FFA500'>Turret</font> Dusk Sun Yellow<br>"
	G.info += "<font color='#AFE3ff'>Glass-Windows</font> Coal Blue<br>"
	G.info += "<font color='#B76E79'>Scrap/Lootables/Salvage</font> Rose Gold<br>"
	G.info += "<font color='#FF0000'>Trap</font> Hostile Spotted Red<br>"
	G.info += "<font color='#000000'>Open Space</font> Burnt Mess Black<br>"
	G.info += "<font color='#BA8E23'>CatWalks</found> Bee Yellow<br>"
	G.update_icon()

	return ..()

/datum/perk/no_inspiro
	name = "Cannot Be Inspired"
	desc = "Unlike most, you are close-minded, leading you to be unable to be inspired. \
	As such, oddities are little more than trinkets to you, and artistic pursuits are beyond you. \
	You can still suffer mental breaks from going insane, though!"
	icon_state = "obfuscation_ranking"
