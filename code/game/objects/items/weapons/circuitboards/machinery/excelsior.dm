/obj/item/weapon/circuitboard/excelsiorshieldwallgen
	build_name = "excelsior shield wall generator"
	board_type = "machine"
	build_path = /obj/machinery/shieldwallgen/excelsior
	origin_tech = list(TECH_BLUESPACE = 3, TECH_MAGNET = 3, TECH_EXCELSIOR = 2)
	req_components = list(
		/obj/item/weapon/stock_parts/subspace/transmitter = 1,
		/obj/item/weapon/stock_parts/subspace/crystal = 1,
		/obj/item/weapon/stock_parts/subspace/amplifier = 1,
		/obj/item/weapon/stock_parts/capacitor = 2,
		/obj/item/stack/cable_coil = 30
	)

/obj/item/weapon/circuitboard/excelsiorautolathe
	build_name = "excelsior autolathe"
	build_path = /obj/machinery/autolathe/excelsior
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_DATA = 2, TECH_EXCELSIOR = 2)
	req_components = list(
		/obj/item/weapon/stock_parts/matter_bin = 3,
		/obj/item/weapon/stock_parts/manipulator = 1,
	)

/obj/item/weapon/circuitboard/excelsiorreconstructor
	build_name = "excelsior implant reconstructor"
	build_path = /obj/machinery/complant_maker
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_BIOTECH = 3, TECH_EXCELSIOR = 2)
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 2,
		/obj/item/weapon/stock_parts/console_screen = 1
	)

/obj/item/weapon/circuitboard/diesel
	build_name = "excelsior diesel generator"
	build_path = /obj/machinery/power/port_gen/pacman/diesel
	board_type = "machine"
	origin_tech = list(TECH_DATA = 3, TECH_POWER = 3, TECH_PLASMA = 3, TECH_ENGINEERING = 3, TECH_EXCELSIOR = 2)
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 1,
		/obj/item/weapon/stock_parts/console_screen = 1
	)

/obj/item/weapon/circuitboard/excelsior_boombox
	build_name = "excelsior boombox"
	build_path = /obj/machinery/excelsior_boombox
	board_type = "machine"
	origin_tech = list(TECH_DATA = 3, TECH_EXCELSIOR = 1)
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 1,
		/obj/item/weapon/stock_parts/console_screen = 1
	)

/obj/item/weapon/circuitboard/excelsior_teleporter
	build_name = "excelsior teleporter"
	build_path = /obj/machinery/complant_teleporter
	board_type = "machine"
	origin_tech = list(TECH_DATA = 3, TECH_BLUESPACE = 3, TECH_EXCELSIOR = 2)
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 2,
		/obj/item/weapon/cell/large = 1,
		/obj/item/weapon/stock_parts/subspace/crystal = 1
	)

/obj/item/weapon/circuitboard/excelsior_turret
	build_name = "excelsior turret"
	build_path = /obj/machinery/porta_turret/excelsior
	board_type = "machine"
	origin_tech = list(TECH_COMBAT = 3, TECH_EXCELSIOR = 2)
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 2,
		/obj/item/device/assembly/prox_sensor = 1,
		/obj/item/weapon/cell/medium = 1
	)

//Putting this here since its an antag type item and making a full .dm for 9 lines of code is.. dumb. -Kaz
/obj/item/weapon/circuitboard/mindswapper
	build_name = "mind swapper"
	build_path = /obj/machinery/mindswapper
	board_type = "machine"
	origin_tech = list(TECH_DATA = 2, TECH_POWER = 2, TECH_ENGINEERING = 2)
	req_components = list(
		/obj/item/weapon/stock_parts/capacitor = 5,
		/obj/item/weapon/stock_parts/scanning_module = 3,
		/obj/item/weapon/stock_parts/manipulator = 4
	)