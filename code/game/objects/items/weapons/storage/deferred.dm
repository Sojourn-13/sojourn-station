/*
	Deferred spawn storage containers
*/

/*
	These are a special type of storage container used for less-accessed gear. They create their contents through a
	spawn_contents proc which is called the first time the box is opened or interacted with.

	The key thing here is, these contents are not spawned at roundstart, only when a player actually needs them
	And thusly, if no player ever does, then those items are not sitting around wasting memory and CPU time

	Most of the things in this file are intended for use by external antags, and are thus exceptionally powerful
*/


/obj/item/storage/deferred
	var/list/initial_contents = list() //List of stuff that will be in this box
	//Can be used as an assoc list and allow you to enter a quantity as the value

	var/contents_spawned = FALSE

	name = "box"
	desc = "A steel-cased box."
	icon = 'icons/obj/storage/deferred.dmi'
	icon_state = "box"
	item_state = "box"
	contained_sprite = TRUE

/obj/item/storage/deferred/populate_contents()
	// Do not create contents if they are already spawned
	if(contents_spawned)
		return

	contents_spawned = TRUE
	for(var/a in initial_contents)
		var/quantity = initial_contents[a] ? initial_contents[a] : 1

		for(var/i = 0; i < quantity; i++)
			new a(src)
	expand_to_fit()

/obj/item/storage/deferred/open(mob/user)
	populate_contents()
	. = ..()

/obj/item/storage/deferred/show_to(mob/user)
	populate_contents()
	. = ..()

/obj/item/storage/deferred/can_be_inserted(obj/item/W, stop_messages = 0)
	populate_contents()
	. = ..()

/obj/item/storage/deferred/rations //DO this before merging
	name = "infantryman's rations kit"
	icon_state = "irp_box"
	item_state = "irp_box"
	w_class = ITEM_SIZE_HUGE
	desc = "A box of preserved, ready-to-eat food for soldiers and spacefarers on the go."
	can_hold = list(/obj/item/storage/ration_pack)
	initial_contents = list(/obj/item/storage/ration_pack = 7)


/obj/item/storage/deferred/toolmod
	name = "tool modifications kit"
	desc = "A sturdy container full of contraptions, bits of material, components and add-ons for modifying tools."
	icon_state = "box_tools"
	can_hold = list(/obj/random/tool_upgrade, /obj/random/tool_upgrade/rare)
	initial_contents = list(/obj/random/tool_upgrade = 12,
	/obj/random/tool_upgrade/rare = 3)


/obj/item/storage/deferred/pouches
	name = "uniform modification kit"
	desc = "A box full of hard-wearing pouches designed for easy attachment to clothing and armor. Good for carrying extra ammo or tools in the field."
	can_hold = list(/obj/random/pouch, /obj/item/storage/pouch/pistol_holster)
	initial_contents = list(/obj/random/pouch = 8, /obj/item/storage/pouch/pistol_holster = 1)
	//One guaranteed holster and plenty of randoms

/obj/item/storage/deferred/comms
	name = "communications kit"
	desc = "A box full of radios and beacons"
	can_hold = list(/obj/item/device/radio/beacon, /obj/item/device/radio)
	initial_contents = list(/obj/item/device/radio/beacon = 6, /obj/item/device/radio = 6)

/obj/item/storage/deferred/lights
	name = "illumination kit"
	desc = "A box of flares and flashlights"
	can_hold = list(/obj/item/device/lighting/glowstick/flare, /obj/item/device/lighting/toggleable/flashlight/heavy)
	initial_contents = list(/obj/item/device/lighting/glowstick/flare = 20, /obj/item/device/lighting/toggleable/flashlight/heavy = 6)

/obj/item/storage/deferred/music
	name = "morale kit"
	desc = "All that's required to unite nation, compacted within single box."
	icon_state = "box_serbian"
	can_hold = list(/obj/item/device/synthesized_instrument/trumpet)
	initial_contents = list(/obj/item/device/synthesized_instrument/trumpet = 1) //TODO: Add an accordian to this, sprites already made.


