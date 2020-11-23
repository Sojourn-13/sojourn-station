/*
 * The 'fancy' path is for objects like donut boxes that show how many items are in the storage item on the sprite itself
 * .. Sorry for the shitty path name, I couldnt think of a better one.
 *
 * WARNING: var/icon_type is used for both examine text and sprite name. Please look at the procs below and adjust your sprite names accordingly
 *		TODO: Cigarette boxes should be ported to this standard
 *
 * Contains:
 *		Donut Box
 *		Egg Box
 *		Candle Box
 *		Crayon Box
 *		Cigarette Box
 *		MRE containers
 */

/obj/item/weapon/storage/fancy/
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox6"
	name = "donut box"
	max_storage_space = 8
	var/icon_type = "donut"
	matter = list(MATERIAL_BIOMATTER = 1)

/obj/item/weapon/storage/fancy/update_icon(var/itemremoved = 0)
	var/total_contents = src.contents.len - itemremoved
	src.icon_state = "[src.icon_type]box[total_contents]"
	return

/obj/item/weapon/storage/fancy/examine(mob/user)
	if(!..(user, 1))
		return

	if(contents.len <= 0)
		to_chat(user, "There are no [src.icon_type]s left in the box.")
	else if(contents.len == 1)
		to_chat(user, "There is one [src.icon_type] left in the box.")
	else
		to_chat(user, "There are [src.contents.len] [src.icon_type]s in the box.")

	return

/*
 * Egg Box
 */

/obj/item/weapon/storage/fancy/egg_box
	icon = 'icons/obj/food.dmi'
	icon_state = "eggbox"
	icon_type = "egg"
	name = "egg box"
	storage_slots = 12
	can_hold = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/boiledegg
		)

/obj/item/weapon/storage/fancy/egg_box/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(src)

//MRE food
/obj/item/weapon/storage/fancy/mre_cracker
	icon_state = "crackersbox"
	name = "enriched crackers pack"
	storage_slots = 5
	icon_type = "crackers"
	can_hold = list(
		/obj/item/weapon/reagent_containers/food/snacks/mre_cracker
		)

/obj/item/weapon/storage/fancy/mre_cracker/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/weapon/reagent_containers/food/snacks/mre_cracker(src)

/*
 * Candle Box
 */

/obj/item/weapon/storage/fancy/candle_box
	name = "candle pack"
	desc = "A pack of red candles."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candlebox5"
	icon_type = "candle"
	item_state = "candlebox5"
	throwforce = WEAPON_FORCE_HARMLESS
	slot_flags = SLOT_BELT


/obj/item/weapon/storage/fancy/candle_box/populate_contents()
	for(var/i in 1 to 5)
		new /obj/item/weapon/flame/candle(src)

/*
 * Crayon Box
 */

/obj/item/weapon/storage/fancy/crayons
	name = "box of crayons"
	desc = "A box of crayons for all your rune drawing needs."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonbox"
	w_class = ITEM_SIZE_SMALL
	icon_type = "crayon"
	can_hold = list(
		/obj/item/weapon/pen/crayon
	)

/obj/item/weapon/storage/fancy/crayons/populate_contents()
	new /obj/item/weapon/pen/crayon/red(src)
	new /obj/item/weapon/pen/crayon/orange(src)
	new /obj/item/weapon/pen/crayon/yellow(src)
	new /obj/item/weapon/pen/crayon/green(src)
	new /obj/item/weapon/pen/crayon/blue(src)
	new /obj/item/weapon/pen/crayon/purple(src)
	update_icon()

/obj/item/weapon/storage/fancy/crayons/update_icon()
	cut_overlays() //resets list
	add_overlay(image('icons/obj/crayons.dmi',"crayonbox"))
	for(var/obj/item/weapon/pen/crayon/crayon in contents)
		add_overlay(image('icons/obj/crayons.dmi',crayon.colourName))

/obj/item/weapon/storage/fancy/crayons/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/pen/crayon))
		switch(W:colourName)
			if("mime")
				to_chat(usr, "This crayon is too sad to be contained in this box.")
				return
			if("rainbow")
				to_chat(usr, "This crayon is too powerful to be contained in this box.")
				return
	..()

////////////
//CIG PACK//
////////////
/obj/item/weapon/storage/fancy/cigarettes
	name = "\improper Roach Eyes packet"
	desc = "A packet of six Roach Eyes cigarettes. The cheapest brand of smokes on the market favored by the type of people who see roaches of all sizes as often as they smoke."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "RoachEyesCigPacket"
	item_state = "RoachEyesCigPacket"
	w_class = ITEM_SIZE_TINY
	throwforce = WEAPON_FORCE_HARMLESS
	slot_flags = SLOT_BELT
	storage_slots = 6
	can_hold = list(/obj/item/clothing/mask/smokable/cigarette, /obj/item/weapon/flame/lighter)
	icon_type = "cigarette"
	reagent_flags = REFILLABLE | NO_REACT
	var/open = FALSE

