//A portable analyzer, for research borgs.  This is better then giving them a gripper which can hold anything and letting them use the normal analyzer.
/obj/item/portable_destructive_analyzer
	name = "Portable Destructive Analyzer"
	icon = 'icons/obj/items.dmi'
	icon_state = "portable_analyzer"
	desc = "Similar to the stationary version, this rather unwieldy device allows you to break down objects in the name of science."

	var/min_reliability = 90 //Can't upgrade, call it laziness or a drawback

	var/datum/research/files 	//The device uses the same datum structure as the R&D computer/server.
										//This analyzer can only store tech levels, however.

	var/obj/item/loaded_item	//What is currently inside the analyzer.

/obj/item/portable_destructive_analyzer/Initialize()
	. = ..()
	files = new /datum/research(src) //Setup the research data holder.

/obj/item/portable_destructive_analyzer/attack_self(user as mob)
	var/response = alert(user, 	"Analyzing the item inside will *DESTROY* the item for good.\n\
							Syncing to the research server will send the data that is stored inside to research.\n\
							Ejecting will place the loaded item onto the floor.",
							"What would you like to do?", "Analyze", "Sync", "Eject")
	if(response == "Analyze")
		if(loaded_item)
			var/confirm = alert(user, "This will destroy the item inside forever.  Are you sure?","Confirm Analyze","Yes","No")
			if(confirm == "Yes") //This is pretty copypasta-y
				to_chat(user, "You activate the analyzer's microlaser, analyzing \the [loaded_item] and breaking it down.")
				flick("portable_analyzer_scan", src)
				playsound(src.loc, 'sound/items/Welder2.ogg', 50, 1)
				for(var/T in loaded_item.origin_tech)
					files.check_item_for_tech(loaded_item)
					var/object_research_value = files.experiments.get_object_research_value(loaded_item)
					files.adjust_research_points(object_research_value)
					files.experiments.do_research_object(loaded_item)
					to_chat(user, "\The [loaded_item] incremented the research points by [object_research_value].")
				loaded_item = null
				for(var/obj/I in contents)
					for(var/mob/M in I.contents)
						M.death()
					if(istype(I,/obj/item/stack/material))//Only deconstructs one sheet at a time instead of the entire stack
						var/obj/item/stack/material/S = I
						if(S.get_amount() > 1)
							S.use(1)
							loaded_item = S
						else
							qdel(S)
							desc = initial(desc)
							icon_state = initial(icon_state)
					else
						qdel(I)
						desc = initial(desc)
						icon_state = initial(icon_state)
			else
				return
		else
			to_chat(user, "The [src] is empty.  Put something inside it first.")
	if(response == "Sync")
		var/success = 0
		for(var/obj/machinery/r_n_d/server/S in GLOB.machines)
			S.files.download_from(files)
			files.download_from(S.files)
			success = TRUE
		if(success)
			to_chat(user, "You connect to the research server, push your data upstream to it, then pull the resulting merged data from the master branch.")
			playsound(src.loc, 'sound/machines/twobeep.ogg', 50, 1)
		else
			to_chat(user, "Reserch server ping response timed out.  Unable to connect.  Please contact the system administrator.")
			playsound(src.loc, 'sound/machines/buzz-two.ogg', 50, 1)
	if(response == "Eject")
		if(loaded_item)
			loaded_item.loc = get_turf(src)
			desc = initial(desc)
			icon_state = initial(icon_state)
			loaded_item = null
		else
			to_chat(user, "The [src] is already empty.")


/obj/item/portable_destructive_analyzer/afterattack(var/atom/target, var/mob/living/user, proximity)
	if(!target)
		return
	if(!proximity)
		return
	if(!isturf(target.loc)) // Don't load up stuff if it's inside a container or mob!
		return
	if(istype(target,/obj/item))
		if(loaded_item)
			to_chat(user, "Your [src] already has something inside.  Analyze or eject it first.")
			return
		var/obj/item/I = target
		I.loc = src
		loaded_item = I
		for(var/mob/M in viewers())
			M.show_message(text(SPAN_NOTICE("[user] adds the [I] to the [src].")), 1)
		desc = initial(desc) + "<br>It is holding \the [loaded_item]."
		flick("portable_analyzer_load", src)
		icon_state = "portable_analyzer_full"

