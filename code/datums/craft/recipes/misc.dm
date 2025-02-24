/datum/craft_recipe/ashtray
	name = "ashtray"
	result = /obj/item/material/ashtray
	steps = list(
		list(CRAFT_MATERIAL, 1, MATERIAL_STEEL)
	)
	related_stats = list(STAT_COG)

/datum/craft_recipe/tray
	name = "dinner tray"
	result = /obj/item/tray
	steps = list(
		list(CRAFT_MATERIAL, 1, MATERIAL_STEEL, "time" = 40),
		list(QUALITY_WIRE_CUTTING, 10, 120)
	)
	related_stats = list(STAT_COG)

/datum/craft_recipe/folder
	name = "folder, black"
	steps = list(
		list(CRAFT_MATERIAL, 1, MATERIAL_CARDBOARD)
	)
	related_stats = list(STAT_COG)

/datum/craft_recipe/folder/blue
	name = "folder, blue"
	result = /obj/item/folder/blue

/datum/craft_recipe/folder/cyan
	name = "folder, cyan"
	result = /obj/item/folder/cyan

/datum/craft_recipe/folder/grey
	name = "folder, grey"
	result = /obj/item/folder

/datum/craft_recipe/folder/red
	name = "folder, red"
	result = /obj/item/folder/red

/datum/craft_recipe/folder/yellow
	name = "folder, yellow"
	result = /obj/item/folder/yellow

/datum/craft_recipe/plasticflaps
	name = "plastic flaps"
	result = /obj/structure/plasticflaps
	steps = list(
		list(CRAFT_MATERIAL, 4, MATERIAL_PLASTIC) //I can see people abusing this a lot
	)
	flags = CRAFT_ON_FLOOR|CRAFT_ONE_PER_TURF

/datum/craft_recipe/metal_rod
	name = "metal rod"
	result = /obj/item/stack/rods
	time = 0
	steps = list(
		list(CRAFT_MATERIAL, 1, MATERIAL_STEEL)
	)
	flags = CRAFT_BATCH
	related_stats = list(STAT_COG)

/datum/craft_recipe/pipe
	name = "Smoking pipe"
	result = /obj/item/clothing/mask/smokable/pipe
	icon_state = "woodworking"
	steps = list(
		list(CRAFT_MATERIAL, 5, MATERIAL_WOOD, "time" = 0),
		list(QUALITY_CUTTING, 10, 10)
	)
	related_stats = list(STAT_COG)

/datum/craft_recipe/cloth_stripe
	name = "salvage cloth"
	result = /obj/item/stack/material/cloth/random
	icon_state = "clothing"
	steps = list(
		list(/obj/item/clothing/under, 1, "time" = 25),
		list(QUALITY_CUTTING, 10, "time" = 30)
	)

/datum/craft_recipe/ameridian_spire
	name = "ameridian growth"
	flags = CRAFT_ON_FLOOR|CRAFT_ONE_PER_TURF
	result = /obj/structure/ameridian_crystal/spire/fake
	icon_state = "device"
	steps = list(
		list(/obj/item/ameridian_core, 1, "time" = 25),
		list(CRAFT_MATERIAL, 60, MATERIAL_AMERIDIAN, "time" = 25)
	)

/datum/craft_recipe/hair_pin
	name = "hair pin"
	result = /obj/item/clothing/head/pin
	steps = list(
		list(CRAFT_MATERIAL, 1, MATERIAL_STEEL)
	)

// Consume!! Makes it's own tab. Not a big deal I guess.

/datum/craft_recipe/consumer
	category = "Consumer"
	time = 200
	related_stats = list(STAT_MEC)
	icon_state = "electronic"


/datum/craft_recipe/consumer/toaster
	name = "toaster"
	result = /obj/item/toy/consumer/product/toaster
	steps = list(
		list(/obj/item/toy/consumer/kit/toaster, 1, "time" = 50),
		list(QUALITY_SCREW_DRIVING, 35, "time" = 50),
		list(QUALITY_BOLT_TURNING, 35, "time" =  100),
		list(QUALITY_SCREW_DRIVING, 35, "time" = 50),
		list(QUALITY_PRYING, 35, "time" = 60)
	)

/datum/craft_recipe/consumer/bottling_kit
	name = "bottling kit"
	result = /obj/item/bottle_kit
	steps = list(
		list(CRAFT_MATERIAL, 10, MATERIAL_WOOD),
		list(CRAFT_MATERIAL, 10, MATERIAL_GLASS),
		list(/obj/item/circuitboard/autolathe, 1)
	)

/datum/craft_recipe/consumer/cement_bag
	name = "Bag: Quick-Cement"
	result = /obj/item/cement_bag
	steps = list(
		list(/obj/item/stack/ore/glass, 2, "time" = 2),
		list(/obj/item/stack/rods, 1, "time" = 2),
		list(/obj/item/stack/ore, 1, "time" = 2),
		list(QUALITY_HAMMERING, 1, 12),
		list(QUALITY_SHOVELING, 1, 15)
	)

/datum/craft_recipe/consumer/hydro_tray_plant_bag_water
	name = "Bag: Woodchips"
	result = /obj/item/hydro_tray_plant_bag_water
	steps = list(
		list(CRAFT_MATERIAL, 10, MATERIAL_WOOD, "time" = 15),
		list(QUALITY_CUTTING, 5, 5)
	)

/datum/craft_recipe/consumer/hydro_tray_plant_bag_nutrient
	name = "Bag: Mealworms"
	result = /obj/item/hydro_tray_plant_bag_nutrient
	steps = list(
		list(/obj/item/stack/ore, 2, "time" = 15),
		list(/obj/item/reagent_containers/snacks/meat, 2, "time" = 2),
		list(QUALITY_CUTTING, 10, 10)
	)