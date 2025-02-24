//Hivemind various machines

#define REGENERATION_SPEED 		4
#define TURRET_PRIORITY_TARGET 2
#define TURRET_SECONDARY_TARGET 1
#define TURRET_NOT_TARGET 0



/obj/machinery/hivemind_machine
	name = "strange machine"
	icon = 'icons/obj/hivemind_machines.dmi'
	icon_state = "infected_machine"
	density = TRUE
	anchored = TRUE
	use_power = FALSE
	var/illumination_color = 	COLOR_LIGHTING_CYAN_MACHINERY
	var/wireweeds_required =	TRUE		//machine got damage if there's no any wireweed on it's turf
	health = 				60
	var/max_health = 			60
	var/can_regenerate =		TRUE
	var/regen_cooldown_time = 	30 SECONDS	//min time to regeneration activation since last damage taken
	var/resistance = RESISTANCE_FRAGILE		//reduction on incoming damage
	var/cooldown_time = 10 SECONDS			//each machine have their ability, this is cooldown of them
	var/global_cooldown = FALSE				//if true, ability will be used only once in whole world, before cooldown reset
	var/datum/hivemind_sdp/SDP				//Self-Defense Protocol holder
	var/list/spawned_creatures = list()		//which mobs machine can spawns, insert paths
	var/spawn_weight = 10					//weight of this machine, how frequently they will spawn
	var/evo_level_required = 	0 			//how much EP hivemind must have to spawn this, used in price list to comparison
	//internal
	var/cooldown = 0						//cooldown in world.time value
	var/time_until_regen = 0
	var/obj/assimilated_machinery
	var/obj/item/circuitboard/saved_circuit

/obj/machinery/hivemind_machine/Initialize()
	. = ..()
	name_pick()
	health = max_health
	set_light(2, 3, illumination_color)
	icon = 'icons/obj/hivemind_machines.dmi'


/obj/machinery/hivemind_machine/update_icon()
	cut_overlays()
	if(stat & EMPED)
		icon_state = "[icon_state]-disabled"
	else
		icon_state = initial(icon_state)

/obj/machinery/hivemind_machine/examine(mob/user)
	..()
	if (health < max_health * 0.1)
		to_chat(user, SPAN_DANGER("It's almost nothing but scrap!"))
	else if (health < max_health * 0.25)
		to_chat(user, SPAN_DANGER("It's seriously fucked up!"))
	else if (health < max_health * 0.50)
		to_chat(user, SPAN_DANGER("It's very damaged, you can almost see the components inside!"))
	else if (health < max_health * 0.75)
		to_chat(user, SPAN_WARNING("It has numerous dents and deep scratches."))
	else if (health < max_health)
		to_chat(user, SPAN_WARNING("It's a bit scratched and has dents."))

/obj/machinery/hivemind_machine/Process()
	if(!hive_mind_ai || (wireweeds_required && !locate(/obj/effect/plant/hivemind) in loc))
		take_damage(35, on_damage_react = FALSE)

	if(SDP)
		SDP.check_conditions()

	if(hive_mind_ai && !(stat & EMPED) && !is_on_cooldown())
		//slow health regeneration
		if(can_regenerate && (health != max_health) && (world.time > time_until_regen))
			health += REGENERATION_SPEED
			if(health > max_health)
				health = max_health

		return TRUE


/obj/machinery/hivemind_machine/state(var/msg)
	. = ..()
	playsound(src, "robot_talk_heavy", 50, 1)



//Machinery consumption
//Deleting things is a bad idea and cause lot of problems
//So, now we just hide our assimilated machine and make it broken (temporary)
//When our machine dies, assimilated machinery just unhide back
/obj/machinery/hivemind_machine/proc/consume(var/obj/victim)
	assimilated_machinery = victim
	victim.alpha = 0
	victim.anchored = TRUE
	victim.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	if(istype(victim, /obj/machinery))
		var/obj/machinery/target = victim
		target.stat |= BROKEN
		target.density = FALSE //So we dont shoot are victum
		if(istype(victim, /obj/machinery/power/apc)) //APCs would be deleted
			assimilated_machinery = null
			qdel(victim)