//Medical
/obj/item/storage/deferred/surgery
	name = "combat surgery kit"
	desc = "Contains tools for surgery. Has precise foam fitting for safe transport of highly advanced tools."
	icon_state = "combat_surgery_kit"
	item_state = "combat_surgery_kit"
	initial_contents = list(
		/obj/item/tool/bonesetter/adv,
		/obj/item/tool/saw/circular/medical,
		/obj/item/tool/hemostat/adv,
		/obj/item/tool/retractor/adv,
		/obj/item/tool/scalpel/laser,
		/obj/item/tool/tape_roll/bonegel,
		/obj/item/tool/surgicaldrill/adv,
		/obj/item/reagent_containers/syringe/stim/ultra_surgeon,
		/obj/item/storage/pill_bottle/tramadol,
		/obj/item/stack/medical/bruise_pack/advanced
		)
	can_hold = list(
		/obj/item/tool/bonesetter,
		/obj/item/tool/saw/circular,
		/obj/item/tool/hemostat,
		/obj/item/tool/retractor,
		/obj/item/tool/scalpel,
		/obj/item/tool/surgicaldrill,
		/obj/item/tool/tape_roll/bonegel,
		/obj/item/reagent_containers/syringe, //We hold any syringe.
		/obj/item/storage/pill_bottle, //We hold pill bottles as well
		/obj/item/stack/medical/bruise_pack/advanced
		)

/obj/item/storage/deferred/meds
	name = "combat medical kit"
	desc = "Contains advanced medical treatments."
	icon_state = "combat_medical_kit"
	item_state = "combat_medical_kit"
	initial_contents = list(/obj/item/storage/pill_bottle/bicaridine,
	/obj/item/storage/pill_bottle/dermaline,
	/obj/item/storage/pill_bottle/dexalin_plus,
	/obj/item/storage/pill_bottle/carthatoline,
	/obj/item/storage/pill_bottle/tramadol,
	/obj/item/storage/pill_bottle/spaceacillin,
	/obj/item/reagent_containers/hypospray/autoinjector/sanguinum,
	/obj/item/stack/medical/splint)

//Crates
//These use open topped crate sprites but are still functionally boxes. They can be picked up, but are too large to fit in anything
/obj/item/storage/deferred/crate
	w_class = ITEM_SIZE_HUGE //This is too big to fit in a backpack
	icon_state = "serbcrate_deferred_worn"
	item_state = "crate"

/obj/item/storage/deferred/crate/tools
	name = "tool storage box"
	desc = "A moderately sized crate full of assorted tools."
	icon_state = "serbcrate_deferred_brown"
	initial_contents = list(/obj/random/tool = 13,
	/obj/random/tool/advanced = 2)

/obj/item/storage/deferred/crate/saw
	name = "infantry support crate"
	desc = "A crate containing two Pulemyot Kalashnikova light machine guns, and 640 rounds of 7.62mm ammunition."
	icon_state = "serbcrate_deferred_green"
	initial_contents = list(/obj/item/gun/projectile/automatic/lmg/pk = 2,
	/obj/item/ammo_magazine/rifle_75_linked_box = 8)

/obj/item/storage/deferred/crate/ak
	name = "rifleman crate"
	desc = "A crate containing six AKM rifles, and plenty of magazines."
	icon_state = "serbcrate_deferred_green"
	initial_contents = list(/obj/item/gun/projectile/automatic/ak47/sa  = 6,
	/obj/item/ammo_magazine/rifle_75 = 18)

/obj/item/storage/deferred/crate/grenadier
	name = "grenadier crate"
	desc = "A crate containing one \"Lenar\" launcher, and copious quantities of hand-propelled explosive devices."
	icon_state = "serbcrate_deferred_black"
	initial_contents = list(/obj/item/ammo_casing/grenade/blast = 5,
	/obj/item/ammo_casing/grenade/frag = 14,
	/obj/item/ammo_casing/grenade/emp = 4,
	/obj/item/gun/projectile/grenade/lenar = 1)

