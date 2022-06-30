// OneStar patrol borg that defends OneStar facilities
// Sprites by Keereere
/mob/living/carbon/superior_animal/robot/greyson/stalker
	name = "\"Iron Lock Security\" Stalker Mk1"
	desc = "A ruthless patrol borg that defends Greyson facilities. This one has a single \"Scaffold\" caseless rifle, still enough to kill pesky intruders."
	icon_state = "stalker_mk1"
	icon_living = "stalker_mk1"
	pass_flags = PASSTABLE

	mob_size = MOB_MEDIUM

	maxHealth = 150
	health = 150

	faction = "greyson"

	deathmessage = "suddenly shuts down, its eye light switching to a dim red."
	attacktext = "bonked"
	attack_sound = 'sound/weapons/smash.ogg'
	speak_emote = list("beeps")
	emote_see = list("beeps repeatedly", "whirrs violently", "flashes its indicator lights", "emits a ping sound")
	speak_chance = 5

	move_to_delay = 6
	turns_per_move = 5
	see_in_dark = 10
	meat_type = null
	meat_amount = 0
	stop_automated_movement_when_pulled = 0

	melee_damage_lower = 12
	melee_damage_upper = 17
	destroy_surroundings = FALSE
	armor = list(melee = 35, bullet = 25, energy = 40, bomb = 60, bio = 100, rad = 100) //We want to be gunned down, not lasered
	contaminant_immunity = TRUE

	light_range = 3
	light_color = COLOR_LIGHTING_BLUE_BRIGHT
	mob_classification = CLASSIFICATION_SYNTHETIC

	reload_message = "ejects a magazine as it loudly reloads with mechanical speed!"
	ranged = TRUE //will it shoot?
	rapid = FALSE //will it shoot fast?
	projectiletype = /obj/item/projectile/bullet/c10x24
	projectilesound = 'sound/weapons/Gunshot.ogg'
	limited_ammo = TRUE
	mag_drop = TRUE
	rounds_left = 99
	mag_type = /obj/item/ammo_magazine/c10x24/empty
	mags_left = 1
	casingtype = null
	ranged_cooldown = 5
	fire_verb = "fires"
	acceptableTargetDistance = 6
	comfy_range = 5
	range_telegraph = "'s servos begin to spool up, aiming at"

/mob/living/carbon/superior_animal/robot/greyson/stalker/New()
	. = ..()
	pixel_x = 0
	pixel_y = 0
	if(prob(1) && (!drop1))
		drop1 = /obj/item/gun/projectile/automatic/scaffold
	if(prob(30) && (!cell_drop))
		cell_drop = /obj/item/cell/large

/mob/living/carbon/superior_animal/robot/greyson/stalker/dual
	name = "\"Iron Lock Security\" Stalker Mk2"
	desc = "A ruthless patrol borg that defends Greyson facilities. This one is an upgraded version with dual \"Scaffold\" caseless rifles, don\'t stand in front of it for too long."
	icon_state = "stalker_mk2"
	icon_living = "stalker_mk2"
	ranged_cooldown = 8
	rounds_left = 33
	mags_left = 3
	maxHealth = 250
	health = 250
	rapid = TRUE


/mob/living/carbon/superior_animal/robot/greyson/stalker/dual/New()
	. = ..()
	if(prob(1) && (!drop2))
		drop2 = /obj/item/gun/projectile/automatic/scaffold

/obj/item/stalker_fuel_rod
	name = "spent fuel rod"
	desc = "A empty greyson-alloyed fuel rod, previously having contained some combustable substance. Presumably."

	icon = 'icons/obj/stack/items.dmi'
	icon_state = "rods"

	color = GLASS_COLOR_PLASMA

	origin_tech = list(TECH_GREYSON = 5, TECH_PLASMA = 3, TECH_ENGINEERING = 2)
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASMA = 1, MATERIAL_PLASMAGLASS = 1, MATERIAL_DIAMOND = 2)

// mini-boss enemy that demands attention or else they will nuke someone. VERY POWERFUL
/mob/living/carbon/superior_animal/robot/greyson/stalker/dual/plasma_cannon
	name = "\"Iron Lock Security\" Assault Stalker Mk2"
	desc = "A ruthless patrol borg that defends Greyson facilities. This one has a pair of massively oversized plasma cannons, and has been fitted with thick layers of ablative plating, although at the cost of it's mobility, melee, and ballistic defenses. This will destroy you."

	range_charge_telegraph = "'s plasma cannons grow brighter, and it hums louder, preparing to fire at"
	range_telegraph = "'s plasma cannons let out an eerie and TERRIFYING whine as it prepares to unleash it's devastating payload upon"
	target_telegraph = "begins to hum, it's plasma cannons glowing with a dim, growing light, as it turns to"

	telegraph_beam_color = COLOR_RED
	color = COLOR_RED

	rounds_left = 4
	mag_type = /obj/item/stalker_fuel_rod
	mags_left = 1

	advance = FALSE

	armor = list(melee = 10, bullet = 15, energy = 60, bomb = 100, bio = 100, rad = 100) //takes stalker armor to the extreme, also, if people want to melee the stalker that explodes apon death, power to them

	maxHealth = 470 //high hp is required due to it bombing itself a lot
	health = 470

	deathmessage = "violently explodes, its internal generator combusting in a brilliant blue-white flame!"
	reload_message = "lets out a hiss as a fuel rod ejects from its carapace!"

	projectiletype = /obj/item/projectile/hydrogen/cannon/max //devastating
	fire_delay = 7 //7 ticks of charging to fire. very important since this will fucking instakill most people
	fire_delay_initial = 7
	rapid_fire_shooting_amount = 2

	delay_for_range = 2 SECONDS
	delay_for_rapid_range = 1 SECOND

	retarget_timer = 15
	retarget_timer_initial = 15
	retarget_chance = 90

	projectilesound = 'sound/weapons/lasercannonfire.ogg'

	fire_through_walls = TRUE //this bad boy can BREAK cover

	move_to_delay = 13 //slow as hell due to it's armor and weapons. also balance reasons.

/mob/living/carbon/superior_animal/robot/greyson/stalker/dual/plasma_cannon/New()
	. = ..()

	drop1 = null
	drop2 = null //we dont want them dropping a nonexistant greyson plasma cannon

	if (prob(30) || cell_drop)
		cell_drop = /obj/item/cell/large/hyper

/mob/living/carbon/superior_animal/robot/greyson/stalker/dual/plasma_cannon/death()

	explosion(src.loc, 0, 1, 2, 3)

	. = ..()




