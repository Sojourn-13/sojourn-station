//// 9mm ////

/obj/item/ammo_casing/pistol_35
	desc = "A 9mm bullet casing."
	icon_state = "pistol_c_l"
	spent_icon = "pistol_c_l-spent"
	shell_color = "l"
	caliber = CAL_PISTOL
	projectile_type = /obj/item/projectile/bullet/pistol_35
	maxamount = 15

/obj/item/ammo_casing/pistol_35/prespawned
	amount = 15

/obj/item/ammo_casing/pistol_35/spent
	projectile_type = null

/obj/item/ammo_casing/pistol_35/hv
	desc = "A 9mm high-velocity bullet casing."
	icon_state = "pistol_c_hv"
	spent_icon = "pistol_c_hv-spent"
	shell_color = "hv"
	projectile_type = /obj/item/projectile/bullet/pistol_35/hv

/obj/item/ammo_casing/pistol_35/spent/hv
	shell_color = "hv"
	icon_state = "pistol_c_hv"
	spent_icon = "pistol_c_hv-spent"
	projectile_type = null

/obj/item/ammo_casing/pistol_35/practice
	desc = "A 9mm practice bullet casing."
	icon_state = "pistol_c_p"
	spent_icon = "pistol_c_p-spent"
	shell_color = "p"
	projectile_type = /obj/item/projectile/bullet/pistol_35/practice

/obj/item/ammo_casing/pistol_35/rubber
	desc = "A 9mm rubber bullet casing."
	icon_state = "pistol_c_r"
	spent_icon = "pistol_c_r-spent"
	shell_color = "r"
	projectile_type = /obj/item/projectile/bullet/pistol_35/rubber

/obj/item/ammo_casing/pistol_35/rubber/pepperball
	desc = "A 9mm pepper-ball projectile casing."
	icon_state = "pistol_c_pepper"
	spent_icon = "pistol_c_pepper-spent"
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/pistol_35/rubber/pepperball

/obj/item/ammo_casing/pistol_35/rubber/soporific_cbo
	desc = "A 9mm soporific condensed plastic shell."
	icon_state = "pistol_c_r"
	spent_icon = "pistol_c_r-spent"
	projectile_type = /obj/item/projectile/bullet/pistol_35/rubber/soporific/cbo
	is_caseless = TRUE

/obj/item/ammo_casing/pistol_35/lethal
	desc = "A 9mm hollow-point bullet casing."
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/pistol_35/lethal

/obj/item/ammo_casing/pistol_35/spent/lethal
	projectile_type = null
	shell_color = "l"

/obj/item/ammo_casing/pistol_35/scrap
	desc = "An old 9mm bullet casing."
	icon_state = "pistol_c_s"
	spent_icon = "pistol_c_s-spent"
	shell_color = "s"
	projectile_type = /obj/item/projectile/bullet/pistol_35/scrap

/obj/item/ammo_casing/pistol_35/scrap/prespawned
	amount = 15

/obj/item/ammo_casing/pistol_35/laser
	desc = "A 9mm laser casing."
	projectile_type = /obj/item/projectile/beam/weak/pistol_35

/obj/item/ammo_casing/pistol_35/biomatter
	desc = "A caseless 9mm caustic."
	projectile_type = /obj/item/projectile/bullet/pistol_35/biomatter
	icon_state = "clrifle_c_s"
	shell_color = "s"
	is_caseless = TRUE

//// 10mm ////

/obj/item/ammo_casing/magnum_40
	desc = "A 10mm Magnum bullet casing."
	icon_state = "magnum_c_l"
	spent_icon = "magnum_c_l-spent"
	caliber = CAL_MAGNUM
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/magnum_40
	maxamount = 6

/obj/item/ammo_casing/magnum_40/prespawned
	amount = 6

/obj/item/ammo_casing/magnum_40/practice
	desc = "A 10mm Magnum practice bullet casing."
	icon_state = "magnum_c_p"
	spent_icon = "magnum_c_p-spent"
	shell_color = "p"
	projectile_type = /obj/item/projectile/bullet/magnum_40/practice

/obj/item/ammo_casing/magnum_40/hv
	desc = "A 10mm Magnum high-velocity bullet casing."
	icon_state = "magnum_c_hv"
	spent_icon = "magnum_c_hv-spent"
	shell_color = "hv"
	projectile_type = /obj/item/projectile/bullet/magnum_40/hv

/obj/item/ammo_casing/magnum_40/rubber
	desc = "A 10mm Magnum rubber bullet casing."
	icon_state = "magnum_c_r"
	spent_icon = "magnum_c_r-spent"
	shell_color = "r"
	projectile_type = /obj/item/projectile/bullet/magnum_40/rubber

/obj/item/ammo_casing/magnum_40/rubber/pepperball
	desc = "A 10mm Magnum pepper-ball projectile casing."
	icon_state = "magnum_c_pepper"
	spent_icon = "magnum_c_pepper-spent"
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/magnum_40/rubber/pepperball

/obj/item/ammo_casing/magnum_40/lethal
	desc = "A 10mm Magnum hollow point bullet casing."
	icon_state = "magnum_c_l"
	spent_icon = "magnum_c_l-spent"
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/magnum_40/lethal

