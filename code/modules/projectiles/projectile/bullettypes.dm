//There are important things regarding this file:
//Rubbers are non sharp, embed capable objects, with non existing armor penetration. Their agony damage is generally lower then actual one.
//The caliber amount was lowered for a reason, don't add more bloat. If you need different values, use gun vars.
//HV exist as antag option for better ammo.
//* Step delays - default value is 1. Lower value makes bullet go faster, higher value makes bullet go slower.

//Low-caliber pistols and SMGs
//*********************************//
///.35 Auto///
/obj/item/projectile/bullet/pistol_35
	damage_types = list(BRUTE = 16)
	armor_penetration = 5
	step_delay = 0.75
	can_ricochet = TRUE

/obj/item/projectile/bullet/pistol_35/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 3)
	agony = 22
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE

/obj/item/projectile/bullet/pistol_35/hv
	damage_types = list(BRUTE = 20)
	armor_penetration = 10
	step_delay = 0.5
	can_ricochet = TRUE

/obj/item/projectile/bullet/pistol_35/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 1)
	agony = 3
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	step_delay = 0.75
	can_ricochet = FALSE

/obj/item/projectile/bullet/pistol_35/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 18)
	agony = 20
	armor_penetration = 0
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = TRUE
	step_delay = 0.55


//Revolvers and high-caliber pistols
//*********************************//
/// .40 Magnum ///

/obj/item/projectile/bullet/magnum_40
	damage_types = list(BRUTE = 24)
	armor_penetration = 10
	can_ricochet = TRUE
	step_delay = 0.75

/obj/item/projectile/bullet/magnum_40/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 2)
	agony = 3
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = FALSE
	step_delay = 0.75

/obj/item/projectile/bullet/magnum_40/hv
	damage_types = list(BRUTE = 28)
	armor_penetration = 25
	penetrating = 1
	step_delay = 0.5

/obj/item/projectile/bullet/magnum_40/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 5)
	agony = 30
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	step_delay = 0.9

/obj/item/projectile/bullet/magnum_40/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 26)
	agony = 32
	armor_penetration = 5
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = TRUE
	step_delay = 0.5

/// .50 Kurtz ///
/obj/item/projectile/bullet/kurtz_50
	damage_types = list(BRUTE = 30)
	armor_penetration = 15
	can_ricochet = TRUE
	step_delay = 0.75

/obj/item/projectile/bullet/kurtz_50/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 6)
	agony = 32
	check_armour = ARMOR_MELEE
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = TRUE
	step_delay = 0.9

/obj/item/projectile/bullet/kurtz_50/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 2)
	agony = 3
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = FALSE
	step_delay = 0.75

/obj/item/projectile/bullet/kurtz_50/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 32)
	agony = 32
	armor_penetration = 5
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = TRUE
	step_delay = 0.8

/obj/item/projectile/bullet/kurtz_50/hv
	name = "AV bullet"
	damage_types = list(BRUTE = 36)
	armor_penetration = 20
	penetrating = 2
	can_ricochet = FALSE
	embed = TRUE
	sharp = TRUE
	step_delay = 0.5


//Carbines and rifles
//*********************************//

/// .257 Carbine///

/obj/item/projectile/bullet/light_rifle_257
	damage_types = list(BRUTE = 16)
	armor_penetration = 15
	penetrating = 1
	can_ricochet = TRUE
	step_delay = 0.3

/obj/item/projectile/bullet/light_rifle_257/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 2)
	agony = 2
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = FALSE
	step_delay = 0.5

/obj/item/projectile/bullet/light_rifle_257/hv
	damage_types = list(BRUTE = 18)
	armor_penetration = 24
	penetrating = 2
	hitscan = TRUE

/obj/item/projectile/bullet/light_rifle_257/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 3)
	agony = 20
	check_armour = ARMOR_MELEE
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = TRUE
	step_delay = 0.9

/obj/item/projectile/bullet/light_rifle_257/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 18)
	agony = 20
	armor_penetration = 5
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = TRUE
	step_delay = 0.6

/obj/item/projectile/bullet/light_rifle_257/nomuzzle
	muzzle_type = null

///7.5 Rifle///

/obj/item/projectile/bullet/rifle_75
	damage_types = list(BRUTE = 26)
	armor_penetration = 20
	penetrating = 1
	can_ricochet = TRUE
	step_delay = 0.5

/obj/item/projectile/bullet/rifle_75/hv
	damage_types = list(BRUTE = 25)
	armor_penetration = 30
	penetrating = 2
	can_ricochet = TRUE
	step_delay = 0.3

/obj/item/projectile/bullet/rifle_75/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 2)
	agony = 2
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = FALSE

/obj/item/projectile/bullet/rifle_75/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 4)
	agony = 26
	check_armour = ARMOR_MELEE
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = TRUE
	step_delay = 0.9

/obj/item/projectile/bullet/rifle_75/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 25)
	agony = 28
	armor_penetration = 5
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = TRUE
	step_delay = 0.8

/// .408 OMNI ///

/obj/item/projectile/bullet/heavy_rifle_408
	damage_types = list(BRUTE = 20)
	armor_penetration = 30
	penetrating = 2
	can_ricochet = TRUE
	step_delay = 0.3

/obj/item/projectile/bullet/heavy_rifle_408/rubber
	name = "rubber bullet"
	icon_state = "rubber"
	damage_types = list(BRUTE = 8)
	agony = 32
	check_armour = ARMOR_MELEE
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = TRUE
	step_delay = 0.9

