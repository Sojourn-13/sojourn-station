//There are important things regarding this file:
//Rubbers are non sharp, embed capable objects, with non existing armor penetration. Their agony damage is generally lower then actual one.
//The total amount of calibers we have is not likely to change, as you see we have A LOT. -CDB
//HV exist as a form of armor penetrating round. They should have lower wounding lower damage higher AP.
//Step delays - default value is 1. Lower value makes bullet go faster, higher value makes bullet go slower.
//Hollowpoint do extra damage against targets that lack armor sufficient. They should have higher wound mult and lower damage to account for the damage_mult.
//Wounding multiplier is generally based on bullet width, it affects some damage procs.
//rifle rounds should generally have lower wounding mult vs handgun rounds(the latter of which are more limited in how many rounds are available, with exception of 9mm/.35)

//Low-caliber pistols and SMGs
//*********************************//
///9mm///
/obj/item/projectile/bullet/pistol_35
	damage_types = list(BRUTE = 24)
	armor_divisor = 0.4
	step_delay = 0.65
	can_ricochet = TRUE
	wounding_mult = WOUNDING_SMALL
	affective_damage_range = 4
	affective_ap_range = 4
	recoil = 5

/obj/item/projectile/bullet/pistol_35/hv
	damage_types = list(BRUTE = 18)
	armor_divisor = 1.2
	step_delay = 0.5
	affective_damage_range = 5
	affective_ap_range = 5
	can_ricochet = TRUE
	sharp = TRUE
	recoil = 6

/obj/item/projectile/bullet/pistol_35/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 4)
	embed = FALSE
	sharp = FALSE
	step_delay = 0.75
	can_ricochet = FALSE
	recoil = 4

/obj/item/projectile/bullet/pistol_35/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 18)
	armor_divisor = 0.2
	wounding_mult = WOUNDING_NORMAL
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = FALSE
	step_delay = 0.65
	recoil = 5
	embed_mult = 1.5

/obj/item/projectile/bullet/pistol_35/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 12, HALLOSS = 22)
	armor_divisor = 0.4
	wounding_mult = WOUNDING_SMALL
	embed = FALSE	//Prob should have a chance to embed, but makes close to no sense to do this for 9mm at least.
	sharp = FALSE
	can_ricochet = TRUE
//	//ricochet_mod = 3 //lower cal rubbers are the most likely to ricochet.
	recoil = 4
	ignition_source = FALSE

/obj/item/projectile/bullet/pistol_35/rubber/soporific
	name = "soporific coated rubber bullet"
	damage_types = list(BRUTE = 0, HALLOSS = 25)
	var/spray = "stoxin"
	can_ricochet = FALSE

/obj/item/projectile/bullet/pistol_35/rubber/soporific/New()
	..()
	if(!testing)
		create_reagents(2)
		reagents.add_reagent(spray, 2)

/obj/item/projectile/bullet/pistol_35/rubber/soporific/on_hit(atom/target, def_zone = null)
	if(!testing)
		if(isliving(target))
			var/mob/living/L = target
			if(istype(L) && L.reagents)
				reagents.trans_to_mob(L, 2, CHEM_TOUCH, copy = FALSE)

/obj/item/projectile/bullet/pistol_35/rubber/soporific/cbo
	name = "soporific condensed plastic bullet"
	damage_types = list(HALLOSS = 30)
	can_ricochet = FALSE

/obj/item/projectile/bullet/pistol_35/rubber/soporific/cbo/on_hit(atom/target, def_zone = null)
	if(!testing)
		if(isliving(target))
			var/mob/living/L = target
			if(istype(L) && L.reagents)
				L.reagents.add_reagent("stoxin", 5)

/obj/item/projectile/bullet/pistol_35/rubber/pepperball
	name = "pepperball"
	damage_types = list(BRUTE = 2, HALLOSS = 22)	//Pepperballs disipate upon impact. They'll sting like shit, but won't do much in a low-velocity round.
	step_delay = 0.6 //a little slower than rubber rounds - these are just pepperspray balls
	var/spray = "condensedcapsaicin"
	embed = FALSE
	can_ricochet = FALSE
	wounding_mult = WOUNDING_SMALL

/obj/item/projectile/bullet/pistol_35/rubber/pepperball/New()
	..()
	if (!testing)
		create_reagents(3)
		reagents.add_reagent(spray, 3)

/obj/item/projectile/bullet/pistol_35/rubber/pepperball/on_hit(atom/target, def_zone = null)
	if(!testing)
		if(isliving(target))
			var/mob/living/L = target
			if(istype(L) && L.reagents && !testing)
				reagents.trans_to_mob(L, 3, CHEM_TOUCH, copy = FALSE)

/obj/item/projectile/bullet/pistol_35/scrap
	damage_types = list(BRUTE = 14)
	armor_divisor = 0.25
	affective_damage_range = 1
	affective_ap_range = 1
	recoil = 3

/obj/item/projectile/bullet/pistol_35/biomatter
	name = "biomatter bullet"
	damage_types = list(BURN = 15, HALLOSS = 20)
	penetrating = 0
	can_ricochet = FALSE
	embed = FALSE
	sharp = FALSE
	step_delay = 0.65
	check_armour = ARMOR_BIO
	recoil = 3

//Revolvers and high-caliber pistols
//*********************************//
/// 10mm Magnum ///

/obj/item/projectile/bullet/magnum_40
	icon_state = "bullet_magnum"
	damage_types = list(BRUTE = 28)
	armor_divisor = 0.5
	wounding_mult = WOUNDING_NORMAL
	can_ricochet = TRUE
	step_delay = 0.4

	affective_damage_range = 4
	affective_ap_range = 4
	recoil = 7

/obj/item/projectile/bullet/magnum_40/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 4)
	embed = FALSE
	sharp = FALSE
	can_ricochet = FALSE
	step_delay = 0.4
	recoil = 4

/obj/item/projectile/bullet/magnum_40/hv
	damage_types = list(BRUTE = 22)
	armor_divisor = 1.3
	penetrating = 1
	step_delay = 0.25
	nocap_structures = TRUE //Door breaching
	sharp = TRUE
	affective_damage_range = 5
	affective_ap_range = 5
	recoil = 9

/obj/item/projectile/bullet/magnum_40/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 22)
	armor_divisor = 0.25
	wounding_mult = WOUNDING_SERIOUS
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = FALSE
	step_delay = 0.5
	recoil = 7
	embed_mult = 1.5

/obj/item/projectile/bullet/magnum_40/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 15, HALLOSS = 30)	//Basically a lower-damage HP but with more agony damage to it. Technically LTL - but not really ideal for it. Crowd-suppression.
	armor_divisor = 0.5
	wounding_mult = WOUNDING_SMALL
	embed = TRUE	//If you shoot someone with a rubber, it will take out an eye - or require surgery if it's high-velocity. Anything over 9mm should, realistically, fuck you up.
	sharp = FALSE
	can_ricochet = TRUE
	//ricochet_mod = 2.5
	step_delay = 0.5
	recoil = 6
	ignition_source = FALSE

