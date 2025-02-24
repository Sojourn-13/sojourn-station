/obj/item/stock_parts
	name = "stock part"
	desc = "What?"
	gender = PLURAL
	icon = 'icons/obj/stock_parts.dmi'
	w_class = ITEM_SIZE_SMALL
	price_tag = 100
	var/rating = 1

/obj/item/stock_parts/New()
	src.pixel_x = rand(-5.0, 5)
	src.pixel_y = rand(-5.0, 5)
	..()

/obj/item/stock_parts/get_item_cost(export)
	. = ..() * rating

//Rank 1

/obj/item/stock_parts/console_screen
	name = "console screen"
	desc = "Used in the construction of computers and other devices with a interactive console."
	icon_state = "screen"
	origin_tech = list(TECH_MATERIAL = 1)
	matter = list(MATERIAL_GLASS = 3)
	price_tag = 30

/obj/item/stock_parts/capacitor
	name = "capacitor"
	desc = "A basic capacitor used in the construction of a variety of devices."
	icon_state = "capacitor_t1"
	origin_tech = list(TECH_POWER = 1)
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_GLASS = 1)
	price_tag = 30

/obj/item/stock_parts/scanning_module
	name = "scanning module"
	desc = "A compact, high resolution scanning module used in the construction of certain devices."
	icon_state = "scanner_t1"
	origin_tech = list(TECH_MAGNET = 1)
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_GLASS = 1)
	price_tag = 30

/obj/item/stock_parts/manipulator
	name = "micro-manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	icon_state = "mani_t1"
	origin_tech = list(TECH_MATERIAL = 1, TECH_DATA = 1)
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1)
	price_tag = 30

/obj/item/stock_parts/micro_laser
	name = "micro-laser"
	desc = "A tiny laser used in certain devices."
	icon_state = "laser_t1"
	origin_tech = list(TECH_MAGNET = 1)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 30

/obj/item/stock_parts/matter_bin
	name = "matter bin"
	desc = "A container for hold compressed matter awaiting re-construction."
	icon_state = "bin_t1"
	origin_tech = list(TECH_MATERIAL = 1)
	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 30

//Rank 2

/obj/item/stock_parts/capacitor/adv
	name = "advanced capacitor"
	desc = "An advanced capacitor used in the construction of a variety of devices."
	icon_state = "capacitor_t2"
	origin_tech = list(TECH_POWER = 3)
	rating = 2
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_GLASS = 1)
	price_tag = 50

/obj/item/stock_parts/scanning_module/adv
	name = "advanced scanning module"
	desc = "A compact, high resolution scanning module used in the construction of certain devices."
	icon_state = "scanner_t2"
	origin_tech = list(TECH_MAGNET = 3)
	rating = 2
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_GLASS = 1)
	price_tag = 50

/obj/item/stock_parts/manipulator/nano
	name = "nano-manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	icon_state = "mani_t2"
	origin_tech = list(TECH_MATERIAL = 3, TECH_DATA = 2)
	rating = 2
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1)
	price_tag = 50

/obj/item/stock_parts/micro_laser/high
	name = "high-power micro-laser"
	desc = "A tiny laser used in certain devices."
	icon_state = "laser_t2"
	origin_tech = list(TECH_MAGNET = 3)
	rating = 2
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1, MATERIAL_GLASS = 1)
	price_tag = 50

/obj/item/stock_parts/matter_bin/adv
	name = "advanced matter bin"
	desc = "A container for hold compressed matter awaiting re-construction."
	icon_state = "bin_t2"
	origin_tech = list(TECH_MATERIAL = 3)
	rating = 2
	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 50

//Rating 3

/obj/item/stock_parts/capacitor/super
	name = "super capacitor"
	desc = "A super-high capacity capacitor used in the construction of a variety of devices."
	icon_state = "capacitor_t3"
	origin_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	rating = 3
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 65

/obj/item/stock_parts/scanning_module/phasic
	name = "phasic scanning module"
	desc = "A compact, high resolution phasic scanning module used in the construction of certain devices."
	icon_state = "scanner_t3"
	origin_tech = list(TECH_MAGNET = 5)
	rating = 3
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 65

/obj/item/stock_parts/manipulator/pico
	name = "pico-manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	icon_state = "mani_t3"
	origin_tech = list(TECH_MATERIAL = 5, TECH_DATA = 2)
	rating = 3
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)
	price_tag = 65

