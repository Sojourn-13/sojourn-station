
/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "Used to treat those nasty burns."
	gender = PLURAL
	singular_name = "ointment" //sprites by @LiLJard @Ajajumbo123
	icon_state = "ointment"
	heal_burn = 10
	origin_tech = list(TECH_BIO = 1)
	preloaded_reagents = list("silicon" = 4, "carbon" = 8)
	fancy_icon = TRUE
	disinfectant  = TRUE

/obj/item/stack/medical/ointment/attack(mob/living/carbon/M, mob/living/user)
	if(..())
		return TRUE

	if(amount < 1)
		return

	var/holy_healer = FALSE
	var/holy_healing = FALSE

	if(ishuman(user) && care_about_faith)
		holy_healer = check_faith_of_healer(user)

	if(ishuman(M))
		var/mob/living/carbon/human/H = M

		if(care_about_faith)
			holy_healing = check_faith_of_healing(M)

		var/obj/item/organ/external/affecting = H.get_organ(user.targeted_organ)

		if(!affecting)
			to_chat(user, SPAN_WARNING("What [user.targeted_organ]?"))
			return TRUE

		var/healed_by_faith
		if(care_about_faith && (holy_healer || holy_healing))
			if(holy_healer)
				healed_by_faith += heal_burn
			if(holy_healing)
				healed_by_faith += heal_burn

		if(affecting.open == 0 || always_useful)
			if(affecting.is_salved() && !always_useful)
				to_chat(user, SPAN_WARNING("The wounds on [M]'s [affecting.name] have already been salved."))
				return TRUE
			if(prevent_wasting)
				var/stop = TRUE
				if(affecting.burn_dam && heal_burn)
					stop = FALSE
				if(affecting.brute_dam && heal_brute)
					stop = FALSE
				if(stop)
					to_chat(user, SPAN_WARNING("The wounds on [affecting.name] cant be healed more with [src]."))
					return TRUE
			user.visible_message(
				SPAN_NOTICE("\The [user] starts salving wounds on [M]'s [affecting.name]."),
				SPAN_NOTICE("You start salving the wounds on [M]'s [affecting.name].")
			)
			if(!do_mob(user, M, 10))
				to_chat(user, SPAN_NOTICE("You must stand still to salve wounds."))
				return TRUE
			user.visible_message(
				SPAN_NOTICE("[user] salved wounds on [M]'s [affecting.name]."),
				SPAN_NOTICE("You salved wounds on [M]'s [affecting.name].")
			)
			if(!try_to_save_use(user))
				use(1)
				update_icon()
			affecting.heal_damage(0,heal_burn)
			affecting.salve()
			try_to_pain(M, user)
			return

		if(can_operate(H, user))        //Checks if mob is lying down on table for surgery
			if(do_surgery(H,user,src))
				return
		else
			to_chat(user, SPAN_NOTICE("The [affecting.name] is cut open, you'll need more than a [src]!"))

/obj/item/stack/medical/ointment/non_consumable
	consumable = FALSE
	splittable = FALSE

/obj/item/stack/medical/ointment/blacshield
	stacktype_alt = /obj/item/stack/medical/ointment
	icon_state = "bs_ointment"

/obj/item/stack/medical/ointment/update_icon()
	if(fancy_icon)
		icon_state = "[initial(icon_state)][amount]"
	..()

/obj/item/stack/medical/ointment/handmade
	name = "spider silk salves"
	singular_name = "spider silk salve"
	desc = "Freshly gathered spider webs that you can slather on burns to prevent infection."
	icon_state = "spidergoo"
	natural_remedy = TRUE
	fancy_icon = FALSE

/obj/item/stack/medical/ointment/soteria
	name = "Soteria branded ointment"
	singular_name = "Soteria branded ointment"
	desc = "Used to treat those nasty burns. Unlike regular ointments this one has a Soteria logo on it, its formula massively improved by including toxin-purging sterilizing crystals."
	icon_state = "sr_ointment"
	preloaded_reagents = list("dermaline" = 5, "sterilizine" = 10)
	heal_burn = 25
	amount = 8
	max_amount = 8