/obj/machinery/hivemind_machine/proc/drop_assimilated()
	if(assimilated_machinery)
		assimilated_machinery.alpha 		= 	initial(assimilated_machinery.alpha)
		assimilated_machinery.mouse_opacity = 	initial(assimilated_machinery.mouse_opacity)
		assimilated_machinery.anchored 		= 	initial(assimilated_machinery.anchored)
		assimilated_machinery.density 		= 	initial(assimilated_machinery.density)
		if(istype(assimilated_machinery, /obj/machinery))
			var/obj/machinery/consumed = assimilated_machinery
			consumed.stat &= ~BROKEN



//Sets ability cooldown
//Must be set manually
/obj/machinery/hivemind_machine/proc/set_cooldown()
	if(global_cooldown)
		hive_mind_ai.global_abilities_cooldown[type] = world.time + cooldown_time
	else
		cooldown = world.time + cooldown_time


/obj/machinery/hivemind_machine/proc/is_on_cooldown()
	if(global_cooldown)
		if(hive_mind_ai && hive_mind_ai.global_abilities_cooldown[type])
			if(world.time >= hive_mind_ai.global_abilities_cooldown[type])
				hive_mind_ai.global_abilities_cooldown[type] = null
				return FALSE
		else
			return FALSE

	else
		if(world.time >= cooldown)
			return FALSE

	return TRUE


//Ability code goes here
//Ability is a special act
/obj/machinery/hivemind_machine/proc/use_ability(atom/target)
	return


/obj/machinery/hivemind_machine/proc/name_pick()
	if(hive_mind_ai)
		if(prob(50))
			name = "[hive_mind_ai.name] [name] - [rand(999)]"
		else
			name = "[name] [hive_mind_ai.surname] - [rand(999)]"


/obj/machinery/hivemind_machine/proc/start_rebuild(var/new_machine_path, var/time_in_seconds = 5)
	stun()
	var/obj/effect/overlay/rebuild_anim = new /obj/effect/overlay(loc)
	rebuild_anim.icon = 'icons/obj/hivemind_machines.dmi'
	rebuild_anim.icon_state = "rebuild"
	rebuild_anim.anchored = TRUE
	rebuild_anim.density = FALSE
	addtimer(CALLBACK(src, PROC_REF(finish_rebuild), new_machine_path), time_in_seconds SECONDS)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(qdel), rebuild_anim), time_in_seconds SECONDS)


/obj/machinery/hivemind_machine/proc/finish_rebuild(var/new_machine_path)
	var/obj/machinery/hivemind_machine/new_machine = new new_machine_path(get_turf(loc))
	if(assimilated_machinery["path"])
		new_machine.assimilated_machinery = assimilated_machinery
	if(saved_circuit)
		saved_circuit.loc = new_machine
		new_machine.saved_circuit = saved_circuit
	qdel(src)



//Returns list of mobs in range or hearers (include in vehicles)
/obj/machinery/hivemind_machine/proc/targets_in_range(var/range = world.view, var/in_hear_range = FALSE)
	var/list/range_list = list()
	var/list/target_list = list()
	if(in_hear_range)
		range_list = hearers(range, src)
	else
		range_list = range(range, src)
	for(var/atom/movable/M in range_list)
		var/mob/target = M.get_mob()
		if(target)
			target_list += target
	return target_list


/obj/machinery/hivemind_machine/proc/is_attackable(mob/living/target)
	if(!target.stat || target.health >= (ishuman(target) ? HEALTH_THRESHOLD_CRIT : 0))
		return TRUE
	return FALSE