/obj/item/storage/deferred/crate/antiarmor //change to demolitions, won't do now because will affect map
	name = "demolitions crate"
	icon_state = "serbcrate_deferred_black"
	desc = "A crate containing one \"RPG-7\" launcher, and twelve 40mm PG-7VL warheads."
	initial_contents = list(/obj/item/ammo_casing/rocket = 9,
	/obj/item/ammo_casing/rocket/emp = 3,
	/obj/item/storage/pouch/tubular = 1,
	/obj/item/gun/projectile/rpg = 1,
	/obj/item/storage/pouch/tubular = 1)

/obj/item/storage/deferred/crate/demolition
	name = "breaching crate"
	desc = "A crate of tools to deal with stationary hard targets, and remove obstacles."
	icon_state = "serbcrate_deferred_brown"
	initial_contents = list(/obj/item/plastique = 13,
	/obj/item/storage/pouch/tubular = 1,
	/obj/item/hatton = 1,
	/obj/item/hatton_magazine = 5,
	/obj/item/tool/pickaxe/diamonddrill = 1)

/obj/item/storage/deferred/crate/marksman
	name = "marksman crate"
	desc = "A crate containing one Anti-Materiel Rifle, and ten 60-06 shells."
	icon_state = "serbcrate_deferred_black"
	initial_contents = list(/obj/item/gun/projectile/boltgun/heavysniper = 1,
	/obj/item/ammo_magazine/ammobox/antim_small = 2)

/obj/item/storage/deferred/crate/sidearm
	name = "sidearm crate"
	desc = "A crate containing six Makarov 9mm pistols, 200 rounds of ammunition, and six fixed-blade combat knives."
	icon_state = "serbcrate_deferred_green"
	initial_contents = list(/obj/item/gun/projectile/makarov = 6,
	/obj/item/ammo_magazine/highcap_pistol_35  = 20,
	/obj/item/tool/knife/boot = 6)

/obj/item/storage/deferred/crate/cells
	name = "power cell bin"
	desc = "A moderately sized crate full of various power cells."
	icon_state = "serbcrate_deferred_worn"
	initial_contents = list(/obj/random/powercell = 16)

/obj/item/storage/deferred/crate/alcohol
	name = "liquor crate"
	desc = "A moderately sized crate full of various alcoholic drinks."
	icon_state = "serbcrate_deferred_worn"
	initial_contents = list(/obj/random/booze = 10,
	/obj/random/booze/low_chance = 10,
	/obj/item/reagent_containers/drinks/bottle/vodka = 3)

//SERBIAN-YUNANI UNIFORM CRATES

/obj/item/storage/deferred/crate/uniform_mardinat
	name = "worn uniform kit"
	desc = "A moderately sized crate full of clothes. Hastily painted green stripes adorn the box."
	icon_state = "mardcrate_deferred"
	initial_contents = list(
	/obj/item/clothing/under/serbiansuit/brown = 1,
	/obj/item/clothing/head/soft/tan2soft = 1,
	/obj/item/clothing/suit/armor/platecarrier = 1,
	/obj/item/clothing/head/helmet/faceshield/altyn/mardinat_yunan = 1,
	/obj/item/clothing/mask/balaclava/tactical = 1,
	/obj/item/clothing/shoes/jackboots = 1,
	/obj/item/clothing/gloves/fingerless = 1,
	/obj/item/clothing/accessory/passcard/mardinat_yunan = 1,
	/obj/item/clothing/accessory/flag/mardinat_yunan = 1)

/obj/item/storage/deferred/crate/uniform_green
	name = "green uniform kit"
	desc = "A moderately sized crate full of clothes."
	icon_state = "serbcrate_deferred_green"
	initial_contents = list(
	/obj/item/clothing/under/serbiansuit = 1,
	/obj/item/clothing/head/soft/green2soft = 1,
	/obj/item/clothing/suit/armor/platecarrier = 1,
	/obj/item/clothing/head/helmet/faceshield/altyn = 1,
	/obj/item/clothing/mask/balaclava/tactical = 1,
	/obj/item/clothing/shoes/jackboots = 1,
	/obj/item/clothing/gloves/fingerless = 1)

