//BIG CELLS - for APC, borgs and machinery.

/obj/item/cell/large
	name = "Lonestar \"Robustcell 2000L\""
	desc = "Lonestar branded rechargeable L-standardized power cell. This one is the cheapest you can find."
	icon_state = "b_st"
	maxcharge = 2000
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 3, MATERIAL_SILVER = 3)
	price_tag = 200

/obj/item/cell/large/high
	name = "Lonestar \"Robustcell 6000L\""
	desc = "Lonestar branded rechargeable L-standardized power cell. Popular and reliable version."
	icon_state = "b_hi"
	origin_tech = list(TECH_POWER = 2)
	maxcharge = 6000

/obj/item/cell/large/super
	name = "Lonestar \"Robustcell 16000L\""
	desc = "Lonestar branded rechargeable L-standardized power cell. This industrial version can store even more energy."
	icon_state = "b_sup"
	origin_tech = list(TECH_POWER = 5)
	maxcharge = 16000

/obj/item/cell/large/hyper
	name = "Lonestar \"Robustcell-X 20000L\""
	desc = "Lonestar-brand rechargeable L-standardized power cell. This is the top of the class most advanced version of cell on the market."
	icon_state = "b_hy"
	origin_tech = list(TECH_POWER = 6)
	maxcharge = 20000

/obj/item/cell/large/moebius
	name = "Soteria \"Power-Geyser 2000L\""
	desc = "Soteria Institute-brand rechargeable L-standardized power cell. This one is as cheap as Lonestar models, yet improved in all senses."
	icon_state = "meb_b_st"
	maxcharge = 2000

/obj/item/cell/large/moebius/high
	name = "Soteria \"Power-Geyser 8000L\""
	desc = "Soteria Laboratories branded rechargeable L-standardized power cell. Popular and reliable version."
	icon_state = "meb_b_hi"
	origin_tech = list(TECH_POWER = 2)
	maxcharge = 8000

/obj/item/cell/large/moebius/super
	name = "Soteria \"Power-Geyser 14000L\""
	desc = "Soteria Institute-brand rechargeable L-standardized power cell. This industrial version can store even more energy."
	icon_state = "meb_b_sup"
	origin_tech = list(TECH_POWER = 5)
	maxcharge = 14000

/obj/item/cell/large/moebius/hyper
	name = "Soteria \"Power-Geyser 18000L\""
	desc = "Soteria Institute-brand rechargeable L-standardized power cell. Regarded as the second most powerful cell on the market."
	icon_state = "meb_b_hy"
	origin_tech = list(TECH_POWER = 6)
	maxcharge = 18000

/obj/item/cell/large/moebius/omega
	name = "Soteria \"Omega-Geyser 20000L\""
	desc = "Soteria Institute-brand rechargeable L-standardized power cell. This one being part of the Omega line, making it the be-all-end-all power cell of its type, yet to hit the open market."
	icon_state = "meb_b_omega"
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 3, MATERIAL_SILVER = 3, MATERIAL_GOLD = 6)
	origin_tech = list(TECH_POWER = 7)
	maxcharge = 20000
	max_chargerate = 0.24

/obj/item/cell/large/moebius/nuclear
	name = "Soteria \"Atomcell 14000L\""
	desc = "Soteria Institute branded rechargeable L-standardized power cell. This version able to recharge itself over time."
	icon_state = "meb_b_nu"
	autorecharging = TRUE
	origin_tech = list(TECH_POWER = 6)
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 3, MATERIAL_SILVER = 3, MATERIAL_URANIUM = 6)
	maxcharge = 14000
	price_tag = 400

/obj/item/cell/large/greyson
	name = "GP-SI \"Posi-cell 16000L\""
	desc = "GP-SI branded rechargeable L-standardized power cell that recharges itself over time. This type has yet to hit the market!"
	icon_state = "greyson_b_omega"
	maxcharge = 16000
	autorecharging = TRUE
	autorecharge_rate = 0.06
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 3, MATERIAL_PLATINUM = 3, MATERIAL_URANIUM = 6)
	price_tag = 600

/obj/item/cell/large/excelsior
	name = "Excelsior \"Zarya 18000L\""
	desc = "Commie rechargeable L-standardized power cell. Power to the people!"
	icon_state = "exs_l"
	origin_tech = list(TECH_POWER = 3)
	matter = list(MATERIAL_STEEL = 4, MATERIAL_PLASTIC = 2)
	maxcharge = 18000