/obj/item/stock_parts/micro_laser/ultra
	name = "ultra-high-power micro-laser"
	icon_state = "laser_t3"
	desc = "A tiny laser used in certain devices."
	origin_tech = list(TECH_MAGNET = 5)
	rating = 3
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 65

/obj/item/stock_parts/matter_bin/super
	name = "super matter bin"
	desc = "A container for hold compressed matter awaiting re-construction."
	icon_state = "bin_t3"
	origin_tech = list(TECH_MATERIAL = 5)
	rating = 3
	matter = list(MATERIAL_PLASTIC = 3, MATERIAL_GLASS = 1)
	price_tag = 65

//greyson positronic stock parts (rating 4)

/obj/item/stock_parts/capacitor/one_star
	name = "Greyson Positronic capacitor"
	desc = "A super-high capacity capacitor used in the construction of a variety of devices."
	icon_state = "one_capacitor"
	origin_tech = list(TECH_POWER = 7, TECH_MATERIAL = 7)
	rating = 4
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1, MATERIAL_PLATINUM = 2)
	price_tag = 80

/obj/item/stock_parts/scanning_module/one_star
	name = "Greyson Positronic scanning module"
	desc = "A compact, high resolution phasic scanning module used in the construction of certain devices."
	icon_state = "one_scan_module"
	origin_tech = list(TECH_MAGNET = 7)
	rating = 4
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1, MATERIAL_PLATINUM = 2)
	price_tag = 80

/obj/item/stock_parts/manipulator/one_star
	name = "Greyson Positronic manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	icon_state = "one_mani"
	origin_tech = list(TECH_MATERIAL = 7, TECH_DATA = 6)
	rating = 4
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_PLATINUM = 2)
	price_tag = 80

/obj/item/stock_parts/micro_laser/one_star
	name = "Greyson Positronic micro-laser"
	icon_state = "one_laser"
	desc = "A tiny laser used in certain devices."
	origin_tech = list(TECH_MAGNET = 7)
	rating = 4
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1, MATERIAL_PLATINUM = 2)
	price_tag = 80

/obj/item/stock_parts/matter_bin/one_star
	name = "Greyson Positronic matter bin"
	desc = "A container for hold compressed matter awaiting re-construction."
	icon_state = "one_matter"
	origin_tech = list(TECH_MATERIAL = 7)
	rating = 4
	matter = list(MATERIAL_PLASTIC = 3, MATERIAL_GLASS = 1, MATERIAL_PLATINUM = 2)
	price_tag = 80

//Guild stock parts (rating 4)
/obj/item/stock_parts/capacitor/guild
	name = "ultra capacitor"
	desc = "A guild tinkered super-high capacity capacitor used in the construction of a variety of devices."
	icon_state = "capacitor_guild"
	origin_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	rating = 4
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1, MATERIAL_GOLD  = 2, MATERIAL_SILVER = 2)
	price_tag = 100

/obj/item/stock_parts/scanning_module/guild
	name = "over-tuned scanning module"
	desc = "An over engineered and expensive yet compact, high resolution phasic scanning module used in the construction of certain devices."
	icon_state = "scanner_guild"
	origin_tech = list(TECH_MAGNET = 5)
	rating = 4
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 2, MATERIAL_RGLASS  = 1, MATERIAL_GOLD  = 2, MATERIAL_SILVER = 2)
	price_tag = 100

/obj/item/stock_parts/manipulator/guild
	name = "forged manipulator"
	desc = "A buffed up pico manipulator with a added case to increase manipulation used in the construction of certain devices."
	icon_state = "mani_guild"
	origin_tech = list(TECH_MATERIAL = 5, TECH_DATA = 2)
	rating = 4
	matter = list(MATERIAL_PLASTEEL = 3, MATERIAL_PLASTIC = 5)
	price_tag = 100

/obj/item/stock_parts/micro_laser/guild
	name = "perfected micro-laser"
	icon_state = "laser_guild"
	desc = "An ultra-high micro laser with a perfected lens to increase productivity."
	origin_tech = list(TECH_MAGNET = 5)
	rating = 4
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1, MATERIAL_RGLASS = 1, MATERIAL_SILVER = 1)
	price_tag = 100

/obj/item/stock_parts/matter_bin/guild
	name = "cast matter bin"
	desc = "A super matter bin with added compression cast onto the base itself for more effective storage."
	icon_state = "bin_guild"
	origin_tech = list(TECH_MATERIAL = 5)
	rating = 4
	matter = list(MATERIAL_PLASTEEL = 3, MATERIAL_GLASS = 1, MATERIAL_PLASMAGLASS = 1)
	price_tag = 100

