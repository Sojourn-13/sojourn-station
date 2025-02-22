// Light rigs are not space-capable, but don't suffer excessive slowdown or sight issues when depowered.
/obj/item/rig/light
	name = "light suit control module"
	desc = "A lighter, less armoured rig suit."
	icon_state = "ninja_rig"
	suit_type = "light suit"
	armor_list = list(
		melee = 6,
		bullet = 5,
		energy = 5,
		bomb = 25,
		bio = 100,
		rad = 100
	)
	seal_delay = 20
	emp_protection = 10
	slowdown = 0
	obscuration = 0
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL | DRAG_AND_DROP_UNEQUIP | EQUIP_SOUNDS
	price_tag = 1000
	offline_slowdown = 0
	offline_vision_restriction = 0
	drain = 2

	chest_type = /obj/item/clothing/suit/space/rig/light
	helm_type =  /obj/item/clothing/head/helmet/space/rig/light
	boot_type =  /obj/item/clothing/shoes/magboots/rig/light
	glove_type = /obj/item/clothing/gloves/rig/light

/obj/item/clothing/suit/space/rig/light
	name = "suit"

/obj/item/clothing/gloves/rig/light
	name = "gloves"

/obj/item/clothing/shoes/magboots/rig/light
	name = "shoes"

/obj/item/clothing/head/helmet/space/rig/light
	name = "hood"

/obj/item/rig/light/ultra_light
	name = "SI 'Proto-Spacer' control module"
	desc = "An ultra light, unarmoured rig suit. The precursor to the Soteria retainer model, quite lacking in armor and EMP protection but capable of fitting hardsuit modules."
	icon_state = "hacker_rig"
	suit_type = "SI 'Spacer"
	armor_list = list(
		melee = 2,
		bullet = 1,
		energy = 0,
		bomb = 25,
		bio = 100,
		rad = 45
	)
	airtight = 0
	seal_delay = 5
	slowdown = -0.2 //We speed up the user at cost of horrable armor
	emp_protection = 0
	matter = list(MATERIAL_STEEL = 30, MATERIAL_PLASTIC = 30, MATERIAL_GLASS = 10) //Costly!

	chest_type = /obj/item/clothing/suit/space/rig/light/ultra_light
	helm_type =  /obj/item/clothing/head/helmet/space/rig/light/ultra_light
	boot_type =  /obj/item/clothing/shoes/magboots/rig/light/ultra_light
	glove_type = /obj/item/clothing/gloves/rig/light/ultra_light

/obj/item/clothing/suit/space/rig/light/ultra_light

/obj/item/clothing/gloves/rig/light/ultra_light

/obj/item/clothing/shoes/magboots/rig/light/ultra_light
/obj/item/clothing/head/helmet/space/rig/light/ultra_light
	name = "HUD"
	body_parts_covered = EYES|EARS
	flags_inv = 0
	camera_networks = list(NETWORK_RESEARCH)

/obj/item/rig/light/ultra_light/janitor
	name = "SI 'Clean Spacer' control module"
	desc = "An ultra light, unarmoured rig suit. Commissioned for cleaners and janitors due to its enhanced speed and helping with protecting against biohazards. \
	Not as fast as the base Spacer Rig due to supportive magboots having galoshes helping janitors not slip."
	icon_state = "hacker_rig"
	suit_type = "SI 'Cleaner"
	boot_type =  /obj/item/clothing/shoes/magboots/rig/light/ultra_light/janitor
	slowdown = -0.1  //The cost of a no slip flag

/obj/item/clothing/shoes/magboots/rig/light/ultra_light/janitor
	item_flags = COVER_PREVENT_MANIPULATION | NOSLIP

/obj/item/clothing/shoes/magboots/rig/light/ultra_light/janitor/attack_self(mob/user)
	if(magpulse)
		magpulse = 0
		set_slowdown()
		force = WEAPON_FORCE_WEAK
		if(icon_base) icon_state = "[icon_base]0"
		to_chat(user, "You disable the mag-pulse traction system.")
	else
		magpulse = 1
		set_slowdown()
		force = WEAPON_FORCE_PAINFUL
		if(icon_base) icon_state = "[icon_base]1"
		to_chat(user, "You enable the mag-pulse traction system.")
	user.update_inv_shoes()	//so our mob-over-lays update
	user.update_action_buttons()
	user.update_floating()


/obj/item/rig/light/ultra_light/janitor/equipped
	initial_modules = list(
		/obj/item/rig_module/device/flash,
		/obj/item/rig_module/device/soap,
		/obj/item/rig_module/device/light_replacer,
		/obj/item/rig_module/device/paperfiller,
		/obj/item/rig_module/storage
		)