/obj/item/projectile/bullet/magnum_40/rubber/pepperball
	name = "pepperball"
	damage_types = list(BRUTE = 4, HALLOSS = 30)	//Pepperballs disipate upon impact. They'll sting like shit, but won't do much in a low-velocity round.
	step_delay = 0.6 //a little slower than rubber rounds - these are just pepperspray balls
	var/spray = "condensedcapsaicin"
	embed = FALSE
	can_ricochet = FALSE	//breaks upon impact; impossible.

/obj/item/projectile/bullet/magnum_40/rubber/pepperball/New()
	..()
	if (!testing)
		create_reagents(5)
		reagents.add_reagent(spray, 5)

/obj/item/projectile/bullet/magnum_40/rubber/pepperball/on_hit(atom/target, def_zone = null)
	if(isliving(target))
		var/mob/living/L = target
		if(istype(L) && L.reagents && !testing)
			reagents.trans_to_mob(L, 5, CHEM_TOUCH, copy = FALSE)

/obj/item/projectile/bullet/magnum_40/rubber/soporific
	name = "soporific coated rubber bullet"
	damage_types = list(BRUTE = 0, HALLOSS = 35)
	var/spray = "stoxin"
	can_ricochet = FALSE
	embed = FALSE

/obj/item/projectile/bullet/magnum_40/rubber/soporific/New()
	..()
	if (!testing)
		create_reagents(3)
		reagents.add_reagent(spray, 3)

/obj/item/projectile/bullet/magnum_40/rubber/soporific/on_hit(atom/target, def_zone = null)
	if(!testing)
		if(isliving(target))
			var/mob/living/L = target
			if(istype(L) && L.reagents && !testing)
				reagents.trans_to_mob(L, 3, CHEM_TOUCH, copy = FALSE)

/obj/item/projectile/bullet/magnum_40/scrap
	damage_types = list(BRUTE = 15)
	armor_divisor = 0.5
	affective_damage_range = 3
	affective_ap_range = 3
	recoil = 6

/obj/item/projectile/bullet/magnum_40/biomatter
	name = "biomatter bullet"
	damage_types = list(BURN = 20, HALLOSS = 32)
	armor_divisor = 0.7
	penetrating = 0
	can_ricochet = FALSE
	embed = FALSE
	sharp = FALSE
	step_delay = 0.65
	check_armour = ARMOR_BIO
	recoil = 6

/// 12mm Heavy Pistol ///
/obj/item/projectile/bullet/kurtz_50
	icon_state = "bullet_krutz"
	damage_types = list(BRUTE = 36)
	armor_divisor = 0.6
	wounding_mult = WOUNDING_WIDE
	can_ricochet = TRUE
	embed = TRUE
	step_delay = 0.65
	affective_damage_range = 5
	affective_ap_range = 5
	recoil = 14

/obj/item/projectile/bullet/kurtz_50/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 20, HALLOSS = 35)
	wounding_mult = WOUNDING_SERIOUS
	check_armour = ARMOR_MELEE
	armor_divisor = 0.5
	can_ricochet = TRUE
	//ricochet_mod = 2 //including our AP mallus for bounce we are baseline about 1.9x as likely to bounce.
	step_delay = 0.7
	recoil = 10
	ignition_source = FALSE

/obj/item/projectile/bullet/kurtz_50/rubber/pepperball
	name = "pepperball"
	damage_types = list(BRUTE = 6, HALLOSS = 35)	//Pepperballs disipate upon impact. They'll sting like shit, but won't do much in a low-velocity round.
	step_delay = 0.75 //a little slower than rubber rounds - these are just pepperspray balls
	var/spray = "condensedcapsaicin"
	embed = FALSE
	can_ricochet = FALSE	//breaks upon impact; impossible.
	wounding_mult = WOUNDING_SMALL

/obj/item/projectile/bullet/kurtz_50/rubber/pepperball/New()
	..()
	if (!testing)
		create_reagents(8)
		reagents.add_reagent(spray, 8)

/obj/item/projectile/bullet/kurtz_50/rubber/pepperball/on_hit(atom/target, def_zone = null)
	if(!testing)
		if(isliving(target))
			var/mob/living/L = target
			if(istype(L) && L.reagents && !testing)
				reagents.trans_to_mob(L, 8, CHEM_TOUCH, copy = FALSE)

/obj/item/projectile/bullet/kurtz_50/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 5)
	embed = FALSE
	can_ricochet = FALSE
	step_delay = 0.75
	recoil = 8

/obj/item/projectile/bullet/kurtz_50/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 27)
	armor_divisor = 0.3
	wounding_mult = WOUNDING_EXTREME
	penetrating = 0
	can_ricochet = FALSE
	step_delay = 0.8
	recoil = 14
	embed_mult = 2

/obj/item/projectile/bullet/kurtz_50/hv
	name = "AV bullet"
	damage_types = list(BRUTE = 27)
	armor_divisor = 1.4
	penetrating = 2
	can_ricochet = FALSE
	step_delay = 0.45
	affective_damage_range = 6
	affective_ap_range = 6
	nocap_structures = TRUE //We can breach doors rather well
	sharp = TRUE
	recoil = 16


//Carbines and rifles
//*********************************//

/// 6.5x39mm Carbine///

/obj/item/projectile/bullet/light_rifle_257
	icon_state = "bullet_carbine"
	damage_types = list(BRUTE = 25)
	armor_divisor = 1
	wounding_mult = WOUNDING_NORMAL
	penetrating = 1
	can_ricochet = TRUE
	step_delay = 0.3
	affective_damage_range = 7
	affective_ap_range = 7
	recoil = 5

/obj/item/projectile/bullet/light_rifle_257/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 4)
	embed = FALSE
	sharp = FALSE
	can_ricochet = FALSE
	step_delay = 0.5
	recoil = 4

/obj/item/projectile/bullet/light_rifle_257/hv
	damage_types = list(BRUTE = 19)
	armor_divisor = 2.5
	penetrating = 2
	hitscan = TRUE
	affective_damage_range = 8 //Can snipe
	affective_ap_range = 8
	nocap_structures = TRUE //RATARATARAT down a door
	sharp = TRUE
	recoil = 7

/obj/item/projectile/bullet/light_rifle_257/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 10, HALLOSS = 20)
	check_armour = ARMOR_MELEE
	armor_divisor = 0.8
	wounding_mult = WOUNDING_TINY
	embed = TRUE	//Imagine being shot with a high velocity .223/5.56 rubber bullet - that shit could easily kill you - or at least would act like a normal bullet.
	sharp = FALSE
	can_ricochet = TRUE
	step_delay = 0.9
	recoil = 4
	ignition_source = FALSE

/obj/item/projectile/bullet/light_rifle_257/rubber/pepperball
	name = "pepperball"
	damage_types = list(BRUTE = 4, HALLOSS = 20)	//Pepperballs disipate upon impact. They'll sting like shit, but won't do much in a low-velocity round.
	step_delay = 1.0 //a little slower than rubber rounds - these are just pepperspray balls
	var/spray = "condensedcapsaicin"
	embed = FALSE
	can_ricochet = FALSE	//breaks upon impact; impossible.