/obj/item/storage/deferred/crate/uniform_brown
	name = "brown uniform kit"
	desc = "A moderately sized crate full of clothes."
	icon_state = "serbcrate_deferred_brown"
	initial_contents = list(
	/obj/item/clothing/under/serbiansuit/brown = 1,
	/obj/item/clothing/head/soft/tan2soft = 1,
	/obj/item/clothing/suit/armor/platecarrier = 1,
	/obj/item/clothing/head/helmet/faceshield/altyn = 1,
	/obj/item/clothing/mask/balaclava/tactical = 1,
	/obj/item/clothing/shoes/jackboots = 1,
	/obj/item/clothing/gloves/fingerless = 1)

/obj/item/storage/deferred/crate/uniform_black
	name = "black uniform kit"
	desc = "A moderately sized crate full of clothes."
	icon_state = "serbcrate_deferred_black"
	initial_contents = list(
	/obj/item/clothing/under/serbiansuit/black = 1,
	/obj/item/clothing/suit/armor/platecarrier = 1,
	/obj/item/clothing/head/helmet/faceshield/altyn = 1,
	/obj/item/clothing/mask/balaclava/tactical = 1,
	/obj/item/clothing/shoes/jackboots = 1,
	/obj/item/clothing/gloves/fingerless = 1,
	/obj/item/reagent_containers/drinks/bottle/vodka = 1)

/obj/item/storage/deferred/crate/uniform_flak
	name = "flak serbian uniform crate"
	desc = "A moderately sized crate full of clothes."
	icon_state = "serbcrate_deferred_worn"
	initial_contents = list(
	/obj/item/clothing/under/serbiansuit = 1,
	/obj/item/clothing/suit/armor/flakvest = 1,
	/obj/item/clothing/head/helmet/faceshield/altyn/maska = 1,
	/obj/item/clothing/mask/balaclava/tactical = 1,
	/obj/item/clothing/shoes/jackboots = 1,
	/obj/item/clothing/gloves/fingerless = 1,
	/obj/item/storage/fancy/cigarettes = 1)

/obj/item/storage/deferred/crate/uniform_light
	name = "light armor kit"
	desc = "A moderately sized crate full of clothes."
	icon_state = "serbcrate_deferred_worn"
	initial_contents = list(
	/obj/item/clothing/under/serbiansuit = 1,
	/obj/item/clothing/head/soft/green2soft = 1,
	/obj/item/clothing/suit/armor/flakvest = 1,
	/obj/item/clothing/head/helmet/steelpot = 1,
	/obj/item/clothing/shoes/jackboots = 1,
	/obj/item/clothing/gloves/fingerless = 1,
	/obj/item/storage/fancy/cigarettes = 1)

/obj/item/storage/deferred/crate/iron_lock_security_uniform
	name = "Iron Lock Security uniform crate"
	desc = "A moderately sized crate full of clothes."
	icon_state = "northtech_deferred"
	initial_contents = list(
	/obj/item/clothing/mask/balaclava/tactical = 1,
	/obj/item/clothing/shoes/ablasive/iron_lock_security = 1,
	/obj/item/clothing/gloves/thick/ablasive/iron_lock_security  = 1,
	/obj/item/clothing/head/soft/iron_lock_security = 1,
	/obj/item/clothing/head/helmet/laserproof/iron_lock_security = 1,
	/obj/item/clothing/suit/armor/vest/iron_lock_security = 1,
	/obj/item/clothing/under/iron_lock_security = 1)

