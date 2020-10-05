/obj/item/weapon/gun/energy/laser
	name = "\"Lightfall\" laser rifle"
	desc = "\"Old Testament\" brand laser carbine. Deadly and radiant, like the ire of God it represents."
	icon = 'icons/obj/guns/energy/laser.dmi'
	icon_state = "laser"
	item_state = "laser"
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/Laser.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEM_SIZE_NORMAL
	force = WEAPON_FORCE_NORMAL
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 8, MATERIAL_SILVER = 5)
	price_tag = 1250
	projectile_type = /obj/item/projectile/beam/midlaser
	gun_tags = list(GUN_LASER, GUN_ENERGY)
	init_firemodes = list(
		WEAPON_NORMAL,
		WEAPON_CHARGE
	)
	twohanded = TRUE

/obj/item/weapon/gun/energy/laser/railgun
	name = "\"Reductor\" rail rifle"
	desc = "\"Artificer's Guild\" brand rail gun. This gun features a sleek and deadly design but it may burn out a battery when used."
	icon = 'icons/obj/guns/energy/railgun.dmi'
	icon_state = "railgun"
	item_state = "railgun"
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/rail.ogg'
	item_charge_meter = TRUE
	w_class = ITEM_SIZE_BULKY
	force = WEAPON_FORCE_PAINFUL
	twohanded = TRUE
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 6, TECH_ENGINEERING = 6)
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_STEEL = 8, MATERIAL_SILVER = 10)
	charge_cost = 2000
	gun_tags = list(GUN_PROJECTILE, GUN_LASER, GUN_ENERGY)
	suitable_cell = /obj/item/weapon/cell/large
	one_hand_penalty = 15 //full sized shotgun level
	fire_delay = 14 //Equivalent to a pump then fire time
	recoil_buildup = 1.5
	damage_multiplier = 0.9
	init_firemodes = list(
		list(mode_name="slug", projectile_type=/obj/item/projectile/bullet/shotgun/railgun, icon="kill"),
		list(mode_name="stun", projectile_type=/obj/item/projectile/bullet/shotgun/beanbag/railgun, icon="stun"),
		list(mode_name="incendiary", projectile_type=/obj/item/projectile/bullet/shotgun/incendiary/railgun, icon="destroy"),
	)
	var/consume_cell = TRUE
	price_tag = 1750

/obj/item/weapon/gun/energy/laser/railgun/consume_next_projectile()
	.=..()
	if(. && consume_cell && cell.empty())
		visible_message(SPAN_WARNING("\The [cell] of \the [src] burns out!"))
		qdel(cell)
		cell = null
		playsound(loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
	return .

/obj/item/weapon/gun/energy/laser/railgun/pistol
	name = "\"Myrmidon\" rail pistol"
	desc = "\"Artificer's Guild\" brand rail pistol. This gun features a sleek and deadly design but it may burn out a battery when used."
	icon = 'icons/obj/guns/energy/railpistol.dmi'
	icon_state = "railpistol"
	item_state = "railpistol"
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/rail.ogg'
	suitable_cell = /obj/item/weapon/cell/medium
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	w_class = ITEM_SIZE_NORMAL
	force = WEAPON_FORCE_NORMAL
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 4, TECH_ENGINEERING = 4)
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_STEEL = 4, MATERIAL_SILVER = 5)
	gun_tags = list(GUN_PROJECTILE, GUN_LASER, GUN_ENERGY)
	fire_delay = 12
	charge_cost = 200
	recoil_buildup = 1
	damage_multiplier = 0.8
	can_dual = 1
	twohanded = FALSE
	init_firemodes = list(
		list(mode_name="slug", projectile_type=/obj/item/projectile/bullet/kurtz/railgun, icon="kill"),
		list(mode_name="stun", projectile_type=/obj/item/projectile/bullet/kurtz/rubber/railgun, icon="stun"),
		list(mode_name="incendiary", projectile_type=/obj/item/projectile/bullet/kurtz/incendiary, icon="destroy"),
	)
	consume_cell = TRUE
	price_tag = 1250