/obj/item/projectile/bullet/light_rifle_257/rubber/pepperball/New()
	..()
	if (!testing)
		create_reagents(5)
		reagents.add_reagent(spray, 5)

/obj/item/projectile/bullet/light_rifle_257/rubber/pepperball/on_hit(atom/target, def_zone = null)
	if(isliving(target))
		var/mob/living/L = target
		if(istype(L) && L.reagents && !testing)
			reagents.trans_to_mob(L, 5, CHEM_TOUCH, copy = FALSE)

/obj/item/projectile/bullet/light_rifle_257/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 19)
	armor_divisor = 0.5
	wounding_mult = WOUNDING_WIDE
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = FALSE
	step_delay = 0.6
	recoil = 5
	embed_mult = 2 //We suck and get blocked by must armor

/obj/item/projectile/bullet/light_rifle_257/incend
	name = "incendiary bullet"
	damage_types = list(BURN = 10) //We deal most of are damage with fire stacks
	fire_stacks = 1
	armor_divisor = 0.5
	penetrating = 0
	can_ricochet = FALSE
	embed = FALSE
	sharp = FALSE
	wounding_mult = WOUNDING_NORMAL
	step_delay = 0.7
	recoil = 7

/obj/item/projectile/bullet/light_rifle_257/scrap
	damage_types = list(BRUTE = 15)
	armor_divisor = 0.5
	affective_damage_range = 4
	affective_ap_range = 4
	recoil = 6

/obj/item/projectile/bullet/light_rifle_257/nomuzzle
	muzzle_type = null

/// 7.62x39mm Rifle ///

/obj/item/projectile/bullet/rifle_75
	damage_types = list(BRUTE = 27)
	armor_divisor = 1.25
	wounding_mult = WOUNDING_SERIOUS
	penetrating = 1
	can_ricochet = TRUE
	step_delay = 0.3
	affective_damage_range = 7
	affective_ap_range = 7
	recoil = 10

/obj/item/projectile/bullet/rifle_75/hv
	damage_types = list(BRUTE = 21)
	armor_divisor = 3
	penetrating = 2
	hitscan = TRUE
	affective_damage_range = 8
	affective_ap_range = 8
	nocap_structures = TRUE //Helps against walls and doors
	sharp = TRUE
	recoil = 14

/obj/item/projectile/bullet/rifle_75/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 2, HALLOSS = 2)
	armor_divisor = 1
	embed = FALSE
	sharp = FALSE
	can_ricochet = FALSE
	recoil = 6

/obj/item/projectile/bullet/rifle_75/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 14, HALLOSS = 26)
	check_armour = ARMOR_MELEE
	armor_divisor = 1
	wounding_mult = WOUNDING_NORMAL
	embed = TRUE	//literally imagine a 7.62 rubber bullet hitting you - holy shit.
	sharp = FALSE
	can_ricochet = TRUE
	//ricochet_mod = 2 //including armor penalty ends up as closer to 1.85x as likely.
	step_delay = 0.9
	recoil = 6
	ignition_source = FALSE

/obj/item/projectile/bullet/rifle_75/rubber/soporific
	name = "soporific coated rubber bullet"
	damage_types = list(BRUTE = 4, HALLOSS = 30) // Minor damage from blunt trauma, it's meant to be LTL
	var/spray = "stoxin"

/obj/item/projectile/bullet/rifle_75/rubber/soporific/New()
	..()
	if (!testing)
		create_reagents(1)
		reagents.add_reagent(spray, 1)

/obj/item/projectile/bullet/rifle_75/rubber/soporific/on_hit(atom/target, def_zone = null)
	if (!testing)
		if(isliving(target))
			var/mob/living/L = target
			if(istype(L) && L.reagents && !testing)
				reagents.trans_to_mob(L, 1, CHEM_TOUCH, copy = FALSE)

/obj/item/projectile/bullet/rifle_75/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 21)
	armor_divisor = 0.65
	wounding_mult = WOUNDING_EXTREME
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = FALSE
	step_delay = 0.8
	recoil = 10
	embed_mult = 1.5

/obj/item/projectile/bullet/rifle_75/incend
	name = "incendiary bullet"
	damage_types = list(BURN = 12) //We deal most of are damage with fire stacks
	fire_stacks = 2
	penetrating = 0
	can_ricochet = FALSE
	embed = FALSE
	sharp = FALSE
	step_delay = 0.8
	recoil = 9

/obj/item/projectile/bullet/rifle_75/scrap
	damage_types = list(BRUTE = 17)
	armor_divisor = 0.5
	affective_damage_range = 3
	affective_ap_range = 3
	recoil = 5

/// 8.6x70mm Heavy Rifle ///

/obj/item/projectile/bullet/heavy_rifle_408
	icon_state = "bullet_heavy"
	damage_types = list(BRUTE = 30)
	armor_divisor = 1.4
	wounding_mult = WOUNDING_WIDE
	penetrating = 2
	can_ricochet = TRUE
	step_delay = 0.3
	affective_damage_range = 8
	affective_ap_range = 8
	recoil = 16

/obj/item/projectile/bullet/heavy_rifle_408/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 17, HALLOSS = 32)
	armor_divisor = 1.3
	check_armour = ARMOR_MELEE
	embed = TRUE	//imagine an effectively smaller .50 Cal marksman round hitting you. holy shit.
	sharp = FALSE
	can_ricochet = TRUE
	//ricochet_mod = 1.35 //after AP penalty to ricochet is factored in we have more like 15% more chance to ricochet.
	step_delay = 0.9
	recoil = 14
	ignition_source = FALSE

/obj/item/projectile/bullet/heavy_rifle_408/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 6)
	armor_divisor = 1
	embed = FALSE
	sharp = FALSE
	wounding_mult = WOUNDING_NORMAL
	can_ricochet = FALSE
	step_delay = 0.5
	recoil = 10

/obj/item/projectile/bullet/heavy_rifle_408/hv
	name = "sabot penetrator"
	damage_types = list(BRUTE = 24)
	armor_divisor = 3.5
	penetrating = 3
	hitscan = TRUE
	affective_damage_range = 9 //Sniping cal
	affective_ap_range = 9
	nocap_structures = TRUE //anit-wall/door
	sharp = TRUE
	recoil = 20

/obj/item/projectile/bullet/heavy_rifle_408/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 24)
	armor_divisor = 0.7
	wounding_mult = WOUNDING_DEVESTATING
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = FALSE
	step_delay = 0.5
	recoil = 16
	embed_mult = 2

/obj/item/projectile/bullet/heavy_rifle_408/incend
	name = "incendiary bullet"
	damage_types = list(BURN = 15) //We deal most of are damage with fire stacks
	fire_stacks = 3
	armor_divisor = 1
	penetrating = 0
	can_ricochet = FALSE
	embed = FALSE
	sharp = FALSE
	step_delay = 0.8
	recoil = 15