/obj/item/storage/deferred/crate/exc_gear
	name = "excelsior crate"
	desc = "A crate containing everything you need for the revolution."
	icon_state = "exc_deferred"
	initial_contents = list(/obj/item/gun/projectile/makarov = 2,
	/obj/item/ammo_magazine/highcap_pistol_35  = 4,
	/obj/item/tool/knife/boot = 1,
	/obj/item/circuitboard/excelsior_teleporter = 1,
	/obj/item/circuitboard/excelsiorautolathe = 1,
	/obj/item/stock_parts/manipulator/excelsior = 3,
	/obj/item/stock_parts/matter_bin/excelsior = 3,
	/obj/item/cell/large/excelsior = 1,
	/obj/item/stock_parts/subspace/crystal = 1,
	/obj/item/clothing/under/excelsior = 1,
	/obj/item/gun/matter/launcher/reclaimer = 1,
	/obj/item/storage/toolbox/syndicate = 1,
	/obj/item/storage/toolbox/electrical = 1,
	/obj/item/clothing/shoes/combat = 1,
	/obj/item/clothing/gloves/thick/combat = 1,
	/obj/item/clothing/suit/space/void/excelsior = 1,
	/obj/item/storage/firstaid/ifak = 1,
	/obj/item/implanter/excelsior = 2,
	/obj/item/storage/backpack = 1,
	/obj/item/storage/backpack/satchel = 1)


// TRADE

// Gambling
/obj/item/storage/deferred/disks
	name = "autolathe disk box"
	desc = "A small collection of autolathe disks"
	initial_contents = list(/obj/random/lathe_disk = 7)

/obj/item/storage/deferred/gun_parts
	name = "gun part box"
	desc = "Uppers, lowers, and everything in between"
	initial_contents = list(/obj/random/gun_parts = 7)

/obj/item/storage/deferred/powercells
	name = "powercell box"
	desc = "A small collection of powercells"
	initial_contents = list(/obj/random/powercell/large_safe = 2,
							/obj/random/powercell/medium_safe = 2,
							/obj/random/powercell/small_safe = 3)

/obj/item/storage/deferred/electronics
	name = "circuit board box"
	desc = "A small collection of circuit boards"
	initial_contents = list(/obj/random/circuitboard = 7)

/obj/item/storage/deferred/science
	name = "scientific things box"
	desc = "A small collection of scientific items."
	initial_contents = list(/obj/random/science = 7)

/obj/item/storage/deferred/rig
	name = "hardsuit box"
	desc = "They put a RIG in a box."
	price_tag = 200 //*5 at casino beacon
	initial_contents = list(/obj/random/rig = 1)

/obj/item/storage/deferred/toolmods
	name = "toolmod box"
	desc = "An assortment of some toolmods."
	price_tag = 150
	initial_contents = list(/obj/random/tool_upgrade = 5)

/obj/item/storage/deferred/medical
	name = "medical supply box"
	desc = "An assortment of some bandages, medicines."
	initial_contents = list(/obj/random/medical/always_spawn = 7)

/obj/item/storage/deferred/tools
	name = "tools box"
	desc = "A small collection of tools."
	price_tag = 120
	initial_contents = list(/obj/random/tool = 7)

// Trade, but specified
// Med
/obj/item/storage/deferred/triage
	name = "triage autoinjector kit"
	desc = "An assorted container of useful medical autoinjectors meant to alleviate minor wounds."
	initial_contents = list(/obj/item/reagent_containers/hypospray/autoinjector/bicaridine = 2,
	/obj/item/reagent_containers/hypospray/autoinjector/kelotane = 2,
	/obj/item/reagent_containers/hypospray/autoinjector/antitoxin = 2,
	/obj/item/reagent_containers/hypospray/autoinjector/dexalin = 2
	)

/obj/item/storage/deferred/bandages
	name = "box of bandages"
	desc = "A container packed with gauze, for packing wounds with gauze."
	initial_contents = list(/obj/item/stack/medical/bruise_pack = 6)

obj/item/storage/deferred/ointment
	name = "box of ointment"
	desc = "A container filled with tubes of ointment."
	initial_contents = list(/obj/item/stack/medical/ointment = 6)

