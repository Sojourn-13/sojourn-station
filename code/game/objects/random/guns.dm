/obj/random/gun_cheap
	name = "random cheap gun"
	icon_state = "gun-grey"
	spawn_nothing_percentage = 10

/obj/random/gun_cheap/item_to_spawn()
	return pickweight(list(/obj/item/gun/projectile/mk58 = 1,\
				/obj/item/gun/projectile/revolver/rev10/rex10 = 2.5,\
				/obj/item/gun/projectile/mk58/wood = 1,\
				/obj/item/gun/projectile/revolver/detective = 3,\
				/obj/item/gun/energy/shrapnel = 4,\
				/obj/item/gun/energy/lasersmg = 0.5,\
				/obj/item/ammo_kit = 3,\
				/obj/item/gun/projectile/giskard = 1.5,\
				/obj/item/gun/projectile/automatic/luger = 1,\
				/obj/item/gun/projectile/boltgun/sa = 3,\
				/obj/item/gun/projectile/shotgun/pump = 0.5,\
				/obj/item/gun/projectile/revolver/sixshot/sawn = 0.5,\
				/obj/item/gun/projectile/shotgun/pump/sawn = 1,\
				/obj/item/gun/projectile/shotgun/pump/obrez = 2,\
				/obj/item/gun/projectile/boltgun/sawn/light = 0.5,\
				/obj/item/gun/projectile/boltgun/sawn/true = 0.5,\
				/obj/item/gun/projectile/boltgun/sawn/sa = 1,\
				/obj/item/gun/projectile/automatic/luger = 1, \
				/obj/item/gun/projectile/automatic/omnirifle/solmarine/shotgunless = 0.5, \
				/obj/item/gun/projectile/olivaw = 2,
				/obj/item/gun_upgrade/barrel/forged = 2))

/obj/random/gun_cheap/low_chance
	name = "low chance random cheap gun"
	icon_state = "gun-grey-low"
	spawn_nothing_percentage = 80


/obj/random/gun_normal
	name = "random normal gun"
	icon_state = "gun-green"
	spawn_nothing_percentage = 10

/obj/random/gun_normal/always_spawn
	name = "random always spawn normal gun"
	spawn_nothing_percentage = 0

/obj/random/gun_normal/item_to_spawn()
	return pickweight(list(/obj/item/gun/projectile/lamia = 0.1,\
				/obj/item/gun/projectile/automatic/texan = 0.5,\
				/obj/item/gun/projectile/lamia/gemini = 0.09,\
				/obj/item/gun/projectile/revolver/rev10/rex10 = 0.5,\
				/obj/item/gun/projectile/revolver/rev10 = 0.3,\
				/obj/item/gun/projectile/basilisk = 0.5,\
				/obj/item/gun/projectile/ladon = 0.5,\
				/obj/item/gun/projectile/automatic/nordwind/strelki = 0.3,\
				/obj/item/gun/projectile/revolver/sixshot = 1,\
				/obj/item/gun/projectile/boltgun/lever = 1.5,\
				/obj/item/gun/projectile/automatic/greasegun = 0.1,\
				/obj/item/gun/projectile/colt = 2,\
				/obj/item/gun/projectile/revolver = 2,\
				/obj/item/gun/projectile/boltgun = 0.5,\
				/obj/item/gun/projectile/boltgun/sa = 2,\
				/obj/item/ammo_kit = 2,
				/obj/item/gun_upgrade/trigger/dangerzone = 1,
				/obj/item/gun_upgrade/trigger/cop_block = 1,
				/obj/item/gun_upgrade/mechanism/overshooter = 1))

/obj/random/gun_normal/low_chance
	name = "low chance random normal gun"
	icon_state = "gun-green-low"
	spawn_nothing_percentage = 80


/obj/random/gun_combat
	name = "random assault weapon"
	icon_state = "gun-green"
	spawn_nothing_percentage = 10

/obj/random/gun_combat/item_to_spawn()
	return pickweight(list(/obj/item/gun/projectile/automatic/greasegun = 1,\
				/obj/item/gun/projectile/automatic/duty = 1,\
				/obj/item/ammo_kit = 0.8,
				/obj/item/gun/projectile/automatic/sts/rifle/sawn = 1,\
				/obj/item/gun/projectile/automatic/omnirifle/solmarine = 1,\
				/obj/item/gun/projectile/automatic/thompson = 0.5,
				/obj/item/gun/projectile/automatic/ak47/sa/sawn = 1,\
				/obj/item/gun/projectile/makarov = 1,\
				/obj/item/gun/projectile/shotgun/pug = 0.5,
				/obj/item/gun/projectile/revolver/hornet = 0.5))

/obj/random/gun_combat/low_chance
	name = "low chance assault weapon"
	icon_state = "gun-green-low"
	spawn_nothing_percentage = 80

/obj/random/gun_fancy
	name = "random fancy gun"
	icon_state = "gun-blue"
	spawn_nothing_percentage = 30

/obj/random/gun_fancy/alawys_spawn
	name = "random always spawn fancy gun"