/obj/item/ammo_casing/magnum_40/laser
	desc = "A 10mm Magnum laser casing."
	projectile_type = /obj/item/projectile/beam/weak/magnum_40

/obj/item/ammo_casing/magnum_40/scrap
	desc = "An old 10mm Magnum bullet casing."
	icon_state = "magnum_c_s"
	spent_icon = "magnum_c_s-spent"
	shell_color = "s"
	projectile_type = /obj/item/projectile/bullet/magnum_40/scrap

/obj/item/ammo_casing/magnum_40/scrap/prespawned
	amount = 6

/obj/item/ammo_casing/magnum_40/biomatter
	desc = "A caseless 10mm Magnum Caustic."
	projectile_type = /obj/item/projectile/bullet/magnum_40/biomatter
	icon_state = "clrifle_c_p"
	shell_color = "s"
	is_caseless = TRUE

/obj/item/ammo_casing/magnum_40/spent
	projectile_type = null

//// 6.5 carbine ////

/obj/item/ammo_casing/light_rifle_257
	desc = "A 6.5mm bullet casing."
	icon_state = "srifle_c_l"
	spent_icon = "srifle_c_l-spent"
	shell_color = "l"
	caliber = CAL_LRIFLE
	projectile_type = /obj/item/projectile/bullet/light_rifle_257
	maxamount = 10

/obj/item/ammo_casing/light_rifle_257/prespawned
	amount = 10

/obj/item/ammo_casing/light_rifle_257/practice
	desc = "A 6.5mm practice bullet casing."
	icon_state = "srifle_c_p"
	spent_icon = "srifle_c_p-spent"
	shell_color = "p"
	projectile_type = /obj/item/projectile/bullet/light_rifle_257/practice

/obj/item/ammo_casing/light_rifle_257/hv
	desc = "A 6.5mm high-velocity bullet casing."
	icon_state = "srifle_c_hv"
	spent_icon = "srifle_c_hv-spent"
	shell_color = "hv"
	projectile_type = /obj/item/projectile/bullet/light_rifle_257/hv

/obj/item/ammo_casing/light_rifle_257/rubber
	desc = "A 6.5mm rubber bullet casing."
	icon_state = "srifle_c_r"
	spent_icon = "srifle_c_r-spent"
	shell_color = "r"
	projectile_type = /obj/item/projectile/bullet/light_rifle_257/rubber

/obj/item/ammo_casing/light_rifle_257/rubber/pepperball
	desc = "A 6.5mm pepper-ball projectile casing."
	icon_state = "lrifle_c_pepper"
	spent_icon = "lrifle_c_pepper-spent"
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/light_rifle_257/rubber/pepperball

/obj/item/ammo_casing/light_rifle_257/scrap
	desc = "An old 6.5mm rifle bullet casing."
	icon_state = "srifle_c_s"
	spent_icon = "srifle_c_s-spent"
	shell_color = "p"
	projectile_type = /obj/item/projectile/bullet/light_rifle_257/scrap

/obj/item/ammo_casing/light_rifle_257/scrap/prespawned
	amount = 10

/obj/item/ammo_casing/light_rifle_257/lethal
	desc = "A 6.5mm hollow-point bullet casing."
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/light_rifle_257/lethal

/obj/item/ammo_casing/light_rifle_257/incend
	desc = "A 6.5mm incendiary bullet casing."
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/light_rifle_257/incend

/obj/item/ammo_casing/light_rifle_257/incend/prespawned
	amount = 10

/obj/item/ammo_casing/light_rifle_257/laser
	desc = "A 6.5mm laser casing."
	projectile_type = /obj/item/projectile/beam/weak/light_rifle_257

//// 7.62mm Rifle ////

/obj/item/ammo_casing/rifle_75
	desc = "A 7.62mm bullet casing."
	icon_state = "srifle_c_l"
	spent_icon = "srifle_c_l-spent"
	shell_color = "l"
	caliber = CAL_RIFLE
	projectile_type = /obj/item/projectile/bullet/rifle_75
	maxamount = 10

/obj/item/ammo_casing/rifle_75/prespawned
	amount = 10

/obj/item/ammo_casing/rifle_75/hv
	desc = "A 7.62mm high-velocity bullet casing."
	icon_state = "srifle_c_hv"
	spent_icon = "srifle_c_hv-spent"
	shell_color = "hv"
	projectile_type = /obj/item/projectile/bullet/rifle_75/hv

/obj/item/ammo_casing/rifle_75/rubber
	desc = "A 7.62mm rubber bullet casing."
	icon_state = "srifle_c_r"
	spent_icon = "srifle_c_r-spent"
	shell_color = "r"
	projectile_type = /obj/item/projectile/bullet/rifle_75/rubber

/obj/item/ammo_casing/rifle_75/practice
	desc = "A 7.62mm practice bullet casing."
	icon_state = "srifle_c_p"
	spent_icon = "srifle_c_p-spent"
	projectile_type = /obj/item/projectile/bullet/rifle_75/practice

/obj/item/ammo_casing/rifle_75/lethal
	desc = "A 7.62mm hollow-point bullet casing."
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/rifle_75/lethal

/obj/item/ammo_casing/rifle_75/incend
	desc = "A 7.62mm incendiary bullet casing."
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/rifle_75/incend

/obj/item/ammo_casing/rifle_75/incend/prespawned
	amount = 10

