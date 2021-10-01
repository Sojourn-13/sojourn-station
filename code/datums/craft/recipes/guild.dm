/datum/craft_recipe/guild
	category = "Guild"
	time = 100
	related_stats = list(STAT_COG)
	avaliableToEveryone = FALSE


//Armor mods ----------------------
/datum/craft_recipe/guild/melee
	name = "melee plating"
	result = /obj/item/tool_upgrade/armor/melee
	icon_state = "clothing"
	steps = list(
		list(CRAFT_MATERIAL, 30, MATERIAL_STEEL, "time" = 60),
		list(QUALITY_WELDING, 40, "time" = 60),
		list(QUALITY_CUTTING, 30, "time" = 180),
		list(QUALITY_HAMMERING, 30, "time" = 180),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 90),
		list(/obj/item/tool_upgrade/reinforcement/rubbermesh, 1),
		list(QUALITY_BOLT_TURNING, 40, "time" = 120),
		list(QUALITY_SAWING, 30, "time" = 60)
	)

/datum/craft_recipe/guild/bullet
	name = "ballistic plating"
	result = /obj/item/tool_upgrade/armor/bullet
	icon_state = "clothing"
	steps = list(
		list(CRAFT_MATERIAL, 10, MATERIAL_PLASTEEL, "time" = 20),
		list(CRAFT_MATERIAL, 10, MATERIAL_PLASTIC , "time" = 20),
		list(CRAFT_MATERIAL, 10, MATERIAL_STEEL, "time" = 20),
		list(QUALITY_WELDING, 40, "time" = 60),
		list(QUALITY_CUTTING, 30, "time" = 180),
		list(QUALITY_HAMMERING, 30, "time" = 180),
		list(/obj/item/tool_upgrade/reinforcement/rubbermesh, 1),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 90),
		list(QUALITY_BOLT_TURNING, 40, "time" = 120),
		list(QUALITY_SAWING, 30, "time" = 60)
	)

/datum/craft_recipe/guild/energy
	name = "energy plating"
	result = /obj/item/tool_upgrade/armor/energy
	icon_state = "clothing"
	steps = list(
		list(CRAFT_MATERIAL, 3, MATERIAL_PLATINUM, "time" = 30),
		list(CRAFT_MATERIAL, 12, MATERIAL_PLASTIC , "time" = 30),
		list(QUALITY_WELDING, 40, "time" = 60),
		list(QUALITY_CUTTING, 30, "time" = 180),
		list(QUALITY_HAMMERING, 30, "time" = 180),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 90),
		list(/obj/item/tool_upgrade/reinforcement/rubbermesh, 1),
		list(QUALITY_BOLT_TURNING, 40, "time" = 120),
		list(QUALITY_SAWING, 30, "time" = 60)
	)

/datum/craft_recipe/guild/bomb
	name = "bomb proofing"
	result = /obj/item/tool_upgrade/armor/bomb
	icon_state = "clothing"
	steps = list(
		list(CRAFT_MATERIAL, 20, MATERIAL_PLASTEEL, "time" = 60),
		list(CRAFT_MATERIAL, 20, MATERIAL_STEEL, "time" = 60),
		list(QUALITY_WELDING, 40, "time" = 60),
		list(QUALITY_CUTTING, 30, "time" = 180),
		list(QUALITY_HAMMERING, 30, "time" = 180),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 90),
		list(/obj/item/tool_upgrade/reinforcement/rubbermesh, 1),
		list(QUALITY_BOLT_TURNING, 40, "time" = 120),
		list(QUALITY_SAWING, 30, "time" = 60)
	)

/datum/craft_recipe/guild/robotmelee //Lots of steps
	name = "robot mark v armor plating"
	result = /obj/item/robot_parts/robot_component/armour/mkv
	steps = list(
		list(CRAFT_MATERIAL, 10, MATERIAL_PLASTEEL, "time" = 90),
		list(CRAFT_MATERIAL, 10, MATERIAL_STEEL, "time" = 30),
		list(QUALITY_WELDING, 40, "time" = 90),
		list(QUALITY_CUTTING, 30, "time" = 180),
		list(QUALITY_HAMMERING, 30, "time" = 180),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 90),
		list(QUALITY_BOLT_TURNING, 40, "time" = 120),
		list(QUALITY_SAWING, 30, "time" = 60)
	)