/obj/item/cell/large/neotheology
	name = "Absolute \"Spark 13000L\""
	desc = "Absolute branded non-rechargeable L-standardized power cell."
	icon_state = "b_nt"
	matter = list(MATERIAL_STEEL = 3, MATERIAL_BIOMATTER = 15)
	maxcharge = 13000
	max_chargerate = 0
	created_max_charge = TRUE

/obj/item/cell/large/neotheology/plasma
	name = "Absolute \"Radiance 20000L\""
	desc = "Absolute branded non-rechargeable L-standardized power cell. This advanced version can store even more energy."
	icon_state = "b_nt_pl"
	matter = list(MATERIAL_STEEL = 3, MATERIAL_BIOMATTER = 7.5)
	maxcharge = 20000

//Meme cells - for fun

/obj/item/cell/large/potato
	name = "potato battery"
	desc = "A rechargeable starch based power cell."
	origin_tech = list(TECH_POWER = 1)
	icon = 'icons/obj/power.dmi'
	icon_state = "potato_cell"
	charge = 100
	maxcharge = 300
	minor_fault = 1
	price_tag = 50
	matter = null

//MEDIUM CELLS - for energy weapons and large devices

/obj/item/cell/medium
	name = "Lonestar \"Robustcell 600M\""
	desc = "Lonestar branded rechargeable M-standardized power cell. This one is the cheapest you can find."
	icon_state = "m_st"
	w_class = ITEM_SIZE_SMALL
	force = WEAPON_FORCE_HARMLESS
	throw_speed = 5
	throw_range = 7
	maxcharge = 600
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_SILVER = 2)
	price_tag = 100

/obj/item/cell/medium/depleted
	charge = 0
	starts_max_charge = FALSE

/obj/item/cell/medium/high
	name = "Lonestar \"Robustcell 800M\""
	desc = "Lonestar branded rechargeable M-standardized power cell. Popular and reliable version."
	icon_state = "m_hi"
	origin_tech = list(TECH_POWER = 2)
	maxcharge = 800

/obj/item/cell/medium/high/depleted
	charge = 0
	starts_max_charge = FALSE

/obj/item/cell/medium/super
	name = "Lonestar \"Robustcell 1000M\""
	desc = "Lonestar-brand rechargeable M-standardized power cell. This industrial version can store even more energy."
	icon_state = "m_sup"
	origin_tech = list(TECH_POWER = 5)
	maxcharge = 1000

/obj/item/cell/medium/hyper
	name = "Lonestar \"Robustcell-X 1600M\""
	desc = "Lonestar branded rechargeable M-standardized power cell. This is the top of the class most advanced version of cell on the market."
	icon_state = "m_hy"
	origin_tech = list(TECH_POWER = 6)
	maxcharge = 1600

/obj/item/cell/medium/moebius
	name = "Soteria \"Power-Geyser 800M\""
	desc = "Soteria branded rechargeable M-standardized power cell. This one is as cheap as Lonestar models come."
	icon_state = "meb_m_st"
	maxcharge = 800

/obj/item/cell/medium/moebius/high
	name = "Soteria \"Power-Geyser 1000M\""
	desc = "Soteria Institute branded rechargeable M-standardized power cell. Popular and reliable version."
	icon_state = "meb_m_hi"
	origin_tech = list(TECH_POWER = 2)
	maxcharge = 1000

/obj/item/cell/medium/moebius/super
	name = "Soteria \"Power-Geyser 1200M\""
	desc = "Soteria Institute branded rechargeable M-standardized power cell. This industrial version can store even more energy."
	icon_state = "meb_m_sup"
	origin_tech = list(TECH_POWER = 5)
	maxcharge = 1200

/obj/item/cell/medium/moebius/hyper
	name = "Soteria \"Power-Geyser 1400M\""
	desc = "Soteria Institute branded rechargeable M-standardized power cell. Regarded as the second most powerful cell on the market."
	icon_state = "meb_m_hy"
	origin_tech = list(TECH_POWER = 6)
	maxcharge = 1400

/obj/item/cell/medium/moebius/omega
	name = "Soteria \"Omega-Geyser 1600M\""
	desc = "Soteria Institute branded rechargeable M-standardized power cell. This one being part of the Omega line, making it the be-all-end-all power cell of its type, yet to hit the open market."
	icon_state = "meb_m_omega"
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_SILVER = 2, MATERIAL_GOLD = 4)
	origin_tech = list(TECH_POWER = 7)
	maxcharge = 1600
	max_chargerate = 0.24

