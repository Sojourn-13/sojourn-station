/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'icons/obj/stack/items.dmi'
	amount = 5
	max_amount = 5
	w_class = ITEM_SIZE_TINY
	throw_speed = 4
	throw_range = 20
	var/heal_brute = 0
	var/heal_burn = 0
	price_tag = 10
	matter = list(MATERIAL_BIOMATTER = 5)
	var/automatic_charge_overlays = FALSE	//Do we handle over-lays with base update_icon()? | Stolen from TG egun code
	var/charge_sections = 5		// How many indicator blips are there?
	var/charge_x_offset = 2		//The spacing between each charge indicator. Should be 2 to leave a 1px gap between each blip.
	var/natural_remedy = FALSE
	var/perk_required = FALSE
	var/needed_perk = null
	var/needed_perk_alt = null
	var/bio_requirement = 0
	var/disinfectant  = FALSE
	//checks if the person using **and** getting the healing is church
	var/care_about_faith = FALSE
	var/bounce_faith_healer_amount = 5

	var/fancy_icon = FALSE //This var is for mulitable icon states that DONT relie on a overlay
	var/always_useful = FALSE
	var/use_timer = 30
	var/prevent_wasting = FALSE

/obj/item/stack/medical/proc/try_to_save_use(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(prob(10 + H.stats.getStat(STAT_BIO)) && H.stats.getPerk(PERK_MEDICAL_EXPERT))
			to_chat(H, SPAN_NOTICE("You have managed to waste less [src]."))
			return TRUE
		if(prob(10 + H.stats.getStat(STAT_BIO)) && H.stats.getPerk(PERK_MASTER_HERBALIST) && natural_remedy == TRUE)
			to_chat(H, SPAN_NOTICE("You have managed to waste less [src]."))
			return TRUE
	return FALSE

/obj/item/stack/medical/proc/try_to_pain(mob/living/carbon/M, mob/living/user)
	//log_debug("try_to_pain 0, I have started")
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/external/affecting = H.get_organ(user.targeted_organ)
		//log_debug("try_to_pain 1, H = [H], user = [user], affecting [affecting]")

		if(user && user.stats.getStat(STAT_BIO) > STAT_LEVEL_ADEPT)
			//log_debug("try_to_pain 1.5,  biocheck passed")
			return

		if(prob(affecting.get_damage() - user.stats.getStat(STAT_BIO)))
			var/pain = rand(min(30,affecting.get_damage()), max(affecting.get_damage() + 30,60) - user.stats.getStat(STAT_BIO))
			H.pain(affecting, pain)
			//log_debug("try_to_pain 2,  PAIN [pain]")

			if(user != H)
			//	log_debug("try_to_pain 3,  user =/= H")
				to_chat(H, "<span class='[pain > 50 ? "danger" : "warning"]'>\The [user]'s amateur actions caused you [pain > 50 ? "a lot of " : ""]pain.</span>")
				to_chat(user, SPAN_WARNING("Your amateur actions caused [H] [pain > 50 ? "a lot of " : ""]pain."))

			//	log_debug("try_to_pain 3.,  I am ending early")
				return

			//log_debug("try_to_pain 4,  user is H")
			to_chat(user, "<span class='[pain > 50 ? "danger" : "warning"]'>Your amateur actions caused you [pain > 50 ? "a lot of " : ""]pain.</span>")

	//log_debug("try_to_pain 5,  I have ended")

/obj/item/stack/medical/attack(mob/living/M, mob/living/user)
	..()
	var/types = M.get_classification()
	if (!(types & CLASSIFICATION_ORGANIC))
		to_chat(user, SPAN_WARNING("\The [src] cannot be applied to [M]!"))
		return TRUE

	if(!(ishuman(user) || issilicon(user)))
		to_chat(user, SPAN_WARNING("You don't have the dexterity to do this!"))
		return TRUE

	//log_debug("medical 0, I have started")
	if(ishuman(M))
		if(perk_required && (!user.stats.getPerk(needed_perk) && !user.stats.getPerk(needed_perk_alt)))
			if(user.stats.getStat(STAT_BIO) < bio_requirement)
				to_chat(user, SPAN_WARNING("You lack the biological skill or training to figure out how to properly use this!"))
				return TRUE

		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/affecting = H.get_organ(user.targeted_organ)
		if(!affecting)
			to_chat(user, SPAN_WARNING("What [user.targeted_organ]?"))
			return TRUE

		if(affecting.organ_tag == BP_HEAD)
			if(H.head && istype(H.head,/obj/item/clothing/head/helmet/space))
				to_chat(user, SPAN_WARNING("You can't apply [src] through [H.head]!"))
				return TRUE
		else
			if(H.wear_suit && istype(H.wear_suit,/obj/item/clothing/suit/space))
				to_chat(user, SPAN_WARNING("You can't apply [src] through [H.wear_suit]!"))
				return TRUE

	//	log_debug("medical 3, halfway")
		if(BP_IS_ROBOTIC(affecting))
			// user is clueless
			if(BP_IS_LIFELIKE(affecting) && user.stats.getStat(STAT_BIO) < STAT_LEVEL_BASIC)
				user.visible_message( \
				SPAN_NOTICE("[user] starts applying [src] to [M]."), \
				SPAN_NOTICE("You start applying [src] to [M].") \
				)
				if(do_after(user, use_timer, M))
					to_chat(user, SPAN_NOTICE("You must stand still to salve wounds."))
					return TRUE
				if(!try_to_save_use(user))
					use(1)
					update_icon()
				user.visible_message( \
					SPAN_NOTICE("[M] starts has been applied with [src] by [user]."), \
					SPAN_NOTICE("You apply [src] to [M].") \
				)
				M.updatehealth()
				return TRUE

			if(!always_useful)
				to_chat(user, SPAN_WARNING("This isn't useful at all on a robotic limb."))
				return TRUE

		if(disinfectant)
			for(var/datum/wound/W in affecting.wounds)
				W.disinfect()

		H.UpdateDamageIcon()

	//	log_debug("medical 2, ended")

	else //Prob not needed but I dont quite know
	//	log_debug("medical 3, started for simple mods")

		if (!M.bruteloss && !M.fireloss)
			to_chat(user, "<span class='notice'> [M] seems healthy, there are no wounds to treat! </span>")
			return TRUE

		user.visible_message( \
				SPAN_NOTICE("[user] starts applying [src] to [M]."), \
				SPAN_NOTICE("You start applying [src] to [M].") \
			)
		var/extra_healing = grabbed_medical_skill()
		if (do_after(user, use_timer, M))
			M.heal_organ_damage((heal_brute + extra_healing), (heal_burn + extra_healing))
			if(!try_to_save_use(user))
				use(1)
			user.visible_message( \
				SPAN_NOTICE("[M] starts has been applied with [src] by [user]."), \
				SPAN_NOTICE("You apply [src] to [M].") \
			)
		M.updatehealth()

/obj/item/stack/medical/proc/grabbed_medical_skill(mob/living/carbon/user)
//note were returning numbers not TRUE/FALSE for clarification
	if(!(ishuman(user) || issilicon(user)))
		return 1

	var/med_skill = user.stats.getStat(STAT_BIO)
	if(med_skill <= 0)
		return 0

	//100 bio = +50!
	//50 (common shockingly) = +25
	//25 = +13/12
	//ect
	med_skill *= 1.5
	med_skill = round(med_skill, 1)
	return med_skill


/obj/item/stack/medical/proc/check_faith_of_healing(mob/living/carbon/human/user, obj/item/implant/core_implant/C)
	var/obj/item/implant/core_implant/cruciform/CI = user.get_core_implant(/obj/item/implant/core_implant/cruciform)
//	log_debug("check_faith_of_healing 0, I have started user = [user]")
	if(!CI || !CI.active || !CI.wearer)
		return FALSE
//	log_debug("check_faith_of_healing 1, ended = [user]")
	return TRUE

/obj/item/stack/medical/proc/check_faith_of_healer(mob/living/carbon/human/user, obj/item/implant/core_implant/C)
	var/obj/item/implant/core_implant/cruciform/CI = user.get_core_implant(/obj/item/implant/core_implant/cruciform)

//	log_debug("check_faith_of_healer 0, I have started user = [user]")
	if(!CI || !CI.active || !CI.wearer)
		return FALSE
//	log_debug("check_faith_of_healer 1, ended = [user]")
	return TRUE

/obj/item/stack/medical/proc/check_for_healer_plus(mob/living/carbon/human/user, obj/item/implant/core_implant/C)
	var/obj/item/implant/core_implant/cruciform/CI = user.get_core_implant(/obj/item/implant/core_implant/cruciform)

//	log_debug("check_faith_of_healer 0, I have started user = [user]")
	if(!CI || !CI.active || !CI.wearer)
		return FALSE

	if(CI.path == "tess" || CI.path == "omni")
		return TRUE

	if (CI.get_module(CRUCIFORM_PRIME))
		return TRUE

	if (CI.get_module(CRUCIFORM_INQUISITOR))
		return TRUE

	return TRUE


/obj/item/stack/medical/update_icon()
	if(QDELETED(src)) //Checks if the item has been deleted
		return	//If it has, do nothing
	..()
	if(!automatic_charge_overlays)	//Checks if the item has this feature enabled
		return	//If it does not, do nothing
	var/ratio = CEILING(CLAMP(amount / max_amount, 0, 1) * charge_sections, 1)
	cut_overlays()
	var/iconState = "[icon_state]_charge"
	if(!amount)	//Checks if there are still charges left in the item
		return //If it does not, do nothing, as the over-lays have been cut before this already.
	else
		var/mutable_appearance/charge_overlay = mutable_appearance(icon, iconState)
		for(var/i = ratio, i >= 1, i--)
			charge_overlay.pixel_x = charge_x_offset * (i - 1)
			add_overlay(charge_overlay)

/obj/item/stack/medical/Initialize()
	. = ..()
	update_icon()
