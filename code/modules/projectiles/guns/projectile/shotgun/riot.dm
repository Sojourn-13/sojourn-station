/obj/item/gun/projectile/automatic/riot_autoshotgun
	name = "\"State\" riot shotgun" //With correct mods this can be better then the pug
	desc = "A Seinemetall Defense GmbH riot auto action shotgun, its uncommonly seen deployed in most police operation due to the success of the \"stolen\" \"Gladstone\" design. \
	This particular shotgun has been redesigned many times, never quite reaching a standard everyone was happy with, with some lauding it as confusing for a shotgun. \
	Holds up to eight 20mm shells in a tube magazine."
	icon = 'icons/obj/guns/projectile/milshotgun.dmi'
	icon_state = "cshotgun"
	item_state = "cshotgun"
	max_shells = 8
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	flags = CONDUCT
	slot_flags = SLOT_BACK
	caliber = CAL_SHOTGUN
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	load_method = SINGLE_CASING
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	handle_casings = EJECT_CASINGS
	fire_sound = 'sound/weapons/guns/fire/shotgunp_fire.ogg'
	bulletinsert_sound 	= 'sound/weapons/guns/interact/shotgun_insert.ogg'
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 10)
	price_tag = 1250
	damage_multiplier = 1.2 //Pug has 0.7 do to its fire normal modes
	recoil_buildup = 13
	one_hand_penalty = 15 //full sized shotgun level
	gun_tags = list(GUN_PROJECTILE, GUN_INTERNAL_MAG)

	init_firemodes = list(
		list(mode_name="semiauto", mode_desc="Shoot once per pull after chambering", burst=1, fire_delay=5, move_delay=null, icon="semi")
		)
	serial_type = "SD GmbH"

/obj/item/gun/projectile/automatic/riot_autoshotgun/robo
	name = "intergrated \"State\" riot shotgun"
	desc = "A Seinemetall Defense GmbH riot auto action shotgun, its uncommonly seen deployed in most police operation due to the success of the \"stolen\" \"Gladstone\" design. \
	This particular shotgun has been redesigned many times, never quite reaching a standard everyone was happy with, with some lauding it as confusing for a shotgun. \
	Holds up to six 20mm shells in a tube magazine."
	icon = 'icons/obj/robot_items.dmi'
	icon_state = "riot_shotgun"
	item_state = "riot_shotgun"
	damage_multiplier = 0.7 //Pug has 0.7 do to its fire normal modes
	recoil_buildup = 0
	one_hand_penalty = 0
	max_shells = 6
	load_method = SINGLE_CASING|SPEEDLOADER //So boxes of ammo work

/obj/item/gun/projectile/automatic/riot_autoshotgun/robo/single_shot
	name = "intergrated single barrel shotgun"
	desc = "A auto ejecting single barrel shotgun for mining borgs to handle pesky critters in the underground."
	icon_state = "miner_shotgun"
	item_state = "miner_shotgun"
	damage_multiplier = 1
	max_shells = 1

/obj/item/gun/projectile/automatic/riot_autoshotgun/operator
	name = "\"Operator\" combat shotgun"
	desc = "The \"Operator\" shotgun appears to be a well designed model of shotgun complete with a polymer grip, holographic sights and a collapsing stock.  \
			Designed by Nadezhda Marshal gunsmiths and surplus parts of the \"Mamba\" series of firearms this shotgun appears to be perfect for both close and medium range engagements."
	icon = 'icons/obj/guns/projectile/operator.dmi'
	icon_state = "operator"
	item_state = "oporator"
	origin_tech = list(TECH_COMBAT = 7, TECH_MATERIAL = 4)
	max_shells = 7
	ammo_type = /obj/item/ammo_casing/shotgun
	matter = list(MATERIAL_PLASTEEL = 25, MATERIAL_PLASTIC = 12)
	price_tag = 1000
	damage_multiplier = 0.8
	penetration_multiplier = 1.0
	zoom_factor = 0.2
	recoil_buildup = 18
	one_hand_penalty = 15 //full sized shotgun level
	folding_stock = TRUE //we can fold are stocks

/obj/item/gun/projectile/automatic/riot_autoshotgun/operator/update_icon()
	..()
	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(!folded)
		iconstring += "_fold"

	if(wielded)
		itemstring += "_doble"


	icon_state = iconstring
	set_item_state(itemstring)