/obj/item/ammo_casing/rifle_75/scrap
	desc = "An old 7.62mm bullet casing."
	icon_state = "srifle_c_s"
	spent_icon = "srifle_c_s-spent"
	shell_color = "p"
	projectile_type = /obj/item/projectile/bullet/rifle_75/scrap

/obj/item/ammo_casing/rifle_75/scrap/prespawned
	amount = 10

/obj/item/ammo_casing/rifle_75/laser
	desc = "A 7.62mm laser casing."
	projectile_type = /obj/item/projectile/beam/weak/rifle_75

//// 8.6mm heavy rifle////

/obj/item/ammo_casing/heavy_rifle_408
	desc = "A 8.6mm bullet casing."
	icon_state = "lrifle_c_l"
	spent_icon = "lrifle_c_l-spent"
	shell_color = "l"
	caliber = CAL_HRIFLE
	projectile_type = /obj/item/projectile/bullet/heavy_rifle_408
	maxamount = 10

/obj/item/ammo_casing/heavy_rifle_408/prespawned
	amount = 10

/obj/item/ammo_casing/heavy_rifle_408/rubber
	desc = "A 8.6mm rubber bullet casing."
	icon_state = "lrifle_c_r"
	spent_icon = "lrifle_c_r-spent"
	shell_color = "r"
	projectile_type = /obj/item/projectile/bullet/heavy_rifle_408/rubber

/obj/item/ammo_casing/heavy_rifle_408/practice
	desc = "A 8.6mm training bullet casing."
	icon_state = "lrifle_c_p"
	spent_icon = "lrifle_c_p-spent"
	shell_color = "p"
	projectile_type = /obj/item/projectile/bullet/heavy_rifle_408/practice

/obj/item/ammo_casing/heavy_rifle_408/hv
	desc = "A 8.6mm high-velocity bullet casing."
	icon_state = "lrifle_c_hv"
	spent_icon = "lrifle_c_hv-spent"
	shell_color = "hv"
	projectile_type = /obj/item/projectile/bullet/heavy_rifle_408/hv

/obj/item/ammo_casing/heavy_rifle_408/lethal
	desc = "A 8.6mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/heavy_rifle_408/lethal

/obj/item/ammo_casing/heavy_rifle_408/incend
	desc = "A 8.6mm incendiary bullet casing."
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/heavy_rifle_408/incend

/obj/item/ammo_casing/heavy_rifle_408/incend/prespawned
	amount = 10

/obj/item/ammo_casing/heavy_rifle_408/scrap
	desc = "An old 8.6mm rifle bullet casing."
	icon_state = "lrifle_c_s"
	spent_icon = "lrifle_c_s-spent"
	shell_color = "p"
	projectile_type = /obj/item/projectile/bullet/heavy_rifle_408/scrap

/obj/item/ammo_casing/heavy_rifle_408/scrap/prespawned
	amount = 10

/obj/item/ammo_casing/heavy_rifle_408/laser
	desc = "A 8.6mm laser casing."
	projectile_type = /obj/item/projectile/beam/weak/heavy_rifle_408

/obj/item/ammo_casing/heavy_rifle_408/spent
	projectile_type = null

/obj/item/ammo_casing/heavy_rifle_408/hv/spent
	projectile_type = null

///10mm caseless
/obj/item/ammo_casing/c10x24
	desc = "A 10x24mm caseless cartidge."
	caliber = "10x24"
	icon_state = "caseless"
	projectile_type = /obj/item/projectile/bullet/c10x24
	is_caseless = TRUE

//Flare, .22
/obj/item/ammo_casing/flare
	name = "flare shell"
	desc = "A chemical flare shell designed to produce a distress signal or illuminate an area."
	caliber = CAL_FLARE
	icon_state = "f-shell"
	spent_icon = "f-shell-spent"
	projectile_type = /obj/item/projectile/bullet/flare
	matter = list(MATERIAL_PLASTIC = 1)
	matter_reagents = list("phosphorus" = 3)
	maxamount = 3

/obj/item/ammo_casing/flare/prespawn
	amount = 3

/obj/item/ammo_casing/flare/old
	name = "old flare shell"
	desc = "A chemical flare shell designed to produce a distress signal or illuminate an area."
	caliber = CAL_FLARE
	icon_state = "old-shell"
	spent_icon = "old-shell-spent"
	projectile_type = /obj/item/projectile/bullet/flare/chaos
	matter = list(MATERIAL_PLASTIC = 1)
	matter_reagents = list("phosphorus" = 3)
	maxamount = 1

/obj/item/ammo_casing/flare/old/prespawn
	amount = 1

/obj/item/ammo_casing/flare/blue
	name = "blue flare shell"
	desc = "A chemical flare shell designed to produce a blue distress signal or illuminate an area."
	caliber = CAL_FLARE
	icon_state = "b-shell"
	spent_icon = "b-shell-spent"
	projectile_type = /obj/item/projectile/bullet/flare/blue
	matter = list(MATERIAL_PLASTIC = 1)
	matter_reagents = list("phosphorus" = 3)
	maxamount = 3

/obj/item/ammo_casing/flare/blue/prespawn
	amount = 3

