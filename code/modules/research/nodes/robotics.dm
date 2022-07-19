/datum/technology/basic_robotics
	name = "Basic Robotics"
	desc = "Basic Robotics"
	tech_type = RESEARCH_ROBOTICS

	x = 0.5
	y = 0.4
	icon = "cyborganalyzer"

	required_technologies = list()
	required_tech_levels = list()
	cost = 0

	unlocks_designs = list(	/datum/design/research/circuit/mech_recharger,
							/datum/design/research/circuit/recharge_station,
							/datum/design/research/item/medical/robot_scanner,
							/datum/design/research/item/mmi)

//Exosuits Branch

/datum/technology/exosuit_robotics
	name = "Basics of Exosuits"
	desc = "Exosuit production and control systems."
	tech_type = RESEARCH_ROBOTICS

	x = 0.5
	y = 0.5
	icon = "ripley"

	required_technologies = list(/datum/technology/basic_robotics)
	required_tech_levels = list()
	cost = 375

	unlocks_designs = list(
		/datum/design/research/circuit/mechfab,
		/datum/design/research/item/mechfab/exosuit/control_module,
		)

/datum/technology/mech_basic_armor
	name = "Basic Armor"
	desc = "Exosuit basic armor plates."
	tech_type = RESEARCH_ROBOTICS

	x = 0.5
	y = 0.8
	icon = "mecharmor"

	required_technologies = list(/datum/technology/exosuit_robotics)
	required_tech_levels = list()
	cost = 500

	unlocks_designs = list(
			/datum/design/research/item/mechfab/exosuit/armour/basic
		)

/datum/technology/mech_odysseus
	name = "Light"
	desc = "Light exosuits' components"
	tech_type = RESEARCH_ROBOTICS

	x = 0.7
	y = 0.5
	icon = "odyssey"

	required_technologies = list(/datum/technology/exosuit_robotics)
	required_tech_levels = list()
	cost = 375

	unlocks_designs = list(
		/datum/design/research/item/mechfab/exosuit/light/head,
		/datum/design/research/item/mechfab/exosuit/light/torso,
		/datum/design/research/item/mechfab/exosuit/light/arms,
		/datum/design/research/item/mechfab/exosuit/light/legs
		)


/datum/technology/mech_combat
	name = "Combat"
	desc = "Combat Exosuit' Components."
	tech_type = RESEARCH_ROBOTICS

	x = 0.6
	y = 0.6
	icon = "gygax"

	required_technologies = list(/datum/technology/exosuit_robotics)
	required_tech_levels = list()
	cost = 1000

	unlocks_designs = list(
		/datum/design/research/item/mechfab/exosuit/combat/head,
		/datum/design/research/item/mechfab/exosuit/combat/torso,
		/datum/design/research/item/mechfab/exosuit/combat/arms,
		/datum/design/research/item/mechfab/exosuit/combat/legs
		)

/datum/technology/mech_combat_armor
	name = "Combat Armor"
	desc = "Exosuit combat armor plates reinforced with " + MATERIAL_TITANIUM
	tech_type = RESEARCH_ROBOTICS

	x = 0.6
	y = 0.8
	icon = "mecharmor"

	required_technologies = list(
		/datum/technology/mech_basic_armor,
		/datum/technology/mech_combat
	)
	required_tech_levels = list()
	cost = 3000

	unlocks_designs = list(
		/datum/design/research/item/mechfab/exosuit/armour/combat
	)

/datum/technology/mech_durand
	name = "Heavy"
	desc = "Heavy exosuit's components."
	tech_type = RESEARCH_ROBOTICS

	x = 0.7
	y = 0.8
	icon = "durand"

	required_technologies = list(/datum/technology/exosuit_robotics)
	required_tech_levels = list()
	cost = 1500

	unlocks_designs = list(
		/datum/design/research/item/mechfab/exosuit/heavy/head,
		/datum/design/research/item/mechfab/exosuit/heavy/torso,
		/datum/design/research/item/mechfab/exosuit/heavy/arms,
		/datum/design/research/item/mechfab/exosuit/heavy/legs
	)