/obj/item/rig/light/hacker/steward
	name = "SI 'Retainer' control module"
	desc = "A Soteria Institute modification of the traditional light rig built for equal parts utility and defense."
	suit_type = "SI 'retainer"
	armor_list = list(
		melee = 7,
		bullet = 6,
		energy = 7,
		bomb = 30,
		bio = 100,
		rad = 80
	)
	emp_protection = 20
	ablative_armor = ABLATION_STANDARD //high quality armor
	ablative_max = 6 //but not a lot of it.
	seal_delay = 5
	airtight = 0
	icon_state = "hacker_rig"
	req_access = list(access_hop)
	price_tag = 2000

	initial_modules = list(
		/obj/item/rig_module/mounted/taser,
		/obj/item/rig_module/device/flash,
		/obj/item/rig_module/vision/medhud,
		/obj/item/rig_module/device/healthscanner,
		/obj/item/rig_module/modular_injector/medical/preloaded,
		/obj/item/rig_module/ai_container,
		//obj/item/rig_module/storage
		)



/obj/item/rig/light/hacker
	name = "cybersuit control module"
	suit_type = "cyber"
	desc = "An advanced powered armour suit with many cyberwarfare enhancements. Comes with built-in insulated gloves for safely tampering with electronics."
	icon_state = "hacker_rig"
	armor_list = list(
		melee = 6,
		bullet = 5,
		energy = 5,
		bomb = 25,
		bio = 100,
		rad = 80
	)

	req_access = list(access_syndicate)

	airtight = 0
	seal_delay = 5 //not being vaccum-proof has an upside I guess

	helm_type = /obj/item/clothing/head/lightrig/hacker
	chest_type = /obj/item/clothing/suit/lightrig/hacker
	glove_type = /obj/item/clothing/gloves/lightrig/hacker
	boot_type = /obj/item/clothing/shoes/lightrig/hacker

//The cybersuit is not space-proof. It does however, have good siemens_coefficient values
/obj/item/clothing/head/lightrig/hacker
	name = "HUD"
	body_parts_covered = EYES|EARS
	siemens_coefficient = 0.4
	flags = 0

/obj/item/clothing/suit/lightrig/hacker
	siemens_coefficient = 0.4

/obj/item/clothing/shoes/lightrig/hacker
	siemens_coefficient = 0.4
	overslot = 1
	flags = NOSLIP //All the other rigs have magboots anyways, hopefully gives the hacker suit something more going for it.

/obj/item/clothing/gloves/lightrig/hacker
	overslot = 1
	siemens_coefficient = 0



/obj/item/rig/light/hacker/equipped

	initial_modules = list(
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/datajack,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/voice,
		/obj/item/rig_module/vision,
		)

/obj/item/rig/light/ninja
	name = "ominous suit control module"
	suit_type = "ominous"
	desc = "A unique, vaccum-proof suit of nano-enhanced armor designed specifically for assassins."
	icon_state = "ninja_rig"
	armor_list = list(
		melee = 7,
		bullet = 7,
		energy = 20,
		bomb = 25,
		bio = 100,
		rad = 100
	)
	seal_delay = 15
	emp_protection = 40 //change this to 30 if too high.
	slowdown = 0
	price_tag = 1000 //rare but ultimately not much to write home about other than its modules.

	chest_type = /obj/item/clothing/suit/space/rig/light/ninja
	glove_type = /obj/item/clothing/gloves/rig/light/ninja

	req_access = list(access_syndicate)

	initial_modules = list(
		/obj/item/rig_module/teleporter,
		/obj/item/rig_module/stealth_field,
		/obj/item/rig_module/held/energy_blade,
		/obj/item/rig_module/vision,
		/obj/item/rig_module/voice,
		/obj/item/rig_module/fabricator/energy_net,
		/obj/item/rig_module/modular_injector/combat/preloaded,
		/obj/item/rig_module/grenade_launcher,
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/datajack,
		/obj/item/rig_module/self_destruct
		)

/obj/item/clothing/gloves/rig/light/ninja
	name = "insulated gloves"
	siemens_coefficient = 0

/obj/item/clothing/suit/space/rig/light/ninja
	breach_threshold = 38 //comparable to regular hardsuits

/obj/item/rig/light/stealth
	name = "stealth suit control module"
	suit_type = "stealth"
	desc = "A highly advanced and expensive suit designed for covert operations."
	icon_state = "ninja_rig"

	req_access = list(access_syndicate)

	initial_modules = list(
		/obj/item/rig_module/stealth_field,
		/obj/item/rig_module/vision
		)