//Tools --------------------------
/datum/craft_recipe/guild/arcwelder
	name = "arc welder"
	result = /obj/item/tool/arcwelder
	steps = list(
		list(CRAFT_MATERIAL, 4, MATERIAL_PLASTEEL, "time" = 60),
		list(QUALITY_CUTTING, 20, "time" = 40),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(/obj/item/stack/cable_coil, 5, "time" = 20),
		list(QUALITY_WIRE_CUTTING, 20, 30),
		list(QUALITY_SCREW_DRIVING, 20, "time" = 60),
		list(QUALITY_BOLT_TURNING, 30, "time" = 40)
	)

/datum/craft_recipe/guild/polytool
	name = "\"jolly co-operation\" polytool"
	result = /obj/item/tool/polytool
	steps = list(
		list(/obj/item/tool/omnitool, 1, "time" = 60),
		list(QUALITY_CUTTING, 20, "time" = 40),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(/obj/item/cell/medium, 1, "time" = 60),
		list(/obj/item/stack/cable_coil, 5, "time" = 20),
		list(QUALITY_WIRE_CUTTING, 20, 30),
		list(/obj/item/tool_upgrade/augment/fuel_tank, 1, "time" = 60),
		list(QUALITY_SCREW_DRIVING, 20, "time" = 60),
		list(QUALITY_BOLT_TURNING, 30, "time" = 40)
	)

/datum/craft_recipe/guild/combat_shovel
	name = "combat crovel"
	result = /obj/item/tool/shovel/combat
	steps = list(
		list(/obj/item/tool/shovel, 1),
		list(QUALITY_SAWING, 20, "time" = 40),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(CRAFT_MATERIAL, 6, MATERIAL_PLASTEEL, "time" = 60),
		list(QUALITY_SCREW_DRIVING, 20, "time" = 30),
		list(/obj/item/tool_upgrade/augment/spikes, 1),
		list(QUALITY_BOLT_TURNING, 30, "time" = 10)
	)

/datum/craft_recipe/guild/rocket_engine
	name = "rocket engine"
	result = /obj/item/rocket_engine
	icon_state = "electronic"
	steps = list(
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTEEL, "time" = 60),
		list(CRAFT_MATERIAL, 1, MATERIAL_GOLD, "time" = 20),
		list(QUALITY_CUTTING, 30, "time" = 40),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(/obj/item/stack/cable_coil, 10, "time" = 20),
		list(QUALITY_WIRE_CUTTING, 40, 30),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 60),
		list(QUALITY_BOLT_TURNING, 40, "time" = 40)
	)

/datum/craft_recipe/guild/supermop
	name = "pneumatic condensing mop"
	result = /obj/item/mop/guild
	steps = list(
		list(/obj/item/mop, 1),
		list(CRAFT_MATERIAL, 1, MATERIAL_PLASTIC, "time" = 40),
		list(QUALITY_CUTTING, 20, "time" = 40),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(/obj/item/stack/cable_coil, 5, "time" = 20),
		list(CRAFT_MATERIAL, 1, MATERIAL_PLASTEEL, "time" = 20),
		list(QUALITY_WIRE_CUTTING, 20, 30),
		list(QUALITY_SCREW_DRIVING, 20, "time" = 60),
		list(QUALITY_BOLT_TURNING, 30, "time" = 40)
	)

//Weapons ------------------------
/datum/craft_recipe/guild/railgunrifle
	name = "reductor rail rifle"
	result = /obj/item/gun/energy/laser/railgun
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 20, MATERIAL_PLASTEEL, "time" = 60),
		list(CRAFT_MATERIAL, 8, MATERIAL_STEEL, "time" = 20),
		list(CRAFT_MATERIAL, 10, MATERIAL_SILVER, "time" = 20),
		list(QUALITY_CUTTING, 30, "time" = 40),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(/obj/item/stack/cable_coil, 10, "time" = 20),
		list(QUALITY_WIRE_CUTTING, 40, 30),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 60),
		list(QUALITY_BOLT_TURNING, 40, "time" = 40)
	)