//Gear (Emergency supplies), as an "Oh fuck a [insert threat] appeared and absolutely no one is prepared to fight it." response by Lonestar. Alternatively, could probably be used to gear up prospies that manage to lose their gear.
/obj/item/storage/deferred/crate/infantry_rifle
	name = "infantry rifle kit"
	desc = "A (relatively) lightweight crate containing everything to arm a colonist (to the bare minimum.)"
	initial_contents = list(/obj/item/gun/projectile/boltgun/lever,
	/obj/item/ammo_magazine/ammobox/magnum_40 = 2
	) // No magnum rifle speedloaders, just throwing an extra box in there.

obj/item/storage/deferred/crate/infantry_armor
	name = "infantry armor kit"
	desc = "A (relatively) lightweight crate containing everything to armor a colonist (to the bare minimum.)"
	initial_contents = list(/obj/item/clothing/suit/armor/vest,
	/obj/item/clothing/gloves/thick/handmade,
	/obj/item/clothing/shoes/jackboots,
	/obj/item/clothing/head/helmet
	)

/obj/item/storage/deferred/crate/infantry_erifle // Kind of goofy how the most common laser rifle in the galaxy is locked behind S.I. or buying it very late stage Trade beacon DIRECTLY from G.P.
	name = "infantry energy rifle kit"
	desc = "A (relatively) lightweight crate containing everything to arm a colonist. With lasers (to the bare minimum.)"
	initial_contents = list(/obj/item/gun/energy/cog,
	/obj/item/cell/medium = 2 // Leave 'em craving literally anything better
	)

/obj/item/storage/deferred/havelock_box
	name = "havelock personal defense kit"
	desc = "Everything you need to technically be armed."
	initial_contents = list(/obj/item/gun/projectile/revolver/detective,
	/obj/item/ammo_magazine/speed_loader_pistol_35,
	/obj/item/ammo_magazine/speed_loader_pistol_35/rubber,
	/obj/item/ammo_magazine/ammobox/pistol_35,
	/obj/item/ammo_magazine/ammobox/pistol_35/rubber
	)
// Kitchen supply
/obj/item/storage/deferred/kitchen
	name = "galley supply box"
	desc = "A small collection of kitchen essentials"
	initial_contents = list(
		/obj/item/tool/knife = 1,
		/obj/item/tool/knife/butch = 1,
		/obj/item/material/kitchen/rollingpin = 1,
		/obj/item/packageWrap = 1,
		/obj/item/reagent_containers/condiment/saltshaker = 1,
		/obj/item/reagent_containers/condiment/peppermill = 1,
		/obj/item/reagent_containers/condiment/cookingoil = 1,
		/obj/item/reagent_containers/condiment/sugar = 1
	)

// MoeSci supply
/obj/item/storage/deferred/slime
	name = "slime supply box"
	desc = "A slime startup kit"
	initial_contents = list(
		/obj/item/slime_extract/grey = 4,
		/obj/item/extinguisher = 1,
		/obj/item/storage/box/monkeycubes = 1
	)

/obj/item/storage/deferred/xenobotany
	name = "xenobotany supply box"
	desc = "A small collection of interesting seeds"
	initial_contents = list(
		/obj/item/seeds/random = 7
	)

/obj/item/storage/deferred/rnd
	name = "research box"
	desc = "A small collection of intellectual curiosities"
	initial_contents = list(
		/obj/item/pc_part/drive/disk/research_points/rare = 1
	)

// Trapper
/obj/item/storage/deferred/roacheggs
	name = "roach egg box"
	desc = "A carton for eggs of the roach variety"
	icon = 'icons/obj/food.dmi'
	icon_state = "eggbox"
	initial_contents = list(
		/obj/item/roach_egg = 12
	)

// Serb
/obj/item/storage/deferred/serb_rifle
	name = "SA rifle pack"
	desc = "A small collection of SA disks"
	initial_contents = list(
		/obj/item/pc_part/drive/disk/design/guns/sa_kalashnikov = 1,
		/obj/item/pc_part/drive/disk/design/guns/sa_pk = 1
	)
