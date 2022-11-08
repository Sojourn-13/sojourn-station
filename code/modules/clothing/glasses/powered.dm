/obj/item/clothing/glasses/powered
	name = "powered goggles"
	desc = "A set of generic powered goggles."
	icon_state = "night"
	item_state = "glasses"
	action_button_name = "Toggle Optical Matrix"
	toggleable = TRUE
	prescription = TRUE
	active = FALSE
	var/tick_cost = 1
	cell = null
	suitable_cell = /obj/item/cell/small
	var/spawn_with_cell = TRUE

/obj/item/clothing/glasses/powered/Initialize()
	. = ..()
	if(!cell && suitable_cell && spawn_with_cell)
		cell = new /obj/item/cell/small(src)

/obj/item/clothing/glasses/powered/Process()
	if(active)
		if(!cell || !cell.checked_use(tick_cost))
			if(ismob(src.loc))
				to_chat(src.loc, SPAN_WARNING("[src] shut down."))
			toggle(ismob(loc) && loc, FALSE)

/obj/item/clothing/glasses/powered/get_cell()
	return cell

/obj/item/clothing/glasses/powered/handle_atom_del(atom/A)
	..()
	if(A == cell)
		cell = null

/obj/item/clothing/glasses/powered/toggle(mob/user, new_state)
	if(new_state)
		if(!cell || !cell.check_charge(tick_cost) && user)
			to_chat(user, SPAN_WARNING("[src] battery is dead or missing."))
			return
	..(user, new_state)

/obj/item/clothing/glasses/powered/MouseDrop(over_object)
	if((src.loc == usr) && istype(over_object, /obj/screen/inventory/hand) && eject_item(cell, usr))
		cell = null

/obj/item/clothing/glasses/powered/attackby(obj/item/C, mob/living/user)
	if(istype(C, suitable_cell) && !cell && insert_item(C, user))
		src.cell = C

/obj/item/clothing/glasses/powered/science
	name = "science goggles"
	desc = "A pair of goggles with a science HUD. These can show you reagents within transparent containers and organoid information."
	icon_state = "purple"
	item_state = "glasses"

	tick_cost = 0.1

/obj/item/clothing/glasses/powered/science/Initialize()
	. = ..()
	screenOverlay = global_hud.science

/obj/item/clothing/glasses/powered/meson
	name = "optical meson scanner"
	desc = "Using meson-spectrum scanning technology, these goggles allow you to see the full physical layout of structures around the wearer."
	icon_state = "meson"
	item_state = "glasses"
	off_state = "demeson"
	vision_flags = SEE_TURFS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	origin_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	matter = list(MATERIAL_PLASTIC = 1, MATERIAL_GLASS = 1)
	price_tag = 250
	darkness_view = 1

	tick_cost = 0.1

/obj/item/clothing/glasses/powered/meson/Initialize()
	. = ..()
	screenOverlay = global_hud.meson

/obj/item/clothing/glasses/powered/night
	name = "night vision goggles"
	desc = "Powered goggles that magnify visible light perceived, allowing you to see better in the dark."
	icon_state = "night"
	item_state = "glasses"
	darkness_view = 7
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	off_state = "denight"
	origin_tech = list(TECH_MAGNET = 2)
	price_tag = 250
	matter = list(MATERIAL_STEEL = 3, MATERIAL_GLASS = 2, MATERIAL_PLASTIC = 5, MATERIAL_URANIUM = 2)
	tick_cost = 0.5 //i.g a basic 100 will last 200 ticks

/obj/item/clothing/glasses/powered/night/Initialize()
	. = ..()
	screenOverlay = global_hud.nvg

/obj/item/clothing/glasses/powered/night/guild
	name = "optimized night vision goggles"
	desc = "Converted from boring mesons, this refined Guild design sports the benefits form the mesons power-saving making these last 10% longer than other NV goggles on the market!"
	icon_state = "guild" // New sprites by Dromkii aka Ezoken#5894 !
	item_state = "guild"
	off_state = "deguild"
	darkness_view = 7
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	origin_tech = list(TECH_MAGNET = 3)
	price_tag = 350
	matter = list(MATERIAL_STEEL = 2, MATERIAL_GLASS = 2, MATERIAL_PLASTEEL = 2, MATERIAL_URANIUM = 1)
	tick_cost = 0.4 //10% more so you have a reason to go to the guild and get these


/obj/item/clothing/glasses/powered/night/guild/crafted
	spawn_with_cell = FALSE