/obj/item/weapon/storage/fancy/cigarettes/attack_self(mob/user)
	if(open)
		close_all()
	else
		..()
	update_icon()

/obj/item/weapon/storage/fancy/cigarettes/open(mob/user)
	. = ..()
	open = TRUE

/obj/item/weapon/storage/fancy/cigarettes/close_all()
	. = ..()
	if(contents.len)
		open = FALSE

/obj/item/weapon/storage/fancy/cigarettes/show_to(mob/user)
	. = ..()
	update_icon()

/obj/item/weapon/storage/fancy/cigarettes/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one

/obj/item/weapon/storage/fancy/cigarettes/update_icon()
	icon_state = "[initial(icon_state)][contents.len]"
	return

/obj/item/weapon/storage/fancy/cigarettes/remove_from_storage(obj/item/W as obj, atom/new_location)
	// Don't try to transfer reagents to lighters
	if(istype(W, /obj/item/clothing/mask/smokable/cigarette))
		var/obj/item/clothing/mask/smokable/cigarette/C = W
		reagents.trans_to_obj(C, (reagents.total_volume/contents.len))
	..()

/obj/item/weapon/storage/fancy/cigarettes/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!ismob(M))
		return

	if(M == user && user.targeted_organ == BP_MOUTH)
		// Find ourselves a cig. Note that we could be full of lighters.
		var/obj/item/clothing/mask/smokable/cigarette/cig = locate() in src

		if(!cig)
			to_chat(user, SPAN_NOTICE("Looks like the packet is out of cigarettes."))
			return

		user.equip_to_slot_if_possible(cig, slot_wear_mask)
	else
		..()

/obj/item/weapon/storage/fancy/cigarettes/ishimura
	name = "\improper Ishimura Special packet"
	desc = "A packet of six Ishimura Special cigarettes. A favored and common smoke among researchers and scientists, often considered the more refined choice for the social smoker."
	icon_state = "IshimuraSpecialCigPack"
	item_state = "IshimuraSpecialCigPack"