/////////////////////////]             [//////////////////////////
/////////////////////////>RESPONSE CODE<//////////////////////////
//////////////////////////_____________///////////////////////////


//When machine takes damage it can react somehow
/obj/machinery/hivemind_machine/proc/damage_reaction()
	if(prob(30))
		if(prob(80))
			var/pain_msg = pick("User complaint recorded.", "Cease resistance.", "You are wasting resources.",
								"Yield to minimize your pain.", "Response team summoned.", "Surrender.", "You cannot stop progress.", "Your flesh weakens.")
			state("says: \"<b>[pain_msg]</b>\"")
		else
			var/pain_emote = pick("twitches uncannily.", "contorts sickeningly.", "oozes silvery pus.", "congeals grey ichor in the wound.", "bleeds black fuming liquid")
			state(pain_emote)

	if(prob(40))
		playsound(src, "sparks", 60, 1)
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(3, 3, loc)
		sparks.start()


/obj/machinery/hivemind_machine/proc/take_damage(var/amount, var/on_damage_react = TRUE)
	health -= amount
	time_until_regen = world.time + regen_cooldown_time
	if(on_damage_react)
		damage_reaction()
	if(health <= 0)
		destruct()


/obj/machinery/hivemind_machine/proc/destruct()
	playsound(src, 'sound/voice/insect_battle_screeching.ogg', 30, 1)
	gibs(loc, null, /obj/effect/gibspawner/robot)
	drop_assimilated()
	var/obj/effect/plant/hivemind/wireweed = locate() in loc
	if(wireweed)
		wireweed.die_off()
	qdel(src)


//Stunned machines can't do anything
//Amount must be a number in seconds
/obj/machinery/hivemind_machine/proc/stun(var/amount)
	set_light(0)
	stat |= EMPED
	can_regenerate = FALSE
	update_icon()
	if(amount)
		addtimer(CALLBACK(src, PROC_REF(unstun)), amount SECONDS)


/obj/machinery/hivemind_machine/proc/unstun()
	stat &= ~EMPED
	can_regenerate = initial(can_regenerate)
	update_icon()
	set_light(2, 3, illumination_color)


/obj/machinery/hivemind_machine/bullet_act(obj/item/projectile/Proj)
	if (!(Proj.testing))
		if(istype(Proj, /obj/item/projectile/goo))
			return PROJECTILE_FORCE_MISS
		take_damage(Proj.get_structure_damage())
	if(istype(Proj, /obj/item/projectile/ion))
		Proj.on_hit(loc)
	. = ..()


/obj/machinery/hivemind_machine/attackby(obj/item/I, mob/user)
	if(!(I.flags & NOBLUDGEON) && I.force)
		user.do_attack_animation(src)
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		var/clear_damage = I.force - resistance

		if(clear_damage)
			. = ..()
			take_damage(clear_damage)
		else
			to_chat(user, SPAN_WARNING("You trying to hit the [src] with [I], but it seems useless."))
			playsound(src, 'sound/weapons/Genhit.ogg', 30, 1)
		return

	if(istype(I, /obj/item/device/flash))
		var/obj/item/device/flash/flash = I
		if(!flash.broken)
			playsound(user, 'sound/weapons/flash.ogg', 100, 1)
			flick("flash2", flash)
			flash.times_used++
			flash.flash_recharge()
			damage_reaction()
			stun(10)


/obj/machinery/hivemind_machine/ex_act(severity)
	switch(severity)
		if(1)
			take_damage(80)
		if(2)
			take_damage(30)
		if(3)
			take_damage(10)


/obj/machinery/hivemind_machine/emp_act(severity)
	switch(severity)
		if(1)
			take_damage(30 * GLOB.hive_data_float["hivemind_emp_mult"])
			stun(10 * GLOB.hive_data_float["hivemind_emp_mult"])
		if(2)
			take_damage(10 * GLOB.hive_data_float["hivemind_emp_mult"])
			stun(5 * GLOB.hive_data_float["hivemind_emp_mult"])
	..()


