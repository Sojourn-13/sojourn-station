// This machine process Ameridian into other raw materials with code stolen from the bullet fabricator
/obj/machinery/ameridian_processor
	name = "ameridian processor"
	desc = "A machine to convert ameridian crystals into other raw materials"
	icon = 'icons/obj/machines/grinder.dmi'
	icon_state = "ameridian_processor"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 40
	circuit = /obj/item/circuitboard/ameridian_processor
	var/processing = FALSE
	var/obj/item/reagent_containers/glass/beaker = null
	var/points = 0
	var/point_ratio = 100 // How many points is a single ameridian sheet worth
	var/menustat = "menu"
	var/build_eff = 1
	var/eat_eff = 1

	/* Keep in mind the points are affected by components tier.
		T5 = 20% of the initial price.
		T4 = 25% of the initial price.
		T3 = 33% of the initial price.
		T2 = 50% of the initial price.
	*/
	var/list/recipes = list(
		"Steel",
			list(name="Steel (1)", cost=100, path=/obj/item/stack/material/steel),
			list(name="Steel (120)", cost=1200, path=/obj/item/stack/material/steel/full),
		"Plastic",
			list(name="Plastic (1)", cost=100, path=/obj/item/stack/material/plastic),
			list(name="Plastic (120)", cost=1200, path=/obj/item/stack/material/plastic/full),
		"Glass",
			list(name="Glass (1)", cost=100, path=/obj/item/stack/material/glass),
			list(name="Glass (120)", cost=1200, path=/obj/item/stack/material/glass/full),
		"Plasteel",
			list(name="Plasteel (1)", cost=350, path=/obj/item/stack/material/plasteel),
			list(name="Plasteel (120)", cost=42000, path=/obj/item/stack/material/plasteel/full),
		"Silver",
			list(name="Silver (1)", cost=200, path=/obj/item/stack/material/silver),
			list(name="Silver (120)", cost=24000, path=/obj/item/stack/material/silver/full),
		"Gold",
			list(name="Gold (1)", cost=200, path=/obj/item/stack/material/gold),
			list(name="Gold (120)", cost=24000, path=/obj/item/stack/material/gold/full),
		"Platinum",
			list(name="Platinum (1)", cost=250, path=/obj/item/stack/material/platinum),
			list(name="Platinum (120)", cost=30000, path=/obj/item/stack/material/platinum/full),
		"Uranium",
			list(name="Uranium (1)", cost=250, path=/obj/item/stack/material/uranium),
			list(name="Uranium (120)", cost=30000, path=/obj/item/stack/material/uranium/full),
		"Plasma",
			list(name="Plasma (1)", cost=250, path=/obj/item/stack/material/plasma),
			list(name="Plasma (120)", cost=30000, path=/obj/item/stack/material/plasma/full),
		"Osmium",
			list(name="Osmium (1)", cost=400, path=/obj/item/stack/material/osmium),
			list(name="Osmium (120)", cost=48000, path=/obj/item/stack/material/osmium/full),
		"Diamonds",
			list(name="Diamonds (1)", cost=400, path=/obj/item/stack/material/diamond),
			list(name="Diamonds (120)", cost=48000, path=/obj/item/stack/material/diamond/full),
		"Metallic Hydrogen",
			list(name="Metallic Hydrogen (1)", cost=400, path=/obj/item/stack/material/mhydrogen),
			list(name="Metallic Hydrogen (120)", cost=48000, path=/obj/item/stack/material/mhydrogen/full),
		"Tritium",
			list(name="Tritium (1)", cost=400, path=/obj/item/stack/material/tritium),
			list(name="Tritium (120)", cost=48000, path=/obj/item/stack/material/tritium/full),
	)

/obj/machinery/ameridian_processor/New()
	..()
	create_reagents(1000)
	beaker = new /obj/item/reagent_containers/glass/beaker/large(src) //???

/obj/machinery/ameridian_processor/attackby(var/obj/item/I, var/mob/user)

	if(istype(I, /obj/item/stack/material/cyborg))
		return //Prevents borgs throwing their stuff into it

	if(default_deconstruction(I, user))
		return

	if(default_part_replacement(I, user))
		return
	if(processing)
		to_chat(user, SPAN_NOTICE("\The [src] is currently processing."))
	else if(!istype(I, /obj/item/stack/material/ameridian))
		to_chat(user, SPAN_NOTICE("You cannot put this in \the [src]."))
	else
		var/i = 0
		for(var/obj/item/stack/material/ameridian/G in contents)
			i++
		if(i >= 120)
			to_chat(user, SPAN_NOTICE("\The [src] is full! Activate it."))
		else
			user.remove_from_mob(I)
			I.loc = src
			to_chat(user, SPAN_NOTICE("You put \the [I] in \the [src]"))
	update_icon()
	return

