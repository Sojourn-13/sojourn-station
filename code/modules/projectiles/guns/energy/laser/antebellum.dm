/obj/item/gun/energy/plasma/antebellum
	name = "\"Antebellum\" Blunderbuss lasgun"
	icon = 'icons/obj/guns/energy/antebellum.dmi'
	icon_state = "antebellum"
	item_state = null	//so the human update icon uses the icon_state instead.
	item_charge_meter = TRUE
	desc = "Created by the Numericals and distributed by the Testament in hopes of combatting Excelsior and psionic creatures. \
	The Antebellum is a plasma shotgun that uses only Church-branded cells, consuming them and releasing their contents in a formidable burst of plasma and ionized shrapnel.\
	This one bears a cruciform rosary, for good luck."
	fire_sound = 'sound/weapons/energy/laser_rifle.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEM_SIZE_BULKY
	matter = list(MATERIAL_PLASTEEL = 10, MATERIAL_WOOD = 15, MATERIAL_GLASS = 5, MATERIAL_SILVER = 3, MATERIAL_GOLD = 2, MATERIAL_BIOMATTER = 30)
	suitable_cell = /obj/item/cell/medium/neotheology
	projectile_type = /obj/item/projectile/plasma/light
	fire_delay = 10
	charge_cost = 125 //10 shots with basic 15 with level 2
	init_recoil = HANDGUN_RECOIL(1)
	price_tag = 900
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	init_firemodes = list(
		list(mode_name="rapid fire", mode_desc="Light rapid plasma bolts", projectile_type=/obj/item/projectile/plasma/light, fire_sound='sound/weapons/energy/Taser4.ogg', fire_delay=8, icon="stun", projectile_color = "#00FFFF"),
		list(mode_name="grenade", mode_desc="fires a frag biomatter-shell", projectile_type=/obj/item/projectile/bullet/grenade/frag/nt, charge_cost=30000, icon="grenade"),
	)
	twohanded = TRUE
	var/consume_cell = TRUE
	price_tag = 2250
	serial_type = "Absolute"

/obj/item/gun/energy/plasma/antebellum/consume_next_projectile()
	if(!cell) return null
	if(!ispath(projectile_type)) return null
	if(consume_cell && !cell.checked_use(charge_cost))
		visible_message(SPAN_WARNING("\The [cell] of \the [src] burns out!"))
		qdel(cell)
		cell = null
		playsound(loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		return new projectile_type(src)
	else if(!consume_cell && !cell.checked_use(charge_cost))
		return null
	else
		return new projectile_type(src)