/*
/datum/technology/mech_phazon
	name = "Phazon"
	desc = "Experimental exosuit parts. Use with caution!"
	tech_type = RESEARCH_ROBOTICS

	x = 0.8
	y = 0.8
	icon = "vindicator" // TODO change icon

	required_technologies = list(/datum/technology/mech_durand)
	required_tech_levels = list() // Add some bluespace requirement?
	cost = 3000

	unlocks_designs = list(
		/datum/design/research/item/mechfab/phazon/chassis,
		/datum/design/research/item/mechfab/phazon/torso,
		/datum/design/research/item/mechfab/phazon/head,
		/datum/design/research/item/mechfab/phazon/left_arm,
		/datum/design/research/item/mechfab/phazon/right_arm,
		/datum/design/research/item/mechfab/phazon/left_leg,
		/datum/design/research/item/mechfab/phazon/right_leg,
		/datum/design/research/item/mechfab/phazon/armour
		)
*/

//Mech Modules
/datum/technology/mech_modules_core
	name = "Mech modular systems"
	desc = "Roots of exosuits' modularity and miner modules."
	tech_type = RESEARCH_ROBOTICS

	x = 0.4
	y = 0.6
	icon = "borgmodule"

	required_technologies = list(/datum/technology/exosuit_robotics)
	required_tech_levels = list()
	cost = 375

	unlocks_designs = list(
		/datum/design/research/item/exosuit/floodlight,
	)

/datum/technology/mech_medical_modules
	name = "Medical Modules"
	desc = "Exosuit's medical systems"

	tech_type = RESEARCH_ROBOTICS

	x = 0.3
	y = 0.6
	icon = "sleeper"

	required_technologies = list(
		/datum/technology/mech_modules_core
	)

	required_tech_levels = list()
	cost = 500

	unlocks_designs = list(
		/datum/design/research/item/exosuit/sleeper
	)

/datum/technology/mech_utility_modules
	name = "Utility Modules"
	desc = "Exosuit's Utility Modules"
	tech_type = RESEARCH_ROBOTICS

	x = 0.4
	y = 0.7
	icon = "mechrcd"

	required_technologies = list(
		/datum/technology/mech_modules_core
	)

	required_tech_levels = list()
	cost = 750

	unlocks_designs = list(
		/datum/design/research/item/exosuit/drill,
		/datum/design/research/item/exosuit/extinguisher,
		/datum/design/research/item/exosuit/hydraulic_clamp,
	)

/datum/technology/mech_teleporter_modules
	name = "Gravity Catapult"
	desc = "Exosuit gravity catapult module"
	tech_type = RESEARCH_ROBOTICS

	x = 0.3
	y = 0.7
	icon = "mechteleporter"

	required_technologies = list(/datum/technology/mech_utility_modules)
	required_tech_levels = list()
	cost = 3750

	unlocks_designs = list(/datum/design/research/item/exosuit/gravity_catapult)

/datum/technology/mech_util_armor
	name = "Utility Armor"
	desc = "Exosuit combat armor plates reinforced EM protection and radiation protection."
	tech_type = RESEARCH_ROBOTICS

	x = 0.4
	y = 0.8
	icon = "mecharmor"

	required_technologies = list(
		/datum/technology/mech_basic_armor,
		/datum/technology/mech_utility_modules)
	required_tech_levels = list()
	cost = 1500

	unlocks_designs = list(
		/datum/design/research/item/mechfab/exosuit/armour/radproof,
		/datum/design/research/item/mechfab/exosuit/armour/em
		)

/datum/technology/mech_weaponry_modules
	name = "Combat Systems"
	desc = "Exosuits' basics of combat systems."
	tech_type = RESEARCH_ROBOTICS

	x = 0.4
	y = 0.5
	icon = "mechgrenadelauncher"

	required_technologies = list(/datum/technology/mech_modules_core)
	required_tech_levels = list()
	cost = 1500

	unlocks_designs = list(
		/datum/design/research/item/exosuit/weapon/scattershot,
		/datum/design/research/item/exosuit/taser,
		/datum/design/research/item/exosuit/weapon/ion
		)

