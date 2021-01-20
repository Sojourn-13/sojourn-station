/obj/machinery/power/nt_obelisk
	name = "Absolutism obelisk"
	desc = "The obelisks of the church are said to protect and empower those bearing cruciforms, how it works is not truly known, perhaps it is faith?"
	icon = 'icons/obj/neotheology_machinery.dmi'
	icon_state = "nt_obelisk"

	density = TRUE
	anchored = TRUE
	layer = 2.8

	use_power = IDLE_POWER_USE
	idle_power_usage = 30
	active_power_usage = 2500

	var/biomatter_ammo = 50 //We attack 50 times before running out on map spawn
	var/biomatter_use_per_shot = 1 //Modular way of making it so admins can tweak this mid round

	var/overrideFaithfulCheck = FALSE
	var/active = FALSE
	var/area_radius = 7
	var/damage = 20
	var/max_targets = 5

	var/nt_buff_power = 5
	var/nt_buff_cd = 3

	var/static/stat_buff
	var/list/currently_affected = list()

/obj/machinery/power/nt_obelisk/eotp
	name = "Eye of the Absolute"
	desc = "An obelisk known as the eye, a powerful and difficult to build device that functions as the pinnacle of defense, in the name of god of course."
	icon = 'icons/obj/eotp.dmi'

	biomatter_ammo = 120 //When made we will attack 150 times before needing to be filled.

	use_power = NO_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0

	active = FALSE
	area_radius = 9
	damage = 40
	max_targets = 10

	nt_buff_power = 8
	nt_buff_cd = 5

/obj/machinery/power/nt_obelisk/Destroy()
	for(var/i in currently_affected)
		var/mob/living/carbon/human/H = i
		H.stats.removePerk(/datum/perk/sanityboost)
	currently_affected = null

/obj/machinery/power/nt_obelisk/New()
	..()

/obj/machinery/power/nt_obelisk/examine(mob/user)
	..()
	to_chat(user, "<span class='info'>Level of stored biomatter: [biomatter_ammo]</span>")

/obj/machinery/power/nt_obelisk/attack_hand(mob/user)
	return

/obj/machinery/power/nt_obelisk/attackby(obj/item/I, mob/user as mob)
	if (istype(I, /obj/item/stack/material/biomatter))
		var/obj/item/stack/material/biomatter/B = I
		if (B.amount)
			var/sheets_amount_to_transphere = input(user, "How many sheets you want to load?", "Biomatter melting", 1) as num
			if (sheets_amount_to_transphere > B.amount ) //No cheating!
				to_chat(user, SPAN_WARNING("You don't have that many [B.name]"))
				return
			if(sheets_amount_to_transphere)
				B.use(sheets_amount_to_transphere)
				biomatter_ammo += sheets_amount_to_transphere
				user.visible_message(
									"[user.name] inserted \the [B.name]'s sheets in \the [name].",
									"You inserted \the [B.name] in  (in amount: [sheets_amount_to_transphere]) \the [name].\
									And after that you see how the counter on \the [name] is incremented by [sheets_amount_to_transphere]."
									)
				ping()
			else
				to_chat(user, SPAN_WARNING("You can't insert [sheets_amount_to_transphere] in [name]"))
			return

/obj/machinery/power/nt_obelisk/Process()
	..()
	if(stat)
		return
	var/list/affected = range(area_radius, src)
	active = check_for_faithful(affected) || overrideFaithfulCheck
	update_icon()
	if(!active)
		use_power = IDLE_POWER_USE
		for(var/obj/structure/burrow/burrow in affected)
			if(burrow.obelisk_around == any2ref(src))
				burrow.obelisk_around = null
	else
		use_power = 2

		var/to_fire = max_targets
		for(var/A in affected)
			if(istype(A, /obj/structure/burrow))
				var/obj/structure/burrow/burrow = A
				if(!burrow.obelisk_around)
					burrow.obelisk_around = any2ref(src)
			else if(istype(A, /mob/living/carbon/superior_animal))
				var/mob/living/carbon/superior_animal/animal = A
				if(animal.stat != DEAD && biomatter_ammo > biomatter_use_per_shot) //got roach, spider, maybe bear
					animal.take_overall_damage(damage)
					biomatter_ammo -= biomatter_use_per_shot
					if(!--to_fire)
						return
			else if(istype(A, /mob/living/simple_animal/hostile))
				var/mob/living/simple_animal/hostile/animal = A
				if(animal.stat != DEAD && biomatter_ammo > biomatter_use_per_shot) //got bear or something
					animal.take_overall_damage(damage)
					biomatter_ammo -= biomatter_use_per_shot
					if(!--to_fire)
						return
			else if(istype(A, /obj/effect/plant))
				var/obj/effect/plant/shroom = A
				if(shroom.seed.type == /datum/seed/mushroom/maintshroom && biomatter_ammo > biomatter_use_per_shot)
					biomatter_ammo -= (biomatter_use_per_shot * 0.1) //Its not hard to kill these
					qdel(shroom)
					if(!--to_fire)
						return

/obj/machinery/power/nt_obelisk/proc/check_for_faithful(list/affected)
	var/got_neoteo = FALSE
	var/list/no_longer_affected = currently_affected - affected
	for(var/i in no_longer_affected)
		var/mob/living/carbon/human/H = i
		H.stats.removePerk(/datum/perk/sanityboost)
	currently_affected -= no_longer_affected
	for(var/mob/living/carbon/human/mob in affected)
		var/obj/item/weapon/implant/core_implant/I = mob.get_core_implant(/obj/item/weapon/implant/core_implant/cruciform)
		if(I && I.active && I.wearer)
			if(!(mob in currently_affected)) // the mob just entered the range of the obelisk
				mob.stats.addPerk(/datum/perk/sanityboost)
				currently_affected += mob
			if(I.power < I.max_power)	I.power += nt_buff_power
			for(var/r_tag in mob.personal_ritual_cooldowns)
				mob.personal_ritual_cooldowns[r_tag] -= nt_buff_cd

			if(stat_buff)
				var/buff_power = disciples.len
				var/message
				var/prev_stat
				for(var/stat in ALL_STATS)
					var/datum/stat_mod/SM = mob.stats.getTempStat(stat, "nt_obelisk")
					if(stat == stat_buff)
						if(!SM)
							message = "A wave of dizziness washes over you, and your mind is filled with a sudden insight into [stat]."
						else if(SM.value != buff_power) // buff power was changed
							message = "Your knowledge of [stat] feels slightly [SM.value > buff_power ? "lessened" : "broadened"]."
						else if(SM.time < world.time + 10 MINUTES) // less than 10 minutes of buff duration left
							message = "Your knowledge of [stat] feels renewed."
						mob.stats.addTempStat(stat, buff_power, 20 MINUTES, "nt_obelisk")
					else if(SM)
						prev_stat = stat
						mob.stats.removeTempStat(stat, "nt_obelisk")

				if(prev_stat) // buff stat was replaced
					message = "A wave of dizziness washes over you, and your mind is filled with a sudden insight into [stat_buff] as your knowledge of [prev_stat] feels lessened."
				if(message)
					to_chat(mob, SPAN_NOTICE(message))

			got_neoteo = TRUE
	return got_neoteo


/obj/machinery/power/nt_obelisk/update_icon()
	icon_state = "nt_obelisk[active?"_on":""]"
