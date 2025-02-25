/datum/trade_station/station_zarya
	name_pool = list(
		"FTB 'Zarya'" = "Free Trade Beacon 'Zarya': \"Privet, this is the trade beacon 'Zarya'. We sell electronics, construction goods, and anything related to engineering! If you are looking for a more general shop, you should contact our main station: FTS 'Solnishko'"
	)
	icon_states = list("nt_destroyer", "ship")
	uid = "techno_basic"
	tree_x = 0.18
	tree_y = 0.9
	start_discovered = TRUE
	spawn_always = TRUE
	markup = COMMON_GOODS
	offer_limit = 20
	base_income = 1600
	wealth = 0
	hidden_inv_threshold = 1000
	recommendation_threshold = 1500
	stations_recommended = list("techno_adv")
	inventory = list(
		"Vozdukh" = list(
			/obj/machinery/portable_atmospherics/canister/sleeping_agent,
			/obj/machinery/portable_atmospherics/canister/nitrogen,
			/obj/machinery/portable_atmospherics/canister/oxygen,
			/obj/item/tank/plasma,
			/obj/machinery/pipedispenser/orderable,
			/obj/machinery/pipedispenser/disposal/orderable
		),
		"Energiya" = list(
			/obj/item/cell/large,
			/obj/item/cell/large/high,
			/obj/item/cell/medium,
			/obj/item/cell/medium/high,
			/obj/item/cell/small,
			/obj/item/cell/small/high,
			/obj/item/solar_assembly,
			/obj/item/circuitboard/solar_control,
			/obj/item/tracker_electronics,
			/obj/machinery/power/emitter,
			/obj/machinery/power/rad_collector,
			/obj/machinery/power/generator,
			/obj/machinery/atmospherics/binary/circulator,
			/obj/item/clothing/gloves/insulated
		),
		"Vsyakoye" = list(
			/obj/structure/reagent_dispensers/watertank,
			/obj/item/storage/briefcase/inflatable/empty,
			/obj/item/inflatable/door,
			/obj/item/inflatable/wall,
			/obj/item/stack/material/steel/full = good_data("steel sheets (x120)", list(3, 5), 660), //Better deal here
			/obj/item/stack/material/glass/plasmaglass = good_data("borosilicate glass sheets (x120)", list(3, 5), 3200),
			/obj/item/storage/belt/utility/full,
			/obj/item/clothing/head/welding,
			/obj/item/tool/omnitool,
			/obj/item/device/geiger,
			/obj/structure/reagent_dispensers/fueltank,
			/obj/machinery/floodlight,
			/obj/item/device/floor_painter
		)
	)

	hidden_inventory = list(
		"Sverkhmateriya" = list(
			/obj/machinery/power/supermatter = good_data("supermatter", list(1, 2), 8500) //The 'unsolicited supermatter shipment' play has gone on long enough. It's time we end it. -Wilson
		),

		"Bystroye Stroitel'stvo" = list(
			/obj/item/rcd/industrial = good_data("Industrial RCD", list(-1, 1), 4500),
			/obj/item/rcd = good_data("RCD", list(1, 2), 2500),
			/obj/item/hatton_magazine= good_data("Hatton TUBE", list(3, 5), 1000)
		),

		"Antiveshchestvo" = list(
			/obj/item/am_containment = good_data("Antimatter Fuel Jar", list(3, 5), 500),
			/obj/item/am_shielding_container = good_data("Antimatter Shielding Kit", list(3, 5), 300)
		),
		"Plokhiye Idei" = list(
			/obj/item/am_containment = good_data("Antimatter Fuel Jar", list(3, 5), 500),
			/obj/item/am_shielding_container = good_data("Antimatter Shielding Kit", list(3, 5), 300),
			/obj/machinery/power/emitter,
			/obj/machinery/field_generator,
			/obj/machinery/shieldwallgen,
			/obj/machinery/the_singularitygen,
			/obj/machinery/power/rad_collector,
			/obj/structure/particle_accelerator/fuel_chamber,
			/obj/machinery/particle_accelerator/control_box,
			/obj/structure/particle_accelerator/particle_emitter/center,
			/obj/structure/particle_accelerator/particle_emitter/left,
			/obj/structure/particle_accelerator/particle_emitter/right,
			/obj/structure/particle_accelerator/power_box,
			/obj/structure/particle_accelerator/end_cap
		)
	)



	offer_types = list(
		//obj/item/tool_upgrade = offer_data("tool upgrade", 200, 0),				// base price: 200 exploitable with other trade stations
		/obj/item/tool/crowbar = offer_data_mods("modified crowbar (6 upgrades)", 2800, 2, OFFER_MODDED_TOOL, 6),
		/obj/item/tool/screwdriver = offer_data_mods("modified screwdriver (6 upgrades)", 2800, 2, OFFER_MODDED_TOOL, 6),
		/obj/item/tool/shovel = offer_data_mods("modified shovel (6 upgrades)", 2800, 2, OFFER_MODDED_TOOL, 6),
		/obj/item/tool/wirecutters = offer_data_mods("modified wirecutters (6 upgrades)", 2800, 2, OFFER_MODDED_TOOL, 6),
		/obj/item/tool/wrench = offer_data_mods("modified wrench (6 upgrades)", 2800, 2, OFFER_MODDED_TOOL, 6),
		/obj/item/tool/weldingtool = offer_data_mods("modified welding tool (6 upgrades)", 2800, 2, OFFER_MODDED_TOOL, 6),
		/obj/item/tool/crowbar/onestar = offer_data("greyson crowbar", 1000, 3),
		/obj/item/tool/pickaxe/onestar = offer_data("greyson pickaxe", 1000, 3),
		/obj/item/tool/pickaxe/jackhammer/onestar = offer_data("greyson jackhammer", 1000, 3),
		/obj/item/tool/screwdriver/combi_driver/onestar = offer_data("greyson combi driver", 1000, 3),
		/obj/item/tool/weldingtool/onestar  = offer_data("greyson welding tool", 1000, 3),
		/obj/item/tool_upgrade/augment/repair_nano = offer_data("repair nano", 1000, 1)
	)