/obj/item/cell/medium/moebius/nuclear
	name = "Soteria \"Atomcell 1000M\""
	desc = "Soteria Institute branded rechargeable M-standardized power cell. This version able to recharge itself over time."
	icon_state = "meb_m_nu"
	autorecharging = TRUE
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_SILVER = 2, MATERIAL_URANIUM = 4)
	origin_tech = list(TECH_POWER = 6)
	maxcharge = 1000
	price_tag = 200

/obj/item/cell/medium/greyson
	name = "GP-SI \"Posi-cell 1600M\""
	desc = "GP-SI branded rechargeable M-standardized power cell that recharges itself over time. This type has yet to hit the market!"
	icon_state = "greyson_m_omega"
	maxcharge = 1600
	autorecharging = TRUE
	autorecharge_rate = 0.06
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_PLATINUM = 2, MATERIAL_URANIUM = 4)
	price_tag = 300

/obj/item/cell/medium/excelsior
	name = "Excelsior \"Zarya 1100M\""
	desc = "Commie rechargeable M-standardized power cell. Power to the people!"
	icon_state = "exs_m"
	origin_tech = list(TECH_POWER = 3)
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 1)
	maxcharge = 1100

/obj/item/cell/medium/neotheology
	name = "Absolute \"Spark 1000M\""
	desc = "Absolute branded non-rechargeable M-standardized power cell."
	icon_state = "m_nt"
	matter = list(MATERIAL_STEEL = 2, MATERIAL_BIOMATTER = 10)
	maxcharge = 1000
	max_chargerate = 0
	created_max_charge = TRUE

/obj/item/cell/medium/neotheology/plasma
	name = "Absolute \"Radiance 1500M\""
	desc = "Absolute branded non-rechargeable M-standardized power cell. This advanced version can store even more energy."
	icon_state = "m_nt_pl"
	matter = list(MATERIAL_STEEL = 2, MATERIAL_BIOMATTER = 5)
	maxcharge = 1500

//SMALL CELLS - for small devices, such as flashlights, analyzers and HUDs.

/obj/item/cell/small
	name = "Lonestar \"Robustcell 100S\""
	desc = "Lonestar branded rechargeable S-standardized power cell. This one is the cheapest you can find."
	icon_state = "s_st"
	w_class = ITEM_SIZE_TINY
	force = WEAPON_FORCE_HARMLESS
	throw_speed = 5
	throw_range = 7
	maxcharge = 100
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_SILVER = 1)
	price_tag = 50

/obj/item/cell/small/depleted
	charge = 0
	starts_max_charge = FALSE

/obj/item/cell/small/high
	name = "Lonestar \"Robustcell 200S\""
	desc = "Lonestar branded rechargeable S-standardized power cell. Popular and reliable version."
	icon_state = "s_hi"
	origin_tech = list(TECH_POWER = 2)
	maxcharge = 200

/obj/item/cell/small/high/depleted
	charge = 0
	starts_max_charge = FALSE

/obj/item/cell/small/super
	name = "Lonestar \"Robustcell 300S\""
	desc = "Lonestar branded rechargeable S-standardized power cell. This industrial version can store even more energy."
	icon_state = "s_sup"
	origin_tech = list(TECH_POWER = 5)
	maxcharge = 300

/obj/item/cell/small/hyper
	name = "Lonestar \"Robustcell-X 500S\""
	desc = "Lonestar branded rechargeable S-standardized power cell. This is the top of the class most advanced version of cell on the market."
	icon_state = "s_hy"
	origin_tech = list(TECH_POWER = 6)
	maxcharge = 500

/obj/item/cell/small/moebius
	name = "Soteria \"Power-Geyser 120S\""
	desc = "Soteria Institute branded rechargeable S-standardized power cell. This one is cheap, yet better than Lonestar models for same price."
	icon_state = "meb_s_st"
	maxcharge = 120

/obj/item/cell/small/moebius/high
	name = "Soteria \"Power-Geyser 250S\""
	desc = "Soteria Institute branded rechargeable S-standardized power cell. Popular and reliable version."
	icon_state = "meb_s_hi"
	origin_tech = list(TECH_POWER = 2)
	maxcharge = 250

/obj/item/cell/small/moebius/super
	name = "Soteria \"Power-Geyser 300S\""
	desc = "Soteria Institute branded rechargeable S-standardized power cell. This industrial version can store even more energy."
	icon_state = "meb_s_sup"
	origin_tech = list(TECH_POWER = 5)
	maxcharge = 300