/obj/item/ammo_casing/flare/green
	name = "green flare shell"
	desc = "A chemical flare shell designed to produce a green distress signal or illuminate an area."
	caliber = CAL_FLARE
	icon_state = "g-shell"
	spent_icon = "g-shell-spent"
	projectile_type = /obj/item/projectile/bullet/flare/green
	matter = list(MATERIAL_PLASTIC = 1)
	matter_reagents = list("phosphorus" = 3)
	maxamount = 3

/obj/item/ammo_casing/flare/green/prespawn
	amount = 3

// 12mm HEAVY PISTOL

/obj/item/ammo_casing/kurtz_50
	desc = "A 12mm bullet casing."
	caliber = CAL_50
	projectile_type = /obj/item/projectile/bullet/kurtz_50
	shell_color = "l"
	icon_state = "lrifle_c_l"
	spent_icon = "lrifle_c_l-spent"

/obj/item/ammo_casing/kurtz_50/prespawned
	amount = 6

/obj/item/ammo_casing/kurtz_50/rubber
	desc = "A 12mm rubber bullet casing."
	caliber = CAL_50
	projectile_type = /obj/item/projectile/bullet/kurtz_50/rubber
	shell_color = "r"
	icon_state = "lrifle_c_r"
	spent_icon = "lrifle_c_r-spent"

/obj/item/ammo_casing/kurtz_50/rubber/pepperball
	desc = "A 12mm pepper-ball projectile casing."
	icon_state = "lrifle_c_pepper"
	spent_icon = "lrifle_c_pepper-spent"
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/kurtz_50/rubber/pepperball

/obj/item/ammo_casing/kurtz_50/practice
	desc = "A 12mm practice bullet casing."
	caliber = CAL_50
	projectile_type = /obj/item/projectile/bullet/kurtz_50/practice
	shell_color = "p"
	icon_state = "lrifle_c_p"
	spent_icon = "lrifle_c_p-spent"

/obj/item/ammo_casing/kurtz_50/hv
	desc = "A 12mm high-velocity bullet casing."
	caliber = CAL_50
	projectile_type = /obj/item/projectile/bullet/kurtz_50/hv
	shell_color = "hv"
	icon_state = "lrifle_c_hv"
	spent_icon = "lrifle_c_hv-spent"

/obj/item/ammo_casing/kurtz_50/lethal
	desc = "A 12mm hollow point bullet casing."
	caliber = CAL_50
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/kurtz_50/lethal

/obj/item/ammo_casing/kurtz_50/laser
	desc = "A 12mm laser casing."
	caliber = CAL_50
	projectile_type = /obj/item/projectile/beam/weak/kurtz_50

//// .60-06 ////
/obj/item/ammo_casing/antim
	name = "shell casing"
	desc = "A 14.5mm Anti-Materiel shell."
	icon_state = "atmr"
	spent_icon = "atmr-spent"
	caliber = CAL_ANTIM
	projectile_type = /obj/item/projectile/bullet/antim
	maxamount = 5

/obj/item/ammo_casing/antim/prespawned
	amount = 5

/obj/item/ammo_casing/antim/scrap
	name = "shell casing"
	desc = "An old 14.5mm Anti-Materiel shell."
	icon_state = "atmr_s"
	spent_icon = "atmr_s-spent"
	projectile_type = /obj/item/projectile/bullet/antim/scrap
	maxamount = 5

/obj/item/ammo_casing/antim/scrap/prespawned
	amount = 5

/obj/item/ammo_casing/antim/lethal
	name = "\"Red-Nose\" shell casing"
	desc = "A SA 14.5mm Anti-Materiel \"Red-Nose\" shell."
	icon_state = "atmr_red"
	spent_icon = "atmr_red-spent"
	projectile_type = /obj/item/projectile/bullet/antim/lethal

/obj/item/ammo_casing/antim/lethal/prespawned
	amount = 5

/obj/item/ammo_casing/antim/ion
	name = "\"Off-Switch\" shell casing"
	desc = "A SA 14.5mm Anti-Materiel \"Off-Switch\" shell."
	icon_state = "atmr_red"
	spent_icon = "atmr_red-spent"
	projectile_type = /obj/item/projectile/bullet/antim/ion

/obj/item/ammo_casing/antim/ion/prespawned
	amount = 5

/obj/item/ammo_casing/antim/incend
	desc = "\"Willy Pete\" shell casing"
	shell_color = "atmr_red"
	spent_icon = "atmr_red-spent"
	projectile_type = /obj/item/projectile/bullet/antim/incend

/obj/item/ammo_casing/antim/incend/prespawned
	amount = 5

//// 17mm rolled shot ////
/obj/item/ammo_casing/ball
	name = "shell casing"
	desc = "A 17mm rolled shot casing."
	icon_state = "ball"
	spent_icon = "ball-spent"
	caliber = CAL_BALL
	projectile_type = /obj/item/projectile/bullet/ball
	maxamount = 5

/obj/item/ammo_casing/ball/prespawned
	amount = 4

//// Shotgun ammo ////
/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 20mm sabot slug."
	icon_state = "s-shell_hv"
	spent_icon = "s-shell_hv-spent"
	shell_color = "hv"
	caliber = CAL_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun
	maxamount = 5

/obj/item/ammo_casing/shotgun/spent
	projectile_type = null