//This is used to unlock other borg covers.
/obj/item/card/robot //This is not a child of id cards, as to avoid dumb typechecks on computers.
	name = "access code transmission device"
	icon_state = "id-robot"
	desc = "A circuit grafted onto the bottom of an ID card.  It is used to transmit access codes into other robot chassis, \
	allowing you to lock and unlock other robots' panels."

//A harvest item for serviceborgs.
/obj/item/robot_harvester
	name = "auto harvester"
	desc = "A hand-held harvest tool that resembles a sickle.  It uses energy to cut plant matter very efficently."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "autoharvester"

/obj/item/robot_harvester/afterattack(var/atom/target, var/mob/living/user, proximity)
	if(!target)
		return
	if(!proximity)
		return
	if(istype(target,/obj/machinery/portable_atmospherics/hydroponics))
		var/obj/machinery/portable_atmospherics/hydroponics/T = target
		if(T.harvest) //Try to harvest, assuming it's alive.
			T.harvest(user)
		else if(T.dead) //It's probably dead otherwise.
			T.remove_dead(user)
	else
		to_chat(user, "Harvesting \a [target] is not the purpose of this tool.  The [src] is for plants being grown.")

// A special tray for the service droid. Allow droid to pick up and drop items as if they were using the tray normally
// Click on table to unload, click on item to load. Otherwise works identically to a tray.
// Unlike the base item "tray", robotrays ONLY pick up food, drinks and condiments.

/obj/item/tray/robotray
	name = "RoboTray"
	desc = "An autoloading tray specialized for carrying refreshments."

/obj/item/tray/robotray/afterattack(atom/target, mob/user as mob, proximity)
	if(!proximity)
		return
	if ( !target )
		return
	// pick up items, mostly copied from base tray pickup proc
	// see code\game\objects\items\weapons\kitchen.dm line 241
	if ( istype(target,/obj/item))
		if ( !isturf(target.loc) ) // Don't load up stuff if it's inside a container or mob!
			return
		var turf/pickup = target.loc

		var addedSomething = 0

		for(var/obj/item/reagent_containers/I in pickup)


			if( I != src && !I.anchored && !istype(I, /obj/item/clothing/under) && !istype(I, /obj/item/clothing/suit) && !istype(I, /obj/item/projectile) )
				var/add = 0
				if(I.w_class == ITEM_SIZE_TINY)
					add = 1
				else if(I.w_class == ITEM_SIZE_SMALL)
					add = 3
				else
					add = 5
				if(calc_carry() + add >= max_carry)
					break

				I.forceMove(src)
				carrying.Add(I)
				add_overlay(image("icon" = I.icon, "icon_state" = I.icon_state, "layer" = 30 + I.layer))
				addedSomething = 1
		if ( addedSomething )
			user.visible_message("\blue [user] load some items onto their service tray.")

		return

	// Unloads the tray, copied from base item's proc dropped() and altered
	// see code\game\objects\items\weapons\kitchen.dm line 263

	if ( isturf(target) || istype(target,/obj/structure/table) )
		var foundtable = istype(target,/obj/structure/table/)
		if ( !foundtable ) //it must be a turf!
			for(var/obj/structure/table/T in target)
				foundtable = 1
				break

		var turf/dropspot
		if ( !foundtable ) // don't unload things onto walls or other silly places.
			dropspot = user.loc
		else if ( isturf(target) ) // they clicked on a turf with a table in it
			dropspot = target
		else					// they clicked on a table
			dropspot = target.loc


		cut_overlays()

		var droppedSomething = 0

		for(var/obj/item/I in carrying)
			I.loc = dropspot
			carrying.Remove(I)
			droppedSomething = 1
			if(!foundtable && isturf(dropspot))
				// if no table, presume that the person just shittily dropped the tray on the ground and made a mess everywhere!
				spawn()
					for(var/i = 1, i <= rand(1,2), i++)
						if(I)
							step(I, pick(NORTH,SOUTH,EAST,WEST))
							sleep(rand(2,4))
		if ( droppedSomething )
			if ( foundtable )
				user.visible_message("\blue [user] unloads their service tray.")
			else
				user.visible_message("\blue [user] drops all the items on their tray.")

	return ..()




// A special pen for service droids. Can be toggled to switch between normal writting mode, and paper rename mode
// Allows service droids to rename paper items.

/obj/item/pen/robopen
	desc = "A black ink printing attachment with a paper naming mode."
	name = "Printing Pen"
	var/mode = 1