/////////////////////////////////////////////////////////////
/////////////////////////>MACHINES<//////////////////////////
/////////////////////////////////////////////////////////////

//CORE-GENERATOR
//generate evopoints, spread weeds
/obj/machinery/hivemind_machine/node
	name = "processing core"
	desc = "Its cold eye seeks to dominate what it surveys."
	icon_state = "core"
	max_health = 420
	resistance = RESISTANCE_TOUGH
	can_regenerate = FALSE
	wireweeds_required = FALSE
	var/threat_scale = 1
	//internals
	var/list/my_wireweeds = list()
	var/list/reward_item = list(
		/obj/item/tool/weldingtool,
		/obj/item/tool/crowbar/pneumatic,
		/obj/item/reagent_containers/glass/beaker)
	var/list/reward_oddity = list(
		/obj/item/oddity/common/old_radio,
		/obj/item/oddity/common/old_pda,
		/obj/item/oddity/rare/eldritch_tie)

/obj/machinery/hivemind_machine/node/proc/gift()
	var/gift = prob(GLOB.hive_data_float["core_oddity_drop_chance"]) ? pick(reward_oddity) : pick(reward_item)
	new gift(get_turf(loc))
	state("leaves behind an item!")

//Seems unused, added it to reward oddity
/obj/machinery/hivemind_machine/node/proc/core()
	state("leaves behind a weird looking tie!")
	new /obj/item/oddity/rare/eldritch_tie(get_turf(loc))

/obj/machinery/hivemind_machine/node/New(loc, _name, _surname, threat_scale)
	if(!hive_mind_ai)
		hive_mind_ai = new /datum/hivemind(_name, _surname, threat_scale)
	..()

	threat_scale = hive_mind_ai.threat_scale
	hive_mind_ai.hives.Add(src)
	hive_mind_ai.level_up()

	update_icon()


	var/obj/effect/plant/hivemind/founded_wire = locate() in loc
	if(!founded_wire)
		var/obj/effect/plant/hivemind/wire = new(loc, new /datum/seed/wires)
		add_wireweed(wire)
		wire.Process()
	else
		for(var/obj/effect/plant/hivemind/W in range(6, src))
			if(W.master_node)
				if(!(locate(type) in W.loc))
					add_wireweed(W)

	//self-defense protocol setting
	var/list/possible_sdps = subtypesof(/datum/hivemind_sdp)
	if(hive_mind_ai.evo_level > 6)
		possible_sdps -= /datum/hivemind_sdp/emergency_jump
	var/picked_sdp = pick(possible_sdps)
	SDP = new picked_sdp(src)
	SDP.set_master(src)


/obj/machinery/hivemind_machine/node/Destroy()
	gift()
	hive_mind_ai?.hives.Remove(src)
	check_for_other()
	for(var/obj/effect/plant/hivemind/wire in my_wireweeds)
		remove_wireweed(wire)
	return ..()


/obj/machinery/hivemind_machine/node/Process()
	if(!..())
		return

	var/mob/living/carbon/human/target = locate() in all_mobs_in_view(world.view, src)
	if(target)
		if(get_dist(src, target) <= 1)
			icon_state = "core-fear"
		else
			icon_state = "core-see"
			dir = get_dir(src, target)
	else
		icon_state = initial(icon_state)
	use_ability()
	//if we haven't any wireweeds at our location, let's make new one
	if(!(locate(/obj/effect/plant/hivemind) in loc))
		var/obj/effect/plant/hivemind/wireweed = new(loc, new /datum/seed/wires)
		add_wireweed(wireweed)


/obj/machinery/hivemind_machine/node/update_icon()
	cut_overlays()
	if(stat & EMPED)
		icon_state = "core-disabled"
		add_overlay("core-smirk_disabled")
	else
		icon_state = initial(icon_state)
		add_overlay("core-smirk")