/datum/technology/mech_heavy_weaponry_modules
	name = "Exosuit Advanced Weaponry"
	desc = "Integration of hand-lethal weapon in exosuit system."
	tech_type = RESEARCH_ROBOTICS

	x = 0.4
	y = 0.4
	icon = "mechlaser"

	required_technologies = list(/datum/technology/mech_weaponry_modules)
	required_tech_levels = list()
	cost = 1500

	unlocks_designs = list(
		/datum/design/research/item/exosuit/weapon/plasma,
		/datum/design/research/item/exosuit/weapon/laser,
		/datum/design/research/item/exosuit/weapon/mecha_sword,
		/datum/design/research/item/exosuit/weapon/mecha_cutlass
		)

//AI BRANCH

/datum/technology/cyborg_robo
	name = "AI Robotics"
	desc = "Positron links. Man-Machine Interface. Cyborg control systems. Artificial Intelegence mobile storages."
	tech_type = RESEARCH_ROBOTICS

	x = 0.5
	y = 0.3
	icon = "posbrain"

	required_technologies = list(/datum/technology/basic_robotics)
	required_tech_levels = list()
	cost = 375

	unlocks_designs = list(
							/datum/design/research/item/posibrain,
							/datum/design/research/item/mmi_radio,
							/datum/design/research/item/intellicard,
							/datum/design/research/item/paicard,
							/datum/design/research/circuit/robocontrol
							)

/datum/technology/artificial_intelligence
	name = "Artificial intelligence"
	desc = "Construction and programming of artificial intelligence."
	tech_type = RESEARCH_ROBOTICS

	x = 0.4
	y = 0.3
	icon = "aicard"

	required_technologies = list(/datum/technology/cyborg_robo)
	required_tech_levels = list()
	cost = 1500

	unlocks_designs = list(
							/datum/design/research/circuit/aicore,
							/datum/design/research/circuit/aiupload
							)

/datum/technology/artificial_intelligence_laws
	name = "Artificial intelligence: LAWS"
	desc = "Artificial intelligence laws sets."
	tech_type = RESEARCH_ROBOTICS

	x = 0.4
	y = 0.2
	icon = "module"

	required_technologies = list(/datum/technology/artificial_intelligence)
	required_tech_levels = list()
	cost = 1500

	unlocks_designs = list(
							/datum/design/research/circuit/aifixer,
							/datum/design/research/aimodule/safeguard,
							/datum/design/research/aimodule/onehuman,
							/datum/design/research/aimodule/protectstation,
							/datum/design/research/aimodule/notele,
							/datum/design/research/aimodule/quarantine,
							/datum/design/research/aimodule/oxygen,
							/datum/design/research/aimodule/freeform,
							/datum/design/research/aimodule/reset,
							/datum/design/research/aimodule/purge,
							/datum/design/research/aimodule/core/freeformcore,
							/datum/design/research/aimodule/core/asimov,
							/datum/design/research/aimodule/core/paladin,
							/datum/design/research/circuit/aicore,
							/datum/design/research/circuit/aiupload,
							/datum/design/research/circuit/borgupload
							)

/datum/technology/robot_modules
	name = "Advanced Cyborg Components"
	desc = "Advanced Cyborg Components"
	tech_type = RESEARCH_ROBOTICS

	x = 0.6
	y = 0.3
	icon = "rigscanner"

	required_technologies = list(/datum/technology/cyborg_robo)
	required_tech_levels = list()
	cost = 1500

	unlocks_designs = list(
						/datum/design/research/item/mechfab/robot/component/jetpack,
						/datum/design/research/item/robot_upgrade/vtec,
						/datum/design/research/item/robot_upgrade/tasercooler,
						/datum/design/research/item/robot_upgrade/rcd,
						/datum/design/research/item/robot_upgrade/arc_welder,
						/datum/design/research/item/mechfab/robot/component/armour,
						/datum/design/research/circuit/repair_station
						)