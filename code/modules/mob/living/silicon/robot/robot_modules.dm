var/global/list/robot_modules = list(
	"Standard"					= /obj/item/robot_module/standard,
	"Service" 					= /obj/item/robot_module/service,
	"Research" 					= /obj/item/robot_module/research,
	"Miner" 					= /obj/item/robot_module/miner,
//	"Rescue" 					= /obj/item/robot_module/medical/rescue, Removed and condensed to medical verson - todo, admin only
	"Medical" 					= /obj/item/robot_module/medical/general,
	"Security"					= /obj/item/robot_module/security/enforcement,
	"Defense" 					= /obj/item/robot_module/security/defense,
	"Engineering"				= /obj/item/robot_module/engineering/general,
//	"Construction"				= /obj/item/robot_module/engineering/construction, Removed and condensed into contruction - todo, admin only
	"Custodial" 				= /obj/item/robot_module/custodial,
	//"Combat" 					= /obj/item/robot_module/combat,
	)

/obj/item/robot_module
	name = "robot module"
	icon = 'icons/obj/module.dmi'
	icon_state = "std_module"
	w_class = 100
	item_state = "electronic"
	flags = CONDUCT
	var/hide_on_manifest = FALSE
	var/channels = list()
	var/networks = list()
	var/languages = list(							//Any listed language will be understandable. Any set to 1 will be speakable
					LANGUAGE_COMMON = 1,
					LANGUAGE_ROMANA = 1,
					LANGUAGE_KRIOSAN = 1,
					LANGUAGE_AKULA = 1,
					LANGUAGE_MARQUA = 1,
					LANGUAGE_BLORP = 1,
					LANGUAGE_YASSARI = 1,
					LANGUAGE_ILLYRIAN = 1,
					LANGUAGE_CYRILLIC = 1,
					LANGUAGE_EURO = 1,
					LANGUAGE_JANA = 1,
					LANGUAGE_LATIN = 1,
					LANGUAGE_JIVE = 0
					)
	var/sprites = list()
	var/tall_sprites = list()
	var/can_be_pushed = 1
	var/no_slip = 0
	var/list/modules = list()
	var/list/datum/matter_synth/synths = list()
	var/list/emag = list()
	var/obj/item/malfAImodule = null
	var/obj/item/borg/upgrade/jetpack = null
	var/list/subsystems = list()
	var/list/obj/item/borg/upgrade/supported_upgrades = list()

	// Bookkeeping
	var/list/original_languages = list()
	var/list/added_networks = list()
	// A list of robot traits , these can be found at cyborg_traits.dm
	var/robot_traits = null
	//Module stats, these are applied to the robot
	health = 100 //Max health. Apparently this is already defined in item.dm
	var/speed_factor = 1.3 //Speed factor, applied as a divisor on movement delay
	var/power_efficiency = 1.0 //Power efficiency, applied as a divisor on power taken from the internal cell

	//Stat modifiers for skillchecks
	var/list/stat_modifiers = list(
		STAT_BIO = 25,
		STAT_COG = 120,
		STAT_MEC = 35, //weldering cracks
		STAT_ROB = 15,
		STAT_TGH = 15,
	)

	desc = "This is a robot module parent class. You shouldn't see this description"

/obj/item/robot_module/New(var/mob/living/silicon/robot/R)
	..()
	if (!istype(R))
		return

	R.module = src

	if(robot_traits)
		R.AddTrait(robot_traits)

	add_camera_networks(R)
	remove_languages(R) //So we dont stack languages
	add_languages(R)
	add_subsystems(R)
	apply_status_flags(R)

	if(R.radio)
		R.radio.recalculateChannels()

	//Snagging the value of armour if a borg has one. So that way health can be updated to accomodate that plating.
	var/armourHealth = 0
	if(R)
		for(var/V in R.components)
			var/datum/robot_component/C = R.components[V]
			if (V == "armour")
				armourHealth = C.max_damage

	//Setting robot stats
	var/healthpercent = R.health / R.maxHealth //We update the health to remain at the same percentage it was before
	R.maxHealth = health + armourHealth //So we don't have borgs with more internal armour then their actual life.
	R.health = R.maxHealth * healthpercent

	R.handle_regular_hud_updates()

	R.speed_factor = speed_factor + R.vtech_added_speed
	R.power_efficiency = power_efficiency
	for(var/obj/item/I in emag)
		I.canremove = 0

	for(var/name in stat_modifiers)
		R.stats.changeStat(name, stat_modifiers[name])

	R.set_module_sprites(sprites, tall_sprites)
	R.icon_selected = 0
	spawn() // For future coders , this "corrupts" the USR reference, so for good practice ,don't make the proc use USR if its called with a spawn.
		R.choose_icon() //Choose icon recurses and blocks new from completing, so spawn it off

	for(var/obj/item/tool/T in modules)
		T.degradation = 0 //We don't want robot tools breaking


/obj/item/robot_module/Initialize()
	. = ..()
	for(var/obj/item/I in modules)
		I.canremove = FALSE
		I.set_plane(ABOVE_HUD_PLANE)
		I.layer = ABOVE_HUD_LAYER

	for(var/obj/item/tool/T in modules)
		T.degradation = 0 //We don't want robot tools breaking

	for (var/obj/item/I in modules)
		for (var/obj/item/cell/C in I)
			C.autorecharging = TRUE
			C.kick_autorecharging() //A quick hack to stop robot modules running out of power
			//Later they'll be wired to the robot's central battery once we code functionality for that
			//Setting it to infinity causes errors, so just a high number is fine
			//Setting this to be infinity power isnt as good of a fix do to guns that cost power getting endless free shots, so auto charging is better - Trilby

/obj/item/robot_module/proc/Reset(var/mob/living/silicon/robot/R)
	if(!istype(R))
		return
	if(R.actively_resting || R.allow_resting)
		R.actively_resting = 0
		R.allow_resting = 0
	if(robot_traits) // removes module-only traits
		R.RemoveTrait(robot_traits)
	remove_camera_networks(R)
	remove_languages(R)
	add_languages(R) //So we dont lose common and are normal languages of being basic
	remove_subsystems(R)
	remove_status_flags(R)

	var/armourHealth = 0
	for(var/V in R.components)
		var/datum/robot_component/C = R.components[V]
		if (V == "armour")
			armourHealth = C.max_damage

	var/healthpercent = R.health / R.maxHealth //We update the health to remain at the same percentage it was before
	R.maxHealth = initial(R.maxHealth) + armourHealth
	R.health = R.maxHealth * healthpercent
	R.speed_factor = initial(R.speed_factor)
	R.power_efficiency = initial(R.power_efficiency)
	for(var/name in stat_modifiers)
		R.stats.changeStat(name, stat_modifiers[name]*-1)

	if(R.radio)
		R.radio.recalculateChannels()

	R.handle_regular_hud_updates()
	R.stats.removeAllPerks() //Dont stack perks fix 1
	R.stats.perks =  list() //READ BELOW COMMENT


	R.pixel_x = initial(pixel_x)
	R.pixel_y = initial(pixel_y)
	R.icon = icon('icons/mob/robots.dmi')
	R.default_pixel_x = initial(pixel_x)
	R.has_given_emaged_gifts = FALSE

	R.set_module_sprites(list("Default" = "robot"))
	R.icon_selected = 0
	R.choose_icon()