/datum/craft_recipe/guild/railgunpistol
	name = "myrmidon rail pistol"
	result = /obj/item/gun/energy/laser/railgun/pistol
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 15, MATERIAL_PLASTEEL, "time" = 60),
		list(CRAFT_MATERIAL, 4, MATERIAL_STEEL, "time" = 20),
		list(CRAFT_MATERIAL, 5, MATERIAL_SILVER, "time" = 20),
		list(QUALITY_CUTTING, 30, "time" = 40),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(/obj/item/stack/cable_coil, 5, "time" = 20),
		list(QUALITY_WIRE_CUTTING, 40, 30),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 60),
		list(QUALITY_BOLT_TURNING, 40, "time" = 40)
	)

/datum/craft_recipe/guild/heavypulserifle
	name = "Jury-Rigged EZ-13 MK2 Heavy Pulse Rifle"
	result = /obj/item/gun/energy/laser/heavypulserifle
	icon_state = "gun"
	steps = list(
		list(/obj/item/mecha_parts/mecha_equipment/ranged_weapon/energy/pulse, 1, "time" = 30),
		list(QUALITY_SAWING, 40, "time" = 60),
		list(QUALITY_BOLT_TURNING, 40, "time" = 40),
		list(/obj/item/stack/cable_coil, 30, "time" = 30),
		list(QUALITY_WIRE_CUTTING, 40, 30),
		list(CRAFT_MATERIAL, 20, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(CRAFT_MATERIAL, 10, MATERIAL_STEEL, "time" = 20),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 10)
	)

/datum/craft_recipe/guild/mace
	name = "War Mace"
	result = /obj/item/tool/hammer/mace
	steps = list(
		list(CRAFT_MATERIAL, 15, MATERIAL_STEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 60)
	)

/datum/craft_recipe/guild/claymore
	name = "Claymore"
	result = /obj/item/tool/sword
	steps = list(
		list(CRAFT_MATERIAL, 15, MATERIAL_STEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 60)
	)

/datum/craft_recipe/guild/machete
	name = "Machete"
	result = /obj/item/tool/sword/machete
	steps = list(
		list(CRAFT_MATERIAL, 15, MATERIAL_STEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 60)
	)

/datum/craft_recipe/guild/katana
	name = "Katana"
	result = /obj/item/tool/sword/katana
	steps = list(
	list(CRAFT_MATERIAL, 10, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
	list(CRAFT_MATERIAL, 5, MATERIAL_STEEL, "time" = 30),
		list(QUALITY_WELDING, 40, "time" = 60),
		list(CRAFT_MATERIAL, 1, MATERIAL_DIAMOND, "time" = 30),
		list(QUALITY_HAMMERING, 45, "time" = 40),
		list(/obj/item/tool_upgrade/productivity/whetstone, 1, "time" = 30)
	)

/datum/craft_recipe/guild/firebrand
	name = "Firebrand"
	result = /obj/item/tool/sword/katana/firebrand
	steps = list(
	list(CRAFT_MATERIAL, 10, MATERIAL_PLASTEEL, "time" = 30),
	list(QUALITY_SAWING, 30, "time" = 60),
	list(CRAFT_MATERIAL, 5, MATERIAL_STEEL, "time" = 30),
	list(QUALITY_WELDING, 40, "time"= 60),
	list(/obj/item/tool_upgrade/productivity/oxyjet, 1, "time" = 30),
	list(QUALITY_HAMMERING, 45, "time" = 40),
	list(/obj/item/tool_upgrade/augment/fuel_tank, 1, "time" = 30)
	)

//Wearables =========================
/datum/craft_recipe/guild/technosuit
	name = "'Mark V' environmental protection suit"
	result = /obj/item/clothing/suit/armor/vest/technomancersuit
	icon_state = "clothing"
	steps = list(
		list(CRAFT_MATERIAL, 40, MATERIAL_PLASTEEL, "time" = 60),
		list(QUALITY_SAWING, 60, "time" = 60),
		list(QUALITY_WELDING, 40, "time" = 60),
		list(QUALITY_CUTTING, 30, "time" = 40),
		list(QUALITY_HAMMERING, 45, "time" = 40),
		list(/obj/item/stack/cable_coil, 30, "time" = 20),
		list(QUALITY_WIRE_CUTTING, 40, 30),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 60),
		list(QUALITY_BOLT_TURNING, 40, "time" = 40)
	)