/obj/item/projectile/bullet/heavy_rifle_408/scrap
	damage_types = list(BRUTE = 20)
	armor_divisor = 0.75
	affective_damage_range = 4
	affective_ap_range = 4
	recoil = 12

///Snowflake  ///

/obj/item/projectile/bullet/c10x24
	damage_types = list(BRUTE = 25)
	armor_divisor = 2
	wounding_mult = WOUNDING_SMALL
	penetrating = 2
	can_ricochet = TRUE
	sharp = TRUE
	step_delay = 0.3
	affective_damage_range = 9
	affective_ap_range = 9
	recoil = 9

/obj/item/projectile/bullet/auto_460
	damage_types = list(BRUTE = 30)
	armor_divisor = 1.25
	penetrating = 2
	can_ricochet = TRUE
	step_delay = 0.3
	affective_damage_range = 8
	affective_ap_range = 8
	recoil = 14

/obj/item/projectile/bullet/auto_460/scrap
	damage_types = list(BRUTE = 17.5)
	armor_divisor = 1.15
	penetrating = 1
	can_ricochet = TRUE
	step_delay = 0.3
	affective_damage_range = 5
	affective_ap_range = 5
	recoil = 12

//// 14.5×114mm Anti-Materiel Rifle Rounds ////
/obj/item/projectile/bullet/antim
	damage_types = list(BRUTE = 60)
	armor_divisor = 10
	wounding_mult = WOUNDING_WIDE
	nocap_structures = TRUE
	//stun = 5
	//weaken = 10
	penetrating = 5
	hitscan = TRUE //so the PTR isn't useless as a sniper weapon
	affective_damage_range = 10 //Unsure why this is so low, this is no where near the range of the AMR scope.
	affective_ap_range = 10
	recoil = 40

/obj/item/projectile/bullet/antim/lethal
	damage_types = list(BRUTE = 45, HALLOSS = 100)
	embed = TRUE
	armor_divisor = 4
	wounding_mult = WOUNDING_EXTREME
	penetrating = 2
	affective_damage_range = 9
	affective_ap_range = 9
	penetrating = -5
	recoil = 20
	embed_mult = 3 //this round is designed for this.

/obj/item/projectile/bullet/antim/incend
	damage_types = list(BURN = 45)
	embed = FALSE
	fire_stacks = 5	//BURN, BABY! BUUURN!!
	armor_divisor = 4
	penetrating = 2
	affective_damage_range = 10
	affective_ap_range = 10
	penetrating = -5
	recoil = 40

/obj/item/projectile/bullet/antim/scrap
	damage_types = list(BRUTE = 40)
	armor_divisor = 4
	affective_damage_range = 8
	affective_ap_range = 8
	recoil = 30

/obj/item/projectile/bullet/antim/ion
	damage_types = list(BRUTE = 25)
	armor_divisor = 4
	recoil = 15

/obj/item/projectile/bullet/antim/ion/on_impact(atom/target, blocked = FALSE)
	. = ..()
	if (!testing)
		empulse(target, 1, 3)

//smoothbore rifles
/obj/item/projectile/bullet/ball
	nocap_structures = TRUE
	damage_types = list(BRUTE = 40, HALLOSS = 60) //Grab me musket as the founding fathers intended
	armor_divisor = 4 //no longer a little jank, much like other older rifles it falters in terms of AP while still having enough to really smash through armor.
	supereffective_mult = 6 //we do 40 damage base, up to 240 with supereffective - plus AP bonus, plus agony bonus, about the same 350~ as before
	supereffective_types = list(/mob/living/carbon/human = FALSE, /mob/living = TRUE) //We are great at fighting living things(other than people, for balance reasons) but not so much robots.
	wounding_mult = WOUNDING_EXTREME
	penetrating = 2
	hitscan = TRUE //It's a bullet, but its hitscan as its only used by snipers.
	embed = FALSE //Blow a golf ball sized hole through the first man, he's dead on the spot - No embeds, tears through
	affective_damage_range = 12
	affective_ap_range = 12 //Good rifling! //wait, what? It's a smoothbore. Whatever ~_~
	recoil = 35

//Mech
/obj/item/projectile/bullet/mech_coilgun //Industrial Coilgun
	name = "coilgun round"
	icon_state = null
	damage_types = list(BRUTE = 26)
	armor_divisor = 2
	wounding_mult = WOUNDING_SERIOUS
	penetrating = 1

	can_ricochet = FALSE
	embed = FALSE //Goes right through
	affective_damage_range = 9
	affective_ap_range = 7

	recoil = 2

/obj/item/projectile/bullet/pellet/mech_flak //Flak Cannon
	name = "flak shrapnel"
	icon_state = "l_birdshot-4"
	damage_types = list(BRUTE = 14)
	armor_divisor = 1.5
	wounding_mult = WOUNDING_NORMAL
	penetrating = 0

	pellets = 4			//number of pellets
	range_step = 4		//projectile will lose a fragment each time it travels this distance.
	base_spread = 15	//lower means the pellets spread more across body parts.
	spread_step = 5	//higher means the pellets spread more across body parts with distance

	can_ricochet = FALSE
	embed = TRUE
	sharp = FALSE //Flak is for exploding near target rather than penetrating

	affective_damage_range = 8
	affective_ap_range = 8 //Anti-Air
	recoil = 2
	embed_mult = 1.5

/obj/item/projectile/bullet/pellet/mech_flak/military //Scatter-Shot Autocannon
	damage_types = list(BRUTE = 22)
	range_step = 8		//projectile will lose a fragment each time it travels this distance.
	base_spread = 90	//lower means the pellets spread more across body parts.
	spread_step = 1	//higher means the pellets spread more across body parts with distance
	pellets = 8
	wounding_mult = WOUNDING_SERIOUS //Faster moving
	affective_damage_range = 11
	affective_ap_range = 11  //Anti-Air

/obj/item/projectile/bullet/mech_machinegun //Heavy Machinegun
	name = "large caliber bullet"
	icon_state = "bullet_heavy"
	damage_types = list(BRUTE = 21)
	wounding_mult = WOUNDING_SERIOUS
	armor_divisor = ARMOR_PEN_MODERATE //To keep it somewhat fair towards the handhelds considering it has higher ammo capacity
	penetrating = 1

	can_ricochet = TRUE

	affective_damage_range = 6
	affective_ap_range = 6 //Blarge rifle caliber
	recoil = 4 //It's mounted into a mech as well as the deviation already screws it over pretty badly - Lamasmaster

/obj/item/projectile/bullet/mech_autocannon //Autocannon
	name = "gigantic round"
	icon_state = "slug"
	damage_types = list(BRUTE = 50)
	armor_divisor = 5 //Tally ho
	wounding_mult = WOUNDING_DEVESTATING //You don't want to get hit by a tank round presumably - Lamasmaster
	penetrating = 2 //tank sized round
	nocap_structures = TRUE //anit-wall/door

	can_ricochet = FALSE
	//embed = FALSE - If it becomes too much of a problem uncomment this

	affective_damage_range = 7
	affective_ap_range = 7 //Heavy blarge caliber meaning bit less range
	recoil = 1