/obj/item/ammo_casing/shotgun/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/ceramic
	name = "ceramic slug"
	desc = "A 20mm sabot slug with compact ceramic material inside."
	icon_state = "s-shell_ceramic"
	spent_icon = "s-shell_ceramic-spent"
	shell_color = "ceramic"
	caliber = CAL_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun/ceramic
	maxamount = 5

/obj/item/ammo_casing/shotgun/ceramic/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/scrap
	name = "old shotgun slug"
	desc = "An older 20mm slug."
	icon_state = "s-shell_s"
	spent_icon = "s-shell_s-spent"
	shell_color = "scrap"
	caliber = CAL_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun/scrap
	maxamount = 5

/obj/item/ammo_casing/shotgun/scrap/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A 20mm beanbag shell."
	icon_state = "s-shell_r"
	spent_icon = "s-shell_r-spent"
	shell_color = "r"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	maxamount = 5

/obj/item/ammo_casing/shotgun/beanbag/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/beanbag/pepperball
	name = "beanbag shell"
	desc = "A 20mm beanbag shell."
	icon_state = "s-shell_pepper"
	spent_icon = "s-shell_pepper-spent"
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag/pepperball
	maxamount = 5

/obj/item/ammo_casing/shotgun/beanbag/pepperball/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/beanbag/scrap
	name = "old beanbag shell"
	desc = "An older 20mm beanbag shell."
	icon_state = "s-shell_rs"
	spent_icon = "s-shell_rs-spent"
	shell_color = "scrap_r"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag/scrap

/obj/item/ammo_casing/shotgun/beanbag/scrap/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/pellet
	name = "shotgun shell"
	desc = "A 20mm buckshot shell."
	icon_state = "s-shell_l"
	spent_icon = "s-shell_l-spent"
	shell_color = "l"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	maxamount = 5

/obj/item/ammo_casing/shotgun/pellet/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/pellet/scrap
	name = "old shotgun shell"
	desc = "An older 20mm shell."
	icon_state = "s-shell_ss"
	spent_icon = "s-shell_ss-spent"
	shell_color = "scrap_s"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun/scrap

/obj/item/ammo_casing/shotgun/pellet/scrap/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun shell"
	desc = "A blank 20mm shell."
	icon_state = "s-shell_b"
	spent_icon = "s-shell_b-spent"
	shell_color = "b"
	projectile_type = /obj/item/projectile/bullet/blank
	maxamount = 5

/obj/item/ammo_casing/shotgun/blank/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/practice
	name = "shotgun shell"
	desc = "A 20mm practice shell."
	icon_state = "s-shell_b"
	spent_icon = "s-shell_b-spent"
	shell_color = "b"
	projectile_type = /obj/item/projectile/bullet/shotgun/practice
	maxamount = 5

/obj/item/ammo_casing/shotgun/practice/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/incendiary
	name = "incendiary shell"
	desc = "A 20mm chemical shell with highly flammable load."
	icon_state = "s-shell_i"
	spent_icon = "s-shell_i-spent"
	shell_color = "i"
	projectile_type = /obj/item/projectile/bullet/shotgun/incendiary

/obj/item/ammo_casing/shotgun/incendiary/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/laser
	name = "laser shell"
	desc = "A 20mm laser shell."
	icon_state = "lasershell"
	spent_icon = "lasershell-spent"
	shell_color = "i"
	projectile_type = /obj/item/projectile/beam/shotgun
	maxamount = 5

/obj/item/ammo_casing/shotgun/laser/prespawned
	amount = 5
/*
/obj/item/ammo_casing/shotgun/payload
	name = "explosive shell"
	desc = "A 20mm explosive shell."
	icon_state = "s-shell_p"
	spent_icon = "s-shell_p-spent"
	shell_color = "p"
	projectile_type = /obj/item/projectile/bullet/shotgun/payload
	maxamount = 5
	is_caseless = TRUE

/obj/item/ammo_casing/shotgun/payload/prespawned
	amount = 5
*/
/obj/item/ammo_casing/shotgun/plasma
	name = "plasma shell"
	desc = "A 20mm plasma shell."
	icon_state = "plasmashell"
	spent_icon = "plasmashell-spent"
	shell_color = "i"
	projectile_type = /obj/item/projectile/plasma/shell
	maxamount = 5

/obj/item/ammo_casing/shotgun/plasma/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/plasma_heavy
	name = "heavy plasma shell"
	desc = "A 20mm heavy plasma shot shell."
	icon_state = "plasmaheavy"
	spent_icon = "plasmaheavy-spent"
	shell_color = "i"
	projectile_type = /obj/item/projectile/plasma/heavy/shell
	maxamount = 5

/obj/item/ammo_casing/shotgun/plasma_heavy/prespawned
	amount = 5

/obj/item/ammo_casing/shotgun/biomatter
	name = "shotgun slug"
	desc = "A New Testament paper cartridge with caustic sabot, in 20mm. Designed for deep-impact delivery of caustic biomass, \
	in a caseless fashion. The cartridge is made of a form of wax paper, designed to burn away and leave nothing to eject after being fired."
	icon_state = "s-shell_caustic"
	is_caseless = TRUE
	caliber = CAL_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun/biomatter
	maxamount = 5

/obj/item/ammo_casing/shotgun/biomatter/prespawned
	amount = 5

