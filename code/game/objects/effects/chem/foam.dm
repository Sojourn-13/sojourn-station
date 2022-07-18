// Foam
// Similar to smoke, but spreads out more
// metal foams leave behind a foamed metal wall

/obj/effect/effect/foam
	name = "foam"
	icon_state = "foam"
	opacity = 0
	anchored = 1
	density = 0
	layer = EDGED_TURF_LAYER
	mouse_opacity = 0
	animate_movement = 0
	var/amount = 3
	var/expand = 1
	var/metal = 0

/obj/effect/effect/foam/New(var/loc, var/ismetal = 0)
	..(loc)
	icon_state = "[ismetal? "m" : ""]foam"
	metal = ismetal
	playsound(src, 'sound/effects/bubbles2.ogg', 80, 1, -3)
	spawn(3 + metal * 3)
		Process()
		checkReagents()
	spawn(120)
		STOP_PROCESSING(SSobj, src)
		sleep(30)
		if(metal)
			var/obj/structure/foamedmetal/M = new(src.loc)
			M.metal = metal
			M.updateicon()
		flick("[icon_state]-disolve", src)
		sleep(5)
		qdel(src)
	return

/obj/effect/effect/foam/proc/checkReagents() // transfer any reagents to the floor
	if(!metal && reagents)
		var/turf/T = get_turf(src)
		reagents.touch_turf(T)
		for(var/obj/O in T)
			reagents.touch_obj(O)

/obj/effect/effect/foam/Process()
	if(--amount < 0)
		return

	for(var/direction in cardinal)
		var/turf/T = get_step(src, direction)
		if(!T)
			continue

		if(!T.Enter(src))
			continue

		var/obj/effect/effect/foam/F = locate() in T
		if(F)
			continue

		F = new(T, metal)
		F.amount = amount
		if(!metal)
			F.create_reagents(10)
			if(reagents)
				for(var/datum/reagent/R in reagents.reagent_list)
					//added safety check since reagents in the foam have already had a chance to react
					F.reagents.add_reagent(R.id, 1, safety = 1)

// foam disolves when heated, except metal foams
/obj/effect/effect/foam/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(!metal && prob(max(0, exposed_temperature - 475)))
		flick("[icon_state]-disolve", src)

		spawn(5)
			qdel(src)

/obj/effect/effect/foam/Crossed(var/atom/movable/AM)
	if(metal)
		return
	if(isliving(AM))
		var/mob/living/M = AM
		M.slip("the foam", 6)

/datum/effect/effect/system/foam_spread
	var/amount = 5				// the size of the foam spread.
	var/list/carried_reagents	// the IDs of reagents present when the foam was mixed
	var/metal = 0				// 0 = foam, 1 = metalfoam, 2 = ironfoam

/datum/effect/effect/system/foam_spread/set_up(amt=5, loca, var/datum/reagents/carry = null, var/metalfoam = 0)
	amount = round(sqrt(amt / 3), 1)
	if(istype(loca, /turf/))
		location = loca
	else
		location = get_turf(loca)

	carried_reagents = list()
	metal = metalfoam

	// bit of a hack here.
	// Foam carries along any reagent also present in the glass it is mixed with
	// (defaults to water if none is present).
	// Rather than actually transfer the reagents, this makes a list of the reagent ids
	// and spawns 1 unit of that reagent when the foam disolves.

	if(carry && !metal)
		for(var/datum/reagent/R in carry.reagent_list)
			carried_reagents += R.id

/datum/effect/effect/system/foam_spread/start()
	spawn(0)
		var/obj/effect/effect/foam/F = locate() in location
		if(F)
			F.amount += amount
			return

		F = new(location, metal)
		F.amount = amount

		if(!metal) // don't carry other chemicals if a metal foam
			F.create_reagents(10)

			if(carried_reagents)
				for(var/id in carried_reagents)
					//makes a safety call because all reagents should have already reacted anyway
					F.reagents.add_reagent(id, 1, safety = 1)
			else
				F.reagents.add_reagent("water", 1, safety = 1)

// wall formed by metal foams, dense and opaque, but easy to break

/obj/structure/foamedmetal
	name = "foamed metal"
	desc = "A lightweight foamed metal wall."
	icon = 'icons/effects/effects.dmi'
	icon_state = "metalfoam"
	density = 1
	opacity = 1 // changed in New()
	anchored = 1
	layer = EDGED_TURF_LAYER
	var/metal = 1 // 1 = aluminum, 2 = iron

/obj/structure/foamedmetal/New()
	..()
	update_nearby_tiles(1)

/obj/structure/foamedmetal/Destroy()
	density = 0
	update_nearby_tiles(1)
	. = ..()

/obj/structure/foamedmetal/proc/updateicon()
	if(metal == 1)
		icon_state = "metalfoam"
	else
		icon_state = "ironfoam"

/obj/structure/foamedmetal/ex_act(severity)
	qdel(src)

/obj/structure/foamedmetal/bullet_act(var/obj/item/projectile/Proj)
	if (!(Proj.testing))
		if(metal == 1 || prob(50))
			qdel(src)

/obj/structure/foamedmetal/attack_hand(var/mob/user)
	if ((HULK in user.mutations) || (prob(75 - metal * 25)))
		user.visible_message(
			SPAN_WARNING("[user] smashes through the foamed metal."),
			SPAN_NOTICE("You smash through the metal foam wall.")
		)
		qdel(src)
	else
		to_chat(user, SPAN_NOTICE("You hit the metal foam but bounce off it."))
	return

/obj/structure/foamedmetal/affect_grab(var/mob/living/user, var/mob/living/target)
	target.forceMove(src.loc)
	visible_message(SPAN_WARNING("[user] smashes [target] through the foamed metal wall."))
	target.Weaken(5)
	qdel(src)
	return TRUE

/obj/structure/foamedmetal/attackby(var/obj/item/I, var/mob/user)
	if(!istype(I))
		return
	if(prob(I.force * 20 - metal * 25))
		user.visible_message(
			SPAN_WARNING("[user] smashes through the foamed metal."),
			SPAN_NOTICE("You smash through the foamed metal with \the [I].")
		)
		qdel(src)
	else
		to_chat(user, SPAN_NOTICE("You hit the metal foam to no effect."))

/obj/structure/foamedmetal/CanPass(atom/movable/mover, turf/target, height=1.5, air_group = 0)
	if(air_group)
		return 0
	return !density
