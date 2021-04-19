/obj/item/weapon/gun/energy/plasma
	name = "\"Dominion\" plasma rifle"
	desc = "A weapon that uses advanced plasma generation technology to emit powerful blasts of energized matter. Due to its complexity and cost, it is rarely seen in use, except by specialists."
	icon = 'icons/obj/guns/energy/pulse.dmi'
	icon_state = "pulse"
	item_state = null	//so the human update icon uses the icon_state instead.
	item_charge_meter = TRUE
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BELT|SLOT_BACK
	force = WEAPON_FORCE_PAINFUL
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 8, MATERIAL_SILVER = 7, MATERIAL_URANIUM = 8)
	price_tag = 2250
	origin_tech = list(TECH_COMBAT = 3, TECH_PLASMA = 2)
	fire_sound = 'sound/weapons/Laser.ogg'
	projectile_type = /obj/item/projectile/beam
	cell_type = /obj/item/weapon/cell/medium
	sel_mode = 2
	charge_cost = 20 //Gives us 40 shots per high medium-sized cell
	recoil_buildup = 0.9 //pulse weapons have a bit more recoil
	one_hand_penalty = 5
	twohanded = TRUE
	damage_multiplier = 0.9
	init_firemodes = list(
		list(mode_name="destroy", projectile_type=/obj/item/projectile/plasma/heavy, fire_sound='sound/weapons/pulse.ogg', fire_delay=14, icon="destroy", projectile_color = "#FFFFFF"),
		list(mode_name="impact", projectile_type=/obj/item/projectile/plasma/impact, fire_sound='sound/effects/supermatter.ogg', fire_delay=25, icon="kill", projectile_color = "#FF0000"),
	)
	gun_tags = list(GUN_ENERGY, GUN_SCOPE)

/obj/item/weapon/gun/energy/plasma/mounted
	self_recharge = TRUE
	use_external_power = TRUE
	safety = FALSE
	twohanded = FALSE
	one_hand_penalty = 0
	damage_multiplier = 0.7


/obj/item/weapon/gun/energy/plasma/mounted/blitz
	name = "SDF PR \"Sprengen\""
	desc = "A miniaturized plasma rifle, remounted for robotic use only."
	icon_state = "plasma_turret"
	charge_meter = FALSE

/obj/item/weapon/gun/energy/plasma/destroyer
	name = "\"Purger\" plasma rifle"
	desc = "A more recent \"Old Testament\" brand plasma rifle, developed in direct response to compete against the highly successful \"Cassad\" design."
	icon = 'icons/obj/guns/energy/destroyer.dmi'
	fire_sound = 'sound/weapons/pulse.ogg'
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 8, MATERIAL_SILVER = 10, MATERIAL_URANIUM = 5)
	sel_mode = 1
	projectile_type = /obj/item/projectile/beam/pulse
	charge_cost = 30 //Gives us 30 shots per high medium-sized cell
	fire_delay = 15
	origin_tech = list(TECH_COMBAT = 4, TECH_PLASMA = 3)
	damage_multiplier = 1
	init_firemodes = list(
		list(mode_name="armor penetrating", projectile_type=/obj/item/projectile/plasma/heavy, fire_sound='sound/weapons/pulse.ogg', fire_delay=15, icon="kill", projectile_color = "#FFFF00"),
		list(mode_name="rapid fire", projectile_type=/obj/item/projectile/plasma, fire_sound='sound/weapons/pulse.ogg', fire_delay=5, icon="destroy", projectile_color = "#FF0000", recoil_buildup=3),
	)

/obj/item/weapon/gun/energy/plasma/martyr // or should it be  Zealot
	name = "\"Martyr\" holdout pistol"
	desc = "An \"New Testament\" weapon that uses advanced biomass-converted blasts of energized matter. It is a disposable holdout side arm, good enough to save you and be recycled."
	icon = 'icons/obj/guns/energy/martyr.dmi'
	icon_state = "martyr"
	suitable_cell = /obj/item/weapon/cell/small    //so if people manage to get the cell out. shouldn't be a huge deal
	item_state = null	//so the human update icon uses the icon_state instead.
	item_charge_meter = TRUE
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_BELT|SLOT_BACK|SLOT_POCKET|SLOT_HOLSTER
	force = WEAPON_FORCE_PAINFUL
	matter = list(MATERIAL_STEEL = 2, "biomatter" = 20)
	disposable = TRUE
	origin_tech = list(TECH_COMBAT = 1, TECH_PLASMA = 1)
	price_tag = 200
	fire_sound = 'sound/weapons/Laser.ogg'
	cell_type = /obj/item/weapon/cell/small //can't recharge this one
	sel_mode = 2
	charge_cost = 12.5 // for 8 shots
	recoil_buildup = 1
	one_hand_penalty = 0
	twohanded = FALSE
	gun_tags = list(GUN_ENERGY)

	init_firemodes = list(
		list(mode_name="Stun", projectile_type=/obj/item/projectile/plasma/stun, fire_sound='sound/weapons/Taser.ogg', fire_delay=2, icon="stun", projectile_color = "#0000FF"),
		list(mode_name="Melt", projectile_type=/obj/item/projectile/plasma/heavy, fire_sound='sound/weapons/pulse.ogg', fire_delay=14, icon="destroy", projectile_color = "#FFFFFF"),
	)