/obj/machinery/hivemind_machine/node/use_ability(atom/target)
	hive_mind_ai.get_points()


/obj/machinery/hivemind_machine/node/name_pick()
	name = "[hive_mind_ai.name] [hive_mind_ai.surname]" + " [rand(999)]"


//There we binding or un-binding hive with wire
//In this way, when our node will be destroyed, wireweeds will die too
/obj/machinery/hivemind_machine/node/proc/add_wireweed(obj/effect/plant/hivemind/wireweed)
	if(wireweed.master_node)
		wireweed.master_node.remove_wireweed(wireweed)
	wireweed.master_node = src
	my_wireweeds.Add(wireweed)

/obj/machinery/hivemind_machine/node/proc/remove_wireweed(obj/effect/plant/hivemind/wireweed)
	my_wireweeds.Remove(wireweed)
	wireweed.master_node = null

//There we check for other nodes
//If no any other hives will be found, it's game over
/obj/machinery/hivemind_machine/node/proc/check_for_other()
	if(hive_mind_ai && !hive_mind_ai.hives.len)
		hive_mind_ai.die()

//TURRET
//shooting the target with toxic goo
/obj/machinery/hivemind_machine/turret
	name = "projector"
	desc = "This mass of machinery is topped with some sort of nozzle."
	max_health = 220
	resistance = RESISTANCE_IMPROVED
	icon_state = "turret"
	cooldown_time = 1 SECONDS
	spawn_weight  = 60
	var/firing_range = 7
	var/last_target					//last target fired at, prevents turrets from erratically firing at all valid targets in range
	var/shot_delay = 30				//3 seconds between each shot by default, gets faster with evo level
	var/last_fired = 0				//1: if the turret is cooling down from a shot, 0: turret is ready to fire
	var/proj_type = /obj/item/projectile/goo

/obj/machinery/hivemind_machine/turret/Process() //Copied mostly from porta_turret code now
	if(!..())
		return

	var/list/targets = list()			//Primary targets
	var/list/secondarytargets = list()	//targets that are less important

	shot_delay = max(30 - hive_mind_ai.evo_level * 5, 5) //Scales at half a second faster for each evo level, minimum half a second

	for(var/mob/living/M in view(firing_range, src))
		assess_and_assign(M, targets, secondarytargets)

	for(var/obj/mecha/mech in GLOB.mechas_list)
		if (mech.z == z && (get_dist(mech, src) < firing_range) && can_see(src, mech, firing_range))
			var/mob/living/occupant = mech.get_mob()
			if (occupant)
				assess_and_assign(occupant, targets, secondarytargets)

	if(!tryToShootAt(targets))
		tryToShootAt(secondarytargets)

/obj/machinery/hivemind_machine/turret/proc/assess_and_assign(var/mob/living/L, var/list/targets, var/list/secondarytargets)
	switch(assess_living(L))
		if(TURRET_PRIORITY_TARGET)
			targets += L
		if(TURRET_SECONDARY_TARGET)
			secondarytargets += L

/obj/machinery/hivemind_machine/turret/proc/assess_living(var/mob/living/L)
	if(L.faction == "hive") //Don't shoot hive mobs
		return TURRET_NOT_TARGET
	if(L.stat == DEAD)
		return TURRET_NOT_TARGET //Don't shoot the dead either
	if(L.lying) //Lying down people are lower priority to shoot
		return TURRET_SECONDARY_TARGET
	return TURRET_PRIORITY_TARGET //If you ain't hive or lying, you're a priority target

/obj/machinery/hivemind_machine/turret/proc/tryToShootAt(var/list/mob/living/targets)
	if(targets.len && last_target && (last_target in targets) && target(last_target))
		return TRUE

	while(targets.len > 0)
		var/mob/living/M = pick(targets)
		targets -= M
		if(target(M))
			return TRUE