//Todo give this a cool animation
/obj/item/ammo_casing/shotgun/relay
	name = "GP relay shell"
	desc = "A 20mm relay shot shell. \
	A highly advanced AI controled bullet, plating in advanced materals and chemicals that are unable to be salvanged. \
	When shot into a living or robotic target the bullet will relay a second projectile to the next closest target, this will repeat on succesful kills automatically."
	icon_state = "relay-shell"
	spent_icon = "relay-shell-spent"
	shell_color = "i"
	projectile_type = /obj/item/projectile/bullet/shotgun/relay
	maxamount = 1

//Can stun in one hit if aimed at the head, but
//is blocked by clothing that stops tasers and is vulnerable to EMP
/obj/item/ammo_casing/shotgun/stunshell
	name = "taser shell"
	desc = "A 20mm gauge taser cartridge."
	icon_state = "stunshell"
	spent_icon = "stunshell-spent"
	shell_color = "i"
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	maxamount = 5

/obj/item/ammo_casing/shotgun/stunshell/emp_act(severity)
	if(prob(100/severity)) BB = null
	update_icon()

/obj/item/ammo_casing/shotgun/stunshell/prespawned
	amount = 5

//Does not stun, only blinds, but has area of effect.
/obj/item/ammo_casing/shotgun/illumination
	name = "flash shell"
	desc = "A chemical shell used to signal distress or provide illumination."
	icon_state = "s-shell_f"
	spent_icon = "s-shell_f-spent"
	shell_color = "f"
	projectile_type = /obj/item/projectile/energy/flash/flare
	maxamount = 5

/obj/item/ammo_casing/shotgun/illumination/prespawned
	amount = 5

//Misc
/obj/item/ammo_casing/rocket
	name = "PG-7VL grenade"
	desc = "A 40mm warhead designed for the RPG-7 launcher. Has tubular shape."
	icon_state = "rocketshell"
	projectile_type = /obj/item/projectile/bullet/rocket
	caliber = CAL_ROCKET
	maxamount = 1
	reload_delay = 15
	is_caseless = TRUE
	w_class = ITEM_SIZE_NORMAL

/obj/item/ammo_casing/rocket/scrap
	name = "scrap rocket"
	desc = "An old improvised rocket shell for the RPG-7 launcher. Has a tubular shape."
	icon_state = "old_rocketshell"
	projectile_type = /obj/item/projectile/bullet/rocket/scrap
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASMA = 2)

/obj/item/ammo_casing/rocket/scrap/prespawned
	amount = 1

/obj/item/ammo_casing/rocket/emp
	name = "PG-7EMP grenade"
	desc = "A 40mm EMP/Flash warhead designed for the RPG-7 launcher. Has a tubular shape."
	projectile_type = /obj/item/projectile/bullet/rocket/emp
/*
/obj/item/ammo_casing/a75
	name = "microjet casing"
	desc = "A 19mm gyrojet rocket."
	caliber = CAL_70
	projectile_type = /obj/item/projectile/bullet/gyro

/obj/item/ammo_casing/a75/spent
	projectile_type = null
*/
/obj/item/ammo_casing/cap
	name = "cap"
	desc = "A cap for children toys."
	caliber = CAL_CAP
	color = "#FF0000"
	projectile_type = /obj/item/projectile/bullet/cap

/obj/item/ammo_casing/cap/prespawned
	amount = 15

/obj/item/ammo_casing/laser_223
	name = "laser casing"
	desc = "A .223 pulse charged laser cavity."
	caliber = CAL_SCI
	projectile_type = /obj/item/projectile/beam/laser_223

/obj/item/ammo_casing/beam/spent
	projectile_type = null
/*
/obj/item/ammo_casing/laser_223/ap
	desc = "A .223 pulse charged laser cavity. This type possess an integrated sensor array that adjusts the focal point to the targets location, allowing for better penetration for the cost of firepower due to the occupied space."
	projectile_type = /obj/item/projectile/beam/laser_223/ap

/obj/item/ammo_casing/laser_223/lethal
	desc = "A .223 pulse charged laser cavity. This type uses a wide witdh lense to cause less overpenetration and cause more damage in exchange of being more susceptible to armor. Its cal is 5.56mm."
	projectile_type = /obj/item/projectile/beam/laser_223/lethal
*/
/obj/item/ammo_casing/beam/ap/spent
	projectile_type = null
	desc = "A spent .223 pulse charged laser cavity. Its metal case is molten and shows an array of discolaretion"

//// Grenade Shells ////

/obj/item/ammo_casing/grenade
	name = "baton round"
	desc = "A less-lethal rubber round, designed to be fired from grenade launchers"
	icon_state = "baton-round"
	spent_icon = "grenadeshell"
	projectile_type = /obj/item/projectile/bullet/batonround
	w_class = ITEM_SIZE_SMALL
	caliber = CAL_GRENADE
	maxamount = 1
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)

/obj/item/ammo_casing/grenade/blast
	name = "blast grenade shell"
	desc = "An explosive grenade shell, designed to be fired from grenade launchers."
	icon_state = "blast"
	projectile_type = /obj/item/projectile/bullet/grenade

/obj/item/ammo_casing/grenade/frag
	name = "frag grenade shell"
	desc = "A frag grenade shell, designed to be fired from grenade launchers."
	icon_state = "frag"
	projectile_type = /obj/item/projectile/bullet/grenade/frag

