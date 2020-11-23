var/list/obj/effect/step_trigger/STEP_TELEPORTERS = list()
/* Simple object type, calls a proc when "stepped" on by something */

/obj/effect/step_trigger
	var/affect_ghosts = 1
	var/stopper = 1 // stops throwers
	var/id = null			//id of this bump_teleporter.
	var/id_target = null	//id of bump_teleporter which this moves you to.
	invisibility = 101 // nope cant see this shit
	anchored = 1

/obj/effect/step_trigger/proc/Trigger(var/atom/movable/A)
	for(var/obj/effect/step_trigger/ST in STEP_TELEPORTERS)
		if(ST.id == src.id_target)
			A.loc = ST.loc	//Teleport to location with correct id.
			return
	return 0

/obj/effect/step_trigger/Crossed(H as mob|obj)
	..()
	if(!H)
		return
	if(isobserver(H) && !(isghost(H) && affect_ghosts))
		return
	Trigger(H)

/obj/effect/step_trigger/New()
	..()
	STEP_TELEPORTERS += src

/obj/effect/step_trigger/Destroy()
	STEP_TELEPORTERS -= src
	return ..()

/* Tosses things in a certain direction */

/datum/movement_handler/no_move/toss

/obj/effect/step_trigger/thrower
	var/direction = SOUTH // the direction of throw
	var/tiles = 3	// if 0: forever until atom hits a stopper
	var/immobilize = 1 // if nonzero: prevents mobs from moving while they're being flung
	var/speed = 1	// delay of movement
	var/facedir = 0 // if 1: atom faces the direction of movement
	var/nostop = 0 // if 1: will only be stopped by teleporters
	var/list/affecting = list()

	Trigger(var/atom/A)
		if(!A || !istype(A, /atom/movable))
			return
		var/atom/movable/AM = A
		var/curtiles = 0
		var/stopthrow = 0
		for(var/obj/effect/step_trigger/thrower/T in orange(2, src))
			if(AM in T.affecting)
				return

		if(ismob(AM))
			var/mob/M = AM
			if(immobilize)
				M.AddMovementHandler(/datum/movement_handler/no_move/toss)

		affecting.Add(AM)
		while(AM && !stopthrow)
			if(tiles)
				if(curtiles >= tiles)
					break
			if(AM.z != src.z)
				break

			curtiles++

			sleep(speed)

			// Calculate if we should stop the process
			if(!nostop)
				for(var/obj/effect/step_trigger/T in get_step(AM, direction))
					if(T.stopper && T != src)
						stopthrow = 1
			else
				for(var/obj/effect/step_trigger/teleporter/T in get_step(AM, direction))
					if(T.stopper)
						stopthrow = 1

			if(AM)
				var/predir = AM.dir
				step(AM, direction)
				if(!facedir)
					AM.set_dir(predir)



		affecting.Remove(AM)

		if(ismob(AM))
			var/mob/M = AM
			if(immobilize)
				M.RemoveMovementHandler(/datum/movement_handler/no_move/toss)

/* Stops things thrown by a thrower, doesn't do anything */

/obj/effect/step_trigger/stopper

/* Instant teleporter */

/obj/effect/step_trigger/teleporter
	var/teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	var/teleport_y = 0
	var/teleport_z = 0

	Trigger(var/atom/movable/A)
		if(teleport_x && teleport_y && teleport_z)

			A.x = teleport_x
			A.y = teleport_y
			A.z = teleport_z

/* Random teleporter, teleports atoms to locations ranging from teleport_x - teleport_x_offset, etc */

/obj/effect/step_trigger/teleporter/random
	var/teleport_x_offset = 0
	var/teleport_y_offset = 0
	var/teleport_z_offset = 0

	Trigger(var/atom/movable/A)
		if(teleport_x && teleport_y && teleport_z)
			if(teleport_x_offset && teleport_y_offset && teleport_z_offset)

				A.x = rand(teleport_x, teleport_x_offset)
				A.y = rand(teleport_y, teleport_y_offset)
				A.z = rand(teleport_z, teleport_z_offset)

/* Step trigger to display message if *TRIGGERED* */
/obj/effect/step_trigger/message
	var/message	//the message to give to the mob
	var/once = 1

/obj/effect/step_trigger/message/Trigger(mob/M as mob)
	if(M.client)
		to_chat(M, "<span class='info'>[message]</span>")
		if(once)
			qdel(src)


//Map teleporters, don't fuck with'em. These are basically dynamic versions of the bump teleporters for map functions so the coordinates are not hard coded. -Kaz
//You should always make news ones of these when connecting maps in normal ways such as through stairs or cave entrances, its safer than hard coded map stuff.