/obj/item/robot_module/Destroy()
	QDEL_LIST(modules)
	QDEL_LIST(synths)
	QDEL_LIST(emag)
	qdel(jetpack)
	qdel(malfAImodule)
	malfAImodule = null
	jetpack = null
	return ..()

/obj/item/robot_module/emp_act(severity)
	if(modules)
		for(var/obj/O in modules)
			O.emp_act(severity)
	if(emag)
		for(var/obj/O in emag)
			O.emp_act(severity)
	if(synths)
		for(var/datum/matter_synth/S in synths)
			S.emp_act(severity)
	..()
	return

/obj/item/robot_module/proc/respawn_consumable(var/mob/living/silicon/robot/R, var/rate)
	var/obj/item/device/flash/F = locate() in src.modules
	if(F)
		if(F.broken)
			F.broken = FALSE
			F.times_used = 0
			F.icon_state = "flash"
		else if(F.times_used)
			F.times_used--

	if(!synths || !synths.len)
		return

	for(var/datum/matter_synth/T in synths)
		T.add_charge(T.recharge_rate * rate)

/obj/item/robot_module/proc/rebuild()//Rebuilds the list so it's possible to add/remove items from the module
	var/list/temp_list = modules
	modules = list()
	for(var/obj/O in temp_list)
		if(O)
			modules += O

/obj/item/robot_module/proc/add_languages(var/mob/living/silicon/robot/R)
	// Stores the languages as they were before receiving the module, and whether they could be synthezized.
	for(var/datum/language/language_datum in R.languages)
		original_languages[language_datum] = (language_datum in R.speech_synthesizer_langs)

	for(var/language in languages)
		R.add_language(language, languages[language])

/obj/item/robot_module/proc/remove_languages(var/mob/living/silicon/robot/R)
	// Clear all added languages, whether or not we originally had them.
	for(var/language in languages)
		R.remove_language(language)

	// Then add back all the original languages, and the relevant synthezising ability
	for(var/original_language in original_languages)
		R.add_language(original_language, original_languages[original_language])
	original_languages.Cut()

/obj/item/robot_module/proc/add_camera_networks(var/mob/living/silicon/robot/R)
	if(R.camera && (NETWORK_ROBOTS in R.camera.network))
		for(var/network in networks)
			if(!(network in R.camera.network))
				R.camera.add_network(network)
				added_networks |= network

/obj/item/robot_module/proc/remove_camera_networks(var/mob/living/silicon/robot/R)
	if(R.camera)
		R.camera.remove_networks(added_networks)
	added_networks.Cut()

/obj/item/robot_module/proc/add_subsystems(var/mob/living/silicon/robot/R)
	for(var/subsystem_type in subsystems)
		R.init_subsystem(subsystem_type)

/obj/item/robot_module/proc/remove_subsystems(var/mob/living/silicon/robot/R)
	for(var/subsystem_type in subsystems)
		R.remove_subsystem(subsystem_type)

/obj/item/robot_module/proc/apply_status_flags(var/mob/living/silicon/robot/R)
	if(!can_be_pushed)
		R.status_flags &= ~CANPUSH

/obj/item/robot_module/proc/remove_status_flags(var/mob/living/silicon/robot/R)
	if(!can_be_pushed)
		R.status_flags |= CANPUSH

//The generic robot, a good choice for any situation. Moderately good at everything
/obj/item/robot_module/standard
	name = "standard robot module"
	sprites = list(	"Basic" = "robot",
					"Android" = "droid",
					"Default" = "robot_old",
					"Sleek" = "sleekstandard",
					"Drone" = "drone-standard",
					"Spider" = "spider",
					"Miss" = "missm_sd"
				  )

	desc = "The baseline, jack of all trades. Can do a little of everything. Some DIY, some healing, some combat."
	stat_modifiers = list(
		STAT_BIO = 30,
		STAT_COG = 120,
		STAT_ROB = 30,
		STAT_TGH = 30,
		STAT_MEC = 30
	)

/obj/item/robot_module/standard/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/device/scanner/price(src)
	src.modules += new /obj/item/tool/baton/robot(src)
	src.modules += new /obj/item/extinguisher/advanced/robotic(src)
	src.modules += new /obj/item/tool/robotic_omni/standard(src)
	src.modules += new /obj/item/tool/tape_roll/fiber/robotic(src) //Window repair
	src.modules += new /obj/item/tool/weldingtool/robotic/weaker(src) //hardsuits.
	src.modules += new /obj/item/device/scanner/health(src)
	src.modules += new /obj/item/gripper(src)
	src.modules += new /obj/item/device/t_scanner(src)
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/device/gps(src)
	src.modules += new /obj/item/gripper/ammo(src)
	src.modules += new /obj/item/gun/energy/borg/pistol(src)
	src.emag += new /obj/item/melee/energy/sword(src)

	var/datum/matter_synth/medicine = new /datum/matter_synth/medicine(10000)
	synths += medicine

	//Comes with bandages and ointment, the basic/weak versions only
	var/obj/item/stack/medical/bruise_pack/B = new /obj/item/stack/medical/bruise_pack(src)
	var/obj/item/stack/medical/ointment/O = new /obj/item/stack/medical/ointment(src)
	B.uses_charge = 1
	B.charge_costs = list(1000)
	B.synths = list(medicine)
	O.uses_charge = 1
	O.charge_costs = list(1000)
	O.synths = list(medicine)
	src.modules += B
	src.modules += O

	//We are stronk so we get less no knockdowns
	R?.stats?.addPerk(PERK_ASS_OF_CONCRETE)
	R?.stats?.addPerk(PERK_SI_SCI)

	..(R)

/obj/item/robot_module/standard/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()

	var/obj/item/tool/baton/robot/B = locate() in src.modules
	if(B && B.cell)
		B.cell.give(amount)

	var/obj/item/extinguisher/advanced/robotic/EX = locate() in src.modules //space cleaner
	if(B)
		EX?.reagents?.add_reagent("abwater", 2 * amount)


/obj/item/robot_module/medical
	name = "medical robot module"
	channels = list("Medical" = 1)
	networks = list(NETWORK_MEDICAL)

	can_be_pushed = 0
	sprites = list(
				"Basic" = "robotmedi",
				"Classic" = "medbot",
				"Heavy" = "heavymed",
				"Needles" = "medicalrobot",
				"Standard" = "surgeon",
				"Advanced Droid - Medical" = "droid-medical",
				"Advanced Droid - Chemistry" = "droid-chemistry",
				"Drone - Medical" = "drone-surgery",
				"Drone - Chemistry" = "drone-chemistry",
				"Sleek - Medical" = "sleekmedic",
				"Sleek - Chemistry" = "sleekchemistry",
				"Miss" = "missm_med",
				"Medical Junkbot" = "qualified_doctor",
				"Tall Felinal" = "mekamed",
				"Tall Felinal Alt" = "mekamed_alt",
				"Tall Tanker" = "k4tmed",
				"Tall Tanker Alt" = "k4tmed_alt1",
				"Tall Female" = "fmekamed",
				"Tall Male" = "mmekamed",
				"Dullahan Medical" = "dullahanmed",
				"FoxTrot Med" = "ftpeace"
				)

	tall_sprites = list(
				"mekamed",
				"mekamed_alt",
				"k4tmed",
				"k4tmed_alt1",
				"fmekamed",
				"mmekamed",
				"mekasecalt",
				"dullahanmed",
				"ftpeace"
				)

	desc = "A versatile medical droid, equipped with all the tools necessary for surgery, chemistry, and \
	 general patient treatments. Medical has a vast array of items, but this comes at a hefty cost. \
	 The medical module is essentially shackled to the medbay and can't afford to stray too far. \
	 Its low power efficiency means it needs to charge regularly"