/obj/item/pen/robopen/attack_self(mob/user as mob)

	var/choice = input("Would you like to change colour or mode?") as null|anything in list("Colour","Mode")
	if(!choice) return

	playsound(src.loc, 'sound/effects/pop.ogg', 50, 0)

	switch(choice)

		if("Colour")
			var/newcolour = input("Which colour would you like to use?") as null|anything in list("black","blue","red","green","yellow")
			if(newcolour) colour = newcolour

		if("Mode")
			if (mode == 1)
				mode = 2
			else
				mode = 1
			to_chat(user, "Changed printing mode to '[mode == 2 ? "Rename Paper" : "Write Paper"]'")

	return

// Copied over from paper's rename verb
// see code\modules\paperwork\paper.dm line 62

/obj/item/pen/robopen/proc/RenamePaper(mob/user as mob,obj/paper as obj)
	if ( !user || !paper )
		return
	var/n_name = sanitizeSafe(input(user, "What would you like to label the paper?", "Paper Labelling", null)  as text, 32)
	if ( !user || !paper )
		return

	//n_name = copytext(n_name, 1, 32)
	if(( get_dist(user,paper) <= 1  && user.stat == 0))
		paper.name = "paper[(n_name ? text("- '[n_name]'") : null)]"
	add_fingerprint(user)
	return

//TODO: Add prewritten forms to dispense when you work out a good way to store the strings.
/obj/item/form_printer
	//name = "paperwork printer"
	name = "paper dispenser"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "paper_bin1"
	item_state = "sheet-metal"

/obj/item/form_printer/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	return

/obj/item/form_printer/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag, params)

	if(!target || !flag)
		return

	if(istype(target,/obj/structure/table))
		deploy_paper(get_turf(target))

/obj/item/form_printer/attack_self(mob/user as mob)
	deploy_paper(get_turf(src))

/obj/item/form_printer/proc/deploy_paper(var/turf/T)
	T.visible_message("\blue \The [src.loc] dispenses a sheet of crisp white paper.")
	new /obj/item/paper(T)


//Personal shielding for the combat module.
/obj/item/borg/combat/shield
	name = "personal shielding"
	desc = "A powerful experimental module that turns aside or absorbs incoming attacks at the cost of charge."
	icon = 'icons/obj/decals-warning.dmi'
	icon_state = "shock"
	var/shield_level = 0.5 //Percentage of damage absorbed by the shield.

/obj/item/borg/combat/shield/verb/set_shield_level()
	set name = "Set shield level"
	set category = "Object"
	set src in range(0)

	var/N = input("How much damage should the shield absorb?") in list("5","10","25","50","75","100")
	if (N)
		shield_level = text2num(N)/100

/obj/item/borg/combat/mobility
	name = "mobility module"
	desc = "By retracting limbs and tucking in its head, a combat android can roll at high speeds."
	icon = 'icons/obj/decals-warning.dmi'
	icon_state = "shock"

/obj/item/inflatable_dispenser
	name = "inflatables dispenser"
	desc = "Small device which allows rapid deployment and removal of inflatables."
	icon = 'icons/obj/storage.dmi'
	icon_state = "inf_deployer"
	w_class = ITEM_SIZE_NORMAL

	// By default stores up to 10 walls and 5 doors. May be changed.
	var/stored_walls = 10
	var/stored_doors = 5
	var/max_walls = 10
	var/max_doors = 5
	var/mode = 0 // 0 - Walls   1 - Doors

/obj/item/inflatable_dispenser/examine(var/mob/user)
	if(!..(user))
		return
	to_chat(user, "It has [stored_walls] wall segment\s and [stored_doors] door segment\s stored.")
	to_chat(user, "It is set to deploy [mode ? "doors" : "walls"]")

/obj/item/inflatable_dispenser/attack_self()
	mode = !mode
	to_chat(usr, "You set \the [src] to deploy [mode ? "doors" : "walls"].")

/obj/item/inflatable_dispenser/afterattack(var/atom/A, var/mob/user)
	..(A, user)
	if(!user)
		return
	if(!user.Adjacent(A))
		to_chat(user, "You can't reach!")
		return
	if(istype(A, /turf))
		try_deploy_inflatable(A, user)
	if(istype(A, /obj/item/inflatable) || istype(A, /obj/structure/inflatable))
		pick_up(A, user)

