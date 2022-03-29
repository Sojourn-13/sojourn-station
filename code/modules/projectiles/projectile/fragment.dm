/obj/item/projectile/bullet/pellet/fragment
	damage_types = list(BRUTE = 7)
	range_step = 2

	base_spread = 0 //causes it to be treated as a shrapnel explosion instead of cone
	spread_step = 20

	silenced = TRUE //embedding messages are still produced so it's kind of weird when enabled.
	no_attack_log = 1
	muzzle_type = null

/obj/item/projectile/bullet/pellet/fragment/strong
	damage_types = list(BRUTE = 13)

/obj/item/projectile/bullet/pellet/fragment/weak
	damage_types = list(BRUTE = 3)

/obj/item/projectile/bullet/pellet/fragment/invisible
	name = "explosion"
	icon_state = "invisible"
	embed = 0
	damage_types = list(BRUTE = 16)
	check_armour = ARMOR_BOMB

/obj/item/projectile/bullet/pellet/fragment/rubber
	damage_types = list(BRUTE = 1)
	agony = 25 // 70 x 25 = 1750 pain, if all hit, rather then 32 x 150 
	embed = FALSE
	sharp = FALSE