/datum/craft_recipe/guild/technohelmet
	name = "'Mark V' environmental protection helmet"
	result = /obj/item/clothing/head/helmet/technomancersuit
	icon_state = "clothing"
	steps = list(
		list(CRAFT_MATERIAL, 20, MATERIAL_PLASTEEL, "time" = 60),
		list(QUALITY_SAWING, 60, "time" = 60),
		list(QUALITY_WELDING, 40, "time" = 60),
		list(QUALITY_CUTTING, 30, "time" = 40),
		list(QUALITY_HAMMERING, 45, "time" = 40),
		list(/obj/item/stack/cable_coil, 30, "time" = 20),
		list(QUALITY_WIRE_CUTTING, 40, 30),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 60),
		list(QUALITY_BOLT_TURNING, 40, "time" = 40)
	)

/datum/craft_recipe/guild/webbing
	name = "Webbing"
	icon_state = "clothing"
	result = /obj/item/storage/belt/webbing
	steps = list(
		list(/obj/item/storage/belt, 1, "time" = 30),
		list(/obj/item/storage/belt, 1, "time" = 30),
		list(/obj/item/stack/cable_coil, 30, "time" = 30),
		list(/obj/item/storage/pouch/medium_generic, 1, "time" = 40)
	)

/datum/craft_recipe/guild/sheet_stacker
	name = "advanced sheet snatcher"
	icon_state = "woodworking"
	result = /obj/item/storage/bag/sheetsnatcher/guild
	steps = list(
		list(CRAFT_MATERIAL, 10, MATERIAL_WOOD, "time" = 30),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 20),
		list(CRAFT_MATERIAL, 3, MATERIAL_STEEL, "time" = 60),
		list(QUALITY_ADHESIVE, 10, "time" = 60),
		list(/obj/item/stack/cable_coil, 30, "time" = 30),
		list(CRAFT_MATERIAL, 5, MATERIAL_PLASTEEL, "time" = 30),
	)

//Tool/Gun Mods ---------------------
//Reinforcement
/datum/craft_recipe/guild/plasmablock
	name = "Plasma Block"
	result = /obj/item/tool_upgrade/reinforcement/plasmablock
	steps = list(
		list(CRAFT_MATERIAL, 5, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 90),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASMA, "time" = 30),
	)

/datum/craft_recipe/guild/rubbermesh
	name = "Rubber Mesh"
	result = /obj/item/tool_upgrade/reinforcement/rubbermesh
	steps = list(
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_WIRE_CUTTING, 20, "time" = 90)
	)

//Productivity
/datum/craft_recipe/guild/booster
	name = "Booster"
	result = /obj/item/tool_upgrade/productivity/booster
	steps = list(
		list(CRAFT_MATERIAL, 3, MATERIAL_STEEL, "time" = 30),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_SCREW_DRIVING, 25, "time" = 90),
		list(CRAFT_MATERIAL, 2, MATERIAL_GOLD, "time" = 30),
		list(QUALITY_BOLT_TURNING, 20, "time" = 40)
	)

/datum/craft_recipe/guild/injector
	name = "Plasma Injector"
	result = /obj/item/tool_upgrade/productivity/injector
	steps = list(
		list(CRAFT_MATERIAL, 3, MATERIAL_STEEL, "time" = 30),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_SCREW_DRIVING, 25, "time" = 90),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASMA, "time" = 30),
		list(QUALITY_WELDING, 40, "time" = 40)
	)

//Gun Mods
/datum/craft_recipe/guild/weintraub
	name = "\"Hurricane\" full auto kit"
	result = /obj/item/gun_upgrade/mechanism/weintraub
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 20, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_SCREW_DRIVING, 25, "time" = 90)
	)