/obj/item/inflatable_dispenser/proc/try_deploy_inflatable(var/turf/T, var/mob/living/user)
	if(mode) // Door deployment
		if(!stored_doors)
			to_chat(user, "\The [src] is out of doors!")
			return

		if(T && istype(T))
			new /obj/structure/inflatable/door(T)
			stored_doors--

	else // Wall deployment
		if(!stored_walls)
			to_chat(user, "\The [src] is out of walls!")
			return

		if(T && istype(T))
			new /obj/structure/inflatable/wall(T)
			stored_walls--

	playsound(T, 'sound/items/zip.ogg', 75, 1)
	to_chat(user, "You deploy the inflatable [mode ? "door" : "wall"]!")

/obj/item/inflatable_dispenser/proc/pick_up(var/obj/A, var/mob/living/user)
	if(istype(A, /obj/structure/inflatable))
		if(istype(A, /obj/structure/inflatable/wall))
			if(stored_walls >= max_walls)
				to_chat(user, "\The [src] is full.")
				return
			stored_walls++
			qdel(A)
		else
			if(stored_doors >= max_doors)
				to_chat(user, "\The [src] is full.")
				return
			stored_doors++
			qdel(A)
		playsound(loc, 'sound/machines/hiss.ogg', 75, 1)
		visible_message("\The [user] deflates \the [A] with \the [src]!")
		return
	if(istype(A, /obj/item/inflatable))
		if(istype(A, /obj/item/inflatable/wall))
			if(stored_walls >= max_walls)
				to_chat(user, "\The [src] is full.")
				return
			stored_walls++
			qdel(A)
		else
			if(stored_doors >= max_doors)
				to_chat(usr, "\The [src] is full!")
				return
			stored_doors++
			qdel(A)
		visible_message("\The [user] picks up \the [A] with \the [src]!")
		return

	to_chat(user, "You fail to pick up \the [A] with \the [src]")
	return

/obj/item/tool/tape_roll/fiber/robotic
	name = "fiber tape roll"
	desc = "A large roll of fiber tape used by borgs and drones for large repairing projects, mostly windows."
	max_stock = 2000 //So we dont waste it all on 1 window


/obj/item/tool/robotic_omni
	name = "robot omni tool"
	desc = "Omni tool that all borg modules are based off. You should'n't have this..."
	icon_state = "engimplant"
	tool_qualities = list(QUALITY_CUTTING = 150)

	force = WEAPON_FORCE_PAINFUL
	use_power_cost = 0
	suitable_cell = null
	degradation = 0
	sharp = 1
	embed_mult = 0

/obj/item/tool/robotic_omni/surgery
	name = "Surgery omnitool"
	desc = "A surgery omnitool for cyborgs, uses the cyborg's own power supply to function. Essentially a less mobile version of the Soteria branded omnitool."
	icon_state = "medimplant"
	tool_qualities = list(QUALITY_CLAMPING = 60,
						  QUALITY_RETRACTING = 60,
						  QUALITY_BONE_SETTING = 60,
						  QUALITY_CAUTERIZING = 60,
						  QUALITY_SAWING = 45,
						  QUALITY_CUTTING = 60,
						  QUALITY_WIRE_CUTTING = 55,
						  QUALITY_BONE_GRAFTING = 80,
						  QUALITY_DRILLING = 40)

/obj/item/tool/robotic_omni/engi
	name = "Engineering omnitool"
	desc = "Omnitool for Engineering cyborgs and the like. Heavy duty monster of multifunctionality and quality."
	icon_state = "engimplant"
	tool_qualities = list(QUALITY_PRYING = 40,
						  QUALITY_HAMMERING = 45,
						  QUALITY_BOLT_TURNING = 40,
						  QUALITY_WIRE_CUTTING = 40,
						  QUALITY_CUTTING = 150, //So were faster at cutting up boddies
						  QUALITY_SAWING = 60,
						  QUALITY_DIGGING = 40,
						  QUALITY_SCREW_DRIVING = 40,
						  QUALITY_DRILLING = 60)

/obj/item/tool/robotic_omni/standard
	name = "Standard omnitool"
	desc = "Omnitool for standard cyborgs and the like. Has basic, but well-performing qualities."
	icon_state = "engimplant"
	tool_qualities = list(QUALITY_PRYING = 40,
						  QUALITY_HAMMERING = 30,
						  QUALITY_BOLT_TURNING = 40,
						  QUALITY_CUTTING = 150, //So were faster at cutting up boddies
						  QUALITY_SAWING = 30,
						  QUALITY_DIGGING = 40,
						  QUALITY_SCREW_DRIVING = 40)

