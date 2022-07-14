/datum/stat_modifier/mob/living/carbon/superior_animal

	var/armor_adjustment = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 0,
		agony = 0
	)

	var/flash_resistances_increment
	var/flash_resistances_mult
	var/flash_resistances_zeroth = 0.5

	var/armor_penetration_increment
	var/armor_penetration_mult
	var/armor_penetration_zeroth = 0

	var/rapid_fire_shooting_amount_increment
	var/rapid_fire_shooting_amount_mult
	var/rapid_fire_shooting_amount_zeroth = 0.5

	var/delay_for_rapid_range_adjustment
	var/delay_for_rapid_range_mult
	var/delay_for_rapid_range_zeroth = 0

	var/fire_delay_increment
	var/fire_delay_mult
	var/fire_delay_zeroth = 0.5

	var/delay_for_range_mult
	var/delay_for_range_adjustment
	var/delay_for_range_zeroth = 0

	var/delayed_adjustment
	var/delayed_mult
	var/delayed_zeroth = 0.5

	var/poison_per_bite_increment
	var/poison_per_bite_mult
	var/poison_per_bite_zeroth = 0

/datum/stat_modifier/mob/living/carbon/superior_animal/remove(qdel_src = TRUE)
	if (issuperioranimal(holder))
		var/mob/living/carbon/superior_animal/superior_holder = holder

		if (flash_resistances_increment)
			superior_holder.flash_resistances = ZERO_OR_MORE(superior_holder.flash_resistances - flash_resistances_increment)
		if (flash_resistances_mult)
			superior_holder.flash_resistances = ZERO_OR_MORE(round(superior_holder.flash_resistances / flash_resistances_mult))

		if (armor_penetration_increment)
			superior_holder.armor_penetration = ZERO_OR_MORE(superior_holder.armor_penetration - armor_penetration_increment)
		if (armor_penetration_mult)
			superior_holder.armor_penetration = ZERO_OR_MORE(superior_holder.armor_penetration / armor_penetration_mult)

		if (fire_delay_increment)
			superior_holder.fire_delay = ZERO_OR_MORE(superior_holder.fire_delay - fire_delay_increment)
			superior_holder.fire_delay_initial = ZERO_OR_MORE(superior_holder.fire_delay_initial - fire_delay_increment)
		if (fire_delay_mult)
			superior_holder.fire_delay = ZERO_OR_MORE(round(superior_holder.fire_delay / fire_delay_mult))
			superior_holder.fire_delay_initial = ZERO_OR_MORE(round(superior_holder.fire_delay_initial / fire_delay_mult))

		if (rapid_fire_shooting_amount_increment)
			superior_holder.rapid_fire_shooting_amount = ZERO_OR_MORE(superior_holder.rapid_fire_shooting_amount - rapid_fire_shooting_amount_increment)
		if (rapid_fire_shooting_amount_mult)
			superior_holder.rapid_fire_shooting_amount = ZERO_OR_MORE(round(superior_holder.rapid_fire_shooting_amount / rapid_fire_shooting_amount_mult))
		if (superior_holder.rapid_fire_shooting_amount <= 0)
			superior_holder.rapid = FALSE

		if (issuperiorspider(superior_holder))
			var/mob/living/carbon/superior_animal/giant_spider/spider_target = holder

			if (poison_per_bite_increment)
				spider_target.poison_per_bite = ZERO_OR_MORE(spider_target.poison_per_bite - poison_per_bite_increment)
			if (poison_per_bite_mult)
				spider_target.poison_per_bite = ZERO_OR_MORE(spider_target.poison_per_bite / poison_per_bite_mult)

		if (delay_for_range_adjustment)
			superior_holder.delay_for_range = ZERO_OR_MORE(superior_holder.delay_for_range - delay_for_range_adjustment)
		if (delay_for_range_mult)
			superior_holder.delay_for_range = ZERO_OR_MORE(superior_holder.delay_for_range / delay_for_range_mult)

		if (superior_holder.rapid)
			if (delay_for_rapid_range_adjustment)
				superior_holder.delay_for_rapid_range = ZERO_OR_MORE(superior_holder.delay_for_rapid_range - delay_for_rapid_range_adjustment)
			if (delay_for_rapid_range_mult)
				superior_holder.delay_for_rapid_range = ZERO_OR_MORE(superior_holder.delay_for_rapid_range / delay_for_rapid_range_mult)

		if (delayed_adjustment)
			superior_holder.delayed = ZERO_OR_MORE(superior_holder.delayed - delayed_adjustment)
			superior_holder.delayed_initial = ZERO_OR_MORE(superior_holder.delayed_initial - delayed_adjustment)
		if (delayed_mult)
			superior_holder.delayed = ZERO_OR_MORE(superior_holder.delayed / delayed_mult)
			superior_holder.delayed_initial = ZERO_OR_MORE(superior_holder.delayed_initial / delayed_mult)

	return ..(qdel_src)

