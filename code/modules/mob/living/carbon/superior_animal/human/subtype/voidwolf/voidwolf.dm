//Void Wolfs are VERY wip. They're set up as basic enemies with the sprites.

/*Melee Void Wolfs*/
/mob/living/carbon/superior_animal/human/voidwolf
	name = "Void Wolf Commando"
	desc = "A Void Wolf mercenary wielding an energy blade and riot shield."
	icon = 'icons/mob/mobs-humanoid.dmi'
	icon_state = "voidwolf_melee"
	icon_dead = "voidwolf_melee_dead"
	stop_automated_movement_when_pulled = 0
	maxHealth = 200
	health = 200
	melee_damage_lower = 30
	melee_damage_upper = 30
	breath_required_type = 0 // Doesn't need to breath, in a space suit
	breath_poison_type = 0 // Can't be poisoned
	min_air_pressure = 0 // Doesn't need pressure
	attacktext = "slashed"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	meat_amount = 0
	meat_type = null
	leather_amount = 0
	bones_amount = 0

	armor = list(melee = 10, bullet = 10, energy = 10, bomb = 0, bio = 100, rad = 50) //Legitmently their armor


//They are all waring space suits
	breath_required_type = NONE
	breath_poison_type = NONE
	min_breath_required_type = 0
	min_breath_poison_type = 0

	min_air_pressure = 0
	min_bodytemperature = 0

//Drops
	meat_amount = 4
	meat_type = /obj/item/reagent_containers/food/snacks/meat/human

	var/weapon1 = /obj/item/melee/energy/sword/pirate
	var/weapon2 = /obj/item/shield/riot
	faction = "pirate"


/mob/living/carbon/superior_animal/human/voidwolf/death()
	..()
	if(weapon1)
		new weapon1 (src.loc)
		weapon1 = null
	if(weapon2)
		new weapon2 (src.loc)
		weapon2 = null

/mob/living/carbon/superior_animal/human/voidwolf/emp_act(severity)
	..()
	if(rapid)
		rapid = FALSE
	if(prob(95) && ranged)
		ranged = FALSE


/mob/living/carbon/superior_animal/human/voidwolf/fieldtech
	name = "Void Wolf Field Tech"
	desc = "A Void Wolf mercenary wielding an industrial welder."
	melee_damage_lower = 20
	melee_damage_upper = 22
	icon_state = "voidengie"
	icon_dead = "voidengie_dead"
	attacktext = "burnt"
	attack_sound = 'sound/items/Welder.ogg'
	weapon1 = /obj/item/tool/weldingtool/advanced
	weapon2 = null

/*Ranged Void Wolfs*/
/mob/living/carbon/superior_animal/human/voidwolf/ranged
	name = "Void Wolf Trooper"
	desc = "A Void Wolf mercenary wielding an energy rifle."
	icon_state = "voidwolf"
	icon_dead = "voidwolf_dead"
	projectilesound = 'sound/weapons/laser.ogg'
	melee_damage_lower = 10 //We dont like melee
	melee_damage_upper = 15
	maxHealth = 100
	health = 100
	ranged = TRUE
	rapid = TRUE
	ranged_cooldown = 3
	projectiletype = /obj/item/projectile/beam
	weapon1 = /obj/item/gun/energy/cog
	weapon2 = null
	limited_ammo = TRUE
	mag_drop = TRUE
	rounds_left = 16
	mag_type = /obj/item/cell/medium/high/depleted
	mags_left = 1

/mob/living/carbon/superior_animal/human/voidwolf/ranged/Initialize(mapload)
	..()
	reload_message = "[name] ejects a depleted cell and rapidly reloads a new one!"

/mob/living/carbon/superior_animal/human/voidwolf/fieldtech/ranged
	name = "Void Wolf Field Tech"
	desc = "A Void Wolf mercenary wielding an industrial welder and energy pistol."
	icon_state = "voidengie_ranged"
	icon_dead = "voidengie_ranged_dead"
	melee_damage_lower = 20
	melee_damage_upper = 22
	ranged = TRUE
	rapid = FALSE
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/weapons/laser.ogg'
	weapon2 = /obj/item/gun/energy/gun/martin
	limited_ammo = TRUE
	mag_drop = TRUE
	rounds_left = 4
	mag_type = /obj/item/cell/small/high/depleted
	mags_left = 2

/mob/living/carbon/superior_animal/human/voidwolf/fieldtech/ranged/Initialize(mapload)
	..()
	reload_message = "[name] ejects a depleted cell and fumbles a new one into their weapon."

/mob/living/carbon/superior_animal/human/voidwolf/aerotrooper
	name = "Void Wolf Aerotrooper"
	desc = "A Void Wolf mercenary wielding an energy rifle and jetpack."
	icon_state = "voidwolf_flying"
	icon_dead = "voidwolf_flying_dead"
	melee_damage_lower = 10 //We dont like melee
	melee_damage_upper = 15
	ranged_cooldown = 3
	ranged = TRUE
	rapid = TRUE
	projectiletype = /obj/item/projectile/beam
	weapon1 = /obj/item/gun/energy/cog
	weapon2 = null
	limited_ammo = TRUE
	mag_drop = TRUE
	rounds_left = 16
	mag_type = /obj/item/cell/medium/high/depleted
	mags_left = 2

/mob/living/carbon/superior_animal/human/voidwolf/aerotrooper/Initialize(mapload)
	..()
	reload_message = "[name] ejects a depleted cell and rapidly reloads a new one!"