/obj/item/projectile/bullet/mech_burstcannon //Burst-Fire Autocannon
	name = "humongous round"
	icon_state = "bullet_kurtz"
	damage_types = list(BRUTE = 30)
	armor_divisor = 3 //This fires 2 in a row so keep that in mind / It is technically armor defeating but for sake of it being the niche kill hordes gun alongside HMG it will stay this way - Lamasmaster
	wounding_mult = WOUNDING_WIDE
	penetrating = 3 //tank sized round
	nocap_structures = TRUE //anit-wall/door

	can_ricochet = FALSE
	//embed = FALSE - If it becomes too much of a problem uncomment this

	affective_damage_range = 10
	affective_ap_range = 10 //Heavy blarge caliber but not as much as regular
	recoil = 2

//Shotguns
//*********************************//

/obj/item/projectile/bullet/shotgun
	name = "slug"
	icon_state = "slug"
	damage_types = list(BRUTE = 35)
	armor_divisor = 3
	wounding_mult = WOUNDING_SERIOUS
	knockback = 0 //Bug doups hits
	step_delay = 0.9
	//Slugs are meant for long range shooting
	affective_damage_range = 7
	affective_ap_range = 7
	recoil = 18

/obj/item/projectile/bullet/shotgun/ceramic
	name = "ceramic slug"
	icon_state = "slug"
	damage_types = list(BRUTE = 30)
	armor_divisor = 1.2
	knockback = 1 //KER-BLAM!!!!
	affective_damage_range = 4
	affective_ap_range = 4
	recoil = 22

/obj/item/projectile/bullet/shotgun/beanbag
	name = "beanbag"
	icon_state = "rubber"
	damage_types = list(BRUTE = 20, HALLOSS = 60)
	wounding_mult = WOUNDING_NORMAL
	armor_divisor = 1.5
	embed = FALSE
	sharp = FALSE
	step_delay = 1.65
	affective_damage_range = 5
	affective_ap_range = 2
	recoil = 10
	ignition_source = FALSE

/obj/item/projectile/bullet/shotgun/beanbag/pepperball
	name = "pepperball slug"
	damage_types = list(BRUTE = 6, HALLOSS = 50)	//Pepperballs disipate upon impact. They'll sting like shit, but won't do much in a low-velocity round.
	step_delay = 2 //Slower than a beanbag due to it being STRONG as fuck.
	armor_divisor = 0.8
	var/spray = "condensedcapsaicin"
	embed = FALSE
	can_ricochet = FALSE	//breaks upon impact; impossible.

/obj/item/projectile/bullet/shotgun/beanbag/pepperball/New()
	..()
	if (!testing)
		create_reagents(10)
		reagents.add_reagent(spray, 10)

/obj/item/projectile/bullet/shotgun/beanbag/on_hit(atom/target, def_zone = null)
	if (!testing)
		if(isliving(target))
			var/mob/living/L = target
			if(istype(L) && L.reagents && !testing)
				reagents.trans_to_mob(L, 10, CHEM_TOUCH, copy = FALSE)

/obj/item/projectile/bullet/shotgun/beanbag/soporific
	name = "soporific coated beanbag"
	damage_types = list(BRUTE = 10, HALLOSS = 65) // They still hurt!
	armor_divisor = 0.8
	var/spray = "stoxin"

/obj/item/projectile/bullet/shotgun/beanbag/soporific/New()
	..()
	if (!testing)
		create_reagents(5)
		reagents.add_reagent(spray, 5)

/obj/item/projectile/bullet/shotgun/beanbag/soporific/on_hit(atom/target, def_zone = null)
	if (!testing)
		if(isliving(target))
			var/mob/living/L = target
			if(istype(L) && L.reagents && !testing)
				reagents.trans_to_mob(L, 5, CHEM_TOUCH, copy = FALSE)


/obj/item/projectile/bullet/shotgun/practice
	name = "practice slug"
	damage_types = list(BRUTE = 4, HALLOSS = 5)
	armor_divisor = 0.5
	embed = FALSE
	affective_damage_range = 1
	affective_ap_range = 1
	recoil = 7

/obj/item/projectile/bullet/shotgun/incendiary
	//This is the best ammo for pvp in a shotgun, beating the stunshell with its pain and cooks anyone in any armor!
	damage_types = list(BURN = 22.5) //We deal most of are damage with fire stacks
	armor_divisor = 0.5
	fire_stacks = 4 //40 pain a fire proc through ALL armor!
	recoil = 40

/obj/item/projectile/bullet/shotgun/scrap
	damage_types = list(BRUTE = 27)
	armor_divisor = 1.2
	affective_damage_range = 3
	affective_ap_range = 4
	recoil = 10

/obj/item/projectile/bullet/shotgun/beanbag/scrap
	damage_types = list(BRUTE = 13, HALLOSS  = 55)
	armor_divisor = 1.25
	affective_damage_range = 1
	affective_ap_range = 1
	recoil = 8

/obj/item/projectile/bullet/pellet/shotgun/scrap
	damage_types = list(BRUTE = 8)
	armor_divisor = 0.9
	affective_damage_range = 4
	affective_ap_range = 4
	recoil = 6

/obj/item/projectile/bullet/shotgun/biomatter //Unique niche round. High AP, Low damage, high agony. Good for mob crunching, or AP LTL uses
	name = "biomatter slug"
	damage_types = list(BURN = 10, HALLOSS = 40) // Thin little piece of biomass designed to defeat armor but not really large enough to cause super serious injuries.
	armor_divisor = 4 //high velocity
	wounding_mult = WOUNDING_SMALL //tiny slug.
	penetrating = 0
	can_ricochet = FALSE
	embed = FALSE
	sharp = FALSE
	step_delay = 0.95 //slightly slower than a slug
	check_armour = ARMOR_BIO //duh.
	recoil = 8//much less damage than slug, much less recoil.

//Fancy ammo that is exspensive
/obj/item/projectile/bullet/shotgun/relay
	name = "greyson relay shot"
	damage_types = list(BRUTE = 22)
	armor_divisor = 8
	wounding_mult = WOUNDING_NORMAL
	penetrating = 0
	can_ricochet = FALSE
	embed = FALSE
	sharp = FALSE
	step_delay = 0.95
	check_armour = ARMOR_BIO
	recoil = 6
	var/allow_relay = TRUE
	serial_type_index_bullet = "GP"
	var/faction_shooter

/obj/item/projectile/bullet/shotgun/relay/gp_npc
	faction_shooter = "greyson"