/datum/craft_recipe/guild/overshooter
	name = "\"Overshooter\" internal magazine kit"
	result = /obj/item/gun_upgrade/mechanism/overshooter
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 1, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 20, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_SCREW_DRIVING, 25, "time" = 90)
	)

/datum/craft_recipe/guild/dangerzone
	name = "\"Danger Zone\" Trigger"
	result = /obj/item/gun_upgrade/trigger/dangerzone
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 1, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 20, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_BOLT_TURNING, 25, "time" = 90)
	)

/datum/craft_recipe/guild/forged
	name = "Forged Barrel"
	result = /obj/item/gun_upgrade/barrel/forged
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 1, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 20, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(CRAFT_MATERIAL, 1, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_BOLT_TURNING, 25, "time" = 90)
	)

/datum/craft_recipe/guild/kit
	name = "Kurtz's refinement kit"
	result = /obj/item/gun_upgrade/mechanism/upgrade_kit
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 20, MATERIAL_STEEL, "time" = 30),
		list(CRAFT_MATERIAL, 15, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 20, "time" = 40),
		list(CRAFT_MATERIAL, 3, MATERIAL_SILVER),
		list(QUALITY_DRILLING, 60, "time" = 90),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(CRAFT_MATERIAL, 10, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_BOLT_TURNING, 25, "time" = 90)
	)

/datum/craft_recipe/guild/heavy_barrel
	name = "Heavy Forged Barrel"
	result = /obj/item/gun_upgrade/barrel/bore
	icon_state = "gun"
	steps = list(
		list(/obj/item/gun_upgrade/barrel/forged, 1, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 20, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(QUALITY_DRILLING, 60, "time" = 90),
		list(/obj/item/tool_upgrade/refinement/ported_barrel, 1, "time" = 30),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_BOLT_TURNING, 25, "time" = 90)
	)

/datum/craft_recipe/guild/silencer
	name = "Silencer"
	result = /obj/item/gun_upgrade/muzzle/silencer
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 20, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_PLASTIC, "time" = 30),
		list(QUALITY_CUTTING, 25, "time" = 90)
	)

/datum/craft_recipe/guild/watchman
	name = "Artificer's Guild \"Watchman\" scope"
	result = /obj/item/gun_upgrade/scope/watchman
	icon_state = "gun"
	steps = list(
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTEEL, "time" = 30),
		list(QUALITY_SAWING, 30, "time" = 60),
		list(QUALITY_HAMMERING, 20, "time" = 40),
		list(QUALITY_WELDING, 40, "time" = 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_GLASS, "time" = 30),
		list(QUALITY_CUTTING, 25, "time" = 90)
	)
/*
//Traps
/datum/craft_recipe/guild/guild_mine_trap
	name = "land mine trap"
	result = /obj/item/mine
	icon_state = "gun"
	steps = list(
		list(/obj/item/mine/improvised, 1, "time" = 120),
		list(QUALITY_SCREW_DRIVING, 10, 70),
		list(CRAFT_MATERIAL, 20, MATERIAL_STEEL),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(/obj/item/stack/cable_coil, 2, "time" = 10)
	)*/

//Machines
/datum/craft_recipe/guild/turretcircuit
	name = "Circuit: Artificer Turret"
	result = /obj/item/circuitboard/artificer_turret
	icon_state = "electronic"
	steps = list(
		list(/obj/item/computer_hardware/processor_unit/super, 1, "time" = 30),
		list(/obj/item/stack/cable_coil, 5, "time" = 20),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 90),
		list(QUALITY_WELDING, 40, "time" = 90)
	)

/datum/craft_recipe/guild/matter_nanoforge
	name = "Circuit: Matter Nano-Forge"
	result = /obj/item/circuitboard/matter_nanoforge
	icon_state = "electronic"
	steps = list(
		list(/obj/item/circuitboard/autolathe, 1, "time" = 30),
		list(CRAFT_MATERIAL, 2, MATERIAL_GOLD),
		list(CRAFT_MATERIAL, 2, MATERIAL_SILVER),
		list(/obj/item/stack/cable_coil, 5, "time" = 20),
		list(QUALITY_SCREW_DRIVING, 20, "time" = 90),
		list(QUALITY_WELDING, 30, "time" = 90)
	)