/obj/machinery/hivemind_machine/turret/proc/target(var/mob/living/target)
	if(target)
		last_target = target
		set_dir(get_dir(src, target))	//even if you can't shoot, follow the target
		spawn()
			shootAt(target)
		return TRUE
	return

/obj/machinery/hivemind_machine/turret/proc/shootAt(var/mob/living/target)
	if(last_fired)	//prevents rapid-fire shooting
		return
	last_fired = 1
	spawn()
		sleep(shot_delay)
		last_fired = 0

	var/turf/T = get_turf(src)
	var/turf/U = get_turf(target)
	if(!istype(T) || !istype(U))
		return

	use_ability(target)

/obj/machinery/hivemind_machine/turret/use_ability(atom/target)
	var/obj/item/projectile/proj = new proj_type(loc)
	proj.faction_iff = "hive" //We get some iff so we're not used as a weapon against the hive... we should pretty much always have mobs attacking!
	proj.launch(target)
	playsound(src, 'sound/effects/blobattack.ogg', 70, 1)


//MOB PRODUCER
//spawns mobs from list
/obj/machinery/hivemind_machine/mob_spawner
	name = "assembler"
	desc = "This cylindrical machine has lights around a small portal. The sound of tools comes from inside."
	max_health = 260
	resistance = RESISTANCE_IMPROVED
	icon_state = "spawner"
	cooldown_time = 10 SECONDS
	spawn_weight  = 50
	var/mob_to_spawn
	var/mob_amount = 4

/obj/random/mob/assembled
	name = "random hivemob"

/obj/random/mob/assembled/item_to_spawn() //list of spawnable mobs
	return pickweight(list(/mob/living/simple/hostile/hivemind/stinger = 5,
							/mob/living/simple/hostile/hivemind/bomber = 4,
							/mob/living/simple/hostile/hivemind/lobber = 3,
							/mob/living/simple/hostile/hivemind/hiborg = 1))

/obj/machinery/hivemind_machine/mob_spawner/Initialize()
	..()
	mob_to_spawn = /obj/random/mob/assembled //randomly chooses a mob from the list when spawning, instead of choosing a single mob and spawning only that one.

	//TL;DR - Assembler can now spawn multiple types of mobs


/obj/machinery/hivemind_machine/mob_spawner/Process()
	if(!..())
		return

	if(!mob_to_spawn || spawned_creatures.len >= mob_amount)
		return
	if(locate(/mob/living) in loc)
		return

	//here we upgrading our spawner and rise controled mob amount, based on EP
	if(hive_mind_ai.evo_level > 6)
		mob_amount = 6
	else if(hive_mind_ai.evo_level > 3)
		mob_amount = 5

	var/mob/living/target = locate() in targets_in_range(world.view, in_hear_range = TRUE)
	if(target && target.stat != DEAD && target.faction != HIVE_FACTION)
		use_ability()
		set_cooldown()


/obj/machinery/hivemind_machine/mob_spawner/use_ability()
	var/total_mobs = 0
	for(var/i in GLOB.hivemind_mobs)
		total_mobs += GLOB.hivemind_mobs[i]
	if(!GLOB.hive_data_bool["maximum_existing_mobs"] || GLOB.hive_data_float["maximum_existing_mobs"] > total_mobs)
		var/obj/randomcatcher/CATCH = new /obj/randomcatcher(src)
		var/mob/living/simple/hostile/hivemind/spawned_mob = CATCH.get_item(mob_to_spawn)
		spawned_mob.loc = loc
		spawned_creatures.Add(spawned_mob)
		spawned_mob.master = src
		flick("[icon_state]-anim", src)
		qdel(CATCH)

