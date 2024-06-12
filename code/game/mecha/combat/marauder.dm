/obj/mecha/combat/dreadnought
	desc = "Heavy-duty, combat exosuit, developed after the Durand model. Rarely found among civilian populations."
	name = "Dreadnought"
	icon_state = "marauder"
	initial_icon = "marauder"
	step_in = 3
	step_energy_drain = 3
	price_tag = 25000 //Rare spawns + uncraftable
	health = 1500
	deflect_chance = 25
	damage_absorption = list("brute"=0.5,"fire"=0.7,"bullet"=0.45,"energy"=0.7,"bomb"=0.7)
	max_temperature = 60000
	infra_luminosity = 3
	var/zoom = 0
	var/thrusters = 0
	var/smoke = 5
	var/smoke_ready = 1
	var/smoke_cooldown = 100
	var/datum/effect/effect/system/smoke_spread/smoke_system = new
	armor_level = MECHA_ARMOR_SUPERHEAVY
	wreckage = /obj/effect/decal/mecha_wreckage/marauder
	add_req_access = 0
	internal_damage_threshold = 25
	force = 45
	max_equip = 10

/obj/mecha/combat/dreadnought/New()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/energy/pulse(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/ultracannon(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot/loaded(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/explosive(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/armor_booster/antiproj_armor_booster(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/armor_booster/anticcw_armor_booster(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tool/drill(src)
	ME.attach(src)
	smoke_system.set_up(3, 0, src)
	smoke_system.attach(src)

/obj/mecha/combat/dreadnought/Destroy()
	QDEL_NULL(smoke_system)
	. = ..()

/obj/mecha/combat/dreadnought/relaymove(mob/user,direction)
	if(user != occupant) //While not "realistic", this piece is player friendly.
		user.forceMove(get_turf(src))
		to_chat(user, "You climb out from [src]")
		return 0
	if(!can_move)
		return 0
	if(zoom)
		if(world.time - last_message > 20)
			occupant_message("Unable to move while in zoom mode.")
			last_message = world.time
		return 0
	if(connected_port)
		if(world.time - last_message > 20)
			occupant_message("Unable to move while connected to the air system port")
			last_message = world.time
		return 0
	if(!thrusters && inertial_movement)
		return 0
	if(state || !has_charge(step_energy_drain))
		return 0
	var/tmp_step_in = step_in
	var/tmp_step_energy_drain = step_energy_drain
	var/move_result = 0
	if(internal_damage&MECHA_INT_CONTROL_LOST)
		set_glide_size(DELAY2GLIDESIZE(step_in))
		move_result = mechsteprand()
	else if(dir!=direction)
		move_result = mechturn(direction)
	else
		set_glide_size(DELAY2GLIDESIZE(step_in))
		move_result	= mechstep(direction)
	if(move_result)
		if(istype(loc, /turf/space))
			if(!check_for_support())
				inertial_movement = direction
				if(thrusters)
					tmp_step_energy_drain = step_energy_drain*2

		can_move = 0
		spawn(tmp_step_in)
			can_move = 1
		use_power(tmp_step_energy_drain)
		return 1
	return 0


/obj/mecha/combat/dreadnought/verb/toggle_thrusters()
	set category = "Exosuit Interface"
	set name = "Toggle thrusters"
	set src = usr.loc
	set popup_menu = 0

	if(usr != occupant)
		return

	if(occupant)
		if(get_charge() > 0)
			thrusters = !thrusters
			log_message("Toggled thrusters.")
			occupant_message("<font color='[thrusters?"blue":"red"]'>Thrusters [thrusters?"en":"dis"]abled.</font>")


/obj/mecha/combat/dreadnought/verb/smoke()
	set category = "Exosuit Interface"
	set name = "Smoke"
	set src = usr.loc
	set popup_menu = 0

	if(usr != occupant)
		return

	if(smoke_ready && smoke>0)
		smoke_system.start()
		smoke--
		smoke_ready = 0
		spawn(smoke_cooldown)
			smoke_ready = 1

//TODO replace this with zoom code that doesn't increase peripherial vision
/obj/mecha/combat/dreadnought/verb/zoom()
	set category = "Exosuit Interface"
	set name = "Zoom"
	set src = usr.loc
	set popup_menu = 0

	if(usr != occupant)
		return

	if(occupant.client)
		zoom = !zoom
		log_message("Toggled zoom mode.")
		occupant_message("<font color='[zoom?"blue":"red"]'>Zoom mode [zoom?"en":"dis"]abled.</font>")
		if(zoom)
			occupant.client.view = 12
			occupant.client.apply_clickcatcher()
			occupant << sound('sound/mecha/imag_enh.ogg',volume=50)
		else
			occupant.client.view = world.view//world.view - default mob view size
			occupant.client.apply_clickcatcher()

/obj/mecha/combat/dreadnought/go_out()
	if(occupant && occupant.client)
		occupant.client.view = world.view
		zoom = 0
	. = ..()

/obj/mecha/combat/dreadnought/get_stats_part()
	var/output = ..()
	output += {"<b>Smoke:</b> [smoke]
					<br>
					<b>Thrusters:</b> [thrusters?"on":"off"]
					"}
	return output


/obj/mecha/combat/dreadnought/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=\ref[src];toggle_thrusters=1'>Toggle thrusters</a><br>
						<a href='?src=\ref[src];toggle_zoom=1'>Toggle zoom mode</a><br>
						<a href='?src=\ref[src];smoke=1'>Smoke</a>
						</div>
						</div>
						"}
	output += ..()
	return output

/obj/mecha/combat/dreadnought/Topic(href, href_list)
	. = ..()
	if(href_list["toggle_thrusters"])
		toggle_thrusters()
	if(href_list["smoke"])
		smoke()
	if(href_list["toggle_zoom"])
		zoom()
	return


/*******************/
/* Subtypes        */
/*******************/

/obj/mecha/combat/dreadnought/gloria
	name = "Warhound Gloria"
	desc = "What was once a heavily augmented person is now a walking tank, modeled after a dreadnought combat mech, Warhound Gloria is the pinnacle of excelsior engineering. A \
	heavily armored and even more heavily equipped bastion for the people's revolution. The modified combat armor appears to be specialized at withstanding electro-magnetic pulses, but \
	otherwise functions as a standard dreadnought."
	icon_state = "mauler"
	initial_icon = "mauler"
	wreckage = /obj/effect/decal/mecha_wreckage/mauler

/obj/mecha/combat/dreadnought/gloria/emp_act(severity)
	return

/obj/mecha/combat/dreadnought/gloria/New()
	. = ..()//Let it equip whatever is needed. TODO: This is stupid
	var/obj/item/mecha_parts/mecha_equipment/ME
	if(equipment.len)//Now to remove it and equip anew.
		for(ME in equipment)
			ME.detach(src)
			qdel(ME)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/energy/ion(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/energy/pulse(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot/loaded(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/flashbang(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/explosive(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/hmg(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/hmg(src)
	ME.attach(src)
	smoke_system.set_up(3, 0, src)
	smoke_system.attach(src)


/obj/mecha/combat/dreadnought/seraph
	desc = "Heavy-duty, command-type exosuit. This is a custom model, utilized only by high-ranking military personnel."
	name = "Seraph"
	icon_state = "seraph"
	initial_icon = "seraph"
	step_in = 2
	step_energy_drain = 1
	health = 1800
	wreckage = /obj/effect/decal/mecha_wreckage/seraph
	internal_damage_threshold = 20
	force = 55
	max_equip = 10
	cargo_capacity = 10

/obj/mecha/combat/dreadnought/seraph/New()
	. = ..()//Let it equip whatever is needed. TODO: This is stupid
	var/obj/item/mecha_parts/mecha_equipment/ME
	if(equipment.len)//Now to remove it and equip anew.
		for(ME in equipment)
			ME.detach(src)
			qdel(ME)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/energy/laser/heavy(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/ultracannon/loaded(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot/loaded(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/explosive(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/teleporter(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/armor_booster/antiproj_armor_booster(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/armor_booster/anticcw_armor_booster(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill(src)
	ME.attach(src)

/obj/mecha/combat/dreadnought/seraph/hellbrute
	desc = "Heavy-duty, combat exosuit, developed off of the existing seraph model. Usually found in the hands of a void wolf reavers. As rare as it is powerful."
	name = "Hell Brute"
	icon_state = "mauler"
	initial_icon = "mauler"
	wreckage = /obj/effect/decal/mecha_wreckage/mauler
