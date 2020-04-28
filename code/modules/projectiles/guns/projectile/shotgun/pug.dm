/obj/item/weapon/gun/projectile/shotgun/pug
	name = "\"Pug\" auto-shotgun"
	desc = "It's magazine-fed shotgun designed for close quarters combat, nicknamed 'Striker' by boarding parties. \
			Robust and reliable design allows you to swap magazines on the go and dump as many shells at your foes as you want... \
			if you could manage recoil, of course. Compatible only with special M12 8-round drum magazines."
	icon = 'icons/obj/guns/projectile/pug.dmi'
	icon_state = "pug"
	w_class = ITEM_SIZE_BULKY
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_SHOTGUN
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	mag_well = MAG_WELL_DRUM
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 10)
	price_tag = 5000
	fire_sound = 'sound/weapons/guns/fire/shotgunp_fire.ogg'
	unload_sound = 'sound/weapons/guns/interact/ltrifle_magout.ogg'
	reload_sound = 'sound/weapons/guns/interact/ltrifle_magin.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ltrifle_cock.ogg'
	damage_multiplier = 0.8
	recoil_buildup = 30
	one_hand_penalty = 20 //automatic shotgun level

				   //while also preserving ability to shoot as fast as you can click and maintain recoil good enough
	firemodes = list(
		FULL_AUTO_400,
		SEMI_AUTO_NODELAY
		)

/obj/item/weapon/gun/projectile/shotgun/pug/update_icon()
	cut_overlays()
	icon_state = "[initial(icon_state)]"
	if(ammo_magazine)
		add_overlay("m12[ammo_magazine.ammo_color]")
	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		add_overlay("slide")
	if(wielded)//I hate this snowflake bullshit but I don't feel like messing with it.
		if(ammo_magazine)
			item_state = wielded_item_state + "_mag"
		else
			item_state = wielded_item_state
	else
		item_state = initial(item_state)

/obj/item/weapon/gun/projectile/shotgun/pug/Initialize()
	. = ..()
	update_icon()