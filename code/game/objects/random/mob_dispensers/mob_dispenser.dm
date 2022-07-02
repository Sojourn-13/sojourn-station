/obj/machinery/mob_dispenser
	name = "mob spawner basetype"
	desc = "dont use this"

	icon = 'icons/obj/machines/autolathe.dmi'
	icon_state = "mechfab"

	use_power = FALSE

	anchored = TRUE

	health = 500
	maxHealth = 500

	/// Shitty half-baked framework for armor, stolen directly from mob armor. don't expect this to 100% work. Only melee, bullet, and energy are used right now.
	var/list/armor_obj = list(melee = 0, bullet = 0, energy = 0, bomb = 0, bio = 0, rad = 0, agony = 0)

	/**
	 * Associative list, enter typepaths as the key, chance to drop as the value. Each item will be considered individually in terms of probability.
	 * Very literal. Apon deconstruction of the spawner, aka when it gets shot a lot, it drops whatever is in this list. Even mobs.
	 * Each entry is one instance of it that will be spawned.
	**/
	var/list/atom/movable/loot = list(
									/obj/item/stack/material/steel/{amount = 15} = 100,
									/obj/item/stack/material/glass/random = 95,
									/obj/item/stack/material/plasteel/random = 15,
									/obj/item/stack/cable_coil{amount = 5} = 90,
									/obj/item/trash/material/circuit = 100,
									/obj/item/stock_parts/matter_bin/ = 32,
									/obj/item/stock_parts/matter_bin/ = 32,
									/obj/item/stock_parts/manipulator/ = 32,
									/obj/item/stock_parts/manipulator/ = 32,
									/obj/item/stock_parts/micro_laser = 32,
									/obj/item/stock_parts/console_screen = 80
	)

	/// If TRUE, will perform check/tick spawn_delay every tick and/or call spawn_entities.
	var/active = TRUE

	var/emp_vulnerable

	/// Maximum total amount of mobs this machine can have created
	var/maximum_spawned = 50

	/// Used as \the [src] [spawn_message] [spawned_mob]
	var/spawn_message = "constructs a"

	///Will only allow mobs to spawn if 0. Decremented every process tick if above 0 and reset to spawn_delay_initial if 0.
	var/spawn_delay = 0
	/// The value to which spawn_delay will be reset to
	var/spawn_delay_initial = 0
	/// used in prob() to determine if this will spawn a mob this process tick
	var/spawn_probability = 50

	///List of lists. If to_spawn is empty or if none of the probabilities proc, we spawn one of these at random. Format: list(list(maximum, typepath), ...) Please don't put any typepaths in here that are in to_spawn.
	var/list/default_spawn = list(list(9, /mob/living/carbon/superior_animal/giant_spider/))

	///List of lists. Format for usage: list(list(maximum, typepath, probability for prob()), ...) Please dont put any typepaths in here that are in default_spawn.
	var/list/to_spawn = list(list(30, /mob/living/carbon/superior_animal/giant_spider/hunter, 7),
						list(1, /mob/living/carbon/superior_animal/giant_spider/tarantula/ogre, 5))

	/// Do we use currently_spawned?
	var/track_spawned = TRUE
	/// List of associative lists. each key is a typepath, each value is a instance of that typepath spawned by this machine.
	var/list/currently_spawned = list() // TODO: maybe move typepath to 2nd entry in all lists

	/// How many mobs do we spawn per successful spawn?
	var/spawn_per_spawn = 1

/obj/machinery/mob_dispenser/Destroy()

	for (var/list/containing_list in currently_spawned)
		for (var/mob/spawned in containing_list)
			spawned.spawned_from = null
		containing_list.Cut()

	. = ..()

/obj/machinery/mob_dispenser/examine(mob/user) //yoinked from hivemind code
	..()
	if (health < maxHealth * 0.1)
		to_chat(user, SPAN_DANGER("It's falling apart!"))
	else if (health < maxHealth * 0.25)
		to_chat(user, SPAN_DANGER("There are noticable holes in it! You can even see the components!"))
	else if (health < maxHealth * 0.50)
		to_chat(user, SPAN_DANGER("It is very heavily dented, a few places having caved in!"))
	else if (health < maxHealth * 0.75)
		to_chat(user, SPAN_WARNING("It has numerous dents and deep scratches."))
	else if (health < maxHealth)
		to_chat(user, SPAN_WARNING("It's a bit scratched and has dents."))

/obj/machinery/mob_dispenser/Process()

	if (active)
		if (spawn_delay == 0)
			spawn_entities()
			spawn_delay = spawn_delay_initial
		else
			spawn_delay--
		return TRUE
	return FALSE