/obj/item/cell/small/moebius/hyper
	name = "Soteria \"Power-Geyser 400S\""
	desc = "Soteria Institute branded rechargeable S-standardized power cell. Regarded as the second most powerful cell on the market."
	icon_state = "meb_s_hy"
	origin_tech = list(TECH_POWER = 6)
	maxcharge = 400

/obj/item/cell/small/moebius/omega
	name = "Soteria \"Omega-Geyser 500S\""
	desc = "Soteria Institute branded rechargeable S-standardized power cell. This one being part of the Omega line making it the be-all-end-all power cell of its type, yet to hit the open market."
	icon_state = "meb_s_omega"
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_SILVER = 1, MATERIAL_GOLD = 2)
	origin_tech = list(TECH_POWER = 7)
	maxcharge = 500
	max_chargerate = 0.24

/obj/item/cell/small/moebius/nuclear
	name = "Soteria \"Atomcell 300S\""
	desc = "Soteria Institute branded rechargeable S-standardized microreactor cell. Recharges itself over time."
	icon_state = "meb_s_nu"
	autorecharging = TRUE
	origin_tech = list(TECH_POWER = 6)
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_SILVER = 1, MATERIAL_URANIUM = 2)
	maxcharge = 300
	price_tag = 100

/obj/item/cell/small/moebius/pda
	name = "Soteria \"Atomcell 50S\""
	desc = "Soteria Institute branded S-standardized microreactor cell. Recharges itself over time."
	icon_state = "meb_pda"
	origin_tech = list(TECH_POWER = 4)
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_URANIUM = 1)
	maxcharge = 50
	// Autorecharge rate is buffed compared to eris, to compensate for the cell's cooldown.
	autorecharging = TRUE
	autorecharge_rate = 0.007
	recharge_time = 1
	price_tag = 65

/obj/item/cell/small/greyson
	name = "GP-SI \"Posi-cell 400S\""
	desc = "GP-SI branded rechargeable S-standardized power cell that recharges itself over time. This type has yet to hit the market!"
	icon_state = "greyson_s_omega"
	maxcharge = 400
	autorecharging = TRUE
	autorecharge_rate = 0.06
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_PLATINUM = 1, MATERIAL_URANIUM = 2)
	price_tag = 150

/obj/item/cell/small/excelsior
	name = "Excelsior \"Zarya 400S\""
	desc = "Commie rechargeable S-standardized power cell. Power to the people!"
	icon_state = "exs_s"
	origin_tech = list(TECH_POWER = 3)
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1)
	maxcharge = 400

/obj/item/cell/small/neotheology
	name = "Absolute \"Spark 300S\""
	desc = "Absolute branded non-rechargeable S-standardized power cell."
	icon_state = "s_nt"
	matter = list(MATERIAL_STEEL = 1, MATERIAL_BIOMATTER = 5)
	maxcharge = 300
	max_chargerate = 0
	created_max_charge = TRUE

/obj/item/cell/small/neotheology/plasma
	name = "Absolute \"Radiance 500S\""
	desc = "Absolute branded non-rechargeable S-standardized power cell. This advanced version can store even more energy."
	icon_state = "s_nt_pl"
	matter = list(MATERIAL_STEEL = 1, MATERIAL_BIOMATTER = 2.5)
	maxcharge = 500

// Hand crank
/obj/item/device/manual_charger
	name = "manual recharger"
	desc = "A basic hand crank recharger utilizing a manual mechanism."
	icon = 'icons/obj/machines/chemistry.dmi'
	icon_state = "centrifuge_makeshift"
	matter = list(MATERIAL_STEEL = 30)
	cell = null
	suitable_cell = /obj/item/cell

/obj/item/device/manual_charger/attack_self(mob/user)
	var/obj/item/cell/cell
	if(do_after(user, 60 - (1 * user.stats.getMult(STAT_TGH, STAT_LEVEL_ADEPT))))
		if(!cell)
			return
		if(cell.charge >= cell.maxcharge)
			user.visible_message(SPAN_NOTICE("The cell can not be charged any more!"))
			return
		else
			user.visible_message(SPAN_NOTICE("[user] have started to turn handle on \the [src]."), SPAN_NOTICE("You started to turn handle on \the [src]."))
			cell.charge += 10
			return //Stafy Return