//Underground to stairs.
/obj/effect/step_trigger/underground_to_transition_1_A
	id = "underground_to_transition_1_A"
	id_target = "underground_to_transition_2_A"

/obj/effect/step_trigger/underground_to_transition_2_A
	id = "underground_to_transition_2_A"
	id_target = "underground_to_transition_1_A"

/obj/effect/step_trigger/underground_to_transition_1_B
	id = "underground_to_transition_1_B"
	id_target = "underground_to_transition_2_B"

/obj/effect/step_trigger/underground_to_transition_2_B
	id = "underground_to_transition_2_B"
	id_target = "underground_to_transition_1_B"

//Surface to stairs.
/obj/effect/step_trigger/surface_to_transition_1_A
	id = "surface_to_transition_1_A"
	id_target = "surface_to_transition_2_A"

/obj/effect/step_trigger/surface_to_transition_2_A
	id = "surface_to_transition_2_A"
	id_target = "surface_to_transition_1_A"

/obj/effect/step_trigger/surface_to_transition_1_B
	id = "surface_to_transition_1_B"
	id_target = "surface_to_transition_2_B"

/obj/effect/step_trigger/surface_to_transition_2_B
	id = "surface_to_transition_2_B"
	id_target = "surface_to_transition_1_B"

//Surface to forest
/obj/effect/step_trigger/surface_to_forest_1_A
	id = "surface_to_forest_1_A"
	id_target = "surface_to_forest_2_A"

/obj/effect/step_trigger/surface_to_forest_2_A
	id = "surface_to_forest_2_A"
	id_target = "surface_to_forest_1_A"

/obj/effect/step_trigger/surface_to_forest_1_B
	id = "surface_to_forest_1_B"
	id_target = "surface_to_forest_2_B"

/obj/effect/step_trigger/surface_to_forest_2_B
	id = "surface_to_forest_2_B"
	id_target = "surface_to_forest_1_B"

//HuT to Gulag
/obj/effect/step_trigger/hut_to_gulag_1_A
	id = "hut_to_gulag_1_A"
	id_target = "hut_to_gulag_2_A"

/obj/effect/step_trigger/hut_to_gulag_2_A
	id = "hut_to_gulag_2_A"
	id_target = "hut_to_gulag_1_A"

/obj/effect/step_trigger/hut_to_gulag_1_B
	id = "hut_to_gulag_1_B"
	id_target = "hut_to_gulag_2_B"

/obj/effect/step_trigger/hut_to_gulag2_B
	id = "hut_to_gulag_2_B"
	id_target = "hut_to_gulag_1_B"

//Monster cave to more beast caves
/obj/effect/step_trigger/monster_to_beast_1_A
	id = "monster_to_beast_1_A"
	id_target = "monster_to_beast_2_A"

/obj/effect/step_trigger/monster_to_beast_2_A
	id = "monster_to_beast_2_A"
	id_target = "monster_to_beast_1_A"

/obj/effect/step_trigger/monster_to_beast_1_B
	id = "monster_to_beast_1_B"
	id_target = "monster_to_beast_2_B"

/obj/effect/step_trigger/monster_to_beast_2_B
	id = "monster_to_beast_2_B"
	id_target = "monster_to_beast_1_B"

//Greyson base to field offices
/obj/effect/step_trigger/gbase_to_gfoffices_1_A
	id = "gbase_to_gfoffices_1_A"
	id_target = "gbase_to_gfoffices_2_A"

/obj/effect/step_trigger/gbase_to_gfoffices_2_A
	id = "gbase_to_gfoffices_2_A"
	id_target = "gbase_to_gfoffices_1_A"

//Prepper base to vault bunker
/obj/effect/step_trigger/prepper_to_vbunker_1_A
	id = "prepper_to_vbunker_1_A"
	id_target = "prepper_to_vbunker_2_A"

/obj/effect/step_trigger/prepper_to_vbunker_2_A
	id = "prepper_to_vbunker_2_A"
	id_target = "prepper_to_vbunker_1_A"

//Ironhead compound to abandoned fortress
/obj/effect/step_trigger/ironcompound_to_abandonedfortress_1_A
	id = "ironcompound_to_abandonedfortress_1_A"
	id_target = "ironcompound_to_abandonedfortress_2_A"

/obj/effect/step_trigger/ironcompound_to_abandonedfortress_2_A
	id = "ironcompound_to_abandonedfortress_2_A"
	id_target = "ironcompound_to_abandonedfortress_1_A"