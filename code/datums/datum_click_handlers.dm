/datum/click_handler
//	var/mob_type
	var/species
	var/handler_name
	var/one_use_flag = 1//drop client.CH after succes ability use
	var/client/owner
	var/icon/mouse_icon

/datum/click_handler/New(client/_owner)
	owner = _owner
	if (mouse_icon)
		owner.mouse_pointer_icon = mouse_icon

//datum/click_handler/Prepare(/client/_owner)

/datum/click_handler/Destroy()
	..()
	if (owner)
		owner.CH = null
		owner.mouse_pointer_icon=initial(owner.mouse_pointer_icon)
	return ..()
//	owner = null

//Return false from these procs to discard the click afterwards
/datum/click_handler/proc/Click(var/atom/target, location, control, params)
	if (!isHUDobj(target))
		if (mob_check(owner.mob) && use_ability(owner.mob, target))
			//Ability successful
			if (one_use_flag)
				//If we're single use, delete ourselves anyways
				qdel(src)
		else
			//Ability fail, delete ourselves
			to_chat(owner.mob, "For some reason you can't use [handler_name] ability")
			qdel(src)

		return FALSE //As long as we're not clicking a hud object, we drop the click
	return TRUE

/datum/click_handler/proc/MouseDown(object,location,control,params)
	return TRUE

/datum/click_handler/proc/MouseDrag(over_object,src_location,over_location,src_control,over_control,params)
	return TRUE

/datum/click_handler/proc/MouseUp(object,location,control,params)
	return TRUE


/datum/click_handler/proc/mob_check(mob/living/carbon/human/user) //Check can mob use a ability
	return

/datum/click_handler/proc/use_ability(mob/living/carbon/human/user,atom/target)
	return

//Tests whether the target thing is valid, and returns it if so.
//If its not valid, null will be returned
//In the case of click catchers, we resolve and return the turf under it
/datum/click_handler/proc/resolve_world_target(var/a)
	if (istype(a, /turf))
		return a

	else if (istype(a, /atom))
		var/atom/A = a
		if (istype(A.loc, /turf))
			return A
	return null

/****************************
	Full auto gunfire
*****************************/
/datum/click_handler/fullauto
	var/atom/target = null
	var/obj/item/gun/reciever // The thing we send firing signals to, spelled reciever instead of receiver for some reason
	var/time_since_last_init // Time since last start of full auto fire , used to prevent ANGRY smashing of M1 to fire faster.
	//Todo: Make this work with callbacks
	var/time_since_last_shot // Keeping track of last shot to determine next one

/datum/click_handler/fullauto/Click()
	return TRUE //Doesn't work with normal clicks

//Next loop will notice these vars and stop shooting
/datum/click_handler/fullauto/proc/stop_firing()
	target = null
	if(reciever)
		if(isliving(reciever.loc))
			reciever.check_safety_cursor(reciever.loc)

/datum/click_handler/fullauto/proc/do_fire()
	reciever.afterattack(target, owner.mob, FALSE)

/datum/click_handler/fullauto/MouseDown(object, location, control, params)
	if(!isturf(owner.mob.loc)) // This stops from firing full auto weapons inside closets or in /obj/effect/dummy/chameleon chameleon projector
		return FALSE
	if(time_since_last_init > world.time)
		return FALSE

	object = resolve_world_target(object)
	if(object)
		target = object
		time_since_last_shot = world.time
		shooting_loop()
		time_since_last_init = world.time + (reciever.fire_delay < GUN_MINIMUM_FIRETIME ? GUN_MINIMUM_FIRETIME : reciever.fire_delay) * min(world.tick_lag, 1)
	return TRUE

/datum/click_handler/fullauto/proc/shooting_loop()
	while(target)
		if(!owner || !owner.mob || owner.mob.resting)
			return FALSE

		owner.mob.face_atom(target)

		while(time_since_last_shot < world.time)
			do_fire()
			time_since_last_shot += (reciever.fire_delay < GUN_MINIMUM_FIRETIME ? GUN_MINIMUM_FIRETIME : reciever.fire_delay) * min(world.tick_lag, 1)

		sleep(1)

/datum/click_handler/fullauto/MouseDrag(over_object, src_location, over_location, src_control, over_control, params)
	src_location = resolve_world_target(src_location)
	if(src_location)
		target = src_location
		return FALSE
	return TRUE

/datum/click_handler/fullauto/MouseUp(object, location, control, params)
	stop_firing()
	return TRUE

/datum/click_handler/fullauto/Destroy()
	stop_firing() //Without this it keeps firing in an infinite loop when deleted
	.=..()

/datum/click_handler/human/mob_check(mob/living/carbon/human/user)
	if(ishuman(user))
		if(user.species.name == src.species)
			return 1
	return 0

/datum/click_handler/human/use_ability(mob/living/carbon/human/user,atom/target)
	return