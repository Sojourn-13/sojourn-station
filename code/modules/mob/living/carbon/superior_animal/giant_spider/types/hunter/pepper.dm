/mob/living/carbon/superior_animal/giant_spider/hunter/pepper
	name = "pepper spider"
	desc = "Furry and black, it makes you shudder to look at it. This one is blood red and pulsating with sacks of irratent gas."
	icon_state = "pepper"
	icon_living = "pepper"
	meat_type = /obj/item/reagent_containers/food/snacks/meat/spider/pepper
	emote_see = list("chitters.","rubs its legs.","vibrates.","belches flames!")
	var/datum/reagents/gas_sac //Stores gas. Can't use the default reagents since that is now bloodstream
	/// How much we can hold in our gas sac.
	var/spray_max = 50
	/// What percentage chance per tick do we have to spray pepper spray at a valid target?
	var/spray_chance = 25 //arbitrary
	/// How much of the reagent is required to fire, how much is fired.
	var/amount_per_transfer_from_this = 10
	/// Minimum delay for spraying pepper in ticks
	var/spray_delay_minimum = 0
	/// Maximum delay for spraying pepper in ticks
	var/spray_delay_maximum = 5
	/// The message to be displayed when we spray
	var/spray_message = "suddenly sprays out a red-colored liquid at"


/mob/living/carbon/superior_animal/giant_spider/hunter/pepper/New()
	.=..()
	gas_sac = new /datum/reagents(spray_max, src)
	gas_sac.add_reagent("condensedcapsaicinspider", (spray_max*0.5))

/mob/living/carbon/superior_animal/giant_spider/hunter/pepper/Destroy()
	gas_sac.my_atom = null
	QDEL_NULL(gas_sac)

	. = ..()

/mob/living/carbon/superior_animal/giant_spider/hunter/pepper/Life()
	. = ..()

	gas_sac.add_reagent("condensedcapsaicinspider", 1)

/mob/living/carbon/superior_animal/giant_spider/hunter/pepper/handle_attacking_stance(atom/targetted_mob, already_destroying_surroundings)
	. = ..()

	var/spray_range = (comfy_range - 2)

	if (istype(targetted_mob, /mob/living))
		var/mob/living/target = targetted_mob
		var/distance = (get_dist(src, target))
		if (distance <= spray_range)
			if (prob(spray_chance))
				if (gas_sac.has_reagent("condensedcapsaicinspider", amount_per_transfer_from_this))
					if (!((target.weakened) || (target.stunned))) //anti-stunlock
						var/delay = rand(spray_delay_minimum, spray_delay_maximum)
						addtimer(CALLBACK(src, .proc/sprayPepper, targetted_mob), delay)

/mob/living/carbon/superior_animal/giant_spider/hunter/pepper/proc/sprayPepper(var/atom/targetted_mob)
	var/obj/effect/effect/water/chempuff/D = new/obj/effect/effect/water/chempuff(get_turf(src))
	var/turf/my_target = get_turf(targetted_mob)
	D.create_reagents(amount_per_transfer_from_this)
	if(!gas_sac)
		return
	gas_sac.trans_to_obj(D, amount_per_transfer_from_this)
	D.set_color()
	var/distance = (get_dist(src, targetted_mob))
	D.set_up(my_target, distance, 10)

	visible_message(SPAN_WARNING("[src] [spray_message] [targetted_mob]!"))
	playsound(loc, 'sound/effects/spray2.ogg', 50, 1, -6)
	playsound(loc, attack_sound, attack_sound_volume, 1)
