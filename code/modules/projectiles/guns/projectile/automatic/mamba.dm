////////////////////////
//.257 Mamba, Standard//
////////////////////////
/obj/item/gun/projectile/automatic/mamba
	name = "\"Mamba\" carbine"
	desc = "Produced cheaply, versatile and made for mass usage are all traits of the .257 \"Mamba\" carbine. Made by Nadezhda Marshal gunsmiths to be used in both close and mid-range combat the Mamba sports a folding adjustable stock and a holographic sight."
	icon_state = "mamba"
	item_state = "mamba"
	icon = 'icons/obj/guns/projectile/mamba.dmi'
	fire_sound = 'sound/weapons/guns/fire/sfrifle_fire.ogg'
	w_class = ITEM_SIZE_BULKY
	slot_flags = SLOT_BACK
	caliber = CAL_LRIFLE
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_STANMAG
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_PLASTIC = 10)
	damage_multiplier = 1.0
	penetration_multiplier = 1.0
	zoom_factor = 0.4
	recoil_buildup = 10
	folding_stock = TRUE
	can_dual = FALSE //please god please please NO MORE NO MORE GOD, PLEASE
	gun_tags = list(GUN_PROJECTILE, GUN_SILENCABLE, GUN_MAGWELL, GUN_SIGHT)
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_2_ROUND,
		FULL_AUTO_400
		)
	serial_type = "NM"

/obj/item/gun/projectile/automatic/mamba/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(!folded)
		iconstring += "_stock"

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "_mag[ammo_magazine.max_ammo]": ""]"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	if(wielded)
		itemstring += "_doble"

	if (silenced)
		iconstring += "_s"
		itemstring += "_s"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/automatic/mamba/Initialize()
	. = ..()
	update_icon()

//////////////////
//.257 Viper DMR//
//////////////////
/obj/item/gun/projectile/automatic/mamba/viper
	name = "\"Viper\" DMR"
	desc = "A variant of the Nadezhda Marshal .257 \"Mamba\" carbine, the \"Viper\" is sports an adjustable recoil compensating stock, a longer barrel and an integrated smart-scope. Perfect for both medium and long range engagements."
	icon_state = "viper"
	item_state = "viper"
	matter = list(MATERIAL_PLASTEEL = 17, MATERIAL_PLASTIC = 9)
	damage_multiplier = 1.2
	penetration_multiplier = 1.2
	extra_damage_mult_scoped = 0.2
	zoom_factor = 0.8
	recoil_buildup = 6
	folding_stock = FALSE
	init_firemodes = list(
		SEMI_AUTO_NODELAY
		)

/////////////////////////////////
//7.5 Copperhead w/ grenade launcher//
/////////////////////////////////
/obj/item/gun/projectile/automatic/mamba/copperhead
	name = "\"Copperhead\" battle rifle"
	desc = "The \"Copperhead\" rifle appears to be a design based off the Nadezhda Marshal's \"Mamba\" carbine, chambered in 7.5 and sporting a carry handle the Copperhead is intended both as a squad support weapon and as a battle rifle, sporting a recoil compensating stock as well as an underbarrel grenade launcher to ensure both uses."
	icon_state = "copperhead"
	item_state = "copperhead"
	icon = 'icons/obj/guns/projectile/copperhead.dmi'
	fire_sound = 'sound/weapons/guns/fire/batrifle_fire.ogg'
	w_class = ITEM_SIZE_BULKY
	slot_flags = SLOT_BACK
	caliber = CAL_RIFLE
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_RIFLE
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_PLASTIC = 10)
	damage_multiplier = 1.2
	penetration_multiplier = 1.1
	zoom_factor = 0.4
	recoil_buildup = 6
	folding_stock = FALSE
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		FULL_AUTO_400,
		list(mode_name="fire 40mm grenade", mode_desc="Shoot the built in underbarrel grenade launcher",  burst=1, fire_delay=null, move_delay=null,  icon="grenade", use_launcher=1)
		)

	var/obj/item/gun/projectile/underslung/launcher

/obj/item/gun/projectile/automatic/mamba/copperhead/Initialize()
	. = ..()
	launcher = new(src)

/obj/item/gun/projectile/automatic/mamba/copperhead/attackby(obj/item/I, mob/user)
	if((istype(I, /obj/item/ammo_casing/grenade)))
		launcher.load_ammo(I, user)
	else
		..()

/obj/item/gun/projectile/automatic/mamba/copperhead/attack_hand(mob/user)
	var/datum/firemode/cur_mode = firemodes[sel_mode]

	if(user.get_inactive_hand() == src && cur_mode.settings["use_launcher"])
		launcher.unload_ammo(user)
	else
		..()

/obj/item/gun/projectile/automatic/mamba/copperhead/Fire(atom/target, mob/living/user, params, pointblank=0, reflex=0)
	var/datum/firemode/cur_mode = firemodes[sel_mode]

	if(cur_mode.settings["use_launcher"])
		launcher.Fire(target, user, params, pointblank, reflex)
		if(!launcher.chambered)
			switch_firemodes() //switch back automatically
	else
		..()

/obj/item/gun/projectile/automatic/mamba/copperhead/Initialize()
	. = ..()
	update_icon()


/obj/item/gun/projectile/automatic/mamba/copperhead/examine(mob/user)
	..()
	if(launcher.loaded.len)
		to_chat(user, "\The [launcher] has \a [launcher.chambered] loaded.")
	else
		to_chat(user, "\The [launcher] is empty.")

//////////////
//7.5 Python//
//////////////
/obj/item/gun/projectile/automatic/mamba/copperhead/python
	name = "\"Python\" heavy sniper"
	desc = "A fine work of the Nadezhda Marshal gunsmiths is the Python, a heavy rifle with a state of the art smart scope displaying wind speeds, built in range finding, nightvision capability, and an internal stabilization system. Chambered in 7.5 for stability, the normally mediocre round punches above its weight to compete with larger caliber .408 rifles."
	icon_state = "python"
	item_state = "python"
	icon = 'icons/obj/guns/projectile/python.dmi'
	fire_sound = 'sound/weapons/guns/fire/sniper_fire.ogg'
	w_class = ITEM_SIZE_HUGE
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 12)
	fire_delay = 15
	damage_multiplier = 1.2
	penetration_multiplier = 1.4
	zoom_factor = 1.2
	extra_damage_mult_scoped = 0.4
	recoil_buildup = 12
	see_invisible_gun = SEE_INVISIBLE_NOLIGHTING
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL, GUN_SIGHT)
	init_firemodes = list(
		list(mode_name="semi-automatic", mode_desc = "A semi-automatic firemode.", mode_type = /datum/firemode/automatic, fire_delay=15, icon="auto"
		))

/obj/item/gun/projectile/automatic/mamba/copperhead/python/Initialize()
	. = ..()