/obj/item/tool/robotic_omni/miner
	name = "Mining omnitool"
	desc = "Omnitool for mining cyborgs and the like. Heavy duty utility in almost everything, with no way to mine rock."
	icon_state = "engimplant"
	tool_qualities = list(QUALITY_PRYING = 40,
						  QUALITY_HAMMERING = 30,
						  QUALITY_BOLT_TURNING = 40,
						  QUALITY_CUTTING = 150, //So were faster at cutting up boddies
						  QUALITY_SAWING = 30,
						  QUALITY_SCREW_DRIVING = 40)

/obj/item/tool/robotic_omni/sec
	name = "Security omnitool"
	desc = "Omnitool for Security cyborgs. Used for upturning and sealing burrows as well as cut up carcasses. Has additional functionality for firearm manipulation."
	icon_state = "engimplant"
	tool_qualities = list(QUALITY_PRYING = 20,
						  QUALITY_HAMMERING = 35, //For undoing random things like barrer placements
						  QUALITY_BOLT_TURNING = 10,
						  QUALITY_SAWING = 15, //Sawing for guns
						  QUALITY_WIRE_CUTTING = 20, //for removing grills and taking apart firearms
						  QUALITY_CUTTING = 150, //So were faster at cutting up boddies
						  QUALITY_SCREW_DRIVING = 40,
						  QUALITY_DIGGING = 40)

/obj/item/tool/robotic_omni/cleaner
	name = "Burrow Omnitool"
	desc = "Omnitool for Custodial cyborgs. Used for upturning and sealing up burrows as well as cut up carcasses."
	icon_state = "engimplant"
	tool_qualities = list(QUALITY_PRYING = 20,
						  QUALITY_HAMMERING = 35, //For undoing random things like barrer placements
						  QUALITY_BOLT_TURNING = 30,
						  QUALITY_CUTTING = 150, //So were faster at cutting up boddies
						  QUALITY_DIGGING = 40,
						  QUALITY_SCREW_DRIVING = 40) //Tiles and the like

/obj/item/tool/robotic_omni/sci
	name = "Science Omnitool"
	desc = "Omnitool for Science cyborgs. Has extensive tool qualities but subpar performance when compared to more specialized tools."
	icon_state = "engimplant"
	tool_qualities = list(QUALITY_PRYING = 30,
						  QUALITY_HAMMERING = 35, //For undoing random things like barrer placements
						  QUALITY_BOLT_TURNING = 30,
						  QUALITY_CUTTING = 150, //So were faster at cutting up boddies
						  QUALITY_WIRE_CUTTING = 40,
						  QUALITY_SAWING = 35,
						  QUALITY_DIGGING = 40,
						  QUALITY_EXCAVATION = 140, //we already get a slowdown per click when it asks if we want to dig or excavation
						  QUALITY_SCREW_DRIVING = 40) //Tiles and the like


/obj/item/tool/crowbar/robotic
	icon = 'icons/obj/robot_items.dmi'
	tool_qualities = list(QUALITY_PRYING = 40, QUALITY_HAMMERING = 10, QUALITY_DIGGING = 20) //only used on the medical borg and they need burrow digging like the rest!
	degradation = 0

/obj/item/tool/wrench/robotic
	icon = 'icons/obj/robot_items.dmi'
	tool_qualities = list(QUALITY_BOLT_TURNING = 40)
	degradation = 0

/obj/item/tool/screwdriver/robotic
	icon = 'icons/obj/robot_items.dmi'
	//random_icon = FALSE
	degradation = 0

/obj/item/tool/multitool/robotic
	icon = 'icons/obj/robot_items.dmi'
	degradation = 0

/obj/item/tool/wirecutters/robotic
	icon = 'icons/obj/robot_items.dmi'
	tool_qualities = list(QUALITY_WIRE_CUTTING = 40, QUALITY_CUTTING = 30)
	degradation = 0

/obj/item/tool/weldingtool/robotic
	icon = 'icons/obj/robot_items.dmi'
	switched_on_qualities = list(QUALITY_WELDING = 40, QUALITY_CAUTERIZING = 15, QUALITY_WIRE_CUTTING = 15)
	max_fuel = 40
	degradation = 0