/obj/machinery/ameridian_processor/nano_ui_interact(var/mob/user, var/ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS, var/datum/topic_state/state =GLOB.outside_state)
	user.set_machine(src)
	var/list/data = list()
	data["points"] = points
	if(menustat == "menu")
		data["beaker"] = beaker
		if(beaker)

			var/list/tmp_recipes = list()
			for(var/smth in recipes)
				if(istext(smth))
					tmp_recipes += list(list(
						"is_category" = TRUE,
						"name" = smth,
					))
				else
					var/list/L = smth
					tmp_recipes += list(list(
						"is_category" = FALSE,
						"name" = L["name"],
						"cost" = round(L["cost"]/build_eff),
						"allow_multiple" = L["allow_multiple"],
					))

			data["recipes"] = tmp_recipes

	data["processing"] = processing
	data["menustat"] = menustat
	if(menustat == "menu")
		data["beaker"] = beaker

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
		// for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "ameridian_processor.tmpl", "Ameridian Processor", 550, 655)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()

/obj/machinery/ameridian_processor/attack_hand(mob/user as mob)
	if(..())
		return TRUE

	user.set_machine(src)
	nano_ui_interact(user)

/obj/machinery/ameridian_processor/proc/activate()
	if (usr.stat)
		return
	if (stat) //NOPOWER etc
		return
	if(processing)
		to_chat(usr, SPAN_NOTICE("The ameridian processor is in the process of working."))
		return
	var/S = 0
	for(var/obj/item/stack/material/ameridian/T in contents)
		S += 5
		points += T.amount * point_ratio
		//if(I.reagents.get_reagent_amount("nutriment") < 0.1)
		//	points += 1
		//else points += I.reagents.get_reagent_amount("nutriment") * 8 * eat_eff
		qdel(T)
	if(S)
		processing = TRUE
		update_icon()
		updateUsrDialog()
		playsound(src.loc, 'sound/sanity/hydraulic.ogg', 50, 1)
		use_power(S * 30)
		spawn((1 + S * 0.5) / eat_eff) //Max stack with t1 is 61 / 1 so long time
			processing = FALSE
			update_icon()
	else
		menustat = "void"
	return

/obj/machinery/ameridian_processor/proc/create_product(var/item, var/amount)
	var/list/recipe = null
	if(processing)
		return

	for(var/list/R in recipes)
		if(R["name"] == item)
			recipe = R
			break
	if(!recipe)
		return

	if(!("allow_multiple" in recipe))
		amount = 1
	else
		amount = max(amount, 1)

	var/cost = recipe["cost"] * amount / build_eff

	if(cost > points)
		menustat = "nopoints"
		return FALSE

	processing = TRUE
	update_icon()
	updateUsrDialog() //maybe we can remove it
	points -= cost
	spawn(cost / eat_eff * 0.1) //Insainly quick do to being made to mass create ammo

		var/creating = recipe["path"]
		var/reagent = recipe["reagent"]
		if(reagent) //For reagents like milk
			beaker.reagents.add_reagent(reagent, 30)
		else
			for(var/i in 1 to amount)
				new creating(loc)
			flick("greyson_finish", src)
		processing = FALSE
		menustat = "menu" //complete adds an extra step thats annoying to deal with
		update_icon()
		return TRUE

/obj/machinery/ameridian_processor/Topic(href, href_list)
	if(stat & BROKEN) return
	if(usr.stat || usr.restrained()) return
	if(!in_range(src, usr)) return
	usr.set_machine(src)

	switch(href_list["action"])
		if("activate")
			activate()
		if("detach")
			if(beaker)
				beaker.loc = src.loc
				beaker = null
				update_icon()
		if("create")
			create_product(href_list["item"], text2num(href_list["amount"]))
		if("menu")
			menustat = "menu"
	updateUsrDialog()

/obj/machinery/ameridian_processor/RefreshParts()
	..()
	var/man_rating = 0
	var/bin_rating = 0

	for(var/obj/item/stock_parts/P in component_parts)
		if(istype(P, /obj/item/stock_parts/matter_bin))
			bin_rating += P.rating
		if(istype(P, /obj/item/stock_parts/manipulator))
			man_rating += P.rating

	build_eff = man_rating
	eat_eff = bin_rating
