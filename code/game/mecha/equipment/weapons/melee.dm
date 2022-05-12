/obj/item/mecha_parts/mecha_equipment/melee_weapon
	name = "mecha melee weapon"
	range = MECHA_MELEE
	origin_tech = list(TECH_MATERIAL = 3, TECH_COMBAT = 3)
	matter = list(MATERIAL_STEEL = 15)
	equip_cooldown = 15
	energy_drain = 10
	var/dam_force = 20
	required_type = /obj/mecha


/obj/item/mecha_parts/mecha_equipment/melee_weapon/sword
	name = "mech sword"
	desc = "A huge sword designed to be wielded by an exosuit."
	icon_state = "mech_sword"
	sharp = TRUE
	edge = TRUE
	tool_qualities = list(QUALITY_CUTTING = 35, QUALITY_SAWING = 20) // It's a literal mech sized blade, what did you expect?
	armor_penetration = ARMOR_PEN_DEEP
	tructure_damage_factor = STRUCTURE_DAMAGE_HEAVY
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/icon/melee_overlay
	dam_force = 40 // Big sword make big boo boo - R4d6


/obj/item/mecha_parts/mecha_equipment/melee_weapon/shockmaul
	name = "mech shock maul"
	desc = "A massive, plasteel maul designed to be wielded by an exosuit"
	icon_state = "mech_maul"
	hitsound = 'sound/weapons/Egloves.ogg'
	var/icon/melee_overlay


/obj/item/mecha_parts/mecha_equipment/melee_weapon/sword/attach(obj/mecha/M as obj)
	..()
	if(istype(M, /obj/mecha/combat/durand))
		melee_overlay = new(src.icon, icon_state = "durand_mech_sword")
		M.add_overlay(melee_overlay)
	else if(istype(M, /obj/mecha/combat/gygax))
		melee_overlay = new(src.icon, icon_state = "gygax_mech_sword")
		M.add_overlay(melee_overlay)
	return