//Relay a new shot!
/obj/item/projectile/bullet/shotgun/relay/attack_mob(mob/living/target_mob, distance, miss_modifier=0)
	//message_admins("health 1     [target_mob.health]")
	//We need it here so that way if we gib the mob we still relay
	var/enemy_turf = get_turf(target_mob)
	. = ..()
	//message_admins("health 2     [target_mob.health]")
	if(!testing && allow_relay)
		for(var/mob/living/M in view(5, enemy_turf)) //We base are view based on the turf to again allow non
			if(M.stat == DEAD || M == target_mob)
				continue
			if(!enemy_turf)
				continue

			if(original_firer)
				if(M.faction != original_firer.faction \
				&& M.colony_friend != original_firer.colony_friend \
				&& M.friendly_to_colony != original_firer.friendly_to_colony)

					var/obj/item/projectile/bullet/shotgun/relay/relayed = new type(enemy_turf)

					if(health >= 1)
						//message_admins("dont relay")

						relayed.allow_relay = FALSE

					relayed.relay_shoting(M, original_firer)

					//message_admins("health 4     [target_mob.health]")
					break

			if(faction_shooter)

				if(M.faction != faction_shooter)

					var/obj/item/projectile/bullet/shotgun/relay/relayed = new type(enemy_turf)

					if(health >= 1)
						//message_admins("dont relay")

						relayed.allow_relay = FALSE

					relayed.relay_shoting(M, original_firer)

					//message_admins("health 4     [target_mob.health]")
					break


/obj/item/projectile/bullet/shotgun/relay/proc/relay_shoting(mob/living/target_mob, second_shooter)
	layer = ABOVE_ALL_MOB_LAYER
	def_zone = BP_CHEST
	if(ismob(second_shooter))
		original_firer = second_shooter
		firer = second_shooter
	else
		faction_shooter = second_shooter
	launch(target_mob)

//Railgun
/obj/item/projectile/bullet/shotgun/railgun
	nocap_structures = TRUE
	hitscan = TRUE
	can_ricochet = FALSE
	affective_damage_range = 10
	affective_ap_range = 10
	recoil = 18

/obj/item/projectile/bullet/shotgun/beanbag/railgun
	hitscan = TRUE
	can_ricochet = FALSE
	affective_damage_range = 10
	affective_ap_range = 10
	recoil = 14

/obj/item/projectile/bullet/shotgun/incendiary/railgun
	hitscan = TRUE
	can_ricochet = FALSE
	affective_damage_range = 10
	affective_ap_range = 10
	recoil = 20

/obj/item/projectile/bullet/kurtz_50/railgun
	nocap_structures = TRUE
	hitscan = TRUE
	can_ricochet = FALSE
	recoil = 13

/obj/item/projectile/bullet/kurtz_50/rubber/railgun
	hitscan = TRUE
	can_ricochet = FALSE
	//ricochet_mod = 1.5
	recoil = 9
	ignition_source = FALSE

/obj/item/projectile/bullet/kurtz_50/incendiary
	damage_types = list(BRUTE = 5, HALLOSS = 5)
	embed = FALSE
	can_ricochet = FALSE
	knockback = 0
	fire_stacks = 4
	recoil = 19

/obj/item/projectile/bullet/heavy_rifle_408/railgun
	can_ricochet = FALSE
	icon_state = "toxin"
	recoil = 23

/obj/item/projectile/bullet/lrifle/incendiary
	icon_state = "fireball"
	damage_types = list(BURN = 3.5, HALLOSS = 5)
	embed = FALSE
	can_ricochet = FALSE
	knockback = 0
	recoil = 20
	fire_stacks = 4
/*
/obj/item/projectile/bullet/lrifle/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target) && !testing)
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()
*/
//Gauss rifle
/obj/item/projectile/bullet/gauss
	name = "gauss"
	icon_state = "gauss"
	mob_hit_sound = list('sound/effects/gore/sear.ogg')
	hitsound_wall = 'sound/weapons/guns/misc/ric4.ogg'
	damage_types = list(BRUTE = 40)
	armor_divisor = 4
	check_armour = ARMOR_BULLET
	embed = FALSE
	can_ricochet = FALSE
	sharp = FALSE
	affective_damage_range = 12
	affective_ap_range = 12
	hitscan = TRUE
	recoil = 38

//Should do about 68 damage at 1 tile distance (adjacent), and 40 damage at 3 tiles distance.
//Overall less damage than slugs in exchange for more damage at very close range and more embedding
/obj/item/projectile/bullet/pellet/shotgun
	name = "shrapnel"
	icon_state = "birdshot-1"
	damage_types = list(BRUTE = 16)
	armor_divisor = 0.6
	wounding_mult = WOUNDING_SMALL //lotta relatively smaller pellets.
	pellets = 4
	range_step = 2	//Range step of 1 includes base-tile..
	spread_step = 10
	knockback = 0 //We do not knockback do to issues with bullet douping
	step_delay = 0.9
	affective_damage_range = 2
	affective_ap_range = 2
	recoil = 11

/obj/item/projectile/bullet/pellet/shotgun/Initialize()
	. = ..()
	icon_state = "birdshot-[rand(1,4)]"

/obj/item/projectile/bullet/pellet/shotgun/scattershot //VERY dangerous, the weapon has a low refire rate for a reason. DO NOT use this for non exo weapons without tweaking.
	name = "heavy shrapnel"
	damage_types = list(BRUTE = 8) //We hit slightly softer than buckshot
	wounding_mult = WOUNDING_NORMAL
	pellets = 6 // but more times
	range_step = 2 //and at longer range
	step_delay = 1.1 //we travel a bit slower
	recoil = 13

//'Laser' buckshot. Effectively just burn buckshot used for the Abdication.
/obj/item/projectile/bullet/pellet/shotgun/energy
	name = "Unstable energy bolt"
	icon_state = "l_birdshot-1"
	damage_types = list(BURN = 11.5) //slightly less than buck, but FAR more painful
	armor_divisor = 2 //heated shot melt armor.
	embed = FALSE
	can_ricochet = FALSE
	sharp = FALSE
	muzzle_type = /obj/effect/projectile/plasma/muzzle/red
	check_armour = ARMOR_ENERGY
	recoil = 7
/*
//For the love of God don't make this common.
/obj/item/projectile/bullet/shotgun/payload
	name = "explosive bolt"
	icon_state = "bolter"
	damage_types = list(BRUTE = 15, HALLOSS = 5)
	wounding_mult = WOUNDING_EXTREME //Shredding
	knockback = 1
	fire_stacks = 1
	armor_divisor = 10
	nocap_structures = TRUE
	check_armour = ARMOR_BOMB
	sharp = TRUE
	edge = TRUE
	step_delay = 0.9
	recoil = 30

/obj/item/projectile/bullet/shotgun/payload/on_impact(atom/target)
	if (!testing)
		explosion(target, 0, 0, 2)
	return TRUE
*/
//Miscellaneous
/obj/item/projectile/bullet/blank
	invisibility = 101
	damage_types = list(BRUTE = 1)
	embed = FALSE
	recoil = 2

/obj/item/projectile/bullet/cap
	name = "cap"
	damage_types = list(HALLOSS = 0)
	nodamage = TRUE
	embed = FALSE
	sharp = FALSE
	recoil = 1
	kill_count = 0 //cap gun so projectile dies the second it fires. -Benl8561
	ignition_source = FALSE //dunno how you'd manage it but just in case.