/// Top layer proc for mob dispenser spawn logic. Checks to_spawn for anything, and if there is none, uses default_spawn instead. Args: spawned, int, defaults to 0. How many have we spawned this spawn tick?
/obj/machinery/mob_dispenser/proc/spawn_entities(var/spawned = 0) //TODO: make it so we can force a certain entity to spawn
// TODO: make it so that we instead add things that succeed the prob() roll to a list so we can randomly pick
// Not perfect, I could clean the code more
	if (prob(spawn_probability))
		var/length = 0
		if (currently_spawned)
			if (currently_spawned.len)
				for (var/key in currently_spawned)
					var/list/mobs = currently_spawned[key]
					length += (mobs.len)
			if (length < maximum_spawned)
				if (to_spawn && to_spawn.len)
					var/list/successful_rolls = list()
					for (var/list/containing_list in to_spawn)
						var/probability_to_spawn = containing_list[3]
						if (prob(probability_to_spawn))
							var/maximum = containing_list[1]
							var/typepath = containing_list[2]
							if (!(currently_spawned[typepath]))
								currently_spawned[typepath] = list()
							if (length(currently_spawned[typepath]) < maximum)
								continue //we do it here so we can spawn something else if all other checks succeed except this
							successful_rolls += containing_list
							continue
					if (successful_rolls.len)
						var/list/random_list = pick(successful_rolls)
						var/maximum = random_list[1]
						var/typepath = random_list[2]
						handle_spawn_logic(maximum, typepath, spawned)
						return TRUE

				if (default_spawn && default_spawn.len)
					var/list/random_list = pick(default_spawn)
					var/maximum = random_list[1]
					var/typepath = random_list[2]
					if (!(currently_spawned[typepath]))
						currently_spawned[typepath] = list()
					if (length(currently_spawned[typepath]) < maximum)
						handle_spawn_logic(maximum, typepath, spawned)
						return TRUE
	return FALSE

/// Lower layer of mob dispenser spawn logic.
/obj/machinery/mob_dispenser/proc/handle_spawn_logic(var/maximum, var/typepath, var/spawned)
	var/mob/spawned_mob = new typepath(get_turf(src))

	visible_message(SPAN_WARNING("\the [src] [spawn_message] [spawned_mob]!"))

	if (track_spawned)
		spawned_mob.spawned_from = src
		currently_spawned[typepath] += spawned_mob

	var/passed_arg = spawned++

	if (passed_arg < spawn_per_spawn)
		spawn_entities(passed_arg)
		return TRUE
	return TRUE

// i wish this was just on machinery god damn
/obj/machinery/mob_dispenser/proc/take_damage(damage = 0, attacking_item = null)
	health -= damage
	if (health <= 0)
		dismantle()

/obj/machinery/mob_dispenser/bullet_act(obj/item/projectile/Proj)
	take_damage(Proj.get_structure_damage(), Proj)
	if(istype(Proj, /obj/item/projectile/ion))
		Proj.on_hit(loc)
	. = ..()

/obj/machinery/mob_dispenser/attackby(obj/item/I, mob/user)
	if(!(I.flags & NOBLUDGEON) && I.force)
		user.do_attack_animation(src)
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		var/clear_damage = I.force

		if(clear_damage)
			. = ..()
			take_damage(clear_damage, I)
		else
			to_chat(user, SPAN_WARNING("You trying to hit the [src] with [I], but it seems useless."))
			playsound(src, 'sound/weapons/Genhit.ogg', 30, 1)
		return

/obj/machinery/mob_dispenser/ex_act(severity)
	switch(severity)
		if(1)
			take_damage(200)
		if(2)
			take_damage(100)
		if(3)
			take_damage(50)
	return TRUE

/obj/machinery/mob_dispenser/emp_act(severity)
	if (emp_vulnerable)
		switch(severity)
			if(1)
				take_damage(70)
				deactivate(7 SECONDS, TRUE)
			if(2)
				take_damage(30)
				deactivate(3 SECONDS, TRUE)
		new /obj/effect/overlay/pulse(loc)
		return TRUE
	return FALSE

/obj/machinery/mob_dispenser/proc/deactivate(duration = 0, emped = FALSE)
	active = FALSE
	if (duration != 0)
		addtimer((CALLBACK(src, .proc/reactivate, emped)), duration)
	if (emped)
		stat |= EMPED

/obj/machinery/mob_dispenser/proc/reactivate(emped = FALSE)
	active = TRUE
	if (emped)
		stat &= ~EMPED

/obj/machinery/mob_dispenser/on_deconstruction()

	if (loot && loot.len)
		for (var/entity in loot)
			if (prob(loot[entity]))
				new entity(loc)

	. = ..()