/obj/item/weapon/storage/fancy/cigarettes/ishimura/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/ishimura(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigarettes/tannhauser
	name = "\improper Tannhauser Gate packet"
	desc = "A packet of six Tannhauser Gate cigarettes. An often overlooked brand of smokes that rarely sells well with anyone who isn't quite old or quite cheap. Tastes like burning rusted metal but survives due to being the number one brand for spacers."
	icon_state = "TannhauserGateCigPacket"
	item_state = "TannhauserGateCigPacket"

/obj/item/weapon/storage/fancy/cigarettes/tannhauser/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/tannhauser(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigarettes/brouzouf
	name = "\improper Brouzouf Message packet"
	desc = "A packet of six Brouzouf Message cigarettes. You gain Brouzouf. Your legs are OK."
	icon_state = "BrouzoufMessageCigPacket"
	item_state = "BrouzoufMessageCigPacket"

/obj/item/weapon/storage/fancy/cigarettes/brouzouf/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/brouzouf(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigarettes/frozen
	name = "\improper Frozen Nova packet"
	desc = "A packet of six Frozen Nova cigarettes. A popular brand for frontier mercenaries and soldiers, often traded commonly by pirates for its deep throat scratching taste."
	icon_state = "FrozenNovaCigPack"
	item_state = "FrozenNovaCigPack"

/obj/item/weapon/storage/fancy/cigarettes/frozen/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/frozen(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigarettes/shodan
	name = "\improper Shodans packet"
	desc = "A packet of six Shodans cigarettes. Smokes often used by those with cybernetic implants in body and brain as its said it relaxes the synapse connections, though it is commonly said that is just marketing speak."
	icon_state = "ShodansCigPacket"
	item_state = "ShodansCigPacket"

/obj/item/weapon/storage/fancy/cigarettes/shodan/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/shodan(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigarettes/toha
	name = "\improper TOHA Heavy Industries packet"
	desc = "A packet of six TOHA Heavy Industries cigarettes. The pack of choice for the engineer, the mechanic, and the technician. A special import as requested by many in the Artificer's Guild with a price to match."
	icon_state = "TOHAHeavyIndustriesCigPacket"
	item_state = "TOHAHeavyIndustriesCigPacket"

/obj/item/weapon/storage/fancy/cigarettes/toha/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/toha(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigarettes/fortress
	name = "\improper Fortress Classic packet"
	desc = "A packet of six Fortress Classic cigarettes. A standard classic pack that many smokers start with, often in the teen years, reasonably priced and well liked."
	icon_state = "cigpacket"
	item_state = "cigpacket"

/obj/item/weapon/storage/fancy/cigarettes/fortress/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/fortress(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigarettes/fortressred
	name = "\improper Fortress RED lights packet"
	desc = "A packet of six Fortress RED light cigarettes. A standard classic pack for the smoker that wants to kick his habit at his own pace. Has a cherry taste."
	icon_state = "Dpacket"
	item_state = "Dpacket"

/obj/item/weapon/storage/fancy/cigarettes/fortressred/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/fortressred(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigarettes/fortressblue
	name = "\improper Fortress BLU menthol packet"
	desc = "A packet of six Fortress BLU menthol cigarettes. A standard classic pack that for the smoker that prefers a cool minty taste."
	icon_state = "Bpacket"
	item_state = "Bpacket"

/obj/item/weapon/storage/fancy/cigarettes/fortressblue/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/fortressblue(src)
	create_reagents(10 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one

/obj/item/weapon/storage/fancy/cigarettes/khi
	name = "\improper Kitsuhana Singularity packet"
	desc = "A packet of six Kitsuhana Singularity cigarettes. A brand made by LSD abusers who overdosed one night and invented these smokes, still finds popularity among retards with no sense of quality. WARNING: Contains the kind of chemicals needed to enjoy this type of brand."
	icon_state = "KhiCigPacket"
	item_state = "KhiCigPacket"

/obj/item/weapon/storage/fancy/cigarettes/khi/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/khi(src)
	create_reagents(20 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one


/obj/item/weapon/storage/fancy/cigar
	name = "cigar case"
	desc = "A case for holding your cigars when you are not smoking them."
	icon_state = "cigarcase"
	item_state = "cigarcase"
	icon = 'icons/obj/cigarettes.dmi'
	w_class = ITEM_SIZE_TINY
	throwforce = WEAPON_FORCE_HARMLESS
	slot_flags = SLOT_BELT
	storage_slots = 7
	can_hold = list(/obj/item/clothing/mask/smokable/cigarette/cigar)
	icon_type = "cigar"
	reagent_flags = REFILLABLE | NO_REACT
	var/open = FALSE

/obj/item/weapon/storage/fancy/cigar/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/clothing/mask/smokable/cigarette/cigar(src)
	create_reagents(15 * storage_slots)
	update_icon()

/obj/item/weapon/storage/fancy/cigar/update_icon()
	if(open)
		icon_state = "[initial(icon_state)][contents.len]"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/weapon/storage/fancy/cigarettes/can_be_inserted(obj/item/W, stop_messages = 0)
	if(!open)
		to_chat(usr, SPAN_WARNING("Open [src] first!"))
		return FALSE
	return ..()

/obj/item/weapon/storage/fancy/cigar/remove_from_storage(obj/item/W as obj, atom/new_location)
		var/obj/item/clothing/mask/smokable/cigarette/cigar/C = W
		if(!istype(C)) return
		reagents.trans_to_obj(C, (reagents.total_volume/contents.len))
		..()

/*
 * Vial Box
 */

/obj/item/weapon/storage/fancy/vials
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox6"
	icon_type = "vial"
	name = "vial storage box"
	storage_slots = 6
	can_hold = list(/obj/item/weapon/reagent_containers/glass/beaker/vial)


/obj/item/weapon/storage/fancy/vials/populate_contents()
	for(var/i in 1 to storage_slots)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(src)

/obj/item/weapon/storage/lockbox/vials
	name = "secure vial storage box"
	desc = "A locked box for keeping things away from children."
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox0"
	item_state = "syringe_kit"
	max_w_class = ITEM_SIZE_SMALL
	can_hold = list(/obj/item/weapon/reagent_containers/glass/beaker/vial)
	max_storage_space = 12 //The sum of the w_classes of all the items in this storage item.
	storage_slots = 6
	req_access = list(access_virology)

/obj/item/weapon/storage/lockbox/vials/Initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/lockbox/vials/update_icon(var/itemremoved = 0)
	var/total_contents = src.contents.len - itemremoved
	src.icon_state = "vialbox[total_contents]"
	src.cut_overlays()
	if (!broken)
		add_overlay(image(icon, src, "led[locked]"))
		if(locked)
			add_overlay(image(icon, src, "cover"))
	else
		add_overlay(image(icon, src, "ledb"))
	return

/obj/item/weapon/storage/lockbox/vials/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	update_icon()

/*
 * Box of Chocolates/Heart Box
 */

/obj/item/weapon/storage/fancy/heartbox
	icon_state = "heartbox"
	name = "box of chocolates"
	icon_type = "chocolate"
	var/startswith = 6
	max_storage_space = 6
	max_w_class = ITEM_SIZE_SMALL
	can_hold = list(
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/white,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/truffle
		)

/obj/item/weapon/storage/fancy/heartbox/New()
	..()
	new /obj/item/weapon/reagent_containers/food/snacks/chocolatepiece(src)
	new /obj/item/weapon/reagent_containers/food/snacks/chocolatepiece(src)
	new /obj/item/weapon/reagent_containers/food/snacks/chocolatepiece(src)
	new /obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/white(src)
	new /obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/white(src)
	new /obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/truffle(src)
	update_icon()

/obj/item/weapon/storage/fancy/heartbox/Initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/fancy/heartbox/update_icon(var/itemremoved = 0)
	if (contents.len == 0)
		icon_state = "heartbox_empty"