/mob/living/carbon/superior_animal/human/voidwolf/captain
	name = "Void Wolf Captain"
	desc = "A Void Wolf field commander wielding an energy sword and Spider Rose combo. "
	icon_state = "voidwolfcap"
	icon_dead = "voidwolfcap_dead"
	melee_damage_lower = 30
	melee_damage_upper = 35
	maxHealth = 200
	health = 200
	ranged_cooldown = 3
	ranged = TRUE
	rapid = FALSE
	projectiletype = /obj/item/projectile/beam
	weapon1 = /obj/item/melee/energy/sword/pirate
	weapon2 = /obj/item/gun/energy/gun
	limited_ammo = TRUE
	mag_drop = TRUE
	rounds_left = 8
	mag_type = /obj/item/cell/medium/high/depleted
	mags_left = 1

/mob/living/carbon/superior_animal/human/voidwolf/captain/Initialize(mapload)
	..()
	reload_message = "[name] ejects a depleted cell and rapidly reloads a new one with one hand!"

//Reavers, the void wolf elite.
/mob/living/carbon/superior_animal/human/voidwolf/elite
	name = "Void Reaver Stormtrooper"
	desc = "A void wolf reaver stormtrooper, vatgrown and given bionic enhancements, with far better equipment and decades of experience raiding ships and killing men under the command of a true reaver."
	icon_state = "reaver_lasrak"
	projectilesound = 'sound/weapons/Laser.ogg'
	melee_damage_lower = 20 //We dont like melee
	melee_damage_upper = 25
	ranged = TRUE
	rapid = TRUE
	ranged_cooldown = 3
	projectiletype = /obj/item/projectile/beam/weak/smg
	weapon1 = /obj/item/gun/energy/firestorm
	weapon2 = null
	limited_ammo = TRUE
	mag_drop = TRUE
	rounds_left = 20
	mag_type = /obj/item/cell/medium/high/depleted
	mags_left = 3

	armor = list(melee = 60, bullet = 55, energy = 50, bomb = 75, bio = 100, rad = 25) //Legitmently their armor

/mob/living/carbon/superior_animal/human/voidwolf/elite/Initialize(mapload)
	..()
	reload_message = "[name] ejects a depleted cell and rapidly reloads a new one!"

/mob/living/carbon/superior_animal/human/voidwolf/elite/c20r
	icon_state = "reaver_bulldog"
	projectilesound = 'sound/weapons/guns/fire/smg_fire.ogg'
	projectiletype = /obj/item/projectile/bullet/pistol_35/hv
	weapon1 = /obj/item/gun/projectile/automatic/c20r
	weapon2 = null
	rounds_left = 32
	mag_type = /obj/item/ammo_magazine/smg_35/empty
	mags_left = 3

/mob/living/carbon/superior_animal/human/voidwolf/elite/c20r/Initialize(mapload)
	..()
	reload_message = "[name] rapidly reloads before the empty mag hits the ground!"

/mob/living/carbon/superior_animal/human/voidwolf/elite/c20r/emp_act(severity)
	return

/mob/living/carbon/superior_animal/human/voidwolf/elite/gyrojet
	icon_state = "reaver_gyro"
	projectilesound = 'sound/weapons/guns/fire/hpistol_fire.ogg'
	projectiletype = /obj/item/projectile/bullet/gyro
	weapon1 = /obj/item/gun/projectile/gyropistol
	weapon2 = null
	rapid = FALSE
	rounds_left = 4
	mag_type = /obj/item/ammo_magazine/a75/empty
	mags_left = 0 //no spare mags, they are lethal

/mob/living/carbon/superior_animal/human/voidwolf/elite/gyrojet/Initialize(mapload)
	..()
	reload_message = "[name] rapidly reloads before the empty mag hits the ground!"// You should be panicing

/mob/living/carbon/superior_animal/human/voidwolf/elite/gyrojet/emp_act(severity)
	return

/mob/living/carbon/superior_animal/human/voidwolf/elite/myrmidon
	icon_state = "reaver_melee"
	melee_damage_lower = 35
	melee_damage_upper = 40
	ranged = FALSE
	rapid = FALSE
	limited_ammo = FALSE
	weapon1 = /obj/item/tool/sword/saber/cutlass
	weapon2 = /obj/item/shield/buckler/energy/reaver
	armor = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 0,
		agony = 1000 //Pain damage proof, and rubber proof.
	)

/mob/living/carbon/superior_animal/human/voidwolf/elite/myrmidon/Initialize(mapload)
	..()
	reload_message = "[name] rapidly reloads?!"

/mob/living/carbon/superior_animal/human/voidwolf/elite/myrmidon/emp_act(severity)
	return

/mob/living/carbon/superior_animal/human/voidwolf/elite/myrmidon/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(prob(65))
		visible_message("\red \b [src] blocks the [O]!")
		return
	..()


/mob/living/carbon/superior_animal/human/voidwolf/elite/myrmidon/bullet_act(var/obj/item/projectile/Proj)
	if(!Proj)	return
	if(prob(65))
		..()
	else
		visible_message("\red <B>[src] blocks [Proj] with its shield!</B>")
	return 0

/mob/living/carbon/superior_animal/human/voidwolf/elite/Initialize()
	..()
	if(prob(50))
		icon_state = "[icon_state]_elite"

/mob/living/carbon/superior_animal/human/voidwolf/elite/death(gibbed, deathmessage = "drops its weapon as it explodes in a shower of gore when their death implant detonates!")
	..()
	new /obj/effect/gibspawner/human(src.loc)
	playsound(src, 'sound/effects/Explosion2.ogg', 75, 1, -3)
	if(weapon1)
		new weapon1(src.loc)
		weapon1 = null
	if(weapon2)
		new weapon2(src.loc)
		weapon2 = null
	qdel(src)
	return