//Guild stock parts (rating 5)
/obj/item/stock_parts/capacitor/handmade
	name = "handcrafted ultra capacitor"
	desc = "A guild tinkered super-high capacity capacitor used in the construction of a variety of devices. Being made by hand by the skilled Guild shows that they can out perform even a Nanoforge."
	icon_state = "capacitor_guild"
	origin_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	rating = 5
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1, MATERIAL_GOLD  = 2, MATERIAL_SILVER = 2)
	price_tag = 200

/obj/item/stock_parts/scanning_module/handmade
	name = "handcrafted over-tuned scanning module"
	desc = "An over engineered and expensive yet compact, high resolution phasic scanning module used in the construction of certain devices. Being made by hand by the skilled Guild shows that they can out perform even a Nanoforge."
	icon_state = "scanner_guild"
	origin_tech = list(TECH_MAGNET = 5)
	rating = 5
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 2, MATERIAL_RGLASS  = 1, MATERIAL_GOLD  = 2, MATERIAL_SILVER = 2)
	price_tag = 200

/obj/item/stock_parts/manipulator/handmade
	name = "handcrafted forged manipulator"
	desc = "A buffed up pico manipulator with a added case to increase manipulation used in the construction of certain devices. Being made by hand by the skilled Guild shows that they can out perform even a Nanoforge."
	icon_state = "mani_guild"
	origin_tech = list(TECH_MATERIAL = 5, TECH_DATA = 2)
	rating = 5
	matter = list(MATERIAL_PLASTEEL = 3, MATERIAL_PLASTIC = 5)
	price_tag = 200

/obj/item/stock_parts/micro_laser/handmade
	name = "handcrafted perfected micro-laser"
	icon_state = "laser_guild"
	desc = "An ultra-high micro laser with a perfected lens to increase productivity. Being made by hand by the skilled Guild shows that they can out perform even a Nanoforge."
	origin_tech = list(TECH_MAGNET = 5)
	rating = 5
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1, MATERIAL_RGLASS = 1, MATERIAL_SILVER = 1)
	price_tag = 200

/obj/item/stock_parts/matter_bin/handmade
	name = "handcrafted cast matter bin"
	desc = "A super matter bin with added compression cast onto the base itself for more effective storage. Being made by hand by the skilled Guild shows that they can out perform even a Nanoforge."
	icon_state = "bin_guild"
	origin_tech = list(TECH_MATERIAL = 5)
	rating = 5
	matter = list(MATERIAL_PLASTEEL = 3, MATERIAL_GLASS = 2, MATERIAL_STEEL = 1)
	price_tag = 200

//excelsior stock parts (rating 5)
/obj/item/stock_parts/capacitor/excelsior
	name = "excelsior capacitor"
	desc = "A super-high capacity capacitor used in the construction of a variety of devices."
	icon_state = "capacitor_excel"
	origin_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	rating = 5
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 100

/obj/item/stock_parts/scanning_module/excelsior
	name = "excelsior scanning module"
	desc = "A compact, high resolution phasic scanning module used in the construction of certain devices."
	icon_state = "scanner_excel"
	origin_tech = list(TECH_MAGNET = 5)
	rating = 5
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 100

/obj/item/stock_parts/manipulator/excelsior
	name = "excelsior manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	icon_state = "mani_excel"
	origin_tech = list(TECH_MATERIAL = 5, TECH_DATA = 2)
	rating = 5
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)
	price_tag = 100

/obj/item/stock_parts/micro_laser/excelsior
	name = "excelsior micro-laser"
	icon_state = "laser_excel"
	desc = "A tiny laser used in certain devices."
	origin_tech = list(TECH_MAGNET = 5)
	rating = 5
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 100

/obj/item/stock_parts/matter_bin/excelsior
	name = "excelsior matter bin"
	desc = "A container for holding compressed matter awaiting re-construction."
	icon_state = "bin_excel"
	origin_tech = list(TECH_MATERIAL = 5)
	rating = 5
	matter = list(MATERIAL_PLASTIC = 3, MATERIAL_GLASS = 1)
	price_tag = 100

//alien stock parts (rating 6)

/obj/item/stock_parts/capacitor/alien_capacitor
	name = "Exothermic Seal"
	desc = "A can-shaped brass component, covered in scratch marks and weathered by time. A faint humming can be heard coming from its inner workings. Seems like it can be used in construction of certain devices."
	icon_state = "alien_capacitor"
	origin_tech = list(TECH_POWER = 5, TECH_MATERIAL = 5)
	rating = 6
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 1, MATERIAL_GLASS = 3)
	price_tag = 700

