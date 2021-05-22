/*
/mob/living/carbon/superior_animal/roach/elektromagnetisch
	name = "Elektromagnetisch Roach"
	desc = "A monstrous, dog-sized cockroach. This blue glowing one looks like its plusing with energy."
	icon_state = "elektromagnetisch"
	meat_amount = 2
	turns_per_move = 2
	maxHealth = 120
	health = 120
	move_to_delay = 7
	deathmessage = "pulses violently as it dies!"
	melee_damage_lower = 12
	melee_damage_upper = 15 //Rare

	mob_size = MOB_MEDIUM
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/roachmeat/elektromagnetisch
	knockdown_odds = 1 //its affect shouldnt be stunlocks like this

/mob/living/carbon/superior_animal/roach/elektromagnetisch/UnarmedAttack(var/atom/A, var/proximity)
	. = ..()
	if(prob(5))
		empulse(src.loc, 0, 3)
		playsound(src.loc, list('sound/weapons/unknown_spacegun_burn.ogg', 'sound/weapons/unknown_spacegun_melt.ogg', 'sound/weapons/unknown_spacegun_incinerate.ogg', 'sound/weapons/unknown_spacegun_vaporize.ogg'))

/mob/living/carbon/superior_animal/roach/elektromagnetisch/death(var/gibbed,var/message = deathmessage)
	if (stat != DEAD)
		target_mob = null
		stance = initial(stance)
		stop_automated_movement = initial(stop_automated_movement)
		walk(src, 0)
		playsound(src.loc, list('sound/weapons/unknown_spacegun_burn.ogg', 'sound/weapons/unknown_spacegun_melt.ogg', 'sound/weapons/unknown_spacegun_incinerate.ogg', 'sound/weapons/unknown_spacegun_vaporize.ogg'))
		empulse(src.loc, 3,3) //Death mixes it making it even worst

		density = 0
		layer = LYING_MOB_LAYER

	. = ..()
*/