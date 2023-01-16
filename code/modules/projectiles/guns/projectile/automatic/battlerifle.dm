/obj/item/gun/projectile/automatic/omnirifle
	name = "\"Omnirifle\""
	desc = "A standard issue battle rifle issued to SolFed Marines, produced across the galaxy by state arsenals. \
		 A weapon built for versatility and rugged reliability, it fires a variety of utility and specialized munitions. \
		 Chambered in 8.6x70mm, its gaping bore allows virtually any imaginable payload, however the recoil and magazine suffer for it. \
		 Certain munitions are physically demanding for even the strongest users without the aid of power armor or gun platforms. \
		 This example has defaced serial numbers and added electro-penciled rack numbers."
	icon = 'icons/obj/guns/projectile/Omnirifle.dmi'
	icon_state = "omnirifle"
	item_state = "omnirifle"
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_HRIFLE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = SLOT_BACK
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_HRIFLE|MAG_WELL_DRUM
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 10, MATERIAL_GLASS = 5)
	price_tag = 1500
	penetration_multiplier = 1.0
	damage_multiplier = 1.0
	zoom_factors = list(0.4)
	init_recoil = RIFLE_RECOIL(1.0)
	fire_sound = 'sound/weapons/guns/fire/lmg_fire.ogg'
	unload_sound 	= 'sound/weapons/guns/interact/sfrifle_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/sfrifle_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/rifle_boltforward.ogg'
	gun_tags = list(GUN_PROJECTILE, GUN_SCOPE, GUN_MAGWELL)
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/guns/interact/sfrifle_cock.ogg'

	init_firemodes = list(
	FULL_AUTO_200,
	SEMI_AUTO_NODELAY
	)
	serial_type = "Sol Fed"
	wield_delay = 1.6 SECOND
	wield_delay_factor = 0.5 // 50 vig to insta wield , heavy class battle rifle

/obj/item/gun/projectile/automatic/omnirifle/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(ammo_magazine)
		add_overlay("_mag[ammo_magazine.max_ammo]")
	else
		cut_overlays()
		return

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/automatic/omnirifle/Initialize()
	. = ..()
	update_icon()

/obj/item/gun/projectile/automatic/omnirifle/scoped
	name = "\"Longarm\" marksman rifle"
	desc = "A heavy front line designated marksman rifle manufactured by H&S, also known as the M13A2 Special Purpose Rifle in its generic military form. \
		 Either a copy or 'liberated' example, it fires a variety of utility and specialized munitions. \
		 Chambered in 8.6x70mm, its gaping bore allows virtually any imaginable payload, however the recoil and magazine suffer for it. \
		 This example is fitted with an advanced combat sight and limited to semiautomatic and burst modes. \
		 Due to market competition on the Omnirifle platform, H&S allowed for an extra fee specital limited addition custom prints."
	icon = 'icons/obj/guns/projectile/blackguard.dmi'
	icon_state = "sts_blackguard"
	item_state = "sts_blackguard"
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 15, MATERIAL_GLASS = 10)
	mag_well = MAG_WELL_HRIFLE
	price_tag = 2000
	damage_multiplier = 1.2
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/guns/interact/sfrifle_cock.ogg'
	fire_sound = 'sound/weapons/guns/fire/sniper_fire.ogg'
	zoom_factors = list(1)
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL)
	init_recoil = RIFLE_RECOIL(0.7)
	penetration_multiplier = 1.35
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_2_ROUND,
		BURST_3_ROUND
		)
	serial_type = "H&S"

/obj/item/gun/projectile/automatic/omnirifle/rds
	name = "\"Warthog\" advanced rifle"
	desc = "A heavy second-line rifle manufactured by H&S, as well as number of state arsenals. Designed for close range encounters and support fire. \
		 A rifle fashioned for cover fire and cramped environments. Chambered in 8.6x70mm. \
		 Its gaping bore packs a punch, however the recoil is incredibly violent and terrifying. \
		 This one is fitted with a muzzle brake, fore grip, holographic sight, and limited to 3-round bursts, it's almost manageable. Almost."
	icon = 'icons/obj/guns/projectile/Warthog.dmi'
	icon_state = "warthog"
	item_state = "warthog"
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_PLASTIC = 10, MATERIAL_GLASS = 5)
	mag_well = MAG_WELL_HRIFLE|MAG_WELL_DRUM
	price_tag = 1750
	penetration_multiplier = 1.2
	damage_multiplier = 1.1
	init_recoil = RIFLE_RECOIL(0.8)
	zoom_factors = list(0.4)
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		FULL_AUTO_200,
		BURST_3_ROUND
		)
	serial_type = "H&S"