/obj/random/gun_fancy/item_to_spawn()
	return pickweight(list(/obj/item/gun/projectile/ladon = 1,\
				/obj/item/gun/projectile/revolver/lemant = 1,\
				/obj/item/gun/projectile/basilisk = 2,\
				/obj/item/gun/projectile/automatic/survivalrifle = 1,\
				/obj/item/gun/projectile/revolver/tacticool_revolver = 1,\
				/obj/item/gun/projectile/silenced = 2,\
				/obj/item/gun/projectile/revolver/mistral = 2,\
				/obj/item/gun/projectile/colt/ten = 2,\
				/obj/item/gun/projectile/colt/ten = 1,\
				/obj/item/gun/projectile/automatic/nordwind/strelki = 0.3, \
				/obj/item/gun/projectile/boltgun/lever = 1, \
				/obj/item/gun/projectile/lamia/scoped = 1,\
				/obj/item/gun/projectile/revolver/deckard = 0.4,\
				/obj/item/gun/projectile/makarov = 1.1,\
				/obj/item/gun/energy/lasercannon = 0.5,\
				/obj/item/gun/projectile/boltgun/scout = 0.5,\
				/obj/item/gun/projectile/revolver/rev10/mateba = 0.5))

/obj/random/gun_fancy/low_chance
	name = "low chance fancy gun"
	icon_state = "gun-blue-low"
	spawn_nothing_percentage = 80

/obj/random/gun_energy_cheap
	name = "random cheap energy weapon"
	icon_state = "gun-blue"
	spawn_nothing_percentage = 30

/obj/random/gun_energy_cheap/item_to_spawn()
	return pickweight(list(/obj/item/gun/energy/gun/martin = 2,\
				/obj/item/gun/energy/gun = 2,\
				/obj/item/gun/energy/cog = 1,\
				/obj/item/gun/energy/lasercore = 0.5,\
				/obj/item/gun/energy/firestorm = 0.5,\
				/obj/item/gun/energy/centauri = 0.1))

/obj/random/gun_energy_cheap/low_chance
	name = "low chance random cheap energy weapon"
	icon_state = "gun-blue-low"
	spawn_nothing_percentage = 80


/obj/random/gun_handmade
	name = "random handmade gun weapon"
	icon_state = "gun-black"
	spawn_nothing_percentage = 30

/obj/random/gun_handmade/item_to_spawn()
	return pickweight(list(/obj/item/gun/projectile/revolver/handmade = 1,\
				/obj/item/gun/projectile/boltgun/handmade = 1,\
				/obj/item/gun/projectile/shotgun/slidebarrel = 1,\
				/obj/item/gun/energy/laser/makeshift = 1,\
				/obj/item/gun/energy/lasersmg = 1,\
				/obj/item/gun/projectile/automatic/ak47/makeshift = 1,\
				/obj/item/gun/projectile/automatic/luty = 1))

/obj/random/gun_handmade/willspawn
	name = "will spawn random handmade gun weapon"
	spawn_nothing_percentage = 0
	icon_state = "gun-black-hight"

/obj/random/gun_handmade/low_chance
	name = "low chance random handmade gun weapon"
	icon_state = "gun-black-low"
	spawn_nothing_percentage = 80

/obj/random/gun_shotgun
	name = "random shotgun"
	icon_state = "gun-red"
	spawn_nothing_percentage = 30

/obj/random/gun_shotgun/item_to_spawn()
	return pickweight(list(
				/obj/item/gun/projectile/shotgun/pump = 1,\
				/obj/item/gun/projectile/shotgun/pump/sawn = 2,\
				/obj/item/gun/projectile/shotgun/pump/obrez = 2,\
				/obj/item/gun/projectile/shotgun/bull = 0.3,\
				/obj/item/gun/projectile/shotgun/doublebarrel/sawn = 2,\
				/obj/item/gun/projectile/shotgun/pump/combat/sawn = 1,\
				/obj/item/gun/projectile/shotgun/pug = 0.3,\
				/obj/item/gun/projectile/revolver/sixshot = 0.7))

/obj/random/gun_shotgun/low_chance
	name = "low chance random shotgun"
	icon_state = "gun-red-low"
	spawn_nothing_percentage = 80


//Dungeon based random spawners (use these only in dungeons, not maint)
/obj/random/dungeon_gun_ballistic
	name = "random special ballistic gun"
	icon_state = "gun-red"

/obj/random/dungeon_gun_ballistic/item_to_spawn()
	return pickweight(list(/obj/item/gun/projectile/automatic/pulse_rifle = 2,
				/obj/item/gun/projectile/automatic/sbaw = 0.7, // Too good, needs to be rare.
				/obj/item/gun/projectile/automatic/chaingun = 1,
				/obj/item/gun/projectile/automatic/lmg/pk = 3,
				/obj/item/gun/projectile/automatic/dp = 2,
				/obj/item/gun/projectile/automatic/bastard = 2,
				/obj/item/gun/projectile/automatic/ak47/sa/tac = 1,
				/obj/item/gun/projectile/shotgun/pump/combat = 3,
				/obj/item/gun/projectile/shotgun/pug = 2,
				/obj/item/gun/projectile/gyropistol = 1,
				/obj/item/gun/projectile/automatic/omnirifle/solmarine = 2,
				/obj/item/gun/projectile/automatic/omnirifle = 1,
				/obj/item/gun/projectile/automatic/c20r = 3,
				/obj/item/gun/projectile/revolver/deckard = 2))

