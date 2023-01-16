/obj/item/gun/projectile/automatic/nordwind
	name = "\"Nordwind\" precision rifle"
	desc = "A \"Nordwind\" high-end police-grade marksman rifle manufactured by Seinemetall Defense GmbH equiped with a night-vision scope. Primarily used by law enforcement, counter-terror units, and private security. Uses 7.62mm Rifle rounds."
	icon = 'icons/obj/guns/projectile/nordwind.dmi'
	icon_state = "nordwind"
	item_state = "nordwind"
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_RIFLE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	mag_well = MAG_WELL_RIFLE
	auto_eject = 1
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_STEEL = 20, MATERIAL_PLASTIC = 10, MATERIAL_URANIUM = 1)
	price_tag = 2000
	fire_sound = 'sound/weapons/guns/fire/lmg_fire.ogg'
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	unload_sound 	= 'sound/weapons/guns/interact/ltrifle_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/ltrifle_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/ltrifle_cock.ogg'
	zoom_factors = list(0.6)
	init_recoil = RIFLE_RECOIL(1.2)
	extra_damage_mult_scoped = 0.5 //High class gun
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL, GUN_SIGHT)
	see_invisible_gun = SEE_INVISIBLE_NOLIGHTING
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_3_ROUND
		)
	serial_type = "SD GmbH"

	wield_delay = 1.5 SECOND
	wield_delay_factor = 0.4 // 40 vig to insta wield , heavy class rifle

/obj/item/gun/projectile/automatic/nordwind/strelki
	name = "\"Strelki\" precision rifle"
	desc = "A Strelki precision rifle, an inexpensive rifle of desent quality made by Hunt Inc.\
			Its mostly wooden design and its usage of 7.62mm rounds make it the ideal weapon for a hunter tired of a crude boltaction. The frontier's favorite sniper!"
	icon = 'icons/obj/guns/projectile/strelki.dmi'
	icon_state = "strelki"
	item_state = "strelki"
	slot_flags = SLOT_BACK
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_RIFLE
	gun_tags = list(GUN_PROJECTILE)
	matter = list(MATERIAL_PLASTEEL = 10, MATERIAL_STEEL = 10, MATERIAL_WOOD = 10)
	price_tag = 700
	zoom_factors = list(0.6)
	damage_multiplier = 0.9
	extra_damage_mult_scoped = 0.3
	init_recoil = RIFLE_RECOIL(1)
	see_invisible_gun = -1
	auto_eject = FALSE
	init_firemodes = list(
		SEMI_AUTO_NODELAY
		)
	saw_off = TRUE
	sawn = /obj/item/gun/projectile/automatic/nordwind/strelki/sawn
	serial_type = "Hunt Inc"

	wield_delay = 1.3 SECOND
	wield_delay_factor = 0.3 // 30 vig to insta wield , not heavy class but not light

/obj/item/gun/projectile/automatic/nordwind/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "_mag[ammo_magazine.max_ammo]": ""]"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/automatic/nordwind/Initialize()
	. = ..()
	update_icon()

/obj/item/gun/projectile/automatic/nordwind/strelki/sawn
	name = "\"Strelki\" precision rifle"
	desc = "A Strelki precision rifle, an inexpensive rifle of dubious quality made by Hunt Inc.\
			Someone has decided it's a good idea to take off the scope, saw off most of the wood and put a barrel shroud on it? Why in Gods name. ."
	icon = 'icons/obj/guns/projectile/sawnoff/strelki.dmi'
	icon_state = "strelki"
	item_state = "strelki"
	w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BACK|SLOT_BELT
	matter = list(MATERIAL_PLASTEEL = 5, MATERIAL_STEEL = 6, MATERIAL_WOOD = 5)
	price_tag = 450
	zoom_factors = list()
	init_recoil = SMG_RECOIL(2.3)
	damage_multiplier = 0.8
	saw_off = FALSE
	serial_type = "Hunt Inc"

	wield_delay = 0.8 SECOND
	wield_delay_factor = 0.2 // 20 vig to insta wield, sawn