/obj/item/weapon/gun/energy/shrapnel
	name = "\"Shellshock\" scrap rifle"
	desc = "A slapped together junk design made as a copy of the far superior Reductor rail gun. It's projectiles fire slower and it has a wider delay between shots with the same issue of burning batteries out."
	icon = 'icons/obj/guns/energy/energyshotgun.dmi'
	icon_state = "eshotgun"
	item_state = "eshotgun"
	item_charge_meter = TRUE
	w_class = ITEM_SIZE_BULKY
	force = WEAPON_FORCE_PAINFUL
	gun_tags = list(GUN_PROJECTILE, GUN_LASER, GUN_ENERGY)
	twohanded = TRUE
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_STEEL = 8)
	charge_cost = 100
	suitable_cell = /obj/item/weapon/cell/medium
	one_hand_penalty = 15 //full sized shotgun level
	fire_delay = 14 //Equivalent to a pump then fire time
	recoil_buildup = 1.5
	damage_multiplier = 0.8
	fire_sound = 'sound/weapons/energy_shotgun.ogg'
	init_firemodes = list(
		list(mode_name="slug", projectile_type=/obj/item/projectile/bullet/hrifle/railgun, icon="kill"),
		list(mode_name="incendiary", projectile_type=/obj/item/projectile/bullet/lrifle/incendiary, icon="destroy"),
	)
	var/consume_cell = TRUE
	price_tag = 500

/obj/item/weapon/gun/energy/shrapnel/consume_next_projectile()
	.=..()
	if(. && consume_cell && cell.empty())
		visible_message(SPAN_WARNING("\The [cell] of \the [src] burns out!"))
		qdel(cell)
		cell = null
		playsound(loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
	return .

/obj/item/weapon/gun/energy/lasersmg
	name = "Disco Vazer \"Lasblender\""
	desc = "This conversion of the \"Texan\" that enables it to shoot lasers. Unlike in other laser weapons, the process of creating a laser is based on a chain reaction of localized micro-explosions. \
	While this method is charge-effective, it worsens accuracy, and the chain-reaction makes the gun always fire in bursts. A viable choice for those who have lots of batteries and few bullets. \
	Sometimes jokingly called the \"Disco Vazer\"."
	icon = 'icons/obj/guns/energy/lasersmg-1.dmi'
	icon_state = "lasersmg"
	item_state = "lasersmg"
	w_class = ITEM_SIZE_NORMAL
	fire_sound = 'sound/weapons/Laser.ogg'
	suitable_cell = /obj/item/weapon/cell/medium
	can_dual = 1
	projectile_type = /obj/item/projectile/beam/weak/smg
	charge_meter = FALSE
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2)
	slot_flags = SLOT_BELT
	matter = list(MATERIAL_PLASTEEL = 11, MATERIAL_STEEL = 13, MATERIAL_PLASTIC = 2, MATERIAL_SILVER = 1, MATERIAL_GLASS = 2)
	price_tag = 500
	damage_multiplier = 0.5 //makeshift laser
	recoil_buildup = 3
	one_hand_penalty = 4
	init_offset = 7 //makeshift laser
	projectile_type = /obj/item/projectile/beam
	suitable_cell = /obj/item/weapon/cell/medium
	charge_cost = 25 // 4 bursts with a 800m cell
	gun_tags = list(GUN_LASER, GUN_ENERGY)
	init_firemodes = list(
		BURST_8_ROUND,
		FULL_AUTO_400
		)

/obj/item/weapon/gun/energy/lasersmg/alt
	name = "Disco Vazer \"Lasblender\""
	desc = "This conversion of the \"MAC\" that enables it to shoot lasers. Unlike in other laser weapons, the process of creating a laser is based on a chain reaction of localized micro-explosions. \
	While this method is charge-effective, it worsens accuracy, and the chain-reaction makes the gun always fire in bursts. A viable choice for those who have lots of batteries and few bullets. \
	Sometimes jokingly called the \"Disco Vazer\"."

/obj/item/weapon/gun/energy/lasersmg/process_projectile(var/obj/item/projectile/P, mob/living/user, atom/target, var/target_zone, var/params=null)
	projectile_color = pick(list("#FF0000", "#0000FF", "#00FF00", "#FFFF00", "#FF00FF", "#00FFFF", "#FFFFFF", "#000000"))
	..()
	return ..()

/obj/item/weapon/gun/energy/lasersmg/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (cell)
		iconstring += "_mag"
		itemstring += "_mag"


/obj/item/weapon/gun/energy/lasersmg/update_icon()
	overlays.Cut()
	..()
	if(istype(cell, /obj/item/weapon/cell/medium/moebius/nuclear))
		overlays += image(icon, "nuke_cell")

	else if(istype(cell, /obj/item/weapon/cell/medium/moebius))
		overlays += image(icon, "moeb_cell")

	else if(istype(cell, /obj/item/weapon/cell/medium/excelsior))
		overlays += image(icon, "excel_cell")

	else if(istype(cell, /obj/item/weapon/cell/medium))
		overlays += image(icon, "guild_cell")

/obj/item/weapon/gun/energy/laser/mounted
	self_recharge = TRUE
	use_external_power = TRUE
	safety = FALSE
	restrict_safety = TRUE
	damage_multiplier = 0.7
	twohanded = FALSE