/obj/item/stock_parts/scanning_module/alien
	name = "Optical receptor"
	desc = "A device, closely resembling a human eye. The pupil dilates and contracts when exposed to different materials. Seems like it can be used in construction of certain devices."
	icon_state = "alien_scan_module"
	origin_tech = list(TECH_MAGNET = 5)
	rating = 6
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 700

/obj/item/stock_parts/manipulator/alien
	name = "Gripper"
	desc = "This strange chunk of metal opens and closes its claws, as if it was a freshly cut crab arm. Seems like it can be used in construction of certain devices."
	icon_state = "alien_mani"
	origin_tech = list(TECH_MATERIAL = 5, TECH_DATA = 2)
	rating = 6
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)
	price_tag = 700

/obj/item/stock_parts/micro_laser/alien
	name = "Pico-emitter"
	icon_state = "alien_laser"
	desc = "A bright glass orb with a port on its back. It glows faint blue from time to time. Seems like it can be used in construction of certain devices."
	origin_tech = list(TECH_MAGNET = 5)
	rating = 6
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	price_tag = 700

/obj/item/stock_parts/matter_bin/alien
	name = "Receptacle"
	desc = "A twisted and time-weathered metal contraption, that's slightly warm to the touch. Seems like it can be used in construction of certain devices."
	icon_state = "alien_matter"
	origin_tech = list(TECH_MATERIAL = 5)
	rating = 6
	matter = list(MATERIAL_PLASTIC = 3, MATERIAL_GLASS = 1)
	price_tag = 700


// Subspace stock parts

/obj/item/stock_parts/subspace/ansible
	name = "subspace ansible"
	icon_state = "subspace_ansible"
	desc = "A compact module capable of sensing extradimensional activity."
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 5 ,TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_GLASS = 1, MATERIAL_SILVER = 2)
	price_tag = 150

/obj/item/stock_parts/subspace/filter
	name = "hyperwave filter"
	icon_state = "hyperwave_filter"
	desc = "A tiny device capable of filtering and converting super-intense radiowaves."
	origin_tech = list(TECH_DATA = 4, TECH_MAGNET = 2)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_GLASS = 1, MATERIAL_SILVER = 1)
	price_tag = 100

/obj/item/stock_parts/subspace/amplifier
	name = "subspace amplifier"
	icon_state = "subspace_amplifier"
	desc = "A compact micro-machine capable of amplifying weak subspace transmissions."
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_GLASS = 1, MATERIAL_SILVER = 1)
	price_tag = 100

/obj/item/stock_parts/subspace/treatment
	name = "subspace treatment disk"
	icon_state = "treatment_disk"
	desc = "A compact micro-machine capable of stretching out hyper-compressed radio waves."
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 2, TECH_MATERIAL = 5, TECH_BLUESPACE = 2)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_GLASS = 1, MATERIAL_SILVER = 1)
	price_tag = 100

/obj/item/stock_parts/subspace/analyzer
	name = "subspace wavelength analyzer"
	icon_state = "wavelength_analyzer"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_GLASS = 1, MATERIAL_SILVER = 1)
	price_tag = 100

/obj/item/stock_parts/subspace/crystal
	name = "ansible crystal"
	icon_state = "ansible_crystal"
	desc = "A crystal made from pure glass used to transmit laser data bursts to subspace."
	origin_tech = list(TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_GLASS = 1, MATERIAL_SILVER = 2)
	price_tag = 150

/obj/item/stock_parts/subspace/transmitter
	name = "subspace transmitter"
	icon_state = "subspace_transmitter"
	desc = "A large piece of equipment used to open a window into the subspace dimension."
	origin_tech = list(TECH_MAGNET = 5, TECH_MATERIAL = 5, TECH_BLUESPACE = 3)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_GLASS = 1, MATERIAL_SILVER = 1)
	price_tag = 100

//Blackshield stock parts

/obj/item/stock_parts/blackshield/stskit
	name = "blackshield conversion kit"
	icon_state = "bs_kit"
	desc = "A parts kit developed from the commissioned STS-30s from Blackshield, for the purpose of converting more to the pattern."
	matter = list(MATERIAL_PLASTEEL = 5, MATERIAL_PLASTIC = 3)
	price_tag = 100