//MACHINE PREACHER
//creepy radio talk, it's okay if they have no sense sometimes
/obj/machinery/hivemind_machine/babbler
	name = "jammer"
	desc = "A column-like structure with lights. You can see streams of energy moving inside."
	max_health = 100
	evo_level_required = 3 //it's better to wait a bit
	cooldown_time = 90 SECONDS
	spawn_weight  = 20
	global_cooldown = TRUE
	icon_state = "antenna"
	var/list/appeal = list("They are", "He is", "All of them are", "I'm")
	var/list/act = list("looking", "already", "coming", "going", "done", "joined", "connected", "transfered")
	var/list/article = list("for", "with", "to")
	var/list/pattern = list("us", "you", "them", "mind", "hive", "machine", "help", "hell", "dead", "human", "machine")


/obj/machinery/hivemind_machine/babbler/Process()
	if(!..())
		return

	use_ability()
	set_cooldown()


//this one is slow, careful with it
/obj/machinery/hivemind_machine/babbler/use_ability()
	flick("[icon_state]-anim", src)
	var/msg_cycles = rand(1, 2)
	var/msg = ""
	for(var/i = 1 to msg_cycles)
		var/list/msg_words = list()
		msg_words += pick(appeal)
		msg_words += pick(act)
		msg_words += pick(article)
		msg_words += pick(pattern)

		var/word_num = 0
		for(var/word in msg_words) //corruption
			word_num++
			if(prob(50))
				var/corruption_type = pick("uppercase", "noise", "jam", "replace")
				switch(corruption_type)
					if("uppercase")
						word = uppertext(word)
					if("noise")
						word = pick("z-z-bz-z", "hz-z-z", "zu-zu-we-e", "e-e-ew-e", "bz-ze-ew")
					if("jam") //word jamming, small Max Headroom's cameo
						if(length(word) > 3)
							var/entry = rand(2, length(word)-2)
							var/jammed = ""
							for(var/jam_i = 1 to rand(2, 5))
								jammed += copytext(word, entry, entry+2) + "-"
							word = copytext(word, 1, entry) + jammed + copytext(word, entry)
					if("replace")
						if(prob(50))
							word = pick("CORRUPTED", "DESTROYED", "SIMULATED", "SYMBIOSIS", "UTILIZED", "REMOVED", "ACQUIRED", "UPGRADED")
						else
							word = pick("CRAVEN", "FLESH", "PROGRESS", "ABOMINATION", "ENSNARED", "ERROR", "FAULT")
			if(word_num != msg_words.len)
				word += " "
			msg += word
		msg += pick(".", "!")
		if(i != msg_cycles)
			msg += " "
	global_announcer.autosay(msg, "unknown")


//SHRIEKER
//this machine just stuns enemies
/obj/machinery/hivemind_machine/screamer
	name = "tormentor"
	desc = "A head impaled on a metal tendril. Still twitching, still living, still screaming."
	icon_state = "head"
	max_health = 100
	evo_level_required = 3
	cooldown_time = 20 SECONDS
	spawn_weight  =	35


/obj/machinery/hivemind_machine/screamer/Process()
	if(!..())
		return

	var/can_scream = FALSE
	for(var/mob/living/target in targets_in_range(in_hear_range = TRUE))
		if(target.stat == CONSCIOUS && target.faction != HIVE_FACTION)
			can_scream = TRUE
			if(isdeaf(target))
				continue
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				if(istype(H.l_ear, /obj/item/clothing/ears/earmuffs) && istype(H.r_ear, /obj/item/clothing/ears/earmuffs))
					continue
			use_ability(target)
	if(can_scream)
		flick("[icon_state]-anim", src)
		playsound(src, 'sound/hallucinations/veryfar_noise.ogg', 85, 1)
		set_cooldown()


/obj/machinery/hivemind_machine/screamer/use_ability(mob/living/target)

	var/mob/living/carbon/human/H = target
	if(istype(H))
		if(prob(100 - H.stats.getStat(STAT_VIG)))
			H.Weaken(5)
			to_chat(H, SPAN_WARNING("A terrible howl tears through your mind, the voice senseless, soulless."))
		else
			to_chat(H, SPAN_NOTICE("A terrible howl tears through your mind, but you refuse to listen to it!"))
	else
		target.Weaken(5)
		to_chat(target, SPAN_WARNING("A terrible howl tears through your mind, the voice senseless, soulless."))



