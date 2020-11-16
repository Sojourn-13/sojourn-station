/obj/item/weapon/grenade/flashbang
	name = "HS FBG \"Serra\""
	desc = "A \"Holland and Sullivan\" flashbang grenade. If in any doubt - use it."
	icon_state = "flashbang"
	item_state = "flashbang"
	origin_tech = list(TECH_MATERIAL = 2, TECH_COMBAT = 1)
	var/banglet = 0

/obj/item/weapon/grenade/flashbang/prime()
	..()
	for(var/obj/structure/closet/L in hear(7, get_turf(src)))
		if(locate(/mob/living/carbon/, L))
			for(var/mob/living/carbon/M in L)
				flashbang_bang(get_turf(src), M)


	for(var/mob/living/carbon/M in hear(7, get_turf(src)))
		flashbang_bang(get_turf(src), M)

	for(var/obj/effect/blob/B in hear(8,get_turf(src)))       		//Blob damage here
		var/damage = round(30/(get_dist(B,get_turf(src))+1))
		B.health -= damage
		B.update_icon()

	new/obj/effect/sparks(src.loc)
	new/obj/effect/effect/smoke/illumination(src.loc, brightness=15)
	qdel(src)
	return

/obj/item/proc/flashbang_bang(var/turf/T, var/mob/living/carbon/M, var/explosion_text = "BANG") //Bang made into an item proc so lot's of stuff can use it wtihout copy - paste
	to_chat(M, SPAN_DANGER(explosion_text))								// Called during the loop that bangs people in lockers/containers and when banging
	playsound(src.loc, 'sound/effects/bang.ogg', 50, 1, 5)		// people in normal view.  Could theroetically be called during other explosions.
																// -- Polymorph

//Checking for protections
	var/eye_safety = 0
	var/ear_safety = 0
	var/stat_def = -STAT_LEVEL_ADEPT
	if(iscarbon(M))
		eye_safety = M.eyecheck()
		if(ishuman(M))
			if(istype(M:l_ear, /obj/item/clothing/ears/earmuffs) || istype(M:r_ear, /obj/item/clothing/ears/earmuffs))
				ear_safety += 2
			if(HULK in M.mutations)
				ear_safety += 1
			if(istype(M:head, /obj/item/clothing/head/helmet))
				ear_safety += 1
			if(M.stats.getPerk(PERK_EAR_OF_QUICKSILVER))
				stat_def *= 2

//Flashing everyone
	if(eye_safety < FLASH_PROTECTION_MODERATE)
		if (M.HUDtech.Find("flash"))
			flick("e_flash", M.HUDtech["flash"])
		M.eye_blurry = max(M.eye_blurry, 15)
		M.eye_blind = max(M.eye_blind, 5)



//Now applying sound
	if((get_dist(M, T) <= 2 || src.loc == M.loc || src.loc == M))
		if(ear_safety <= 0)
			stat_def *= 5
			if ((prob(14) || (M == src.loc && prob(70))))
				M.ear_damage += rand(1, 10)
				M.confused = max(M.confused,8)
			else
				M.ear_damage += rand(0, 5)
				M.ear_deaf = max(M.ear_deaf,15)
				M.confused = max(M.confused,8)
		else
			stat_def *= 2
			M.confused = max(M.confused,4)

	else if(get_dist(M, T) <= 5)
		if(ear_safety <= 0)
			stat_def *= 4
			M.ear_damage += rand(0, 3)
			M.ear_deaf = max(M.ear_deaf,10)
			M.confused = max(M.confused,6)
		else
			M.confused = max(M.confused,2)

	else if(!ear_safety)
		stat_def *= 2
		M.ear_damage += rand(0, 1)
		M.ear_deaf = max(M.ear_deaf,5)
		M.confused = max(M.confused,5)

	//This really should be in mob not every check
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/eyes/E = H.internal_organs_by_name[BP_EYES]
		if (E && E.damage >= E.min_bruised_damage)
			to_chat(M, SPAN_DANGER("Your eyes start to burn badly!"))
	if (M.ear_damage >= 15)
		to_chat(M, SPAN_DANGER("Your ears start to ring badly!"))
	else
		if (M.ear_damage >= 5)
			to_chat(M, SPAN_DANGER("Your ears start to ring!"))
	M.stats.addTempStat(STAT_VIG, stat_def, 10 SECONDS, "flashbang")
	M.stats.addTempStat(STAT_COG, stat_def, 10 SECONDS, "flashbang")
	M.stats.addTempStat(STAT_BIO, stat_def, 10 SECONDS, "flashbang")
	M.stats.addTempStat(STAT_MEC, stat_def, 10 SECONDS, "flashbang")
	M.update_icons()
