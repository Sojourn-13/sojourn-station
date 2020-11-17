/obj/item/organ/internal
	var/list/owner_verbs = list()
	layer = ABOVE_LYING_MOB_LAYER

/obj/item/organ/internal/New(mob/living/carbon/human/holder, datum/organ_description/OD)
	..()
	update_icon()

/obj/item/organ/internal/Process()
	..()
	handle_regeneration()

/obj/item/organ/internal/removed_mob()
	owner.internal_organs_by_name -= organ_tag
	owner.internal_organs -= src

	for(var/verb_path in owner_verbs)
		verbs -= verb_path
	..()

/obj/item/organ/internal/replaced(obj/item/organ/external/affected)
	..()
	parent.internal_organs |= src

/obj/item/organ/internal/replaced_mob(mob/living/carbon/human/target)
	..()
	owner.internal_organs |= src
	owner.internal_organs_by_name[organ_tag] = src

	for(var/proc_path in owner_verbs)
		verbs += proc_path

/obj/item/organ/internal/proc/take_internal_damage(amount, var/silent=0)
	if(BP_IS_ROBOTIC(src))
		damage = between(0, src.damage + (amount * 0.8), max_damage)
	else if(BP_IS_ASSISTED(src))
		damage = between(0, src.damage + (amount * 1.2), max_damage) //Assisted organs are more easily damaged.
	else
		damage = between(0, src.damage + amount, max_damage)

	if(!silent && (amount > 5 || prob(10)))
		var/obj/item/organ/external/parent = get_limb()
		if(parent)
			var/degree = ""
			if(is_bruised())
				degree = " a lot"
			if(damage < 5)
				degree = " a bit"
			owner_custom_pain("Something inside your [parent.name] hurts[degree].", amount)

/obj/item/organ/internal/proc/handle_regeneration()
	if(!damage || BP_IS_ROBOTIC(src) || !owner || owner.chem_effects[CE_TOXIN] || owner.is_asystole())
		return
	if(damage < 0.1*max_damage)
		heal_damage(0.1)

/obj/item/organ/internal/is_usable()
	return ..() && !is_broken()

/obj/item/organ/internal/heal_damage(amount, natural = TRUE)
	if (natural && !can_recover())
		return
	if(owner.chem_effects[CE_BLOODCLOT])
		amount *= 1 + owner.chem_effects[CE_BLOODCLOT]
	damage = between(0, damage - round(amount, 0.1), max_damage)

// Is body part open for most surgerical operations?
/obj/item/organ/internal/is_open()
	var/obj/item/organ/external/limb = get_limb()

	if(limb)
		return limb.is_open()
	else
		return TRUE


// Gets a list of surgically treatable conditions
/obj/item/organ/internal/get_conditions()
	var/list/conditions_list = ..()
	var/list/condition

	if(damage > 0)
		if(BP_IS_ROBOTIC(src))
			condition = list(
				"name" = "Damage",
				"fix_name" = "Repair",
				"step" = /datum/surgery_step/robotic/fix_organ,
				"organ" = "\ref[src]"
			)
		elseif(BP_IS_ASSISTED(src))
			condition = list(
				"name" = "Damage"
				"fix_name" = "Fix"
				"step" = /datum/surgery_step/assisted/fix_organ,
				"organ" = "\ref[src]"
			)
		else
			condition = list(
				"name" = "Damage",
				"fix_name" = "Heal",
				"step" = /datum/surgery_step/fix_organ,
				"organ" = "\ref[src]"
			)

		conditions_list.Add(list(condition))

	return conditions_list

// Organ eating
/obj/item/organ/internal/proc/prepare_eat()
	if(BP_IS_ROBOTIC(src))
		return // No eating cybernetic implants!
	var/obj/item/weapon/reagent_containers/food/snacks/organ/S = new
	S.name = name
	S.desc = desc
	S.icon = icon
	S.icon_state = icon_state
	S.w_class = w_class

	return S

/obj/item/organ/internal/attack(mob/living/carbon/M, mob/user)
	if(M == user && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/weapon/reagent_containers/food/snacks/S = prepare_eat()
		if(S)
			H.drop_item()
			H.put_in_active_hand(S)
			S.attack(H, H)
			qdel(src)
	else
		..()