/obj/item/tool/weldingtool/robotic/weaker
	name = "small welder"
	desc = "A smaller welder used for seeling cracks or small repairs."
	icon = 'icons/obj/robot_items.dmi'
	switched_on_qualities = list(QUALITY_WELDING = 30, QUALITY_CAUTERIZING = 5)
	max_fuel = 15 //cracks
	degradation = 0

// -----------------------------
//           Bags
// -----------------------------

/*
		The following code was ported from Civ13-RP and heavily adjusted.
		It is more efficient, without the UI weirdness, and properly works with borgs.
		The code has been adjusted to work with Sojourn without problems, but possible weirdness may occur.
		~Ritea
*/

/obj/item/storage/bag/robotic
	name = "robotic bag"
	desc = "A bag for robots. It seems more complicated then it needs to be."
	var/used_storage_space = 0 //Used to keep track of total amount of items, it's here for stacks.

/obj/item/storage/bag/robotic/attack_self(mob/user as mob)
	examine(user)

/obj/item/storage/bag/robotic/afterattack(obj/target as obj, mob/user as mob)
	gather_all(target, user)

/obj/item/storage/bag/robotic/examine(mob/user as mob)
	..()
	to_chat(user, SPAN_NOTICE("Ctrl + Click: Switch Mode\nAlt + Click: Empty Contents"))
	if(!Adjacent(user)) //Can only check the contents of ore bags if you can physically reach them.
		return

	if(istype(user, /mob/living))
		add_fingerprint(user)

	if(!contents.len)
		to_chat(user, SPAN_NOTICE("It is empty."))
		return

	to_chat(user, SPAN_NOTICE("It holds:"))
	var/list/item_count = get_item_count()
	for(var/item in item_count)
		to_chat(user, SPAN_NOTICE("- [item_count[item]] [item]"))
	return

/obj/item/storage/bag/robotic/AltClick(mob/user as mob)
	if(src.loc == user)
		dump_it(user.loc)
	else
		..()

/obj/item/storage/bag/robotic/CtrlClick(mob/user as mob)
	if(src.loc == user)
		toggle_gathering_mode()
	else
		..()

/obj/item/storage/bag/robotic/remove_from_storage(obj/item/W as obj, atom/new_location)
	if(!istype(W))
		return FALSE
	if(new_location)
		if(ismob(loc))
			W.dropped(usr)
		else
			W.reset_plane_and_layer()
		W.forceMove(new_location)
	else
		W.forceMove(get_turf(src))
	W.on_exit_storage(src)
	update_icon()
	if(istype(W, /obj/item/stack))
		var/obj/item/stack/S = W
		used_storage_space -= S.amount
	else
		used_storage_space--
	return TRUE

/obj/item/storage/bag/robotic/proc/add_to_storage(obj/item/target_item as obj)

	if(max_w_class < target_item.w_class)
		to_chat(usr, SPAN_NOTICE("[target_item] can not fit inside."))
		return FALSE


	if(used_storage_space < max_storage_space)
		var/transfer //Used to track how much was transferred between stacks.
		var/overfill_amount //Used to track just how much the bag would get filled over it's capacity.
		if(istype(target_item, /obj/item/stack) && is_type_in_list(target_item, can_hold) || can_hold.len == 0 && !is_type_in_list(target_item, cant_hold))
		//Checking if the item is a stack since they are processed differently, and if the item is allowed.
			var/obj/item/stack/S = target_item
			if(is_type_in_list(S, contents)) //Checking if the bag contains item's type to avoid needless looping.
				for(var/obj/item/stack/current_stack in contents)
					if(current_stack.amount < current_stack.max_amount)
						transfer = S.transfer_to(current_stack) //Transfer is done here, and the amount transferred is returned and kept in a variable.
						if(used_storage_space + transfer > max_storage_space) //Checking if the transfer caused inventory to overfill past capacity.
							overfill_amount = used_storage_space + transfer - max_storage_space //Calculating how much it was overfilled.
							S.amount += overfill_amount //Recompensating the overfilled amount.
							current_stack.amount -= overfill_amount //Taking away the amount that caused the overfill.
							used_storage_space += S.amount - overfill_amount //Adding the used-up storage space.
							to_chat(usr, SPAN_NOTICE("[src] has been filled to capacity."))
							return TRUE //Returning since there is no point to continue looping when it's max capacity.
						used_storage_space += transfer //In case no overfill happened, we assign transfer amount to used space.
						if(S.amount) //If the stack isn't empty, we continue the loop.
							continue
						else //If the stack is empty, we delete it and return.
							qdel(S)
							return TRUE
			if(S && used_storage_space != max_storage_space) //If no same types were found in a bag, we move the stack.
				if(used_storage_space + S.amount <= max_storage_space) //If there is no overfill, we just move it.
					S.forceMove(src)
					used_storage_space += S.amount
					return TRUE
				else //If there is overfill, we create a new stack inside storage with the amount that fits, and adjust origin stack.
					overfill_amount = used_storage_space + S.amount - max_storage_space
					var/obj/item/stack/NewStack = new type(S)
					NewStack.amount = S.amount - overfill_amount
					S.amount -= NewStack.amount
					return TRUE
		else if(is_type_in_list(target_item, can_hold) || can_hold.len == 0 && is_type_in_list(target_item, cant_hold))
			//If item isn't a stack, it's very easy to account for.
			target_item.forceMove(src)
			used_storage_space++
			return TRUE
	else if(used_storage_space == max_storage_space) //If bag is full, we return and notify the user.
		to_chat(usr, SPAN_NOTICE("[src] is already full."))
		return FALSE
	else //If item didn't meet condition, we return quietly to avoid spam.
		return FALSE