/datum/stat_modifier/mob/living/carbon/superior_animal/apply_to(atom/target)

	. = ..()

	if (issuperioranimal(target))
		var/mob/living/carbon/superior_animal/superior_target = target

		if (armor_adjustment)
			for (var/key in armor_adjustment)
				if (key in superior_target.armor)
					superior_target.armor[key] = (superior_target.armor[key] + armor_adjustment[key])
				else
					superior_target.armor[key] = armor_adjustment[key]

		if (flash_resistances_mult)
			superior_target.flash_resistances = ZERO_OR_MORE(round(SAFEMULT(superior_target.flash_resistances, flash_resistances_mult, flash_resistances_zeroth)))
		if (flash_resistances_increment)
			superior_target.flash_resistances = ZERO_OR_MORE(superior_target.flash_resistances + flash_resistances_increment)

		if (armor_penetration_mult)
			superior_target.armor_penetration = (SAFEMULT(superior_target.armor_penetration, armor_penetration_mult, armor_penetration_zeroth))
		if (armor_penetration_increment)
			superior_target.armor_penetration = (superior_target.armor_penetration + armor_penetration_increment)

		if (fire_delay_mult)
			superior_target.fire_delay_initial = ZERO_OR_MORE(round(SAFEMULT(superior_target.fire_delay_initial, fire_delay_mult, fire_delay_zeroth)))
			superior_target.fire_delay = ZERO_OR_MORE(round(SAFEMULT(superior_target.fire_delay, fire_delay_mult, fire_delay_zeroth)))
		if (fire_delay_increment)
			superior_target.fire_delay_initial = ZERO_OR_MORE(superior_target.fire_delay_initial + fire_delay_increment)
			superior_target.fire_delay = ZERO_OR_MORE(superior_target.fire_delay + fire_delay_increment)

		if (delay_for_range_mult)
			superior_target.delay_for_range = ZERO_OR_MORE(SAFEMULT(superior_target.delay_for_range, delay_for_range_mult, delay_for_range_zeroth))
		if (delay_for_range_adjustment)
			superior_target.delay_for_range = ZERO_OR_MORE(superior_target.delay_for_range + delay_for_range_adjustment)

		if (delayed_mult)
			superior_target.delayed_initial = ZERO_OR_MORE(round(SAFEMULT(superior_target.delayed_initial, delayed_mult, delayed_zeroth)))
			superior_target.delayed = ZERO_OR_MORE(round(SAFEMULT(superior_target.delayed, delayed_mult, delayed_zeroth)))
		if (delayed_adjustment)
			superior_target.delayed_initial = ZERO_OR_MORE(superior_target.delayed_initial + delayed_adjustment)
			superior_target.delayed = ZERO_OR_MORE(superior_target.delayed + delayed_adjustment)

		if (rapid_fire_shooting_amount_mult)
			superior_target.rapid_fire_shooting_amount = ZERO_OR_MORE(round(SAFEMULT(superior_target.rapid_fire_shooting_amount, rapid_fire_shooting_amount_mult, rapid_fire_shooting_amount_zeroth)))
		if (rapid_fire_shooting_amount_increment)
			superior_target.rapid_fire_shooting_amount = ZERO_OR_MORE(superior_target.rapid_fire_shooting_amount + rapid_fire_shooting_amount_increment)
		if ((superior_target.rapid_fire_shooting_amount > 0) && (!(superior_target.rapid))) //if we are rapid firing and dont have the var set, lets set it
			superior_target.rapid = TRUE

		if (delay_for_rapid_range_mult)
			superior_target.delay_for_rapid_range = ZERO_OR_MORE(SAFEMULT(superior_target.delay_for_rapid_range, delay_for_rapid_range_mult, delay_for_rapid_range_zeroth))
		if (delay_for_rapid_range_adjustment)
			superior_target.delay_for_rapid_range = ZERO_OR_MORE(superior_target.delay_for_rapid_range + delay_for_rapid_range_adjustment)

		if (issuperiorspider(superior_target))
			var/mob/living/carbon/superior_animal/giant_spider/spider_target = target

			if (poison_per_bite_mult)
				spider_target.poison_per_bite = ZERO_OR_MORE(SAFEMULT(spider_target.poison_per_bite, poison_per_bite_mult, poison_per_bite_zeroth))
			if (poison_per_bite_increment)
				spider_target.poison_per_bite = ZERO_OR_MORE(spider_target.poison_per_bite + poison_per_bite_increment)