/obj/item/projectile/bullet/crossbow_bolt
	name = "bolt"
	icon_state = "bolt"
	damage_types = list(BRUTE = 25)
	wounding_mult = WOUNDING_SERIOUS //decent but won't like armor
	armor_divisor = 1.3
	knockback = 0 //Bug doups hits
	supereffective_types = list(/mob/living/carbon/human = FALSE, /mob/living = TRUE)
	supereffective_mult = 1.5
	step_delay = 0.9
	affective_damage_range = 7
	affective_ap_range = 7
	recoil = 2

/obj/item/projectile/bullet/crossbow_bolt/lethal
	name = "bolt"
	icon_state = "bolt"
	damage_types = list(BRUTE = 30)
	wounding_mult = WOUNDING_WIDE //slightly bigger
	armor_divisor = 0.5
	supereffective_types = list(/mob/living/carbon/human = FALSE, /mob/living = TRUE)
	supereffective_mult = 1.5
	step_delay = 0.9
	recoil = 1

/obj/item/projectile/bullet/crossbow_bolt/hv
	name = "bolt"
	icon_state = "bolt"
	damage_types = list(BRUTE = 20)
	armor_divisor = 3
	penetrating = 3
	hitscan = TRUE
	sharp = TRUE
	supereffective_types = list(/mob/living/carbon/human = FALSE, /mob/living = TRUE)
	supereffective_mult = 1.5
	affective_damage_range = 9
	affective_ap_range = 9
	nocap_structures = TRUE //Can do well againt walls and doors
	recoil = 5

//reusable
/obj/item/projectile/bullet/reusable
	var/obj/item/create_type
	muzzle_type = null

/obj/item/projectile/bullet/reusable/on_impact(atom/A)
	..()
	if(create_type && !testing)
		new create_type(get_turf(src))

/obj/item/projectile/bullet/reusable/rod_bolt
	name = "metal rod"
	icon_state = "bolt"
	damage_types = list(BRUTE = 5) //This is multiplied by tension when fired, so it's actually 25 damage.
	armor_divisor = 1.25
	wounding_mult = WOUNDING_NORMAL //it's a whole ass rod.
	step_delay = 0.9
	embed = FALSE
	penetrating = 1
	affective_damage_range = 7
	affective_ap_range = 7
	create_type = /obj/item/stack/rods

/obj/item/projectile/bullet/reusable/rod_bolt/superheated
	name = "superheated metal rod"
	damage_types = list(BRUTE = 5, BURN = 2.5) //This is multiplied by tension when fired, so it's actually 37.5 damage.
	armor_divisor = 1.5
	wounding_mult = WOUNDING_SERIOUS //it's a SUPER HOT whole ass bolt.
	step_delay = 0.6
	embed = TRUE
	penetrating = 0
	affective_damage_range = 7
	affective_ap_range = 7
	create_type = null
	recoil = 10
	embed_mult = 1.5


/obj/item/projectile/bullet/reusable/rod_bolt/rcd
	name = "flashforged rod"
	icon_state = "bolt"
	damage_types = list(BRUTE = 5) //This is multiplied by tension when fired, so it's actually 25 damage. Slightly worse, but it's faster and has higher AP.
	armor_divisor = 2
	step_delay = 0.6
	embed = FALSE
	penetrating = 1
	affective_damage_range = 7
	affective_ap_range = 7
	create_type = /obj/item/arrow/rcd
	recoil = 6 //Scrap verson

/obj/item/projectile/bullet/reusable/rod_bolt/rcd/superhot
	name = "flashforged superheated rod"
	icon_state = "bolt"
	damage_types = list(BRUTE = 5, BURN = 2.5) //This is multiplied by tension when fired, so it's actually 57.5 damage. Slightly worse, but it's faster and has higher AP.
	armor_divisor = 20
	step_delay = 0.2
	embed = TRUE
	penetrating = 2
	affective_damage_range = 7
	affective_ap_range = 7
	create_type = null
	embed_mult = 2


/obj/item/projectile/bullet/reusable/arrow
	name = "arrow"
	icon_state = "arrow"
	damage_types = list(BRUTE = 2) //Multiplied by 10 when fired.
	armor_divisor = 0.3
	effective_faction = list("wurm", "roach", "spider", "vox_tribe", "russian", "tengo") //good against common colony mobs
	damage_mult = 2 // Turns out arrows always sucked
	embed = FALSE //don't want to embed and drop an arrow, that would be weird
	check_armour = ARMOR_MELEE
	step_delay = 0.9
	affective_damage_range = 6
	affective_ap_range = 6
	create_type = /obj/item/ammo_casing/arrow
	recoil = 0 //arrow moment
	ignition_source = FALSE

/obj/item/projectile/bullet/reusable/arrow/serrated //Lower base damage, higher embed rate, higher AP. Arrow HV's, though not as good as the Lodge's.
	name = "serrated arrow"
	icon_state = "arrow"
	embed = TRUE
	damage_types = list(BRUTE = 1.5) // 15 damage at max pull
	damage_mult = 1.5 // Less bonus damage against effective faction
	embed_mult = 3 //we are going to try really hard to embed
	armor_divisor = 0.75 // Crossbow bolts are better, however this should not penetrate armor the same as a bullet (if not MORE).
	hitscan = TRUE // As every HV ammo
	affective_damage_range = 8
	affective_ap_range = 8
	create_type = null
	shrapnel_type = /obj/item/ammo_casing/arrow/serrated //the ENTIRE arrow!
	ignition_source = FALSE

/obj/item/projectile/bullet/reusable/arrow/broadhead
	name = "broadhead arrow"
	icon_state = "arrow-broad"
	damage_types = list(BRUTE = 4.5) //Very good base damage, negligible (5) AP, but no embedding. Think of it as arrow-hollowpoints.
	embed = FALSE
	armor_divisor = 0.2
	create_type = /obj/item/ammo_casing/arrow/broadhead

/obj/item/projectile/bullet/reusable/arrow/hunting
	name = "hunting arrow"
	icon_state = "arrow-bone"
	damage_types = list(BRUTE = 1) //Multiplied by 10 when fired.
	supereffective_types = list(/mob/living/carbon/human = FALSE, /mob/living = TRUE)
	supereffective_mult = 5 //we do 10 damage base, up to 50 against SE mobs, then with 50 AP on should do ~100. Slow to fire, unwieldly, slow projectiles (but reusable), so I'll say this is fair?
	armor_divisor = 1 //high ap to take advantage of overpen on mobs
	step_delay = 0.7 // 20% faster than normal arrows
	affective_damage_range = 8 //worse than the baroque, but better than regular arrows
	affective_ap_range = 8
	create_type = /obj/item/ammo_casing/arrow/hunting

