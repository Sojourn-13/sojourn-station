/datum/trade_station/rigvider
	name_pool = list(
		"HTB 'Boris'" = "Hardsuit Trade Beacon 'Boris': \"Hello there, we are hardsuit salvagers. We will be around the system for some time and we have leftover stock. We can sell some off if you want them."
	)
	uid = "rigs"
	tree_x = 0.74
	tree_y = 0.7
	spawn_always = TRUE
	markup = UNCOMMON_GOODS
	offer_limit = 20
	base_income = 1600
	wealth = 0
	hidden_inv_threshold = 2000
	recommendation_threshold = 4000
	stations_recommended = list("illegal1")
	recommendations_needed = 1
	inventory = list(
		"RIGs II" =  list(
			/obj/item/rig/light = custom_good_amount_range(list(1, 5)),
			/obj/item/rig/combat = custom_good_amount_range(list(1, 5))
		),
		"RIG Specialized Modules II" = list(
			/obj/item/rig_module/grenade_launcher,
			/obj/item/rig_module/held/energy_blade,
			/obj/item/rig_module/held/shield,
			/obj/item/rig_module/datajack,
			/obj/item/rig_module/modular_injector,
			/obj/item/rig_module/cargo_clamp/large
		)
	)
	hidden_inventory = list(
		"RIG Specialized Modules III" = list(
			/obj/item/rig_module/electrowarfare_suite,
			/obj/item/rig_module/modular_injector/combat,
			/obj/item/rig_module/modular_injector/medical,
			//obj/item/rig_module/cape
		)
	)
	offer_types = list(
		// TODO: offers
		/obj/item/rig/merc = offer_data("crimson hardsuit control module", 10000, 1)		// base price: 6282 (incl. components)
	)
