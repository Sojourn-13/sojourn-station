/obj/item/weapon/tool/surgicaldrill
	name = "hand drill"
	desc = "You can drill using this item. You dig?"
	icon_state = "drill"
	hitsound = WORKSOUND_DRIVER_TOOL
	worksound = WORKSOUND_DRIVER_TOOL
	matter = list(MATERIAL_STEEL = 4, MATERIAL_PLASTIC = 2)
	flags = CONDUCT
	force = WEAPON_FORCE_DANGEROUS
	armor_penetration = ARMOR_PEN_MODERATE
	w_class = ITEM_SIZE_NORMAL
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 1)
	attack_verb = list("drilled")
	tool_qualities = list(QUALITY_DRILLING = 30)

	use_power_cost = 0.24
	suitable_cell = /obj/item/weapon/cell/small

/obj/item/weapon/tool/surgicaldrill/adv
	name = "long-nose hand drill"
	desc = "A handheld drill with a longer and more durable drill, for precision drilling."
	icon_state = "longdrill"
	force = WEAPON_FORCE_ROBUST 
	armor_penetration = ARMOR_PEN_DEEP //Diamond tip!
	matter = list(MATERIAL_STEEL = 6, MATERIAL_PLASTIC = 2, MATERIAL_DIAMOND = 1)
	tool_qualities = list(QUALITY_DRILLING = 60)
	use_power_cost = 0.60