/obj/item/stack/medical/ointment/advanced
	name = "advanced burn kit"
	singular_name = "advanced burn kit"
	desc = "An advanced treatment kit for severe burns."
	icon_state = "burnkit"
	heal_burn = 15
	origin_tech = list(TECH_BIO = 2)
	automatic_charge_overlays = TRUE
	consumable = FALSE	// Will the stack disappear entirely once the amount is used up?
	splittable = FALSE	// Is the stack capable of being splitted?
	preloaded_reagents = list("silicon" = 4, "ethanol" = 10, "mercury" = 4)
	w_class = ITEM_SIZE_SMALL
	perk_required = TRUE
	needed_perk = PERK_MEDICAL_EXPERT
	needed_perk_alt = PERK_SURGICAL_MASTER
	bio_requirement = 25
	stacktype_alt = /obj/item/stack/medical/ointment/advanced
	disinfectant  = TRUE
	fancy_icon = FALSE

/obj/item/stack/medical/ointment/advanced/large
	name = "large advanced burn kit"
	singular_name = "large advanced burn kit"
	icon = 'icons/obj/stack/medical_big.dmi'
	amount = 10
	max_amount = 10
	charge_sections = 10
	stacktype_alt = /obj/item/stack/medical/ointment/advanced

/obj/item/stack/medical/ointment/advanced/powder_pouch
	name = "tatonka powder pouch"
	singular_name = "tatonka powder pouch"
	desc = "A small pouch containing the powder of a tatonka horn, a medicine useful for treating burns and disinfecting wounds."
	icon_state = "powder_pouch"
	automatic_charge_overlays = FALSE
	consumable = TRUE
	matter = list(MATERIAL_BIOMATTER = 2.5)
	natural_remedy = TRUE
	fancy_icon = FALSE
	perk_required = TRUE
	needed_perk = PERK_BUTCHER
	bio_requirement = 10 // So simple a tribal can do it, still has a small check to use.
	stacktype_alt = null

/obj/item/stack/medical/ointment/advanced/regenerative_ichor
	name = "regenerative ichor"
	singular_name = "regenerative ichor"
	desc = "An ichor that regenerates dead cells and fights off bacterial infection."
	icon_state = "regenerative_ichor"
	automatic_charge_overlays = FALSE
	consumable = TRUE	// Will the stack disappear entirely once the amount is used up?
	matter = list(MATERIAL_BIOMATTER = 2.5)
	natural_remedy = TRUE
	fancy_icon = FALSE
	perk_required = FALSE
	needed_perk = null
	bio_requirement = 0
	stacktype_alt = null

/obj/item/stack/medical/ointment/advanced/nt
	name = "Absolutism Burnpack"
	singular_name = "Absolutism Burnpack"
	desc = "An advanced treatment kit for severe burns. Created by the will of God and made far easier to use than normal advanced kits."
	icon_state = "nt_burnkit"
	heal_brute = 5
	automatic_charge_overlays = FALSE
	matter = list(MATERIAL_BIOMATTER = 2)
	origin_tech = list(TECH_BIO = 4)
	fancy_icon = TRUE
	w_class = ITEM_SIZE_SMALL
	perk_required = TRUE
	needed_perk = PERK_MEDICAL_EXPERT
	bio_requirement = 15
	stacktype_alt = null
	care_about_faith = TRUE

/obj/item/stack/medical/ointment/advanced/nt/update_icon()
	if(fancy_icon)
		icon_state = "[initial(icon_state)][amount]"
	..()

/obj/item/stack/medical/ointment/greyson
	name = "Greyson Advanced Burn-Treatment Pack" //G(P)ABTP
	singular_name = "Greyson Advanced Burn-Treatment Pack"
	desc = "A packet of nanites with silicon and ethanol that quickly treats burns. \
	Due to GP-programming these nanites are able to be used on already sealed or healed wounds as long as they are able to detect still-present damage. \
	Works on robotic limbs."
	icon_state = "medigel_big_brute"
	icon = 'icons/obj/stack/medical_big.dmi'
	origin_tech = list(TECH_BIO = 8)
	heal_burn = 3 //15 hp per packet, 9 packets in a kit, 135 hp total
	preloaded_reagents = list("uncap nanites" = 4, "ethanol" = 8, "silicon" = 2, "glue" = 26) //Has a lot of stuff
	fancy_icon = TRUE
	amount = 5
	max_amount = 5
	use_timer = 60 //These are compelx things
	always_useful = TRUE
	extra_bulk = 2
	prevent_wasting = TRUE
