/obj/item/storage/firstaid/greyson
	name = "Greyson Field Abrasion Medical Kit"
	desc = "A Greyson Smart Kit that rejects anything other than Greyson Advanced Treatment Packs. \
	Alt+click to open and close."
	icon_state = "medigel_case_brute_preview"
	var/real_item_state = "medigel_case_brute"
	item_state = "firstaid-surgeon"
	max_storage_space = null
	storage_slots = 9
	max_w_class = ITEM_SIZE_NORMAL
	matter = list(MATERIAL_PLASTIC = 15)
	can_hold = list(
		/obj/item/stack/medical/bruise_pack/greyson
		)
	var/kit_type = "brute"
	var/opened = FALSE

/obj/item/storage/firstaid/greyson/Initialize(mapload)
	..()
	update_icon()

/obj/item/storage/firstaid/greyson/populate_contents()
	if (empty) return
	for(var/i in 1 to 9)
		new /obj/item/stack/medical/bruise_pack/greyson(src)

/obj/item/storage/firstaid/greyson/update_icon()
	..()
	cut_overlays()
	if(opened)
		icon_state = "[initial(real_item_state)]"
		var/kits = 0
		for(kits in 1 to contents.len)
			add_overlay(image(icon, "medigel_overlay_[kits]_[kit_type]"))
			//message_admins("kits = [kits] icon = [icon] overlay = medigel_overlay_[kits]_[kit_type]")
		return
	icon_state = "[initial(real_item_state)]_closed"

/obj/item/storage/firstaid/greyson/open(mob/user)
	if(!opened)
		to_chat(user, SPAN_NOTICE("The lid is closed."))
		return

	. = ..()

/obj/item/storage/firstaid/greyson/verb/quick_open_close()
	set name = "Toggle Lid"
	set category = "Object"
	set src in view(1)

	if(isghost(usr))
		to_chat(usr, SPAN_NOTICE("The lid doesn’t open, no matter what you do."))
		return

	if(can_interact(usr) == 1)	//can't use right click verbs inside bags so only need to check for ablity
		return

	open_close(usr)

/obj/item/storage/firstaid/greyson/AltClick(mob/user)

	var/able = can_interact(user)

	if(able == 1)
		return

	if(able == 2)
		to_chat(user, SPAN_NOTICE("You cannot open the lid of \the [src] while it\'s in a container."))
		return

	open_close(user)

/obj/item/storage/firstaid/greyson/proc/open_close(user)
	close_all()
	if(!opened)
		to_chat(user, SPAN_NOTICE("You close the lid of the [src]."))
		w_class = ITEM_SIZE_TITANIC
		opened = TRUE
	else
		to_chat(user, SPAN_NOTICE("You open the lid of the [src]."))
		w_class = ITEM_SIZE_NORMAL
		opened = FALSE

	playsound(loc, 'sound/weapons/guns/interact/selector.ogg', 100, 1)
	update_icon()

/obj/item/storage/firstaid/greyson/attackby(obj/item/W, mob/user)
	if(!opened)
		to_chat(user, SPAN_NOTICE("You try to access \the [src] but its lid is closed!"))
		return
	. = ..()

/obj/item/storage/firstaid/greyson/can_interact(mob/user, require_adjacent_turf = TRUE, show_message = TRUE)
	if((!ishuman(user) && (loc != user)) || user.stat || user.restrained())
		return 1
	if(istype(loc, /obj/item/storage))
		return 2
	return 0

/obj/item/storage/firstaid/greyson/burn
	name = "Greyson Field Scorch Medical Kit"
	desc = "A Greyson Smart Kit that rejects anything other than Greyson Advanced Burn-Treatment Packs. \
	Alt+click to open and close."
	icon_state = "medigel_case_burn_preview"
	real_item_state = "medigel_case_burn"
	can_hold = list(
		/obj/item/stack/medical/ointment/greyson
		)
	kit_type = "burn"

/obj/item/storage/firstaid/greyson/burn/populate_contents()
	if (empty) return
	for(var/i in 1 to 9)
		new /obj/item/stack/medical/ointment/greyson(src)
