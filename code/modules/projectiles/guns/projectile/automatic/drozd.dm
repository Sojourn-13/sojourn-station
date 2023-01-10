/obj/item/gun/projectile/automatic/drozd
	name = "Excelsior \"Drozd\" SMG"
	desc = "An excellent fully automatic submachinegun. Famous for it's perfomance in close quarters and used by communists groups such as the excelsior. Uses 10mm rounds."
	icon = 'icons/obj/guns/projectile/drozd.dmi'
	icon_state = "drozd"
	item_state = "drozd"
	excelsior = TRUE
	w_class = ITEM_SIZE_NORMAL
	can_dual = TRUE
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_MAGNUM
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_PISTOL|MAG_WELL_SMG
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_PLASTIC = 3)
	price_tag = 800
	damage_multiplier = 0.95
	init_recoil = SMG_RECOIL(0.4)
	twohanded = FALSE
	gun_tags = list(GUN_PROJECTILE, GUN_CALIBRE_9MM, GUN_MAGWELL)
	init_firemodes = list(
		FULL_AUTO_300_NOLOSS,
		SEMI_AUTO_NODELAY
		)
	serial_type = "EXC"

	wield_delay = 0.5 SECOND
	wield_delay_factor = 0.1 // 10 vig

/obj/item/gun/projectile/automatic/drozd/NM_colony
	name = "\"Kompleks\" SMG"
	desc = "An excellent fully automatic submachinegun. Famous for it's perfomance in close quarters. Uses 9mm rounds."
	icon = 'icons/obj/guns/projectile/drozd.dmi'
	excelsior = FALSE
	origin_tech = list(TECH_COMBAT = 4)
	serial_type = "NM"

/obj/item/gun/projectile/automatic/drozd/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "_mag[ammo_magazine.max_ammo]": ""]"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	if (silenced)
		iconstring += "_s"
		itemstring += "_s"

	icon_state = iconstring
	item_state = itemstring