/obj/item/projectile/bullet/reusable/arrow/hunting/heavy
	name = "fragmenting hunting arrow"
	icon_state = "arrow-bone"
	damage_types = list(BRUTE = 2) //Multiplied by 10 when fired.
	armor_divisor = 0.75
	embed = TRUE
	hitscan = TRUE // Sniping round, fast
	supereffective_mult = 18 //we do 20 damage base, up to 360 against SE mobs, then with 55 (+5 hunting bow) AP on should do ~410. Baroque is around ~430 vs mobs, so roughly baroque-tier vs mobs, with the same wieldliness and different ammo costs (bone/leather/metal/plastic vs metal/cardboard).
	affective_damage_range = 10 // Worse than Baroque, better than its predecesor arrow
	affective_ap_range = 10
	create_type = null //NOT reusable.

/obj/item/projectile/bullet/reusable/arrow/reagent
	name = "chemical arrow"
	icon_state = "arrow-reagent"
	effective_faction = null
	damage_types = list(BRUTE = 0.5) //Low damage, but chem-warfarable.
	embed = FALSE
	reagent_flags = INJECTABLE | DRAINABLE | AMOUNT_VISIBLE | REFILLABLE
	step_delay = 1
	create_type = /obj/item/projectile/bullet/reusable/arrow/practice/payload
	var/volume = 15// We only splash the target with reagents, so we hold a little more than syrette arrows. Good for acids, incindiaries, etc.

/obj/item/projectile/bullet/reusable/arrow/reagent/Initialize()
	..()
	create_reagents(volume)

/obj/item/projectile/bullet/reusable/arrow/reagent/on_impact(atom/target)
	if (!testing)
		visible_message(SPAN_DANGER("The vial attached to [name] bursts, spraying [target] with its contents!"))
		reagents.splash(target, reagents.total_volume)
	return ..()

/obj/item/projectile/bullet/reusable/arrow/reagent/hypo
	name = "injector arrow"
	volume = 5 //hypo arrows only hold 5u of reagents.

/obj/item/projectile/bullet/reusable/arrow/reagent/hypo/on_impact(atom/target)
	if (!testing)
		visible_message(SPAN_DANGER("The hypo attached to [name] hits [target], injecting [target] with its contents!"))
		if(isliving(target))
			var/mob/living/injectee = target
			admin_inject_log(original_firer, target, src, reagents.log_list(), 5)
			reagents.trans_to_mob(injectee, 5, CHEM_BLOOD)
		else
			reagents.trans_to(target, 5)
	return TRUE


/obj/item/projectile/bullet/reusable/arrow/practice
	name = "training arrow"
	icon_state = "arrow-practice"
	damage_types = list(HALLOSS = 0.1)
	embed = FALSE
	nodamage = TRUE
	create_type = /obj/item/ammo_casing/arrow/practice

/obj/item/projectile/bullet/reusable/arrow/practice/payload
	name = "empty payload arrow"
	step_delay = 1.1
	create_type = /obj/item/ammo_casing/arrow/empty_payload


//spolsives here

/obj/item/projectile/bullet/reusable/arrow/explosive
	name = "explosive arrow"
	desc = "Holy shit, there's a bomb taped to this arrow!"
	icon_state = "arrow-grenade"
	effective_faction = null
	damage_types = list(HALLOSS = 1)
	embed = FALSE //impact fuze
	step_delay = 1.1 //slower
	affective_damage_range = 6
	affective_ap_range = 6
	kill_count = 7 //heavy arrow, worse aerodynamics
	create_type = null
	ignition_source = TRUE

/obj/item/projectile/bullet/reusable/arrow/explosive/on_impact(atom/target)
	if (!testing)
		explosion(target, 0, 1, 3)
	return TRUE

/obj/item/projectile/bullet/reusable/arrow/explosive/frag
	name = "frag grenade arrow"
	desc = "Holy shit, there's a military-grade frag grenade taped to this arrow!"
	var/frag_type = /obj/item/projectile/bullet/pellet/fragment/strong
	var/frag_damage = 3
	var/frag_count = 75

/obj/item/projectile/bullet/reusable/arrow/explosive/frag/on_impact(atom/target)
	if (!testing)
		fragment_explosion(target, 4, frag_type, frag_count, frag_damage, 2, 100)
	return TRUE

/obj/item/projectile/bullet/reusable/arrow/explosive/frag/sting
	name = "stinger grenade arrow"
	desc = "Holy shit, there's a police-grade stinger grenade taped to this arrow!"
	frag_type = /obj/item/projectile/bullet/pellet/fragment/rubber
	frag_damage = 1
	frag_count = 50

/obj/item/projectile/bullet/reusable/arrow/explosive/frag/on_impact(atom/target)
	if (!testing)
		fragment_explosion(target, 4, frag_type, frag_count, frag_damage, 2, 100)
	return TRUE


/obj/item/projectile/bullet/reusable/arrow/explosive/emp
	name = "electromagnetic pulse grenade arrow"
	desc = "Holy shit, there's a EMP grenade taped to this arrow!"

/obj/item/projectile/bullet/reusable/arrow/explosive/emp/on_impact(atom/target)
	if (!testing)
		empulse(target, 1, 2) //fairly weak
	return TRUE

/obj/item/projectile/bullet/reusable/arrow/explosive/flashbang
	name = "flashbang arrow"
	desc = "Holy shit, there's a flashbang taped to this arrow!"

/obj/item/projectile/bullet/reusable/arrow/explosive/flashbang/on_impact(atom/target)
	if (!testing)
		for(var/mob/living/carbon/M in hear(2, get_turf(target)))
			flashbang_bang(get_turf(target), M)

		for(var/mob/living/carbon/human/thermal_user in orange(4, target))
			if(!thermal_user.glasses)
				return
			var/obj/item/clothing/glasses/potential_thermals = thermal_user.glasses
			if(potential_thermals.overlays == global_hud.thermal)
				flashbang_without_the_bang(get_turf(target), thermal_user)

		for(var/obj/effect/blob/B in hear(2,get_turf(target)))	//Blob damage here
			var/damage = round(30/(get_dist(2,get_turf(target))+1))
			B.health -= damage
			B.update_icon()

		new /obj/effect/sparks(get_turf(target))
	return TRUE

/obj/item/projectile/bullet/reusable/arrow/explosive/heatwave
	name = "heatwave arrow"
	desc = "Holy shit, there's a heatwave grenade taped to this arrow!"

/obj/item/projectile/bullet/reusable/arrow/explosive/heatwave/on_impact(atom/target)
	if (!testing)
		heatwave(target, 1, 2, 25, TRUE, 0)
	return TRUE

/obj/item/projectile/bullet/reusable/arrow/explosive/smoke
	name = "smoke grenade arrow"
	desc = "Holy shit, there's a smoke grenade taped to this arrow!"
	var/datum/effect/effect/system/smoke_spread/bad/smoke

/obj/item/projectile/bullet/reusable/arrow/explosive/smoke/Initialize()
	..()
	if (!testing)
		src.smoke = new
		src.smoke.attach(src)

/obj/item/projectile/bullet/reusable/arrow/explosive/smoke/on_impact(atom/target)
	if (!testing)
		src.smoke.set_up(10, 0, usr.loc)
		src.smoke.start()
	return TRUE

/obj/item/projectile/bullet/reusable/arrow/explosive/smoke/Destroy()
	..()
	if (smoke)
		QDEL_NULL(smoke)