/datum/craft_recipe/guild/matter_nanoforge_blackbox
	name = "Black Box: Matter Nano-Forge"
	result = /obj/item/oddity/blackbox_nanoforge
	steps = list(
		list(/obj/item/computer_hardware/processor_unit, 1, "time" = 120),
		list(QUALITY_SCREW_DRIVING, 20, 70, "time" = 10),
		list(CRAFT_MATERIAL, 12, MATERIAL_PLASTEEL, "time" = 90),
		list(CRAFT_MATERIAL, 2, MATERIAL_RGLASS, "time" = 20),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 30, "time" = 90),
		list(/obj/item/stack/cable_coil, 10, "time" = 90),
		list(CRAFT_MATERIAL, 1, MATERIAL_DIAMOND, "time" = 20),
		list(/obj/item/stock_parts/manipulator, 1, "time" = 120),
		list(QUALITY_HAMMERING, 30, "time" = 40),
		list(QUALITY_SAWING, 30, "time" = 60),
		//list(QUALITY_DRILLING, 60, "time" = 90),
		list(CRAFT_MATERIAL, 2, MATERIAL_GOLD),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(CRAFT_MATERIAL, 2, MATERIAL_SILVER)
	)

/datum/craft_recipe/guild/guild_bull
	name = "Reforge Bull shotgun"
	result = /obj/item/gun/projectile/shotgun/bull/bison
	steps = list(
		list(/obj/item/gun/projectile/shotgun/bull, 1, "time" = 80),
		list(/obj/item/gun_upgrade/barrel/bore, 1, "time" = 60),
		list(CRAFT_MATERIAL, 10, MATERIAL_PLASTEEL, "time" = 60),
		list(QUALITY_DRILLING, 60, "time" = 90),
		list(QUALITY_WELDING, 40, "time" = 60),
		list(QUALITY_HAMMERING, 45, "time" = 40),
		list(QUALITY_SAWING, 50, "time" = 60),
		list(CRAFT_MATERIAL, 10, MATERIAL_PLASTIC, "time" = 60),
		list(QUALITY_CUTTING, 30, "time" = 40),
		list(QUALITY_SCREW_DRIVING, 40, "time" = 40),
		list(QUALITY_BOLT_TURNING, 40, "time" = 40)
	)

/datum/craft_recipe/guild/guild_bin
	name = "Cast Matter Bin"
	result = /obj/item/stock_parts/matter_bin/guild
	steps = list(
		list(/obj/item/stock_parts/matter_bin/super, 2),
		list(QUALITY_SCREW_DRIVING, 10, 70),
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTEEL),
		list(CRAFT_MATERIAL, 1, MATERIAL_PLASMAGLASS),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(QUALITY_HAMMERING, 40),
		list(QUALITY_SAWING, 60)
	)

/datum/craft_recipe/guild/guild_manip
	name = "Forged Manipulator"
	result = /obj/item/stock_parts/manipulator/guild
	steps = list(
		list(/obj/item/stock_parts/manipulator/pico, 2),
		list(QUALITY_SCREW_DRIVING, 40, 70),
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTEEL),
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTIC),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(/obj/item/stack/cable_coil, 10),
		list(QUALITY_HAMMERING, 40),
		list(QUALITY_SAWING, 60)
	)

/datum/craft_recipe/guild/guild_laser
	name = "Perfected Micro-Laser"
	result = /obj/item/stock_parts/micro_laser/guild
	steps = list(
		list(/obj/item/stock_parts/micro_laser/ultra, 2),
		list(QUALITY_SCREW_DRIVING, 40, 70),
		list(CRAFT_MATERIAL, 1, MATERIAL_DIAMOND),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(QUALITY_SAWING, 60)
	)

/datum/craft_recipe/guild/guild_scanner
	name = "Perfected Scanning Module"
	result = /obj/item/stock_parts/scanning_module/guild
	steps = list(
		list(/obj/item/stock_parts/scanning_module/phasic, 2),
		list(QUALITY_SCREW_DRIVING, 40, 70),
		list(CRAFT_MATERIAL, 2, MATERIAL_GOLD),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_SILVER),
		list(QUALITY_SAWING, 60)
	)

