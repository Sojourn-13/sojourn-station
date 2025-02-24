/obj/random/rig
	name = "random rig suit"
	icon_state = "armor-blue"
	spawn_nothing_percentage = 20

/obj/random/rig/item_to_spawn()
	return pickweight(list(
	//Uncommon/civilian ones. These should make up most of the rig spawns
	/obj/item/rig/eva = 40,
	/obj/item/rig/eva/equipped = 10,
	/obj/item/rig/medical = 30,
	/obj/item/rig/medical/equipped = 10,
	/obj/item/rig/light = 10,
	/obj/item/rig/industrial = 10,
	/obj/item/rig/industrial/equipped = 5,
	/obj/item/rig/light/hacker = 10,
	/obj/item/rig/light/hacker/equipped = 1, //has numerous rare modules including power sink and omni hud rare treat

	//Head of staff
	//obj/item/rig/ce = 10,
	//obj/item/rig/ce/equipped = 5,
	/obj/item/rig/hazmat = 2,
	/obj/item/rig/hazmat/equipped = 1,

	//Heavy armor
	//obj/item/rig/combat = 10,
	//obj/item/rig/combat/ironhammer = 10,
	/obj/item/rig/hazard = 2,

	//The ones below here come with built in weapons
	//obj/item/rig/combat/equipped = 4,
	//obj/item/rig/combat/ironhammer/equipped = 4,
	/obj/item/rig/hazard/equipped = 1,
	))

/obj/random/rig/always_spawn
	name = "random always spawn rig suit"
	spawn_nothing_percentage = 0

/obj/random/rig/low_chance
	name = "low chance random rig suit"
	icon_state = "armor-blue-low"
	spawn_nothing_percentage = 80

/obj/random/rig/engi
	name = "random engi rig suit"

/obj/random/rig/engi/item_to_spawn()
	return pickweight(list(
	//Uncommon/civilian ones. These should make up most of the rig spawns
	/obj/item/rig/eva = 30,
	/obj/item/rig/eva/equipped = 10,
	/obj/item/rig/light = 20,
	/obj/item/rig/industrial = 30,
	/obj/item/rig/industrial/equipped = 10
	))


/obj/random/rig/damaged
	name = "random damaged rig suit"
	icon_state = "armor-red"
	has_postspawn = TRUE

/obj/random/rig/damaged/always_spawn
	name = "random always spawn damaged rig suit"
	spawn_nothing_percentage = 0

/obj/random/rig/damaged/post_spawn(var/list/spawns)
	for (var/obj/item/rig/module in spawns)
		//screw it up a bit
		var/cnd = rand(40,80)
		module.lose_modules(cnd)
		module.misconfigure(cnd)
		module.sabotage_cell()
		module.sabotage_tank()

/obj/random/rig/damaged/low_chance
	name = "low chance random rig suit"
	icon_state = "armor-red-low"
	spawn_nothing_percentage = 80




//Installable modules!

/obj/random/rig_module
	name = "random hardsuit module"
	icon_state = "box-orange"
	spawn_nothing_percentage = 40

/obj/random/rig_module/item_to_spawn()
	return pickweight(list(
	//Storage
	//obj/item/rig_module/storage = 12, //Made much more common

	//Computer
	/obj/item/rig_module/ai_container = 5,
	/obj/item/rig_module/datajack = 3,
	/obj/item/rig_module/electrowarfare_suite = 1,
	/obj/item/rig_module/power_sink = 3,


	//Combat
	/obj/item/rig_module/device/flash = 2,
	/obj/item/rig_module/mounted/taser = 2,
	/obj/item/rig_module/grenade_launcher = 0.5, //Comes preloaded with smoke, flashbang and EMP
	/obj/item/rig_module/mounted = 0.1, //This is mounted lasercannon, dangerous
	/obj/item/rig_module/mounted/egun = 0.2, //Lethal laser
	/obj/item/rig_module/held/energy_blade = 0.1,
	/obj/item/rig_module/fabricator = 0.1,
	/obj/item/rig_module/fabricator/energy_net = 0.2,
	/obj/item/rig_module/self_destruct = 1,
	/obj/item/rig_module/held/shield = 0.5,
	/obj/item/rig_module/teleporter = 0.5,

	//Utility
	/obj/item/rig_module/device/healthscanner = 4,
	/obj/item/rig_module/device/drill = 1,
	/obj/item/rig_module/device/anomaly_scanner = 2,
	/obj/item/rig_module/device/orescanner = 2,
	/obj/item/rig_module/device/rcd = 0.5,
	/obj/item/rig_module/modular_injector = 0.8,
	/obj/item/rig_module/modular_injector/combat = 0.8,
	/obj/item/rig_module/modular_injector/medical = 0.5, //Like normal but can be used on other people as well as yourself
	/obj/item/rig_module/voice = 3,
	/obj/item/rig_module/maneuvering_jets = 8, //Useful but common
	/obj/item/rig_module/device/soap = 0.5, //Dud 99% of the time
	/obj/item/rig_module/device/light_replacer = 0.1, //Almost always a dud
	/obj/item/rig_module/device/paperfiller = 0.01, //Is a dud

	//Vision
	/obj/item/rig_module/vision/multi = 0.1, //Every vision mod in one, very powerful
	/obj/item/rig_module/vision/meson = 2,
	/obj/item/rig_module/vision/thermal = 0.5, //Thermal is very strong
	/obj/item/rig_module/vision/nvg = 2,
	/obj/item/rig_module/vision/sechud = 2,
	/obj/item/rig_module/vision/medhud = 2

	))

/obj/random/rig_module/low_chance
	name = "low chance random hardsuit module"
	icon_state = "box-orange-low"
	spawn_nothing_percentage = 80




//Special variant that has less of the mundane junk and all the really desireable ones
/obj/random/rig_module/rare
	name = "random rare hardsuit module"
	icon_state = "box-red"
	spawn_nothing_percentage = 60

/obj/random/rig_module/rare/always_spawn
	name = "random always spawn rare hardsuit module"
	spawn_nothing_percentage = 0

/obj/random/rig_module/rare/item_to_spawn()
	return pickweight(list(
	//Storage
	//obj/item/rig_module/storage = 1,

	/obj/item/rig_module/electrowarfare_suite = 1,


	//Combat
	/obj/item/rig_module/grenade_launcher = 1, //Comes preloaded with smoke, flashbang and EMP
	/obj/item/rig_module/mounted = 1, //This is mounted lasercannon, dangerous
	/obj/item/rig_module/mounted/egun = 1, //Lethal laser
	/obj/item/rig_module/held/energy_blade = 1,
	/obj/item/rig_module/fabricator = 1,
	/obj/item/rig_module/fabricator/energy_net = 1,
	/obj/item/rig_module/self_destruct = 1,

	//Utility
	/obj/item/rig_module/device/drill = 1,
	/obj/item/rig_module/device/rcd = 1,
	/obj/item/rig_module/modular_injector/combat = 1,
	/obj/item/rig_module/modular_injector/medical = 1, //Like normal but can be used on other people as well as yourself
	/obj/item/rig_module/voice = 1,
	/obj/item/rig_module/held/shield = 1,
	//Vision
	/obj/item/rig_module/vision/multi = 0.1, //Every vision mod in one, very powerful
	/obj/item/rig_module/vision/thermal = 1, //Thermal is very strong
	/obj/item/rig_module/vision/nvg = 1
	))

/obj/random/rig_module/rare/low_chance
	name = "low chance random rare hardsuit module"
	icon_state = "box-red-low"
	spawn_nothing_percentage = 80