/obj/item/storage/bag/robotic/proc/gather_all(atom/A, mob/user as mob, var/silent = 0)
	var/success = 0
	if(collection_mode) //If collection_mode is TRUE, we gather from a turf.
		var/turf/T = A
		if(istype(A, /obj/item)) //If item is clicked on with collection_mode set to all, get it's turf instead.
			T = get_turf(A)
		for(var/obj/item/I in T)
			success = add_to_storage(I) //If item is added successfully, it returns TRUE.
	else if(istype(A, /obj/item)) //Check if target is an item.
		success = add_to_storage(A)
	if(success && !silent) //Notifying user that items were placed inside the bag.
		to_chat(user, "<span class='notice'>You put everything in [src].</span>")
	else if(!silent) //If transfer didn't succeed, it means no item can be picked up, we notify user here.
		to_chat(user, "<span class='notice'>There is nothing to pick up with \the [src].</span>")
	if(istype(user.pulling, /obj/structure/ore_box/) && src.contains(/obj/item/stack/ore))
		//This is mainly used for ore bag, there is no point in making this bit universal, so it is only for ores.
		//If the user is pulling an ore box, the ores from the ore bag will be transferred to it automatically.
		var/obj/structure/ore_box/O = user.pulling
		O.attackby(src, user)

/obj/item/storage/bag/robotic/equipped(mob/user as mob) //Used for assigning event signal tracking for autoload proc when bag is equipped.
	..()
	if(user.get_inventory_slot(src) == slot_wear_suit || slot_l_hand || slot_r_hand || slot_belt) //Basically every place they can go. Makes sure it doesn't unregister if moved to other slots.
		GLOB.moved_event.register(user, src, /obj/item/storage/bag/robotic/proc/autoload, user)

/obj/item/storage/bag/robotic/dropped(mob/user as mob) //Used to unassign event signal tracking to prevent it from triggering when not worn.
	..()
	if(user.get_inventory_slot(src) == slot_wear_suit || slot_l_hand || slot_r_hand || slot_belt) //See above. This should really be a define.
		GLOB.moved_event.register(user, src, /obj/item/storage/bag/robotic/proc/autoload, user)
	else
		GLOB.moved_event.unregister(user, src)

/obj/item/storage/bag/robotic/proc/autoload(mob/user as mob)
//This proc is not very efficient, since it can't be triggered if can_hold is empty.
//However, allowing such bags to pick items automatically would cause problems.
//~Ritea
	for(var/item in can_hold) //For every item in the can_hold list, we check if that item is in the turf.
		var/obj/I = locate(item) in get_turf(src)
		if(I) //If an item is located in the turf, we trigger this.
			gather_all(get_turf(src), user, TRUE)
			return //Returning to prevent excessive looping, since add_to_storage handles all can_hold and cant_hold lists.