/obj/item/robot_module/medical/general
	name = "medical robot module"
	health = 120 //bit weaker
	speed_factor = 1.3 //normal speed
	power_efficiency = 0.9 //Very poor, shackled to a charger
	supported_upgrades = list(/obj/item/borg/upgrade/hypospray_medical,
							  /obj/item/borg/upgrade/jetpack)

	stat_modifiers = list(
		STAT_BIO = 60,
		STAT_COG = 120,
		STAT_MEC = 35, //weldering cracks
	)

/obj/item/robot_module/medical/general/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/tool/crowbar/robotic(src)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/borg/sight/hud/med(src)
	src.modules += new /obj/item/device/scanner/health(src)
	src.modules += new /obj/item/reagent_containers/borghypo/medical(src)
	src.modules += new /obj/item/tool/robotic_omni/surgery(src)
	src.modules += new /obj/item/tool/weldingtool/robotic/weaker(src) //hardsuits.
	src.modules += new /obj/item/tool/scalpel/laser/si/robo(src) //hardsuits.
	src.modules += new /obj/item/gripper/chemistry(src)
	src.modules += new /obj/item/reagent_containers/dropper/industrial(src)
	src.modules += new /obj/item/reagent_containers/syringe/large(src)
	src.modules += new /obj/item/reagent_containers/glass/beaker/large(src)
	src.modules += new /obj/item/reagent_containers/glass/beaker/large(src)
	src.modules += new /obj/item/reagent_containers/glass/beaker/large(src)
	src.modules += new /obj/item/reagent_containers/glass/beaker/large(src) //Two beakers
	src.modules += new /obj/item/device/scanner/reagent/adv(src)
	src.modules += new /obj/item/autopsy_scanner(src) // an autopsy scanner
	src.modules += new /obj/item/reagent_containers/spray/sterilizine(src)
	src.modules += new /obj/item/shockpaddles/robot(src)
	src.modules += new /obj/item/roller_holder(src)
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/device/scanner/price(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/tool/sword/saber/injection_rapier(src)
	src.modules += new /obj/item/device/gps(src)
	src.modules += new /obj/item/gripper/ammo(src)
	src.modules += new /obj/item/gun/energy/borg/pistol(src)
	src.emag += new /obj/item/melee/energy/sword(src)

	var/datum/matter_synth/medicine = new /datum/matter_synth/medicine(10000)
	synths += medicine

	var/obj/item/stack/nanopaste/N = new /obj/item/stack/nanopaste(src)
	var/obj/item/stack/medical/bruise_pack/advanced/B = new /obj/item/stack/medical/bruise_pack/advanced(src)
	var/obj/item/stack/medical/ointment/advanced/O = new /obj/item/stack/medical/ointment/advanced(src)
	N.uses_charge = 1
	N.charge_costs = list(1000)
	N.synths = list(medicine)
	B.uses_charge = 1
	B.charge_costs = list(1000)
	B.synths = list(medicine)
	O.uses_charge = 1
	O.charge_costs = list(1000)
	O.synths = list(medicine)
	src.modules += N
	src.modules += B
	src.modules += O

	var/obj/item/stack/medical/splint/S = new /obj/item/stack/medical/splint(src)
	S.uses_charge = 1
	S.charge_costs = list(1000)
	S.synths = list(medicine)
	src.modules += S

	//We know medical care and have all the data on it
	R?.stats?.addPerk(PERK_MEDICAL_EXPERT)
	R?.stats?.addPerk(PERK_SURGICAL_MASTER)
	R?.stats?.addPerk(PERK_ADVANCED_MEDICAL)
	R?.stats?.addPerk(PERK_SI_SCI)

	..(R)



/obj/item/robot_module/medical/general/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	var/obj/item/reagent_containers/syringe/large/S = locate() in src.modules
	if(S && S.mode == 2)
		S.reagents?.clear_reagents()
		S.mode = initial(S.mode)
		S.desc = initial(S.desc)
		S.update_icon()

	if(src.modules)
		var/obj/item/reagent_containers/spray/sterilizine/ST = locate() in src.modules //ST for STerilizine
		ST?.reagents?.add_reagent("sterilizine", 2 * amount)
	..()

	if(src.emag)
		var/obj/item/reagent_containers/spray/acid/PS = locate() in src.emag
		PS?.reagents?.add_reagent("pacid", 2 * amount)
	..()

/obj/item/robot_module/engineering
	name = "engineering robot module"
	channels = list("Engineering" = 1)
	networks = list(NETWORK_ENGINEERING)
	supported_upgrades = list(/obj/item/borg/upgrade/arc_welder,
							  /obj/item/borg/upgrade/rcd,
							  /obj/item/borg/upgrade/jetpack)
	subsystems = list(/datum/nano_module/power_monitor)
	sprites = list(
					"Basic" = "robotengi",
					"Antique" = "engineerrobot",
					"Landmate" = "landmate",
					"Landmate - Treaded" = "engiborg+tread",
					"Drone" = "drone-engineer",
					"Android" = "droid",
					"Classic" = "engineering",
					"Sleek" = "sleekengineer",
					"Spider" = "spidereng",
					"Plated" = "ceborg",
					"Heavy" = "heavyeng",
					"Miss" = "missm_eng",
					"Tall Felinal" = "mekacargo",
					"Tall Felinal Alt" = "mekacargo_alt",
					"Tall Hazard" = "mekaengi",
					"Tall Tanker" = "k4tengi",
					"Tall Female" = "fmekaeng",
					"Tall Male" = "mmekaeng",
					"Tall Porter" = "k4tcargo",
					"Tall Porter Alt" = "k4tcargo_alt1",
					"Tall Crate Pusher" = "fmekacargo",
					"Tall Crate Pusher Alt" = "mmekacargo",
					"Dullahan Hazard" = "dullahaneng",
					"Dullahan" = "dullahancargo"
					)

	tall_sprites = list(
				"mekacargo",
				"mekacargo_alt",
				"mekaengi",
				"k4tengi",
				"fmekaeng",
				"mmekaeng",
				"k4tcargo",
				"k4tcargo_alt1",
				"fmekacargo",
				"mmekacargo",
				"dullahaneng",
				"dullahancargo"
				)

	health = 120 //Slightly above average
	speed_factor = 1.4 //Slightly above average
	power_efficiency = 0.9 //Slightly below average

	desc = "The engineering module is designed for setting up and maintaining core colony systems, \
	as well as occasional repair work here and there. It's a good all rounder that can serve most \
	engineering tasks."

	stat_modifiers = list(
		STAT_COG = 120,
		STAT_MEC = 60,
		STAT_BIO = 25
	)

/obj/item/robot_module/engineering/general/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/borg/sight/meson(src)
	src.modules += new /obj/item/extinguisher/advanced/robotic(src)
	src.modules += new /obj/item/tool/weldingtool/robotic(src)
	src.modules += new /obj/item/tool/multitool/robotic(src)
	src.modules += new /obj/item/tool/robotic_omni/engi(src)
	src.modules += new /obj/item/tool/tape_roll/fiber/robotic(src) //Window repair
	//src.modules += new /obj/item/hatton/robot(src)
	src.modules += new /obj/item/device/t_scanner(src)
	src.modules += new /obj/item/device/scanner/gas(src)
	src.modules += new /obj/item/taperoll/engineering(src)
	src.modules += new /obj/item/gripper(src)
	src.modules += new /obj/item/gripper/no_use/loader(src)
	src.modules += new /obj/item/device/lightreplacer(src)
	src.modules += new /obj/item/device/pipe_painter(src)
	src.modules += new /obj/item/device/floor_painter(src)
	src.modules += new /obj/item/inflatable_dispenser(src)
	src.modules += new /obj/item/storage/part_replacer/mini(src)
	src.modules += new /obj/item/reagent_containers/glass/bucket(src)
	src.modules += new /obj/item/reagent_containers/spray/cleaner(src)
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/device/scanner/price(src)
	src.modules += new /obj/item/device/gps(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/gripper/ammo(src)
	src.modules += new /obj/item/gun/energy/borg/pistol(src)
	src.emag += new /obj/item/tool/baton/robot(src)

	var/datum/matter_synth/metal = new /datum/matter_synth/metal(80000)
	var/datum/matter_synth/plasteel = new /datum/matter_synth/plasteel(40000)
	var/datum/matter_synth/glass = new /datum/matter_synth/glass(60000)
	var/datum/matter_synth/wire = new /datum/matter_synth/wire(60)
	var/datum/matter_synth/wood = new /datum/matter_synth/wood(20000)
	var/datum/matter_synth/plastic = new /datum/matter_synth/plastic(15000)
	synths += metal
	synths += glass
	synths += plasteel
	synths += wire
	synths += wood
	synths += plastic

	var/obj/item/matter_decompiler/MD = new /obj/item/matter_decompiler(src)
	MD.metal = metal
	MD.glass = glass
	src.modules += MD

	var/obj/item/stack/material/cyborg/steel/M = new (src)
	M.synths = list(metal)
	src.modules += M

	var/obj/item/stack/material/cyborg/glass/G = new (src)
	G.synths = list(glass)
	src.modules += G

	var/obj/item/stack/rods/cyborg/Ro = new /obj/item/stack/rods/cyborg(src)
	Ro.synths = list(metal)
	src.modules += Ro

	var/obj/item/stack/cable_coil/cyborg/C = new /obj/item/stack/cable_coil/cyborg(src)
	C.synths = list(wire)
	src.modules += C

	var/obj/item/stack/tile/floor/cyborg/S = new /obj/item/stack/tile/floor/cyborg(src)
	S.synths = list(metal)
	src.modules += S

	var/obj/item/stack/material/cyborg/glass/reinforced/RG = new (src)
	RG.synths = list(metal, glass)
	src.modules += RG

	var/obj/item/stack/material/cyborg/plasteel/PL = new (src)
	PL.synths = list(plasteel)
	src.modules += PL

	var/obj/item/stack/material/cyborg/wood/W = new (src)
	W.synths = list(wood)
	src.modules += W

	var/obj/item/stack/material/cyborg/plastic/PS = new (src)
	PS.synths = list(plastic)
	src.modules += PS

	var/obj/item/stack/tile/wood/cyborg/FWT = new (src)
	FWT.synths = list(wood)
	src.modules += FWT

	//We know guild work and robotics.
	R?.stats?.addPerk(PERK_HANDYMAN)
	R?.stats?.addPerk(PERK_ROBOTICS_EXPERT)
	R?.stats?.addPerk(PERK_SI_SCI)
	..(R)


/obj/item/robot_module/engineering/general/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	if(src.modules)
		var/obj/item/reagent_containers/spray/cleaner/SC = locate() in src.modules //space cleaner
		SC?.reagents?.add_reagent("cleaner", 2 * amount)

		var/obj/item/extinguisher/advanced/robotic/EX = locate() in src.modules //space cleaner
		EX?.reagents?.add_reagent("abwater", 2 * amount)

	..()

	if(R.HasTrait(CYBORG_TRAIT_EMAGGED))
		var/obj/item/tool/baton/robot/B = locate() in src.modules
		if(B && B.cell)
			B.cell.give(amount)

	//TODO: Insert appropriate tiles here
	//var/obj/item/stack/tile/floor_white/cyborg/FTW = new (src)
	//FTW.synths = list(plastic)
	//src.modules += FTW

	//var/obj/item/stack/tile/floor_freezer/cyborg/FTF = new (src)
	//FTF.synths = list(plastic)
	//src.modules += FTF

	//var/obj/item/stack/tile/floor_dark/cyborg/FTD = new (src)
	//FTD.synths = list(plasteel)
	//src.modules += FTD

//Possible todo: Discuss giving security module some kind of lethal ranged weapon
/obj/item/robot_module/security
	name = "security robot module"
	channels = list("Marshal" = 1, "Blackshield" = 1)
	networks = list(NETWORK_SECURITY)
	can_be_pushed = 0
	supported_upgrades = list(/obj/item/borg/upgrade/tasercooler,
							 /obj/item/borg/upgrade/jetpack,
							 /obj/item/borg/upgrade/bigknife)

/obj/item/robot_module/security/defense
	health = 160 //Kinda light! We're meant for rapid response
	speed_factor = 1.45 //pretty fast!
	power_efficiency = 0.95 //We're dangerous, but generally can't stray too far from our chargers!

	desc = "Focused on protecting the colony from great threats! Ensure a rapid response to any  major threats, leave little stuff to the humans and enforcement bots \
	heavily armed, though lightly armored security unit."

	stat_modifiers = list(
		STAT_VIG = 60,
		STAT_ROB = 60,
		STAT_TGH = 60,
		STAT_BIO = 25,
		STAT_COG = 120,
		STAT_MEC = 35 //weldering cracks
	)

/obj/item/robot_module/security/defense
	sprites = list(
					"Bloodhound" = "syndie_bloodhound",
					"Treadhound" = "syndie_treadhound",
					"Classic" = "defenceborg",
					"Precision" = "syndi-medi",
					"Heavy" = "syndi-heavy",
					"Artillery" = "spidersyndi",
					"Miss" = "missm_syndie",
					"Contractor RedShell" = "mekasyndi",
					"Contractor RedShell Alt" = "mekasec",
					"Contractor Tanker" = "k4tsec",
					"Contractor Tanker Alt" = "k4tsyndi",
					"Contractor Tactical" = "fmekasec",
					"Contractor Tactical Alt" = "mmekasec",
					"Contractor Foxtrot" = "mekasyndi_foxtrot",
					"Contractor Traffic Light" = "fmekasyndi",
					"Marshal Civil Servant" = "fmekasyndi_marshal", //Odio made this and for some reason named the original file slutty_bot.dmi so putting here so nobody will forget to shame him later for it.
					"Contractor Riot Stopper" = "mmekasyndi",
					"Marshal Riot Unit" = "mmekasyndi_marshal",
					"Dullahan Riot Unit" = "dullahansyndi"
				)

	tall_sprites = list(

					"mekasyndi",
					"mekasec",
					"k4tsec",
					"k4tsyndi",
					"mmekasec",
					"mekasyndi_foxtrot",
					"fmekasyndi",
					"fmekasyndi_marshal",
					"mmekasyndi",
					"mmekasyndi_marshal",
					"dullahansyndi"
				)

/obj/item/robot_module/security/defense/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/borg/sight/hud/sec(src)
	src.modules += new /obj/item/tool/hammer/ironhammer(src) //breaching!
	src.modules += new /obj/item/gun/energy/bsrifle(src) //Clearing! Comes prepared to do warcrimes via incendiary rounds
	src.modules += new /obj/item/gripper/ammo(src)
	src.modules += new /obj/item/shield_projector/rectangle/borg_personal(src) //this is your lifeline, without it you are SCRAP
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/tool/robotic_omni/sec(src) //borrows and the like.
	src.modules += new /obj/item/tool/weldingtool/robotic/weaker(src) //cracks and the like.
	src.modules += new /obj/item/gun/energy/dazzlation(src)
	src.modules += new /obj/item/device/gps(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.emag += new /obj/item/melee/energy/sword(src)

	//We are stronk so we get less no knockdowns
	R?.stats?.addPerk(PERK_ASS_OF_CONCRETE)
	R?.stats?.addPerk(PERK_BLOOD_LUST) //Target ME
	R?.stats?.addPerk(PERK_SI_SCI)

	..(R)

/obj/item/robot_module/security/defense/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/gun/energy/bsrifle/T = locate() in src.modules
	if(T && T.cell && (T.cell.charge < T.cell.maxcharge))
		T.cell.give(T.charge_cost * amount)
		T.update_icon()
	else
		T?.charge_tick = 0


/obj/item/robot_module/security/enforcement
	health = 220 //Very tanky!
	speed_factor = 1.15 //Kinda slow
	power_efficiency = 1.55 //Decent, we are meant to be going out and learing spiders

	desc = "Focused on keeping the peace and ensuring colony law is maintained, the enforcement module is a \
	heavily armored, though lightly armed security unit."

	stat_modifiers = list(
		STAT_ROB = 60,
		STAT_VIG = 60,
		STAT_TGH = 60,
		STAT_BIO = 25,
		STAT_COG = 120,
		STAT_MEC = 35 //weldering cracks
	)

/obj/item/robot_module/security/enforcement
	sprites = list(
					"Basic" = "robotsecy",
					"Sleek" = "sleeksecurity",
					"Black Knight" = "securityrobot",
					"Bloodhound" = "bloodhound",
					"Bloodhound - Treaded" = "treadhound",
					"Drone" = "drone-sec",
					"Classic" = "secborg",
					"Spider" = "spidersec",
					"Heavy" = "heavysec",
					"Miss" = "missm_security",
					"Contractor RedShell" = "mekasyndi",
					"Contractor RedShell Alt" = "mekasec",
					"Contractor Tanker" = "k4tsec",
					"Contractor Tanker Alt" = "k4tsyndi",
					"Contractor Tactical" = "fmekasec",
					"Contractor Tactical Alt" = "mmekasec",
					"Contractor Foxtrot" = "mekasyndi_foxtrot",
					"Contractor Traffic Light" = "fmekasyndi",
					"Marshal Civil Servant" = "fmekasyndi_marshal", //Odio made this and for some reason named the original file slutty_bot.dmi so putting here so nobody will forget to shame him later for it.
					"Contractor Riot Stopper" = "mmekasyndi",
					"Marshal Riot Unit" = "mmekasyndi_marshal",
					"Dullahan Riot Unit" = "dullahansyndi"
				)

	tall_sprites = list(
					"mekasyndi",
					"mekasec",
					"k4tsec",
					"k4tsyndi",
					"mmekasec",
					"mekasyndi_foxtrot",
					"fmekasyndi",
					"fmekasyndi_marshal",
					"mmekasyndi",
					"mmekasyndi_marshal",
					"dullahansyndi"
				)

/obj/item/robot_module/security/enforcement/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/device/scanner/price(src)
	src.modules += new /obj/item/borg/sight/hud/sec(src)
	src.modules += new /obj/item/handcuffs/cyborg(src)
	src.modules += new /obj/item/tool/baton/robot(src)
	src.modules += new /obj/item/gun/energy/taser/mounted/cyborg(src)
	src.modules += new /obj/item/tool/robotic_omni/sec(src) //borrows and the like.
	src.modules += new /obj/item/tool/weldingtool/robotic/weaker(src) //cracks and the like.
	src.modules += new /obj/item/tool/knife/tacknife/robo(src)
	src.modules += new /obj/item/taperoll/police(src)
	src.modules += new /obj/item/gun/energy/riot(src)
	src.modules += new /obj/item/gripper/ammo(src)
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/device/gps(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/device/holowarrant(src)
	//src.modules += new /obj/item/book/manual/wiki/security_ironparagraphs(src) // book of marshal paragraphs
	src.emag += new /obj/item/gun/energy/laser/mounted/cyborg(src)

	//We are stronk so we get less no knockdowns
	R?.stats?.addPerk(PERK_ASS_OF_CONCRETE)
	R?.stats?.addPerk(PERK_BLOOD_LUST) //Target ME
	R?.stats?.addPerk(PERK_SI_SCI)

	..(R)

/obj/item/robot_module/security/enforcement/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/gun/energy/taser/mounted/cyborg/T = locate() in src.modules
	if(T && T.cell && (T.cell.charge < T.cell.maxcharge))
		T.cell.give(T.charge_cost * amount)
		T.update_icon()
	else
		T?.charge_tick = 0

	if(R.HasTrait(CYBORG_TRAIT_EMAGGED))
		var/obj/item/gun/energy/laser/mounted/cyborg/L = locate() in src.modules
		if(L && L.cell && (L.cell.charge < L.cell.maxcharge))
			L.cell.give(T.charge_cost * amount)
			L.update_icon()
		else
			L?.charge_tick = 0

	var/obj/item/tool/baton/robot/B = locate() in src.modules
	if(B && B.cell)
		B.cell.give(amount)

/obj/item/robot_module/custodial
	name = "custodial robot module"
	channels = list("Service" = 1)
	sprites = list(
					"Basic" = "robotjani",
					"Mopbot"  = "janitorrobot",
					"Mop Gear Rex" = "mopgearrex",
					"Drone" = "drone-janitor",
					"Classic" = "janbot2",
					"Buffer" = "mechaduster",
					"Sleek" = "sleekjanitor",
					"Maid" = "maidbot",
					"Miss" = "missm_janitor",
					"Tall Felinal" = "mekajani",
					"Tall Felinal Alt" = "mekajani_alt",
					"Tall Dedicated" = "fmekapeace",
					"Tall Dedicated Alt" = "mmekapeace",
					"Tall Dedicated Tanker" = "k4tpeace",
					"Tall Tanker" = "k4tjani",
					"Tall Tanker Alt" = "k4tjani_alt1",
					"Tall Maid" = "fmekajani",
					"Tall Maid Alt" = "mmekajani",
					"Dullahan Cleaner" = "dullahanjani",
					"Dullahan Sweeper" = "dullahanpeace"
					)

	tall_sprites = list(
					"mekajani",
					"mekajani_alt",
					"fmekapeace",
					"mmekapeace",
					"k4tpeace",
					"k4tjani",
					"k4tjani_alt1",
					"fmekajani",
					"mmekajani",
					"dullahanjani",
					"dullahanpeace"
				)

	health = 120 //Bulky
	speed_factor = 1.45 //Fast
	power_efficiency = 0.8 //Poor

	supported_upgrades = list(/obj/item/borg/upgrade/jetpack,
							  /obj/item/borg/upgrade/satchel_of_holding_for_borgs,
							  /obj/item/borg/upgrade/arc_welder)

	robot_traits = CYBORG_TRAIT_CLEANING_WALK
	stat_modifiers = list(
		STAT_ROB = 25,
		STAT_TGH = 25,
		STAT_BIO = 30,
		STAT_COG = 120,
		STAT_MEC = 35 //weldering cracks
	)

	desc = "A vast machine designed for cleaning up trash and scrubbing floors. A fairly specialised task, \
	but requiring a large capacity. The huge chassis consequentially grants it a degree of toughness, \
	without compromising its speed."

/obj/item/robot_module/custodial/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/device/scanner/price(src)
	src.modules += new /obj/item/gripper/service(src)
	src.modules += new /obj/item/soap/deluxe(src)
	src.modules += new /obj/item/storage/bag/trash/big/robotic(src)
	src.modules += new /obj/item/mop(src)
	src.modules += new /obj/item/device/lightreplacer(src)
	src.modules += new /obj/item/reagent_containers/glass/bucket(src) // a hydroponist's bucket
	src.modules += new /obj/item/matter_decompiler(src) // free drone remains for all
	src.modules += new /obj/item/device/t_scanner(src)
	src.modules += new /obj/item/tool/robotic_omni/cleaner(src)
	src.modules += new /obj/item/tool/weldingtool/robotic(src)
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/device/gps(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/gripper/ammo(src)
	src.modules += new /obj/item/gun/energy/smg(src) //superior arms due to janitor union /s. But really, this is because they're more likely to have to do fighting while roaming around cleaning
	src.emag += new /obj/item/melee/energy/sword(src)

	//Silent cleaners
	R?.stats?.addPerk(PERK_QUIET_AS_MOUSE)
	R?.stats?.addPerk(PERK_SI_SCI)

	..(R)

/obj/item/robot_module/custodial/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/device/lightreplacer/LR = locate() in src.modules
	LR?.Charge(R, amount)
	if(src.emag)
		var/obj/item/reagent_containers/spray/lube/S = locate() in src.emag
		S?.reagents?.add_reagent("lube", 2 * amount)

/obj/item/robot_module/service
	name = "service robot module"
	channels = list("Service" = 1)

	sprites = list(	"Waitress" = "service",
					"Kent" = "toiletbot",
					"Bro" = "brobot",
					"Rich" = "maximillion",
					"Basic" = "robotserv",
					"Drone - Service" = "drone-service",
					"Drone - Hydro" = "drone-hydro",
					"Classic" = "service2",
					"Gardener" = "botany",
					"Mobile Bar" = "heavyserv",
					"Sleek" = "sleekservice",
					"Maid" = "maidbot",
					"Miss" = "missm_service",
					"Tall Felinal" = "mekaserve",
					"Tall Felinal Maid" = "mekaserve_alt",
					"Tall Hopper" = "mekaserve_hopper",
					"Tall Ringleader" = "mekaserve_ringleader",
					"Tall Tanker" = "k4tserve",
					"Tall k4tserve Alt" = "k4tserve_alt1",
					"Tall Tanker Maid" = "k4tserve_alt2",
					"Tall Female Maid" = "fmekaserv",
					"Tall Male Maid" = "mmekaserv",
					"Dullahan Server" = "dullahanserv",
					"Dullahan Server Alt" = "dullahanserv_alt"
				)

	tall_sprites = list(
					"mekaserve",
					"mekaserve_alt",
					"mekaserve_hopper",
					"mekaserve_ringleader",
					"k4tserve",
					"k4tserve_alt1",
					"k4tserve_alt2",
					"fmekaserv",
					"mmekaserv",
					"dullahanserv",
					"dullahanserv_alt"
				)

	health = 120
	speed_factor = 1.5 //Quick
	power_efficiency = 1 //Base line

	desc = "A lightweight unit designed to serve humans directly, in housekeeping, cooking, bartending, \
	 gardening, secreterial and similar personal service roles. Their work does not necessitate any \
	 significant durability, and they are typically constructed from civilian grade plastics."

	stat_modifiers = list(
		STAT_BIO = 30,
		STAT_COG = 120,
		STAT_ROB = 30,
		STAT_TGH = 30,
		STAT_MEC = 30
	)
	supported_upgrades = list(/obj/item/borg/upgrade/jetpack,/obj/item/borg/upgrade/satchel_of_holding_for_borgs)

/obj/item/robot_module/service/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/tool/robotic_omni/standard(src)
	src.modules += new /obj/item/device/scanner/price(src)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/gripper/service(src)
	src.modules += new /obj/item/reagent_containers/glass/bucket(src)
	src.modules += new /obj/item/tool/minihoe(src)
	src.modules += new /obj/item/tool/hatchet/robo(src)
	src.modules += new /obj/item/tool/multitool/robotic(src) //hydro
	src.modules += new /obj/item/device/scanner/plant(src)
	src.modules += new /obj/item/storage/bag/robotic/produce(src)
	src.modules += new /obj/item/robot_harvester(src)
	src.modules += new /obj/item/material/kitchen/rollingpin(src)
	src.modules += new /obj/item/reagent_containers/condiment/enzyme(src)
	src.modules += new /obj/item/flame/lighter/zippo(src)
	src.modules += new /obj/item/soap(src) // a cheap bar of soap
	src.modules += new /obj/item/reagent_containers/glass/rag(src) // a rag for.. yeah.. the primary tool of bartender
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/hand_labeler(src)
	src.modules += new /obj/item/tool/tape_roll(src) //allows it to place flyers
	src.modules += new /obj/item/stamp/denied(src) //why was this even a emagged item before smh
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/device/gps(src)
	src.modules += new /obj/item/device/synthesized_instrument/synthesizer(src)
	src.modules += new /obj/item/gun/energy/borg/pistol(src)
	src.emag += new /obj/item/melee/energy/sword(src)
	src.emag += new /obj/item/stamp/chameleon(src)
	src.emag += new /obj/item/pen/chameleon(src)

	var/obj/item/rsf/M = new /obj/item/rsf(src)
	M.stored_matter = 30
	src.modules += M

	src.modules += new /obj/item/reagent_containers/dropper/industrial(src)

	var/obj/item/flame/lighter/zippo/L = new /obj/item/flame/lighter/zippo(src)
	L.lit = 1
	src.modules += L

	src.modules += new /obj/item/tray/robotray(src)
	src.modules += new /obj/item/reagent_containers/borghypo/service(src)
	src.emag += new /obj/item/reagent_containers/drinks/bottle/small/beer_two(src)

	//Seller and cleaner mix, so quite and knowing the deal!
	R?.stats?.addPerk(PERK_QUIET_AS_MOUSE)
	R?.stats?.addPerk(PERK_MARKET_PROF)
	R?.stats?.addPerk(PERK_SI_SCI)

	..(R)

/obj/item/robot_module/service/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	..()
	var/obj/item/reagent_containers/condiment/enzyme/E = locate() in src.modules
	E?.reagents?.add_reagent("enzyme", 2 * amount)
	if(src.emag)
		var/obj/item/reagent_containers/drinks/bottle/small/beer_two/B = locate() in src.emag
		B?.reagents?.add_reagent("beer2", 2 * amount)

/obj/item/robot_module/miner
	name = "miner robot module"
	channels = list("Supply" = 1)
	networks = list(NETWORK_MINE)
	sprites = list(
					"Basic" = "robotmine",
					"Advanced Droid" = "droid-miner",
					"Sleek" = "sleekminer",
					"Treadhead" = "miner",
					"Drone" = "drone-miner",
					"Classic" = "miner_old",
					"Heavy" = "heavymine",
					"Spider" = "spidermining",
					"Miss" = "missm_miner",
					"Tall Felinal" = "mekamine",
					"Tall Felinal Alt" = "mekamine_alt",
					"Tall Female Feline" = "fmekamine",
					"Tall Male Feline" = "mmekamine",
					"Tall Tanker" = "k4tmine",
					"Tall Tanker Alt" = "k4tmine_alt1",
					"Dullahan Miner" = "dullahanmine"
				)


	tall_sprites = list(
					"mekamine",
					"mekamine_alt",
					"fmekamine",
					"mmekamine",
					"k4tmine",
					"k4tmine_alt1",
					"dullahanmine"
				)

	health = 160 //Pretty tough
	speed_factor = 1.2 //meh
	power_efficiency = 1.5 //Best efficiency

	stat_modifiers = list(
		STAT_ROB = 60,
		STAT_TGH = 50,
		STAT_BIO = 25,
		STAT_COG = 120,
		STAT_MEC = 50 //Drills
	)
	supported_upgrades = list(/obj/item/borg/upgrade/jetpack,
							  /obj/item/borg/upgrade/satchel_of_holding_for_borgs)

	desc = "Built for digging anywhere, excavating the ores and materials to keep the colony running, \
	this is heavy and powerful unit with a fairly singleminded purpose. It needs to withstand impacts \
	from falling boulders, and exist for long periodsanwhere, often far from a charging \
	port. It is built with these purposes in mind."

/obj/item/robot_module/miner/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/tool/robotic_omni/miner(src)
	src.modules += new /obj/item/tool/pickaxe/borgonly(src)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/borg/sight/material(src)
	src.modules += new /obj/item/storage/bag/robotic/ore(src)
	src.modules += new /obj/item/storage/bag/robotic/sheetsnatcher(src)
	src.modules += new /obj/item/gripper/miner(src)
	src.modules += new /obj/item/gripper/no_use/loader(src) //They have to sell materials over desks at times.
	src.modules += new /obj/item/device/scanner/mining(src)
	src.modules += new /obj/item/device/t_scanner(src)
	src.modules += new /obj/item/gun/energy/riot(src)
	src.modules += new /obj/item/gripper/ammo(src)
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/device/scanner/price(src)
	src.modules += new /obj/item/device/gps(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/device/ore_sonar(src)
	src.emag += new /obj/item/melee/energy/sword(src)

	//Seller so quite and knowing the deal!
	R?.stats?.addPerk(PERK_MARKET_PROF)
	R?.stats?.addPerk(PERK_SI_SCI)


	..(R)

/obj/item/robot_module/research
	name = "research module"
	channels = list("Science" = 1)
	networks = list(NETWORK_RESEARCH)
	sprites = list(
					"Droid" = "droid-science",
					"Drone" = "drone-science",
					"Classic" = "robotjani",
					"Sleek" = "sleekscience",
					"Heavy" = "heavysci",
					"Miss" = "missm_med",
					"Tall Felinal" = "mekapeace",
					"Tall Felinal Alt" = "mekapeace_alt",
					"Tall" = "mekaninja",
					"Tall Alt" = "mekaninja_alt",
					"Tall Tanker" = "k4tninja",
					"Tall Female" = "fmekaninja",
					"Tall Male" = "mmekaninja",
					"Dullahan Researcher" = "dullahanninja"
					)

	tall_sprites = list(
					"mekapeace",
					"Tmekapeace_alt",
					"mekaninja",
					"mekaninj_alt",
					"k4tninja",
					"fmekaninja",
					"mmekaninja",
					"dullahanninja"
					)

	health = 120 //Weak
	speed_factor = 1.3 //Average
	power_efficiency = 0.75 //Poor efficiency

	desc = "Built for working in a well-equipped lab, and designed to handle a wide variety of research \
	duties, this module prioritises flexibility over efficiency. Capable of working in R&D, Toxins, \
	chemistry, xenobiology and robotics."
	supported_upgrades = list(/obj/item/borg/upgrade/jetpack,/obj/item/borg/upgrade/satchel_of_holding_for_borgs,/obj/item/borg/upgrade/arc_welder)

	stat_modifiers = list(
		STAT_BIO = 40,
		STAT_COG = 120,
		STAT_MEC = 60 //So a cyborg that is meant to work in robotics can work robotics.
	)

/obj/item/robot_module/research/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/flash(src)
//	src.modules += new /obj/item/portable_destructive_analyzer(src) dosnt work
	src.modules += new /obj/item/gripper/research(src)
	src.modules += new /obj/item/gripper/no_use/loader(src)
	src.modules += new /obj/item/device/robotanalyzer(src)
	src.modules += new /obj/item/card/robot(src)
	src.modules += new /obj/item/tool/robotic_omni/sci(src)
	src.modules += new /obj/item/tool/multitool/robotic(src) //hydro checks for tool rather then use
	src.modules += new /obj/item/tool/weldingtool/robotic(src)
	src.modules += new /obj/item/robot_harvester(src)
	src.modules += new /obj/item/reagent_containers/syringe(src)
	src.modules += new /obj/item/gripper/chemistry(src)
	src.modules += new /obj/item/reagent_containers/dropper/industrial(src)
	src.modules += new /obj/item/reagent_containers/glass/beaker/large(src)
	src.modules += new /obj/item/device/scanner/reagent/adv(src)
	src.modules += new /obj/item/extinguisher/advanced/robotic(src)
	src.modules += new /obj/item/storage/bag/robotic/produce(src)
	src.modules += new /obj/item/device/science_tool(src)
	src.modules += new /obj/item/device/scanner/price(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/storage/part_replacer(src)
	src.modules += new /obj/item/tool/sword/saber/deconstuctive_rapier(src)
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/gripper/ammo(src)
	src.modules += new /obj/item/gun/energy/borg/pistol(src)
	src.modules += new /obj/item/device/gps(src)
	src.emag += new /obj/item/melee/energy/sword(src)

	var/datum/matter_synth/nanite = new /datum/matter_synth/nanite(10000)
	var/datum/matter_synth/wire = new /datum/matter_synth/wire(30)
	synths += nanite
	synths += wire

	var/obj/item/stack/nanopaste/N = new /obj/item/stack/nanopaste(src)
	N.uses_charge = 1
	N.charge_costs = list(1000)
	N.synths = list(nanite)
	src.modules += N

	var/obj/item/stack/cable_coil/cyborg/C = new /obj/item/stack/cable_coil/cyborg(src)
	C.synths = list(wire)
	src.modules += C

	//We know medical and robotics, were a mix.
	R?.stats?.addPerk(PERK_MEDICAL_EXPERT)
	R?.stats?.addPerk(PERK_SURGICAL_MASTER)
	R?.stats?.addPerk(PERK_ROBOTICS_EXPERT)
	R?.stats?.addPerk(PERK_SI_SCI)

	..(R)

/obj/item/robot_module/research/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	if(src.modules)
		var/obj/item/extinguisher/advanced/robotic/EX = locate() in src.modules //space cleaner
		EX?.reagents?.add_reagent("abwater", 2 * amount)

/obj/item/robot_module/drone
	name = "drone module"
	hide_on_manifest = TRUE
	no_slip = 1
	networks = list(NETWORK_ENGINEERING)
	channels = list("Engineering" = 1, "Common" = 1)
	health = 35 //Basic colony drones and the like should have 35 health as they are not meant for combat
	stat_modifiers = list(
		STAT_COG = 120,
		STAT_MEC = 80
	) //so we can use rnd consoles for parts ect

/obj/item/robot_module/drone/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/tool/weldingtool/robotic(src)
	src.modules += new /obj/item/tool/multitool/robotic(src)
	src.modules += new /obj/item/tool/robotic_omni/engi(src)
	src.modules += new /obj/item/tool/tape_roll/fiber/robotic(src) //Window repair
	src.modules += new /obj/item/device/t_scanner(src)
	src.modules += new /obj/item/device/lightreplacer(src)
	src.modules += new /obj/item/gripper(src)
	src.modules += new /obj/item/soap(src)
	src.modules += new /obj/item/gripper/no_use/loader(src)
	src.modules += new /obj/item/gripper/chemistry(src)// For refilling autolathens with sillicon
	src.modules += new /obj/item/storage/part_replacer/mini(src)
	src.modules += new /obj/item/extinguisher/advanced/robotic(src)
	src.modules += new /obj/item/device/pipe_painter(src)
	src.modules += new /obj/item/device/floor_painter(src)
	src.modules += new /obj/item/borg/sight/meson(src)
	src.modules += new /obj/item/reagent_containers/spray/krag_b_gone(src)
	src.modules += new /obj/item/pen/robopen(src)
	src.modules += new /obj/item/form_printer(src)
	src.modules += new /obj/item/gripper/paperwork(src)
	src.modules += new /obj/item/gripper/upgrade(src)
	src.modules += new /obj/item/device/gps(src)

	//src.emag += new /obj/item/gun/energy/plasmacutter/mounted(src)
	//src.emag.name = "Plasma Cutter"

	var/datum/matter_synth/metal = new /datum/matter_synth/metal(25000)
	var/datum/matter_synth/glass = new /datum/matter_synth/glass(25000)
	var/datum/matter_synth/wood = new /datum/matter_synth/wood(10000)
	var/datum/matter_synth/plastic = new /datum/matter_synth/plastic(10000)
	var/datum/matter_synth/wire = new /datum/matter_synth/wire(30)
	synths += metal
	synths += glass
	synths += wood
	synths += plastic
	synths += wire

	var/obj/item/matter_decompiler/MD = new /obj/item/matter_decompiler(src)
	MD.metal = metal
	MD.glass = glass
	MD.wood = wood
	MD.plastic = plastic
	src.modules += MD

	var/obj/item/stack/material/cyborg/steel/M = new (src)
	M.synths = list(metal)
	src.modules += M

	var/obj/item/stack/material/cyborg/glass/G = new (src)
	G.synths = list(glass)
	src.modules += G

	var/obj/item/stack/rods/cyborg/Ro = new /obj/item/stack/rods/cyborg(src)
	Ro.synths = list(metal)
	src.modules += Ro

	var/obj/item/stack/cable_coil/cyborg/C = new /obj/item/stack/cable_coil/cyborg(src)
	C.synths = list(wire)
	src.modules += C

	var/obj/item/stack/tile/floor/cyborg/S = new /obj/item/stack/tile/floor/cyborg(src)
	S.synths = list(metal)
	src.modules += S

	var/obj/item/stack/material/cyborg/glass/reinforced/RG = new (src)
	RG.synths = list(metal, glass)
	src.modules += RG

	var/obj/item/stack/tile/wood/cyborg/WT = new /obj/item/stack/tile/wood/cyborg(src)
	WT.synths = list(wood)
	src.modules += WT

	var/obj/item/stack/material/cyborg/wood/W = new (src)
	W.synths = list(wood)
	src.modules += W

	var/obj/item/stack/material/cyborg/plastic/P = new (src)
	P.synths = list(plastic)
	src.modules += P

	//We know repair work and robotics.
	R?.stats?.addPerk(PERK_ROBOTICS_EXPERT)
	R?.stats?.addPerk(PERK_SI_SCI)

	..(R)

/obj/item/robot_module/drone/respawn_consumable(var/mob/living/silicon/robot/R, var/amount)
	if(src.modules)
		var/obj/item/reagent_containers/spray/krag_b_gone/KBG = locate() in src.modules //Krag-B-Gone
		KBG?.reagents?.add_reagent("silicate", 2 * amount)

		var/obj/item/device/lightreplacer/LR = locate() in src.modules
		LR?.Charge(R, amount)

		var/obj/item/extinguisher/advanced/robotic/EX = locate() in src.modules //space cleaner
		EX?.reagents?.add_reagent("abwater", 2 * amount)


	..()

/obj/item/robot_module/drone/construction
	name = "construction drone module"
	channels = list("Engineering" = 1)
	health = 75 //These spawn in high combat areas and zones, 1 shot by a random person mob isnt fun
	languages = list()

/obj/item/robot_module/drone/construction/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/rcd/borg(src)
	..(R)

