/datum/trade_station/asterstradecapital
	name_pool = list(
		"FTS 'Solnishko'" = "Free Trade Station 'Solnishko', they're sending a message \"Zdravstvuite, this is the Trade Station 'Solnishko'. We have all of the best products for sale on the frontier! You couldn't get better prices! \ Everything for sale here, don't be afraid to come aboard and check our wares!\"",
	)
	forced_overmap_zone = list(
		list(24, 26),
		list(30, 30)
	)

	icon_states = list("capital", "station")

	uid = "asterstradecapital"
	tree_x = 0.58
	tree_y = 0.9
	start_discovered = TRUE
	spawn_always = TRUE
	markup = WHOLESALE_GOODS
	base_income = 1600
	wealth = 0
	hidden_inv_threshold  = 2000
	recommendation_threshold = 1000
	stations_recommended = list("casino", "kriosanconfederacy")
	inventory  = list(
		"Tools and Equipment" = list(
			/obj/item/clothing/suit/storage/hazardvest,
			/obj/item/storage/pouch/small_generic,
			/obj/item/storage/pouch/ammo,
			/obj/item/storage/belt/utility = good_data("empty toolbelt", list(5, 20), 70),
			/obj/item/device/lighting/toggleable/flashlight,
			/obj/item/device/lighting/toggleable/flashlight/heavy,
			/obj/item/device/lightreplacer,
			/obj/item/tool/omnitool = good_data("Lonestar \"Munchkin 5000\"", list(1, 3), 1000),
			/obj/item/tool/crowbar,
			/obj/item/tool/screwdriver,
			/obj/item/tool/shovel,
			/obj/item/tool/wirecutters,
			/obj/item/tool/wrench,
			/obj/item/tool/weldingtool,
			/obj/item/tool/tape_roll,
			/obj/item/device/geiger,
			/obj/item/device/toner
		),
		"Storage Utilities" = list(
			/obj/item/storage/hcases/ammo,
			/obj/item/storage/hcases/parts,
			/obj/item/storage/hcases/med,
			/obj/item/storage/hcases/engi,
			/obj/item/storage/bag/produce,
			/obj/item/storage/bag/sheetsnatcher,
			/obj/item/storage/bag/chemistry
		),
		"Lonestar Cells" = list(
			/obj/item/cell/small,
			/obj/item/cell/small/high,
			/obj/item/cell/small/super,
			/obj/item/cell/medium,
			/obj/item/cell/medium/high,
			/obj/item/cell/medium/super,
			/obj/item/cell/large,
			/obj/item/cell/large/high,
			/obj/item/cell/large/super
		),
		"Lonestar Grenades" = list(
			/obj/item/grenade/chem_grenade/antiweed,
			/obj/item/grenade/chem_grenade/cleaner,
			/obj/item/grenade/chem_grenade/metalfoam
		),
		"Mining Gear" = list(
			/obj/item/tool/karl,
			/obj/item/tool/pickaxe,
			/obj/item/tool/pickaxe/excavation,
			/obj/item/storage/bag/ore,
			/obj/structure/ore_box
		),
		"Toys" = list(
			/obj/item/toy/junk/balloon = good_data("Water Balloon", list(1, 50), 5),
			/obj/item/toy/junk/blink,
			/obj/item/toy/junk/inflatable_duck,
			/obj/item/toy/junk/eight_ball,
			/obj/item/toy/weapon/sword,
			/obj/item/toy/weapon/katana,
			/obj/item/toy/junk/snappop,
			/obj/item/toy/junk/bosunwhistle,
			/obj/item/toy/junk/dodgeball,
			/obj/item/toy/junk/dodgeball/face,
			/obj/item/toy/figure/character/bobblehead/excelsior,
			/obj/item/toy/figure/character/bobblehead/serbian,
			/obj/item/toy/figure/character/bobblehead/acolyte,
			/obj/item/toy/figure/character/bobblehead/carrion,
			/obj/item/toy/figure/character/bobblehead/roach,
			/obj/item/toy/figure/character/bobblehead/vagabond,
			/obj/item/toy/figure/character/bobblehead/rooster,
			/obj/item/toy/figure/character/bobblehead/barking_dog,
			/obj/item/toy/figure/character/bobblehead/red_soldier,
			/obj/item/toy/figure/character/bobblehead/metacat,
			/obj/item/toy/figure/character/bobblehead/shitcurity,
			/obj/item/toy/figure/character/bobblehead/metro_patrolman,
			/obj/item/gun/projectile/revolver/capgun,
			/obj/item/storage/box/blanks
		),
		"Holland and Sullivan Sidearms & Ammunition" = list(
			/obj/item/clothing/accessory/holster,
			/obj/item/clothing/accessory/holster/armpit,
			/obj/item/clothing/accessory/holster/waist,
			/obj/item/clothing/accessory/holster/hip,
			/obj/item/gun/projectile/revolver/detective,
			/obj/item/gun/projectile/olivaw,
			/obj/item/gun/projectile/giskard,
			/obj/item/gun/energy/gun/martin,
			/obj/item/gun/energy/gun,
			/obj/item/ammo_magazine/pistol_35,
			/obj/item/ammo_magazine/pistol_35/rubber,
			/obj/item/ammo_magazine/magnum_40 = custom_good_amount_range(list(-1, 3)),
			/obj/item/ammo_magazine/magnum_40/rubber = custom_good_amount_range(list(-1, 5)),
			/obj/item/ammo_magazine/ammobox/pistol_35,
			/obj/item/ammo_magazine/ammobox/pistol_35/rubber
		),
		"Solnishko 'Guns-from-Home' Parts" = list(
			/obj/item/pc_part/drive/disk/design/gun_parts/bootleg = good_data("Solnishko Distrubtion - Homemade Parts", list(1, 1), 600),
			/obj/item/part/gun/grip/wood,
			/obj/item/part/gun/mechanism/pistol,
			/obj/item/part/gun/mechanism/revolver,
			/obj/item/part/gun/barrel/pistol,
			/obj/item/part/gun/barrel/magnum
		),
		"Miscellaneous" = list(
			/obj/item/device/camera,
			/obj/item/device/camera_film,
			/obj/item/storage/photo_album,
			/obj/item/wrapping_paper,
			/obj/item/packageWrap,
			/obj/item/reagent_containers/glass/paint/red = good_data("Red Paint", list(1, 10), 50),
			/obj/item/reagent_containers/glass/paint/green = good_data("Green Paint", list(1, 10), 50),
			/obj/item/reagent_containers/glass/paint/blue = good_data("Blue Paint", list(1, 10), 50),
			/obj/item/reagent_containers/glass/paint/yellow = good_data("Yellow Paint", list(1, 10), 50),
			/obj/item/reagent_containers/glass/paint/purple = good_data("Purple Paint", list(1, 10), 50),
			/obj/item/reagent_containers/glass/paint/black = good_data("Black Paint", list(1, 10), 50),
			/obj/item/reagent_containers/glass/paint/white = good_data("White Paint", list(1, 10), 45),
			/obj/item/storage/lunchbox = good_data("Lunchbox", list(1, 10), 30),
			/obj/item/storage/lunchbox/rainbow = good_data("Rainbow Lunchbox", list(1, 10), 30),
			/obj/item/storage/lunchbox/cat = good_data("Cat Lunchbox", list(1, 10), 30),
			/obj/item/contraband/poster,
			/obj/item/device/eftpos
		)
	)

	hidden_inventory = list(
		"Robustcell-X" = list(
			/obj/item/cell/large/hyper,
			/obj/item/cell/medium/hyper,
			/obj/item/cell/small/hyper
		),
		"Imported Liquids" = list(
			/obj/item/weldpack,
			/obj/item/weldpack/canister,
			/obj/structure/reagent_dispensers/fueltank,
			/obj/structure/reagent_dispensers/watertank,
			/obj/structure/reagent_dispensers/watertank/huge
		),
		"LSS Novelties" = list(
			/obj/item/gun/projectile/revolver/longboi,
			/obj/item/gun_upgrade/trigger/honker,
			/obj/item/clothing/glasses/sunglasses/big,
			/obj/item/gun/projectile/basilisk,
		),
		"LSS Toolmods" = list(
			/obj/item/tool_upgrade/productivity/diamond_blade,
			/obj/item/tool_upgrade/refinement/laserguide
		),
		"LSS Music" = list(
			/obj/item/device/synthesized_instrument/guitar,
			/obj/item/device/synthesized_instrument/guitar/multi,
			/obj/item/device/synthesized_instrument/synthesizer,
			/obj/item/device/synthesized_instrument/trumpet,
			/obj/item/device/synthesized_instrument/violin,
			/obj/structure/synthesized_instrument/synthesizer/piano = good_data("Piano", list(-4, 2), 1200),
			/obj/item/media/boombox = good_data("NT Boom Box", list(-400000000, -399999999), 300) //When will K5 fix this???
		),
		"Trinkets & Baubles" = list(
			/obj/item/oddity/ls/collector_coin = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/pamphlet = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/rod_figure = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/chess_set = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/starscope = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/flashdrive = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/mutant_tooth = custom_good_amount_range(list(1, 3)),
			/obj/item/oddity/ls/manual = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/bouquet = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/magazine = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/puzzlebox = custom_good_amount_range(list(-1, 2)),
			/obj/item/oddity/ls/dogtags = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/silk_cloak = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/kriosan_sword = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/newton_odd = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/starprojector = custom_good_amount_range(list(3, 6)),
			/obj/item/oddity/ls/inertdetonator = custom_good_amount_range(list(3, 6))
		)
	)

	offer_types = list(
		/obj/item/tool/knife = offer_data("spare knifes", 30, 20),
		/obj/item/reagent_containers/snacks/grown = offer_data("spare grown food", 10, 120), //10 credits a grown item basicl
		/datum/reagent/organic/nutriment/honey = offer_data("Honey bottle (60u)", 800, 1),
		/obj/item/organ/external/robotic/one_star = offer_data("grayson external prosthetic", 1800, 4),
		/obj/item/toy/consumer/product/toaster = offer_data("toolbox toaster", 250, 4)
	)