/obj/item/storage/bag/robotic/proc/get_item_count()
//This proc is re-used from ore boxes, since borgs can't open storage containers.
//Ultimately this is only a short-term fix, if possible, someone should fix the borgs' HUD and attack_hand bugs.
//~Ritea

	var/list/stored_items = list() //List for items inside the storage.

	for(var/obj/item/I in contents) //Loop over every item in bag's contents.
		if(stored_items[I.name]) //If our stored_items already has the item, we just increase the number.
			if(istype(I, /obj/item/stack))
				var/obj/item/stack/S = I
				stored_items[S.name] += S.amount
			else
				stored_items[I.name]++
		else //If there is no such item in the list, we create new one and assign the amount.
			if(istype(I, /obj/item/stack))
				var/obj/item/stack/S = I
				stored_items[S.name] = S.amount
			else
				stored_items[I.name] = 1

	return stored_items //We return the list for use in other procs.

/obj/item/storage/bag/robotic/ore
	name = "mining satchel compactor"
	desc = "This little bugger can be used to store and transport ores, comes with extra capacity."
	icon = 'icons/obj/mining.dmi'
	icon_state = "satchel"
	slot_flags = SLOT_BELT | SLOT_POCKET
	w_class = ITEM_SIZE_NORMAL
	max_storage_space = 500 //Bonus capacity because of specialization.
	max_w_class = ITEM_SIZE_NORMAL
	can_hold = list (
		/obj/item/stack/ore
	)

/obj/item/storage/bag/robotic/produce
	name = "heavy-duty produce bag"
	desc = "A larger capacity produce bag, made specifically for cyborgs. Get out there and gather 'em plants!'"
	icon = 'icons/obj/hydroponics_machines.dmi'
	icon_state = "plantbag"
	w_class = ITEM_SIZE_NORMAL
	max_storage_space = 500 //Bonus, to keep cosistency with other borg bags, may be pointless for this bag.
	max_w_class = ITEM_SIZE_NORMAL
	can_hold = list(
		/obj/item/seeds,
		/obj/item/grown,
		/obj/item/reagent_containers/snacks/grown,
		/obj/item/reagent_containers/snacks/egg,
		/obj/item/reagent_containers/snacks/meat
	)

/obj/item/storage/bag/trash/big/robotic
	name = "internal trash container"
	desc = "An internalized trash container for gathering trash. Become a walking trash can, today!"

/obj/item/storage/bag/robotic/trash/autoload(mob/user as mob)
	return //Prevent the trash bag from autoloading everything during movement, for sanity.

/obj/item/storage/bag/robotic/trash/update_icon()
	if(contents.len == 0)
		icon_state = "trashbag0"
	else if(contents.len < 24)
		icon_state = "trashbag1"
	else if(contents.len < 42)
		icon_state = "trashbag2"
	else
		icon_state = "trashbag3"

/obj/item/storage/bag/robotic/sheetsnatcher
	name = "heavy-duty sheet snatcher"
	desc = "A patented storage system designed for any kind of mineral sheet, this variation comes with larger capacity and is designed for cyborgs."
	icon = 'icons/obj/mining.dmi'
	icon_state = "sheetsnatcher"
	max_storage_space = 500 //Using max_storage_space instead of base sheetsnatcher's capacity, no point in creating a new variable.
	can_hold = list (
		/obj/item/stack/material
	)

/obj/item/storage/bag/robotic/holding
	name = "satchel of holding"
	desc = "A revolution in convenience, this satchel allows for immense ore or produce storage even has safty restrictions to stabilize unwanted reactions."
	icon_state = "satchel_bspace"
	icon = 'icons/obj/mining.dmi'
	max_storage_space = DEFAULT_HUGE_STORAGE * 10
	max_w_class = ITEM_SIZE_BULKY
	matter = list(MATERIAL_STEEL = 4, MATERIAL_GOLD = 4, MATERIAL_DIAMOND = 2, MATERIAL_URANIUM = 2)
	origin_tech = list(TECH_BLUESPACE = 4)
	can_hold = list(/obj/item/stack/ore,
	                /obj/item/reagent_containers/snacks/grown,
	                /obj/item/seeds,
	                /obj/item/grown,
	                /obj/item/reagent_containers/snacks/egg,
	                /obj/item/reagent_containers/snacks/meat)

/obj/item/storage/bag/ore/holding/New()
	..()
	item_flags |= BLUESPACE
	bluespace_entropy(4, get_turf(src))
