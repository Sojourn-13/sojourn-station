/datum/trade_station/ningishzida
	name_pool = list(
		"SI 'Ningishzida'" = "SI Trade Beacon 'Ningishzida': Connection with the SI surplus network established."
	)
	icon_states = list("moe_capital", "station")
	uid = "moe_adv"
	tree_x = 0.26
	tree_y = 0.8
	spawn_always = TRUE
	markup = UNCOMMON_GOODS
	offer_limit = 1
	base_income = 1200
	wealth = 0
	hidden_inv_threshold = 2000
	recommendation_threshold = 3000
	stations_recommended = list("trapper", "bluespace")
	recommendations_needed = 1
	inventory = list(
		"Scientific Surplus" = list(
			/obj/item/storage/deferred/slime = custom_good_amount_range(list(0, 1)),
			/obj/item/storage/deferred/xenobotany = custom_good_amount_range(list(2, 5)),
			/obj/item/storage/deferred/rnd = custom_good_amount_range(list(-1, 1)),
			/obj/item/storage/part_replacer/mini,
			/obj/item/device/geiger
		),
		"Cryo-Sealed Hydrogen" = list(
			/obj/item/hydrogen_fuel_cell,
			/obj/item/hydrogen_fuel_cell/backpack
		),
		"Chemical Surplus" = list(
			/obj/item/reagent_containers/glass/bottle/inaprovaline = custom_good_amount_range(list(1, 3)),
			/obj/item/reagent_containers/glass/bottle/antitoxin = good_data("dylovene bottle", list(1,3), 200),
			/obj/item/reagent_containers/glass/bottle/trade/kelotane = good_data("kelotane bottle", list(1, 3), 200),
			/obj/item/reagent_containers/glass/bottle/trade/bicaridine = good_data("bicaridine bottle", list(1, 3), 200),
			/obj/item/reagent_containers/glass/bottle/trade/cronexidone = good_data("cronexidone bottle", list(1, 3), 800),
			/obj/item/reagent_containers/glass/bottle/trade/imidazoline = good_data("imidazoline bottle", list(1, 3), 400),
			/obj/item/reagent_containers/glass/bottle/trade/alkysine = good_data("alkysine bottle", list(1, 3), 400),
			/obj/item/reagent_containers/glass/beaker/vial/nanites = good_data("Raw Nanites Vial", list(-2, 2), 1200),
			/obj/item/reagent_containers/glass/beaker/vial/uncapnanites = good_data("Raw Uncapped Nanites Vial", list(-1, 1), 1500)
		)
	)
	hidden_inventory = list(
		"Upgraded Organs" = list(
			/obj/item/pc_part/drive/disk/design/surgery = good_data("back alley organs disk", list(1, 2), 1200),
			/obj/item/pc_part/drive/disk/research_points= good_data("research data disk", list(1, 2), 2000),
			/obj/item/organ_module/active/simple/armshield,
			/obj/item/organ_module/active/simple/armsmg
		),
		"Autoinjectors II" = list(
			// Autoinjectors defined in hypospray.dm
			/obj/item/reagent_containers/hypospray/autoinjector/polystem = good_data("polystem autoinjector", list(10, 20), 40),
			/obj/item/reagent_containers/hypospray/autoinjector/meralyne = good_data("meralyne autoinjector", list(10, 20), 65),
			/obj/item/reagent_containers/hypospray/autoinjector/dermaline = good_data("dermaline autoinjector", list(10, 20), 60),
			/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus = good_data("dexalin plus autoinjector", list(10, 20), 65),
			/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = good_data("oxycodone autoinjector", list(10, 20), 40),
			/obj/item/reagent_containers/hypospray/autoinjector/ryetalyn = good_data("ryetalyn autoinjector", list(10, 20), 40)
		)
	)
	offer_types = list(
		/obj/item/oddity/common/healthscanner = offer_data("odd health scanner", 800, 1),
		/obj/item/oddity/common/disk = offer_data("broken design disk", 800, 1),
		/obj/item/oddity/common/device = offer_data("odd device", 800, 1),
		/obj/item/organ/internal/scaffold = offer_data_mods("aberrant organ (input, process, output, secondary)", 2400, 4, OFFER_ABERRANT_ORGAN_PLUS, 4),
		/obj/item/slime_extract/lightpink = offer_data("light pink slime extract", 10000, 1),
		/obj/item/slime_extract/black = offer_data("black slime extract", 10000, 1),
		/obj/item/slime_extract/oil = offer_data("oil slime extract", 10000, 1),
		/obj/item/slime_extract/adamantine = offer_data("adamantine slime extract", 10000, 1),
		/obj/item/cell/small/greyson = offer_data("GP_SI \"Posi-cell 400S\"", 350, 4)
		// /obj/item/slime_extract/bluespace
		// /obj/item/slime_extract/pyrite
		// /obj/item/slime_extract/cerulean
		// /obj/item/slime_extract/sepia
		// /obj/item/slime_extract/rainbow
	)