/datum/craft_recipe/guild/guild_capacitor
	name = "Crafted Ultra Capacitor"
	result = /obj/item/stock_parts/capacitor/guild
	steps = list(
		list(/obj/item/stock_parts/capacitor/super, 2),
		list(QUALITY_SCREW_DRIVING, 40, 70),
		list(CRAFT_MATERIAL, 2, MATERIAL_GOLD),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(CRAFT_MATERIAL, 2, MATERIAL_SILVER),
		list(QUALITY_SAWING, 60)
	)

// Boxes for max crafting, should always cost x6 materials.
 // saves on needing 4 extra parts tho
/datum/craft_recipe/guild/guild_bin_box
	name = "Box of Cast Matter Bins"
	result = /obj/item/storage/box/guild_bin
	steps = list(
		list(/obj/item/stock_parts/matter_bin/super, 4),
		list(QUALITY_SCREW_DRIVING, 10, 70),
		list(CRAFT_MATERIAL, 13, MATERIAL_PLASTEEL),
		list(CRAFT_MATERIAL, 5, MATERIAL_PLASMAGLASS),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(QUALITY_HAMMERING, 40),
		list(QUALITY_SAWING, 60),
		list(CRAFT_MATERIAL, 1, MATERIAL_CARDBOARD)
	)

/datum/craft_recipe/guild/guild_manip_box
	name = "Box of Forged Manipulators"
	result = /obj/item/storage/box/guild_manip
	steps = list(
		list(/obj/item/stock_parts/manipulator/pico, 4),
		list(QUALITY_SCREW_DRIVING, 40, 70),
		list(CRAFT_MATERIAL, 13, MATERIAL_PLASTEEL),
		list(CRAFT_MATERIAL, 13, MATERIAL_PLASTIC),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(/obj/item/stack/cable_coil, 10),
		list(QUALITY_HAMMERING, 40),
		list(QUALITY_SAWING, 60),
		list(CRAFT_MATERIAL, 1, MATERIAL_CARDBOARD)
	)

/datum/craft_recipe/guild/guild_laser_box
	name = "Box of Perfected Micro-Lasers"
	result = /obj/item/storage/box/guild_laser
	steps = list(
		list(/obj/item/stock_parts/micro_laser/ultra, 4),
		list(QUALITY_SCREW_DRIVING, 40, 70),
		list(CRAFT_MATERIAL, 4, MATERIAL_DIAMOND),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(QUALITY_SAWING, 60),
		list(CRAFT_MATERIAL, 1, MATERIAL_CARDBOARD)
	)

/datum/craft_recipe/guild/guild_scanner_box
	name = "Box of Perfected Scanning Modules"
	result = /obj/item/storage/box/guild_scanner
	steps = list(
		list(/obj/item/stock_parts/scanning_module/phasic, 4),
		list(QUALITY_SCREW_DRIVING, 40, 70),
		list(CRAFT_MATERIAL, 9, MATERIAL_GOLD),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(CRAFT_MATERIAL, 9, MATERIAL_SILVER),
		list(QUALITY_SAWING, 60),
		list(CRAFT_MATERIAL, 1, MATERIAL_CARDBOARD)
	)

/datum/craft_recipe/guild/guild_capacitor_box
	name = "Box of Crafted Ultra Capacitors"
	result = /obj/item/storage/box/guild_capacitor
	steps = list(
		list(/obj/item/stock_parts/capacitor/super, 4),
		list(QUALITY_SCREW_DRIVING, 40, 70),
		list(CRAFT_MATERIAL, 9, MATERIAL_GOLD),
		list(QUALITY_BOLT_TURNING, 10, 70),
		list(QUALITY_WELDING, 40),
		list(CRAFT_MATERIAL, 9, MATERIAL_SILVER),
		list(QUALITY_SAWING, 60),
		list(CRAFT_MATERIAL, 1, MATERIAL_CARDBOARD)
	)