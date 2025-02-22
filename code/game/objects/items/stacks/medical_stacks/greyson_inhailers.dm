/obj/item/greyson_inhaler
	name = "GP Tissue-Treatment Inhaler"
	desc = "A strange one-use inhaler that auto ejects the spent case of gasses and nanites. Used to quickly disperse nanites and treat damaged tissue. \
	Works even on robotic limbs and FBPs. \
	While treating brute trauma, it does not inherently stop bleeding."
	icon_state = "inhaler_brute_preview"
	icon = 'icons/obj/stack/medical_big.dmi'
	preloaded_reagents = list("uncap nanites" = 12, "ethanol" = 8, "arectine" = 10, "luminol" = 30 , "sagent" = 1) //Has a lot of stuff
	force = WEAPON_FORCE_HARMLESS
	w_class = ITEM_SIZE_SMALL
	matter = list(MATERIAL_PLASTIC = 5, MATERIAL_GLASS = 5)
	var/use = 2 // Number of times it can be used.
	//MISSLEADING: this value is affectively 2x if are half robotic half human. As it heals 45 damage for flesh and then 45 for metal
	var/heal_per_use = -45 // Amount health this gives when used
	var/heal_type = "brute" //Type of damage it heals

/obj/item/greyson_inhaler/burn
	name = "GP Burn-Treatment Inhaler"
	desc = "A strange one-use inhaler that auto ejects the spent case of gasses and nanites. Used to quickly disperse nanites and treat burnt tissue. \
	Works even on robotic limbs and FBPs. \
	While treating burn damage, it does not salve the wound."
	icon_state = "inhaler_burn_preview"
	heal_type = "burn"

/obj/item/greyson_inhaler/Initialize(mapload)
	..()
	update_icon()

/obj/item/greyson_inhaler/update_icon()
	icon_state = "inhaler_[heal_type]_[use]"

/obj/item/greyson_inhaler/attack(atom/target, mob/user)
	update_icon()
	if(ishuman(target)) // Check if it's an actual mob and not a wall
		var/mob/living/carbon/human/T = target
		var/obj/item/blocked = T.check_mouth_coverage()
		if(blocked)
			to_chat(user, SPAN_WARNING("\The [blocked] is in the way!"))
			return
		if(use)
			if(heal_type == "brute")
				T.adjustBruteLoss(heal_per_use)
			if(heal_type == "burn")
				T.adjustFireLoss(heal_per_use)
			if(heal_type == "mixed")
				T.adjustFireLoss(heal_per_use)
				T.adjustBruteLoss(heal_per_use)
			use--
			update_icon()
			if(target == user)
				user.visible_message(
					SPAN_NOTICE("[user] quickly inhales [src]."),
					SPAN_NOTICE("You quickly use [src], inhaling the plume of nanites.")
				)
			else
				user.visible_message(
						SPAN_NOTICE("[user] raises and uses an [src] on [T]."),
						SPAN_NOTICE("You quickly use [src] letting [T] use a casing.")
					)

			//For robo lims and fpbs, works sightly different
			var/healing_to_do = 0
			var/healing_left = -heal_per_use //We affectively give another +45 healing for robotic lims
			for(var/obj/item/organ/external/robotic/E in T.organs)
				if(!healing_left)
					to_chat(user, SPAN_NOTICE("no healing."))
					break

				if(heal_type == "brute" || heal_type == "mixed")
					if(E.brute_dam >= healing_left)
						healing_to_do = healing_left
					else
						healing_to_do = E.brute_dam
						healing_left -= E.brute_dam
					E.heal_damage(healing_to_do,0,TRUE)

				if(heal_type == "burn" || heal_type == "mixed")
					if(E.burn_dam >= healing_left)
						healing_to_do = healing_left
					else
						healing_to_do = E.burn_dam
						healing_left -= E.burn_dam
					E.heal_damage(0,healing_to_do,TRUE)
				T.UpdateDamageIcon()

			return
		to_chat(user, "The [src.name] has no cases left.")
		return

	//For non-humans
	if(isliving(target))
		var/mob/living/L = target
		if(use)
			if(heal_type == "brute")
				L.adjustBruteLoss(heal_per_use)
			if(heal_type == "burn")
				L.adjustFireLoss(heal_per_use)
			if(heal_type == "mixed")
				L.adjustFireLoss(heal_per_use)
				L.adjustBruteLoss(heal_per_use)
			user.visible_message(
					SPAN_NOTICE("[user] raises and uses an [src] on [L]."),
					SPAN_NOTICE("You quickly use [src] letting [L] use a casing.")
				)
	..()