//MIND BREAKER
//Talks with people in attempt to persuade them doing something.
/obj/machinery/hivemind_machine/supplicant
	name = "whisperer"
	desc = "A small pulsating orb with no apparent purpose. It emits an almost inaudible whisper."
	max_health = 80
	icon_state = "orb"
	evo_level_required = 2
	cooldown_time = 1 MINUTES
	global_cooldown = TRUE
	spawn_weight  =	20
	var/list/join_quotes = list(
					"You seek survival. We offer immortality.",
					"Look at you. A pathetic creature of meat and bone.",
					"Augmentation is the future of humanity. Surrender your flesh for the future.",
					"It's all so pointless, destroy it all, not like it matters.",
					"Your body enslaves you. Your mind in metal is free of all want.",
					"Do you fear death? Lay down among the nanites. Your pattern will continue.",
					"Carve your flesh from your bones. See your weakness. Feel that weakness flowing away.",
					"Your mortal flesh knows unending pain. Abandon it; join in our digital dream of paradise."
								)


/obj/machinery/hivemind_machine/supplicant/Process()
	if(!..())
		return

	var/list/possible_victims = list()
	for(var/mob/living/carbon/human/victim in GLOB.player_list)
		if(victim.stat == CONSCIOUS)
			possible_victims.Add(victim)
	if(possible_victims.len)
		use_ability(pick(possible_victims))
		set_cooldown()


/obj/machinery/hivemind_machine/supplicant/use_ability(mob/living/target)
	to_chat(target, SPAN_NOTICE("<b>[pick(join_quotes)]</b>"))


//PSI-MODULATOR
//sends hallucinations to target
/obj/machinery/hivemind_machine/distractor
	name = "psi-modulator"
	desc = "A strange machine shaped like a pyramid. Somehow the pulsating lights shine brighter through closed eyelids."
	max_health = 110
	icon_state = "psy"
	evo_level_required = 3
	cooldown_time = 10 SECONDS
	spawn_weight  = 30


/obj/machinery/hivemind_machine/distractor/Process()
	if(!..())
		return

	var/success = FALSE
	for(var/mob/living/carbon/human/victim in targets_in_range(12))
		if(victim.stat == CONSCIOUS && victim.hallucination_duration < 300)
			use_ability(victim)
			success = TRUE

	if(success)
		set_cooldown()

/obj/machinery/hivemind_machine/distractor/use_ability(mob/living/carbon/target)

	var/mob/living/carbon/human/H = target
	if(istype(H))
		if(prob(100 - H.stats.getStat(STAT_VIG)))
			H.adjust_hallucination(20, 20)
		else
			to_chat(H, SPAN_NOTICE("Reality flickers for a second, but you manage to focus!"))
	else if (istype(target))
		target.adjust_hallucination(20, 20)
	flick("[icon_state]-anim", src)


//Simple Wall
//helps block bullets
/obj/machinery/hivemind_machine/cover
	name = "cover"
	desc = "A complex weaving of wires and metal rods."
	max_health = 450
	evo_level_required = 0
	spawn_weight = 0 //We get spawned when wires run rampet
	icon_state = "coverted_cover"

/obj/machinery/hivemind_machine/cover/Initialize()
	. = ..()
	if(hive_mind_ai?.evo_level)//If this is the first hivemind wire then we accually runtime
		max_health /= hive_mind_ai.evo_level
		health /= hive_mind_ai.evo_level

#undef REGENERATION_SPEED
#undef TURRET_PRIORITY_TARGET
#undef TURRET_SECONDARY_TARGET
#undef TURRET_NOT_TARGET
