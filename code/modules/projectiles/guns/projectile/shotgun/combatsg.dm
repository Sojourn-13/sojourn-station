/obj/item/gun/projectile/shotgun/pump/combat
	name = "\"Regulator\" combat shotgun"
	desc = "Designed for close quarters combat, the Regulator is widely regarded as a weapon of choice for protecting borders. \
			One of the only decent ballistic weapons made by the Old Testament. Can hold up to 6+1 20mm shells in its tube magazine."
	icon = 'icons/obj/guns/projectile/cshotgun.dmi'
	icon_state = "cshotgun"
	item_state = "cshotgun"
	caliber = CAL_SHOTGUN
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	max_shells = 6 //less ammo and regular recoil
	ammo_type = /obj/item/ammo_casing/shotgun
	fire_sound = 'sound/weapons/guns/fire/regulator.ogg'
	matter = list(MATERIAL_PLASTEEL = 25, MATERIAL_PLASTIC = 12)
	price_tag = 1250
	damage_multiplier = 1.2
	penetration_multiplier = 1
	init_recoil = RIFLE_RECOIL(1.2)
	saw_off = TRUE
	sawn = /obj/item/gun/projectile/shotgun/pump/combat/sawn
	serial_type = "Absolute"

	wield_delay = 1 SECOND
	wield_delay_factor = 0.4 // 40 vig

/obj/item/gun/projectile/shotgun/pump/combat/sawn
	name = "\"Regulator\" stakeout shotgun"
	desc = "Designed for close encounters, the Regulator is widely regarded as a weapon of choice for protecting against boarders. \
	Without its stock, it's much more compact, but much harder to use. Can hold up to 6+1 20mm shells in its tube magazine."
	icon = 'icons/obj/guns/projectile/sawnoff/cshotgun.dmi'
	icon_state = "short"
	item_state = "short"
	w_class = ITEM_SIZE_BULKY
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 10)
	price_tag = 1000
	init_recoil = RIFLE_RECOIL(2.8)
	damage_multiplier = 0.9
	fire_delay = 12
	saw_off = FALSE

	wield_delay = 0.7 SECOND
	wield_delay_factor = 0.3 // 30 vig
