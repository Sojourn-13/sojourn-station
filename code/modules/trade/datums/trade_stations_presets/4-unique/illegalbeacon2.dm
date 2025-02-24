/datum/trade_station/illegaltrader2
	name_pool = list(
		"NSTB 'Introversion'" = "Nefarious-Space Trade Beacon 'Introversion'. The trade beacon is sending an automated message. \"Uplink established. Welcome, agent.\""
	)
	uid = "illegal2"
	icon_states = list("oberth_destroyer", "object")
	tree_x = 0.62
	tree_y = 0.3
	start_discovered = FALSE
	spawn_always = TRUE
	markup = RARE_GOODS
	offer_limit = 20
	base_income = 1600
	wealth = 0
	hidden_inv_threshold = 6000
	recommendations_needed = 3
	inventory = list(
		// TEST: pricing should be tested. Guideline is 775 credits per TC.
		"RIG Accessories" = list(
			/obj/item/rig_module/vision/thermal,
			/obj/item/rig_module/mounted/egun
		),
		"Tools" = list(
			/obj/item/device/shield_diffuser,
			/obj/item/plastique,
			/obj/item/clothing/glasses/powered/thermal/syndi,
			/obj/item/noslipmodule,
			/obj/item/storage/box/syndie_kit/imp_compress,
			/obj/item/grenade/empgrenade,
			/obj/item/storage/backpack/military = good_data("MOLLE pack", list(3, 8), 1000),
			/obj/item/clothing/shoes/magboots/merc
		),
		"Weapons" = list(
			/obj/item/melee/energy/sword,
			/obj/item/shield/buckler/energy,
			/obj/item/organ_module/active/simple/armblade/energy_blade,
			/obj/item/gun/projectile/revolver/tacticool_revolver
		)
	)
	hidden_inventory = list(
		"Firearms" = list(
			/obj/item/gun/projectile/automatic/c20r = custom_good_amount_range(list(1, 1)),
			/obj/item/gun/projectile/automatic/omnirifle = custom_good_amount_range(list(1, 1))
		),
		"RIG Modules" = list(
			/obj/item/rig_module/autodoc,
			/obj/item/rig_module/mounted,
			/obj/item/rig_module/fabricator,
			/obj/item/rig_module/fabricator/energy_net
		),
		"Software" = list(
			/obj/item/pc_part/drive/disk/adv/shady = good_data("old data disk", list(1, 1), 900),
			/obj/item/pc_part/drive/disk/design/guns/china = good_data("China Lake Disk", list(1, 1), 1100)
		),
		"Grenade Shells" = list(
			/obj/item/ammo_casing/grenade = good_data("Baton Shell", list(4, 8), 100),
			/obj/item/ammo_casing/grenade/blast = good_data("Blast Shell", list(2, 3), 800),
			/obj/item/ammo_casing/grenade/frag = good_data("Frag Shell", list(2, 3), 800),
			/obj/item/ammo_casing/grenade/frag/stinger = good_data("Stinger Shell", list(4, 8), 1200),
			/obj/item/ammo_casing/grenade/emp = good_data("EMP Shell", list(1, 1), 1800),
			/obj/item/ammo_casing/grenade/flash = good_data("Flash Shell", list(4, 8), 100)
		),
	)
	offer_types = list(
		/obj/item/stack/telecrystal = offer_data("telecrystal x50", 100000, 1),
		/obj/item/device/radio/uplink = offer_data("Radio Uplink", 10000, 1),
		/obj/item/card/emag = offer_data("Cryptographic Sequencer", 5000, 1),
		/obj/item/clothing/glasses/powered/night/guild  = offer_data("Optimized NV Goggles", 1200, 3)
	)