/obj/item/ammo_casing/grenade/frag/stinger
	name = "stinger grenade shell"
	desc = "A stinger grenade shell, designed to be fired from grenade launchers."
	projectile_type = /obj/item/projectile/bullet/grenade/frag/stinger

/obj/item/ammo_casing/grenade/emp
	name = "emp grenade shell"
	desc = "An EMP grenade shell, designed to be fired from grenade launchers."
	icon_state = "emp"
	projectile_type = /obj/item/projectile/bullet/grenade/emp

/obj/item/ammo_casing/grenade/flash
	name = "flash grenade shell"
	desc = "A grenade shell containing specific chemical substances similar to those used in flashbangs, designed to be fired from gernade launchers."
	icon_state = "flash"
	projectile_type = /obj/item/projectile/bullet/grenade/flash

//Cross Bolt ammo
/obj/item/ammo_casing/crossbow_bolts
	name = "crossbow bolt"
	desc = "A finely made bolt designed for a crossbow."
	icon_state = "bolt"
	caliber = CAL_CROSSBOW
	projectile_type = /obj/item/projectile/bullet/crossbow_bolt
	matter = list(MATERIAL_STEEL = 1)
	maxamount = 10
	is_caseless = TRUE

/obj/item/ammo_casing/crossbow_bolts/bulk //Admin spawn stuff
	amount = 10

/obj/item/ammo_casing/crossbow_bolts/fragment
	name = "fragment crossbow bolt"
	desc = "A finely made bolt designed for a crossbow with sharp shards of ores and rocks attached to the tip that break apart inside the target."
	icon_state = "bolt"
	projectile_type = /obj/item/projectile/bullet/crossbow_bolt/lethal
	matter = list(MATERIAL_STEEL = 1)
	maxamount = 10

/obj/item/ammo_casing/crossbow_bolts/fragment/bulk //Admin spawn stuff
	amount = 10

/obj/item/ammo_casing/crossbow_bolts/speed
	name = "aerodynamic crossbow bolt"
	desc = "A finely made bolt designed for a crossbow added fletching and balance to shoot true and faster."
	icon_state = "bolt"
	projectile_type = /obj/item/projectile/bullet/crossbow_bolt/hv
	matter = list(MATERIAL_STEEL = 1)
	maxamount = 10

/obj/item/ammo_casing/crossbow_bolts/speed/bulk //Admin spawn stuff
	amount = 10

/obj/item/ammo_casing/rod_bolt
	name = "metal rod"
	desc = "Wait a second, this is a bullet!"
	icon = 'icons/obj/stack/items.dmi'
	icon_state = "rods"
	caliber = "rod" //not a define
	projectile_type = /obj/item/projectile/bullet/reusable/rod_bolt
	matter = list(MATERIAL_STEEL = 1)
	maxamount = 1
	is_caseless = TRUE

/obj/item/ammo_casing/rod_bolt/rcd
	name = "flashforged rod"
	desc = "Wait a second, this is a flashforged bullet!"
	projectile_type = /obj/item/projectile/bullet/reusable/rod_bolt/rcd

//arrows
/obj/item/ammo_casing/arrow
	name = "arrow"
	desc = "A crudely made cardboard-fletched metal-headed arrow."
	icon_state = "arrow"
	w_class = ITEM_SIZE_SMALL
	caliber = CAL_ARROW
	force = WEAPON_FORCE_NORMAL
	armor_divisor = ARMOR_PEN_GRAZING
	projectile_type = /obj/item/projectile/bullet/reusable/arrow
	matter = list(MATERIAL_STEEL = 0.5, MATERIAL_WOOD = 0.5, MATERIAL_PLASTIC= 0.5)
	maxamount = 3
	is_caseless = TRUE

/obj/item/ammo_casing/arrow/bulk
	amount = 3

/obj/item/ammo_casing/arrow/hunting
	name = "hunting arrow"
	icon_state = "arrow-bone"
	desc = "A good-quality handmade arrow, with a bone head and leaf fletching. The head is shaped to allow easy removal from an animal's corpse."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/hunting

/obj/item/ammo_casing/arrow/hunting/bulk
	amount = 3

/obj/item/ammo_casing/arrow/hunting/heavy
	name = "broadhead hunting arrow"
	icon_state = "arrow-broadbone"
	desc = "A good-quality handmade arrow, with a bone head and leaf fletching. The head is shaped to stick fast in wounds- it likely won't be retrievable from a corpse."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/hunting/heavy

/obj/item/ammo_casing/arrow/hunting/heavy/bulk
	amount = 3

/obj/item/ammo_casing/arrow/broadhead
	name = "broadhead arrow"
	icon_state = "arrow-broad"
	force = WEAPON_FORCE_PAINFUL
	armor_divisor = 1
	desc = "A good-quality handmade arrow, with a metal head and plastic fletching. This one has quite a broad head, capable of causing severe damage to unarmored targets, but reducing its ability to penetrate armor."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/broadhead

/obj/item/ammo_casing/arrow/serrated
	name = "serrated arrow"
	icon_state = "arrow-serrated"
	force = WEAPON_FORCE_PAINFUL
	armor_divisor = 1
	desc = "A good-quality handmade aerodinamic arrow, with a metal head and plastic fletching. This one has wicked sharp serrated blades along its head, letting it stick in wounds easily, penetrating thick hide and armor alike at fast speeds."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/serrated