/obj/random/dungeon_gun_ballistic/low_chance
	name = "low chance random special ballistic gun"
	icon_state = "gun-red-low"
	spawn_nothing_percentage = 80

/obj/random/dungeon_gun_energy
	name = "random special energy gun"
	icon_state = "gun-red"

/obj/random/dungeon_gun_energy/item_to_spawn()
	return pickweight(list(
				/obj/item/gun/energy/xray = 2,
				/obj/item/gun/energy/sniperrifle = 2,
				/obj/item/gun/energy/laser/railgun = 1,
				/obj/item/gun/energy/laser/railgun/pistol = 1,
				/obj/item/gun/energy/plasma/auretian = 1,
				/obj/item/gun/energy/centurio = 2,
				/obj/item/gun/energy/centauri = 1,
				/obj/item/gun/energy/gun/nuclear = 2,
				/obj/item/gun/energy/plasma/destroyer = 1,
				/obj/item/gun/energy/sunrise = 1))

/obj/random/dungeon_gun_energy/low_chance
	name = "low chance random special energy gun"
	icon_state = "gun-red-low"
	spawn_nothing_percentage = 80


//Gun Mod Spawners
/obj/random/dungeon_gun_mods
	name = "random gun mod"
	icon_state = "gun-red"

/obj/random/dungeon_gun_mods/item_to_spawn()
	return pickweight(list(/obj/item/gun_upgrade/muzzle/silencer = 1,
				/obj/item/gun_upgrade/muzzle/pain_maker = 0.3,
				/obj/item/gun_upgrade/barrel/forged = 1,
				/obj/item/gun_upgrade/barrel/mag_accel = 1,
				/obj/item/gun_upgrade/barrel/overheat = 1,
				/obj/item/gun_upgrade/mechanism/bikehorn = 0.1,
				/obj/item/gun_upgrade/barrel/excruciator = 1,
				/obj/item/gun_upgrade/trigger/dangerzone = 1,
				/obj/item/gun_upgrade/trigger/cop_block = 0.5,
				/obj/item/gun_upgrade/magwell/auto_eject = 0.5,
				/obj/item/gun_upgrade/magwell/auto_eject/no_removal = 0.5,
				/obj/item/gun_upgrade/mechanism/overshooter = 1,
				/obj/item/gun_upgrade/mechanism/weintraub = 1,
				/obj/item/gun_upgrade/mechanism/reverse_loader = 0.5,
				/obj/item/gun_upgrade/mechanism/battery_shunt = 1,
				/obj/item/gun_upgrade/mechanism/overdrive = 1,
				/obj/item/gun_upgrade/trigger/honker = 0.1,
				/obj/item/gun_upgrade/barrel/toxin_coater = 1,
				/obj/item/gun_upgrade/barrel/gauss = 1,
				/obj/item/gun_upgrade/trigger/boom = 0.5,
				/obj/item/gun_upgrade/scope/watchman = 0.7,
				/obj/item/gun_upgrade/scope/killer = 0.7,
				/obj/item/gun_upgrade/underbarrel/bipod = 1,
				/obj/item/gun_upgrade/mechanism/greyson_master_catalyst = 0.01))

/obj/random/dungeon_gun_mods/low_chance
	name = "low chance random gun mod"
	icon_state = "gun-red-low"
	spawn_nothing_percentage = 80

/obj/random/dungeon_gun_mods/voidwolf
	name = "random voidwolf good only gun mod"
	icon_state = "gun-red-low"
	spawn_nothing_percentage = 0

/obj/random/dungeon_gun_mods/voidwolf/item_to_spawn()
	return pickweight(list( // i hate pickweight but fine
		/obj/item/gun_upgrade/barrel/gauss = 1,
		/obj/item/gun_upgrade/scope/killer = 1,
		/obj/item/gun_upgrade/trigger/dangerzone = 1 //only good mods
	))

//Armor Mod Spawners
/obj/random/dungeon_armor_mods
	name = "random armor mod"
	icon_state = "gun-red"
/obj/random/dungeon_armor_mods/item_to_spawn()
	return pickweight(list(/obj/item/tool_upgrade/armor/bomb = 1,
				/obj/item/tool_upgrade/armor/melee = 1,
				/obj/item/tool_upgrade/armor/bullet = 1,
				/obj/item/tool_upgrade/armor/energy = 1))

/obj/random/dungeon_armor_mods/low_chance
	name = "low chance random armor mod"
	icon_state = "gun-red-low"
	spawn_nothing_percentage = 80