/obj/item/projectile/bullet/heavy_rifle_408/practice
	name = "practice bullet"
	damage_types = list(BRUTE = 2)
	agony = 2
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	can_ricochet = FALSE
	step_delay = 0.5

/obj/item/projectile/bullet/heavy_rifle_408/hv
	name = "sabot penetrator"
	damage_types = list(BRUTE = 24)
	armor_penetration = 40
	penetrating = 3
	hitscan = TRUE

/obj/item/projectile/bullet/heavy_rifle_408/lethal
	name = "hollow-point bullet"
	damage_types = list(BRUTE = 22)
	agony = 32
	armor_penetration = 35
	penetrating = 0
	can_ricochet = FALSE
	embed = TRUE
	sharp = TRUE
	step_delay = 0.5

///Snowflake caseless///

/obj/item/projectile/bullet/c10x24
	damage_types = list(BRUTE = 16)
	armor_penetration = 15
	penetrating = 2
	can_ricochet = TRUE
	sharp = TRUE
	step_delay = 0.3

//Sniper rifles
/obj/item/projectile/bullet/antim
	damage_types = list(BRUTE = 90)
	armor_penetration = 100
	stun = 5
	weaken = 10
	penetrating = 5
	hitscan = TRUE //so the PTR isn't useless as a sniper weapon

//Shotguns
//*********************************//

/obj/item/projectile/bullet/shotgun
	name = "slug"
	icon_state = "slug"
	damage_types = list(BRUTE = 55) //normal would be 45
	armor_penetration = 10
	knockback = 0 //Bug doups hits
	step_delay = 0.9

/obj/item/projectile/bullet/shotgun/beanbag
	name = "beanbag"
	icon_state = "rubber"
	check_armour = ARMOR_BULLET //neverforget
	damage_types = list(BRUTE = 10)
	agony = 60
	armor_penetration = 0
	embed = FALSE
	sharp = FALSE
	step_delay = 1.65

/obj/item/projectile/bullet/shotgun/practice
	name = "practice slug"
	damage_types = list(BRUTE = 4)
	agony = 5
	armor_penetration = 0
	embed = FALSE
	knockback = 0

/obj/item/projectile/bullet/shotgun/incendiary
	damage_types = list(BURN = 10)
	agony = 5
	armor_penetration = 0
	embed = FALSE
	knockback = 0
	var/fire_stacks = 4

/obj/item/projectile/bullet/shotgun/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

//Railgun
/obj/item/projectile/bullet/shotgun/railgun
	hitscan = TRUE
	can_ricochet = FALSE

/obj/item/projectile/bullet/shotgun/beanbag/railgun
	hitscan = TRUE
	can_ricochet = FALSE

/obj/item/projectile/bullet/shotgun/incendiary/railgun
	hitscan = TRUE
	can_ricochet = FALSE

/obj/item/projectile/bullet/kurtz/railgun
	hitscan = TRUE
	can_ricochet = FALSE

/obj/item/projectile/bullet/kurtz/rubber/railgun
	hitscan = TRUE
	can_ricochet = FALSE

/obj/item/projectile/bullet/kurtz/incendiary
	damage_types = list(BRUTE = 10)
	agony = 5
	armor_penetration = 0
	embed = FALSE
	can_ricochet = FALSE
	knockback = 0
	var/fire_stacks = 4

/obj/item/projectile/bullet/kurtz/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

/obj/item/projectile/bullet/hrifle/railgun
	can_ricochet = FALSE
	icon_state = "toxin"

/obj/item/projectile/bullet/lrifle/incendiary
	icon_state = "fireball"
	damage_types = list(BURN = 7)
	agony = 5
	armor_penetration = 0
	embed = FALSE
	can_ricochet = FALSE
	knockback = 0
	var/fire_stacks = 4

/obj/item/projectile/bullet/lrifle/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

//Should do about 68 damage at 1 tile distance (adjacent), and 40 damage at 3 tiles distance.
//Overall less damage than slugs in exchange for more damage at very close range and more embedding
/obj/item/projectile/bullet/pellet/shotgun
	name = "shrapnel"
	icon_state = "birdshot-1"
	damage_types = list(BRUTE = 18)
	pellets = 4
	range_step = 1
	spread_step = 10
	knockback = 0 //We do not knockback do to issues with bullet douping
	step_delay = 0.9

/obj/item/projectile/bullet/pellet/shotgun/Initialize()
	. = ..()
	icon_state = "birdshot-[rand(1,4)]"

//For the love of God don't make this common.
/obj/item/projectile/bullet/shotgun/payload
	name = "explosive bolt"
	icon_state = "bolter"
	damage_types = list(BRUTE = 30)
	agony = 5
	knockback = 1
	var/fire_stacks = 2
	armor_penetration = 10
	check_armour = ARMOR_BOMB
	sharp = TRUE
	edge = TRUE
	step_delay = 0.9

/obj/item/projectile/bullet/shotgun/payload/on_hit(atom/target)
	explosion(target, -1, 0, 2)
	return TRUE
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(fire_stacks)
		M.IgniteMob()

//Miscellaneous
/obj/item/projectile/bullet/blank
	invisibility = 101
	damage_types = list(BRUTE = 1)
	embed = FALSE

/obj/item/projectile/bullet/cap
	name = "cap"
	damage_types = list(HALLOS = 0)
	nodamage = TRUE
	embed = FALSE
	sharp = FALSE