/datum/stat_modifier/mob/living/carbon/superior_animal/durable

	armor_adjustment = list(
	melee = 5,
	bullet = 5,
	bomb = 15,
	agony = 30
	)

	flash_resistances_increment = 1

	prefix = "Durable"

	stattags = DEFENSE_STATTAG

	description = "This one looks somewhat more sturdy than others. It'll likely be slightly more resistant to damage and pain."

/datum/stat_modifier/mob/living/carbon/superior_animal/brutish

	armor_adjustment = list(
		melee = 5,
		bullet = 5,
		energy = -5,
		bomb = 5,
		agony = 15
		)

	melee_damage_lower_increment = 2
	melee_damage_upper_increment = 2
	maxHealth_increment = 5
	armor_penetration_increment = 2

	stattags = DEFENSE_STATTAG | MELEE_STATTAG

	inherent_projectile_mult_increment = 0.1
	projectile_armor_penetration_adjustment = 2

	description = "This one is noticably muscular. It looks like it might hit harder than others."

	prefix = "Brutish"

/datum/stat_modifier/mob/living/carbon/superior_animal/padded

	armor_adjustment = list(
		melee = 10,
		bullet = 5,
		bomb = 10,
		agony = 15 //Rubbers deal way less to us!
	)

	stattags = DEFENSE_STATTAG

	maxHealth_increment = 10

	prefix = "Padded"

	description = "This one seems to be a bit 'puffier' than others. It looks like your attacks will do somewhat less on it."

/datum/stat_modifier/mob/living/carbon/superior_animal/old

	armor_adjustment = list(
		melee = 5,
		bullet = 5,
		bomb = 10,
		agony = 20 //just cant feel it
	)

	maxHealth_increment = 20 //life already seen them by
	move_to_delay_increment = 1 // Very slow

	stattags = DEFENSE_STATTAG

	delay_for_range_mult = 1.1

	prefix = "Old"

	description = "This one seems old - lethargic, but seasoned. It's likely to be slower but harder to kill."

/datum/stat_modifier/mob/living/carbon/superior_animal/young

	armor_adjustment = list(
		melee = -5,
		bullet = -5,
		energy = -5,
		agony = -5
	)

	maxHealth_increment = -10

	move_to_delay_increment = -0.5

	delay_for_range_mult = 0.8

	stattags = DEFENSE_STATTAG

	prefix = "Young"

	description = "This one seems to be more active and energetic than the others, but somewhat smaller. It's likely to be more fragile, but quicker."

/datum/stat_modifier/mob/living/carbon/superior_animal/quick

	move_to_delay_increment = -0.8
	delay_for_range_mult = 0.8

	stattags = DEFENSE_STATTAG

	prefix = "Quick"

	description = "This one seems to be quicker than the others."

/// slower, deadlier, significantly tanker -- a significant buff
/datum/stat_modifier/mob/living/carbon/superior_animal/brutal

	armor_adjustment = list(
		melee = 15,
		bullet = 5,
		bomb = 15,
		agony = 30
	)

	flash_resistances_increment = 4

	melee_damage_lower_mult = 1.3
	melee_damage_upper_mult = 1.3

	inherent_projectile_mult_increment = 1.3

	stattags = DEFENSE_STATTAG | MELEE_STATTAG | RANGED_STATTAG

	move_to_delay_increment = 1.3

	prefix = "Brutal"

	description = "This one looks exceptionally muscular and scarred. You get the feeling they might be significantly physically stronger, durable, and resistant to pain, than others of its like."
