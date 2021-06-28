/*
/mob/living/carbon/superior_animal/human/excelsior
	name = "Excelsior Slave"
	desc = "An excelsior rank and file, often converted unwillingly, making them nothing more than cannon fodder as they fight against the implant controlling them. These ones are too far gone, \
	worn down from years of abuse, death is the only mercy they can have."
	icon = 'icons/mob/mobs-humanoid.dmi'
	icon_state = "excel_makarov"
	stop_automated_movement_when_pulled = 1
	wander = 0
	maxHealth = 200
	health = 200
	ranged = 1
	rapid = 1
	ranged_cooldown = 3
	projectiletype = /obj/item/projectile/bullet/pistol_35/hv
	projectilesound = 'sound/weapons/guns/fire/pistol_fire.ogg'
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "slashed"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	meat_amount = 0
	meat_type = null
	leather_amount = 0
	bones_amount = 0

	waring_faction = ""
	waring_faction_multy = 1

//Drops
	meat_amount = 4
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/human

	var/weapon1 = /obj/item/weapon/gun/projectile/clarissa/makarov
	faction = "excelsior"

/mob/living/carbon/superior_animal/human/excelsior/excel_ppsh
	icon_state = "excel_ppsh"
	projectiletype = /obj/item/projectile/bullet/pistol_35/hv
	weapon1 = /obj/item/weapon/gun/projectile/automatic/ppsh
	projectilesound = 'sound/weapons/guns/fire/grease_fire.ogg'

/mob/living/carbon/superior_animal/human/excelsior/excel_ak
	icon_state = "excel_ak"
	projectiletype = /obj/item/projectile/bullet/light_rifle_257/hv
	weapon1 = /obj/item/weapon/gun/projectile/automatic/ak47
	projectilesound = 'sound/weapons/guns/fire/ltrifle_fire.ogg'

/mob/living/carbon/superior_animal/human/excelsior/excel_vintorez
	icon_state = "excel_vintorez"
	rapid = 0 //The gun cant rapid fire...
	projectiletype = /obj/item/projectile/bullet/rifle_75/hv
	weapon1 = /obj/item/weapon/gun/projectile/automatic/vintorez
	projectilesound = 'sound/weapons/guns/fire/ltrifle_fire.ogg'

/mob/living/carbon/superior_animal/human/excelsior/excel_drozd
	icon_state = "excel_drozd"
	projectiletype = /obj/item/projectile/bullet/pistol_35/hv
	weapon1 = /obj/item/weapon/gun/projectile/automatic/drozd
	projectilesound = 'sound/weapons/guns/fire/smg_fire.ogg'

/mob/living/carbon/superior_animal/human/excelsior/death(gibbed, deathmessage = "drops its weapon as it explodes in a shower of gore when their death implant detonates!")
	..()
	new /obj/effect/gibspawner/human(src.loc)
	playsound(src, 'sound/effects/Explosion2.ogg', 75, 1, -3)
	if(weapon1)
		new weapon1(src.loc)
		weapon1 = null
	qdel(src)
	return
*/