/obj/item/weapon/gun/energy/laser/mounted/cyborg
	name = "integrated \"Cog\" lasgun"
	desc = "A Greyson Positronic design, cheap and widely produced. In the distant past - this was the main weapon of low-rank police forces, billions of copies of this gun were made."
	recharge_time = 10 //Time it takes for shots to recharge (in ticks)

/obj/item/weapon/gun/energy/laser/practice
	name = "OT LG \"Lightfall\" - P"
	desc = "A modified version of \"Old Testament\" brand laser carbine, this one fires less concentrated energy bolts, designed for target practice."
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 8, MATERIAL_SILVER = 2)
	price_tag = 500
	projectile_type = /obj/item/projectile/beam/practice

/obj/item/weapon/gun/energy/retro
	name = "\"Cog\" lasgun"
	icon = 'icons/obj/guns/energy/retro.dmi'
	icon_state = "retro"
	item_state = null	//so the human update icon uses the icon_state instead.
	item_charge_meter = TRUE
	desc = "A Greyson Positronic design, cheap and widely produced. In the distant past - this was the main weapon of low-rank police forces, billions of copies of this gun were made. They are ubiquitous."
	fire_sound = 'sound/weapons/Laser.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	matter = list(MATERIAL_STEEL = 12)
	projectile_type = /obj/item/projectile/beam
	fire_delay = 10 //old technology
	price_tag = 1000
	gun_tags = list(GUN_LASER, GUN_ENERGY)
	init_firemodes = list(
		WEAPON_NORMAL,
		WEAPON_CHARGE
	)
	twohanded = TRUE

/obj/item/weapon/gun/energy/captain
	name = "\"Destiny\" energy pistol"
	icon = 'icons/obj/guns/energy/capgun.dmi'
	icon_state = "caplaser"
	item_state = "caplaser"
	item_charge_meter = TRUE
	desc = "This weapon is old, yet still robust and reliable. It's marked with an old Greyson Positronic brand, a distant reminder of what this corporation was, before it fell to ruin."
	force = WEAPON_FORCE_PAINFUL
	fire_sound = 'sound/weapons/Laser.ogg'
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_NORMAL
	can_dual = 1
	projectile_type = /obj/item/projectile/beam
	origin_tech = null
	self_recharge = TRUE
	price_tag = 2250
	init_firemodes = list(
		WEAPON_NORMAL,
		WEAPON_CHARGE
	)
	twohanded = FALSE

/obj/item/weapon/gun/energy/lasercannon
	name = "\"Titanica\" laser cannon"
	desc = "A new design for an energy weapon. The lasing medium is enclosed in a tube lined with uranium-235 and subjected to high neutron flux in a nuclear reactor core. This incredible technology may help YOU achieve high excitation rates with small laser volumes!"
	icon = 'icons/obj/guns/energy/lascannon.dmi'
	icon_state = "lasercannon"
	item_state = "lasercannon"
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/lasercannonfire.ogg'
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BELT|SLOT_BACK
	projectile_type = /obj/item/projectile/beam/heavylaser
	charge_cost = 100
	fire_delay = 20
	matter = list(MATERIAL_STEEL = 25, MATERIAL_SILVER = 4, MATERIAL_URANIUM = 1)
	price_tag = 1500
	one_hand_penalty = 5
	twohanded = TRUE
	init_firemodes = list(
		WEAPON_NORMAL,
		WEAPON_CHARGE
		)

/obj/item/weapon/gun/energy/lasercannon/mounted
	name = "mounted laser cannon"
	self_recharge = TRUE
	use_external_power = TRUE
	damage_multiplier = 0.7 //Mounted cannon deals less do to being a mini-verson
	recharge_time = 10
	safety = FALSE
	restrict_safety = TRUE
	twohanded = FALSE

/obj/item/weapon/gun/energy/laser/mounted/blitz
	name = "SDF LR \"Strahl\""
	desc = "A miniaturized laser rifle, remounted for robotic use only."
	icon_state = "laser_turret"
	damage_multiplier = 0.9
	charge_meter = FALSE
	twohanded = FALSE

/obj/item/weapon/gun/energy/laser/railgun/mounted
	name = "SDF SC \"Schrapnell\""
	desc = "An energy-based railgun, employing a matter fabricator to pull shotgun rounds from thin air and energy before launching them at faster than light speeds."
	icon_state = "shrapnel"
	self_recharge = 1
	use_external_power = 1
	safety = FALSE
	restrict_safety = TRUE
	consume_cell = FALSE
	cell_type = /obj/item/weapon/cell/small/high //Two shots
	twohanded = FALSE
