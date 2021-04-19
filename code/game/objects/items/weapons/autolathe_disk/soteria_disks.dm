// Disks formated as /designpath = pointcost , if no point cost is specified it defaults to 1.
// To make a design unprotect use -1

// Soteria
/obj/item/weapon/computer_hardware/hard_drive/portable/design/medical
	disk_name = "Soteria Medical Designs"
	icon_state = "moebius"
	license = 20
	designs = list(
		/datum/design/autolathe/gun/syringe_gun = 4,
		/datum/design/autolathe/misc/penflashlight,
		/datum/design/autolathe/tool/scalpel,
		/datum/design/autolathe/tool/circularsaw,
		/datum/design/autolathe/tool/bonegel,
		/datum/design/autolathe/tool/retractor,
		/datum/design/autolathe/tool/cautery,
		/datum/design/autolathe/tool/hemostat,
		/datum/design/autolathe/tool/bonesetter,
		/datum/design/autolathe/container/syringe,
		/datum/design/autolathe/container/syringe/large = 2,
		/datum/design/autolathe/container/vial,
		/datum/design/autolathe/container/beaker,
		/datum/design/autolathe/container/beaker_large,
		/datum/design/autolathe/container/pill_bottle,
		/datum/design/autolathe/container/spray,
		/datum/design/autolathe/device/implanter,
		/datum/design/autolathe/container/syringegun_ammo,
		/datum/design/autolathe/misc/bodybag,
		/datum/design/research/item/medical/autopsy_scanner,
		/datum/design/research/item/medical/roller_bed
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/medical/advanced
	disk_name = "Soteria Advanced Medical Designs"
	icon_state = "moebius"
	license = 10
	designs = list(
		/datum/design/autolathe/gun/syringe_gun,
		/datum/design/autolathe/misc/penflashlight,
		/datum/design/autolathe/container/syringe,
		/datum/design/autolathe/container/syringe/large,
		/datum/design/autolathe/container/vial = 0,
		/datum/design/autolathe/container/beaker,
		/datum/design/autolathe/container/beaker_large,
		/datum/design/autolathe/container/pill_bottle = 0,
		/datum/design/autolathe/container/spray,
		/datum/design/autolathe/container/syringegun_ammo,
		/datum/design/research/item/medical/cryobag,
		/datum/design/research/item/medical/compact_roller_bed,
		/datum/design/research/item/medical/adv_mass_spectrometer,
		/datum/design/research/item/medical/adv_reagent_scanner,
		/datum/design/research/item/medical/defibs = 3,
		/datum/design/research/item/medical/red,
		/datum/design/research/item/scalpel_laser,
		/datum/design/autolathe/tool/scalpel/advanced,
		/datum/design/research/item/bonesetter_adv,
		/datum/design/research/item/cautery_adv,
		/datum/design/research/item/hemostat_adv,
		/datum/design/research/item/retractor_adv,
		/datum/design/research/item/medsaw_circular,
		/datum/design/autolathe/tool/bonegel,
		/datum/design/research/item/medical/nanopaste = 2,
		/datum/design/research/item/clothing/health = 2
	)


/obj/item/weapon/computer_hardware/hard_drive/portable/design/medical/cmo
	disk_name = "Soteria Medical Factory"
	license = -1 //Same disk, but for the CBO exclusively with endless uses.

/obj/item/weapon/computer_hardware/hard_drive/portable/design/medical/advanced/cmo
	disk_name = "Soteria Advanced Medical Designs Factory"
	license = -1 //Same disk, but for the CBO exclusively with endless uses.

/obj/item/weapon/computer_hardware/hard_drive/portable/design/surgery
	disk_name = "Back Alley Organs"
	icon_state = "moebius"

	license = 5
	designs = list(
		/datum/design/bioprinter/lungs
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/computer
	disk_name = "Soteria Computer Parts"
	icon_state = "moebius"
	license = 20
	designs = list(
		/datum/design/autolathe/computer_part/frame_pda,
		/datum/design/autolathe/computer_part/frame_tablet,
		/datum/design/autolathe/computer_part/frame_laptop,
		/datum/design/research/item/computer_part/disk/micro,
		/datum/design/research/item/computer_part/disk/small,
		/datum/design/research/item/computer_part/disk/normal,
		/datum/design/research/item/computer_part/disk/advanced = 2,
		/datum/design/research/item/computer_part/cpu/basic,
		/datum/design/research/item/computer_part/cpu/basic/small,
		/datum/design/research/item/computer_part/cpu/adv = 2,
		/datum/design/research/item/computer_part/cpu/adv/small,
		/datum/design/research/item/computer_part/netcard/basic,
		/datum/design/research/item/computer_part/netcard/advanced = 2,
		/datum/design/research/item/computer_part/netcard/wired,
		/datum/design/research/item/computer_part/cardslot,
		/datum/design/research/item/computer_part/teslalink,
		/datum/design/research/item/computer_part/portabledrive/basic,
		/datum/design/research/item/computer_part/portabledrive/normal = 2,
		/datum/design/research/item/computer_part/printer,
		/datum/design/research/item/computer_part/led,
		/datum/design/research/item/computer_part/led/adv = 2,
		/datum/design/autolathe/device/camera,
		/datum/design/autolathe/device/camerafilm,
		/datum/design/autolathe/computer_part/gps,
		/datum/design/autolathe/part/heatsink = 2,
		/datum/design/autolathe/part/motor = 2,
		/datum/design/autolathe/part/dampener = 3,
		/datum/design/autolathe/part/cell_mout = 2,
		/datum/design/autolathe/computer_part/scanner/paper,
		/datum/design/autolathe/computer_part/scanner/atmos,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/computer/rd
	disk_name = "Soteria Computer Factory"
	license = -1

/obj/item/weapon/computer_hardware/hard_drive/portable/design/rped
	disk_name = "Soteria RnD Stock Parts Designs"
	icon_state = "moebius"
	license = 20
	designs = list(
		/datum/design/research/item/part/RPED = 2,
		/datum/design/research/item/part/basic_capacitor,
		/datum/design/research/item/part/adv_capacitor = 2,
		/datum/design/research/item/part/super_capacitor = 3,
		/datum/design/research/item/part/micro_mani,
		/datum/design/research/item/part/nano_mani = 2,
		/datum/design/research/item/part/pico_mani = 3,
		/datum/design/research/item/part/basic_matter_bin,
		/datum/design/research/item/part/adv_matter_bin = 2,
		/datum/design/research/item/part/super_matter_bin = 3,
		/datum/design/research/item/part/basic_micro_laser,
		/datum/design/research/item/part/high_micro_laser = 2,
		/datum/design/research/item/part/ultra_micro_laser = 3,
		/datum/design/research/item/part/basic_sensor,
		/datum/design/research/item/part/adv_sensor = 2,
		/datum/design/research/item/part/phasic_sensor = 3,
		/datum/design/autolathe/part/consolescreen
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/rped/rd
	disk_name = "Soteria Stock Parts Factory"
	license = -1