/obj/item/ammo_casing/arrow/reagent
	name = "vial arrow"
	icon_state = "arrow-vial"
	desc = "An arrow with a aerodynamic plastic head and a fragile glass vial attached, which should shatter on impact."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/reagent
	maxamount = 1

/obj/item/ammo_casing/arrow/reagent/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/reagent_containers) && BB)
		var/obj/item/reagent_containers/the_inpcontainer = I
		var/trans = the_inpcontainer.reagents.trans_to_obj(BB, the_inpcontainer.amount_per_transfer_from_this)
		to_chat(user, SPAN_NOTICE("You fill the [BB.name] with [trans] units of the solution."))
	..()

/obj/item/ammo_casing/arrow/reagent/hypo
	name = "injector arrow"
	icon_state = "arrow-hypo"
	desc = "An arrow with a reinforced hypodermic needle sticking out. Looks quite painful."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/reagent/hypo

/obj/item/ammo_casing/arrow/practice
	name = "training arrow"
	icon_state = "arrow-practice"
	force = WEAPON_FORCE_HARMLESS
	desc = "A plastic-fletched training arrow, with a light-coloured plastic tip."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/practice
	matter = list(MATERIAL_PLASTIC = 0.1)
	maxamount = 10

/obj/item/ammo_casing/arrow/practice/bulk
	amount = 10

//payload arrows
/obj/item/ammo_casing/arrow/empty_payload
	name = "streamlined ultralight arrow"
	desc = "A finely-made arrow with an aerodynamic plastic tip. Looks like it has small mounting points attached along the shaft."
	force = WEAPON_FORCE_HARMLESS
	icon_state = "arrow-practice"
	maxamount = 4
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/practice/payload
	var/list/special_crafting_types = list(/obj/item/grenade/explosive = /obj/item/ammo_casing/arrow/explosive,
	/obj/item/mine/improvised = /obj/item/ammo_casing/arrow/explosive/frag,
	/obj/item/mine = /obj/item/ammo_casing/arrow/explosive,
	/obj/item/grenade/frag/stinger = /obj/item/ammo_casing/arrow/explosive/frag/sting,
	/obj/item/grenade/frag = /obj/item/ammo_casing/arrow/explosive/frag,
	/obj/item/grenade/empgrenade = /obj/item/ammo_casing/arrow/explosive/emp,
	/obj/item/grenade/flashbang = /obj/item/ammo_casing/arrow/explosive/flashbang,
	/obj/item/grenade/heatwave = /obj/item/ammo_casing/arrow/explosive/heatwave,
	/obj/item/grenade/smokebomb = /obj/item/ammo_casing/arrow/explosive/smoke,
	/obj/item/reagent_containers/hypospray/autoinjector = /obj/item/ammo_casing/arrow/reagent/hypo,
	/obj/item/reagent_containers/glass/beaker/vial = /obj/item/ammo_casing/arrow/reagent)

/obj/item/ammo_casing/arrow/empty_payload/bulk
	amount = 4

/obj/item/ammo_casing/arrow/empty_payload/attackby(obj/item/I, mob/user)
	if(is_type_in_list(I, special_crafting_types, TRUE))
		if(amount > 1)
			to_chat(user, SPAN_NOTICE("Seperate an arrow from the stack before attaching a payload."))
			return
		var/creation = is_type_in_list(I, special_crafting_types, TRUE)
		new creation(get_turf(src))
		qdel(src)
		qdel(I)
	..()

/obj/item/ammo_casing/arrow/explosive
	name = "grenade arrow"
	desc = "Holy shit, there's a bomb taped to this arrow!"
	force = WEAPON_FORCE_HARMLESS
	maxamount = 2
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/explosive

/obj/item/ammo_casing/arrow/explosive/frag
	name = "frag grenade arrow"
	icon_state = "arrow-explosive"
	desc = "A pared-down frag grenade attached to an arrow. This likely won't go far, or fast."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/explosive/frag

/obj/item/ammo_casing/arrow/explosive/frag/sting
	name = "stingball grenade arrow"
	icon_state = "arrow-sting"
	desc = "A stinger grenade attached to an arrow. This likely won't go far, or fast."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/explosive/frag/sting

/obj/item/ammo_casing/arrow/explosive/emp
	name = "EMP grenade arrow"
	icon_state = "arrow-emp"
	desc = "An aerodynamic plastic-tipped arrow, with some electronics attached."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/explosive/emp

/obj/item/ammo_casing/arrow/explosive/flashbang
	name = "flashbang arrow"
	icon_state = "arrow-flashbang"
	desc = "A fairly unaerodynamic arrow, with a pared-down flashbang grenade attached."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/explosive/flashbang

/obj/item/ammo_casing/arrow/explosive/heatwave
	name = "heatwave grenade arrow"
	icon_state = "arrow-heatwave"
	desc = "A fairly unaerodynamic arrow with a pared-down heatwave grenade attached. Thankfully, the pin's still in."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/explosive/heatwave

/obj/item/ammo_casing/arrow/explosive/smoke
	name = "smoke grenade arrow"
	icon_state = "arrow-smoke"
	desc = "A fairly unaerodynamic arrow, with a pared-down smoke grenade attached."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/explosive/smoke
