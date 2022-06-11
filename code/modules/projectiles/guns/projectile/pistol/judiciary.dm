/obj/item/gun/projectile/judiciary
	name = "\"Judiciary\" pistol"
	desc = "A common Nadezhda Marshal issue pistol chambered in .35 Auto. This pistol appears to be the workhorse of Marshals, a near staple found in pictures on nearly any recruiting ad. \
			By the looks of the mag-loading mechanism this firearm is strangely able to take standard, high-cap and drum magazines! Truely a marval of engineering; even.. if it feels unsteady when holding the drum."
	icon_state = "judiciary"
	item_state = "judiciary"
	caliber = CAL_PISTOL
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	matter = list(MATERIAL_PLASTEEL = 12, MATERIAL_PLASTIC = 6)
	price_tag = 800
	fire_sound = 'sound/weapons/guns/fire/pistol_fire.ogg'
	can_dual = TRUE
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_H_PISTOL|MAG_WELL_PISTOL|MAG_WELL_DRUM
	damage_multiplier = 1
	penetration_multiplier = 1.2
	zoom_factor = 0.2
	gun_tags = list(GUN_PROJECTILE, GUN_CALIBRE_35, GUN_SILENCABLE, GUN_MAGWELL)
	init_recoil = HANDGUN_RECOIL(0.8)
	auto_eject = TRUE
	init_firemodes = list(
		SEMI_AUTO_NODELAY
		)
	serial_type = "NM"

/obj/item/gun/projectile/judiciary/update_icon()
	..()
	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "_mag[ammo_magazine.max_ammo]": ""]"
		itemstring += "_full"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	if (silenced)
		iconstring += "_s"
		itemstring += "_s"

	icon_state = iconstring
	set_item_state(itemstring)