/datum/trade_station/suit_up
	name_pool = list(
		"ATB 'Suit Up!'" = "Aster's Trade Beacon 'Suit Up!': \"Suits, voidsuits and more for you, traveler!\""
	)
	icon_states = list("serb_frigate", "ship")
	uid = "suit_up"
	tree_x = 0.74
	tree_y = 0.9
	start_discovered = TRUE
	spawn_always = TRUE
	markup = COMMON_GOODS
	offer_limit = 20
	base_income = 3200
	wealth = 0
	hidden_inv_threshold = 2000
	//recommendations_needed = 1
	stations_recommended = list("rigs")
	inventory = list(
		"Armor" = list(
			/obj/item/clothing/head/helmet/faceshield/riot = custom_good_amount_range(list(3, 5)),
			/obj/item/clothing/suit/armor/heavy/riot = custom_good_amount_range(list(3, 5)),
			/obj/item/clothing/suit/armor/bulletproof = custom_good_amount_range(list(3, 5)),
			/obj/item/clothing/head/helmet = custom_good_amount_range(list(3, 5)),
			/obj/item/clothing/suit/armor/laserproof = custom_good_amount_range(list(1, 5)),
			/obj/item/clothing/shoes/ablasive = custom_good_amount_range(list(1, 5)),
			/obj/item/clothing/gloves/thick/ablasive = custom_good_amount_range(list(1, 5)),
			/obj/item/clothing/head/helmet/laserproof = custom_good_amount_range(list(1, 5)),
			/obj/item/clothing/head/helmet/faceshield/altyn = custom_good_amount_range(list(1, 5)),
			/obj/item/clothing/suit/armor/flakvest/full = custom_good_amount_range(list(1, 5))
		),
		"Voidsuits" = list(
			/obj/item/clothing/suit/space/void,
			/obj/item/clothing/suit/space/void/atmos = custom_good_amount_range(list(1, 5)),
			/obj/item/clothing/suit/space/void/mining = custom_good_amount_range(list(1, 5)),
			/obj/item/clothing/suit/space/void/engineering = custom_good_amount_range(list(-5, 3)),
			/obj/item/clothing/suit/space/void/medical = custom_good_amount_range(list(-5, 3)),
			/obj/item/clothing/suit/space/void/security = custom_good_amount_range(list(-5, 1)),
			/obj/item/clothing/suit/space/void/SCAF = custom_good_amount_range(list(-5, 1)),
			/obj/item/clothing/shoes/magboots = custom_good_amount_range(list(5, 5)),
			/obj/item/tank/oxygen = custom_good_amount_range(list(5, 5)),
			/obj/item/tank/emergency_oxygen/double = custom_good_amount_range(list(5, 5))
		),
		"RIGs" =  list(
			/obj/item/rig/eva = custom_good_amount_range(list(1, 5)),
			/obj/item/rig/sea = custom_good_amount_range(list(1, 5)),
			/obj/item/rig/medical = custom_good_amount_range(list(1, 5)),
			/obj/item/rig/light = custom_good_amount_range(list(1, 5))
		),
		"Rig modules" = list(
			/obj/item/rig_module/device/healthscanner,
			/obj/item/rig_module/device/drill,
			/obj/item/rig_module/device/orescanner,
			/obj/item/rig_module/device/rcd,
			/obj/item/rig_module/grappler,
			/obj/item/rig_module/cargo_clamp,
			/obj/item/rig_module/modular_injector,
			/obj/item/rig_module/modular_injector/medical,
			/obj/item/rig_module/maneuvering_jets,
			/obj/item/rig_module/device/flash,
			/obj/item/rig_module/mounted,
			/obj/item/rig_module/mounted/egun,
			/obj/item/rig_module/mounted/taser,
			/obj/item/rig_module/held/energy_blade,
			/obj/item/rig_module/held/shield,
			/obj/item/rig_module/fabricator,
			/obj/item/rig_module/fabricator/energy_net,
			/obj/item/rig_module/vision/meson,
			/obj/item/rig_module/vision/nvg,
			/obj/item/rig_module/vision/sechud,
			/obj/item/rig_module/vision/medhud,
			/obj/item/rig_module/storage,
			/obj/item/rig_module/storage/engi,
			/obj/item/rig_module/storage/med,
			/obj/item/rig_module/storage/combat,
			/obj/item/rig_module/storage/large
		)
	)

	hidden_inventory = list(
		"Utility Suits" = list(
			/obj/item/clothing/suit/space/bomb,
			/obj/item/clothing/head/helmet/space/bomb,
			/obj/item/clothing/suit/fire,
			/obj/item/clothing/suit/radiation,
			/obj/item/clothing/head/radiation
		)
	)

	offer_types = list(
		/obj/item/tool/tape_roll = offer_data("tape roll", 100, 0),
		/obj/item/tool/surgicaldrill = offer_data("surgical drill", 400, 0),
		/obj/item/cell/large = offer_data("large cell", 200, 0)
	)
