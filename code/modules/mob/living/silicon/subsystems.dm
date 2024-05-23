/mob/living/silicon
	var/list/silicon_subsystems_by_name = list()
	var/list/silicon_subsystems = list(
		/datum/nano_module/alarm_monitor/all,
		/datum/nano_module/law_manager,
		/datum/tgui_module/email_client/silicon,
		/datum/nano_module/crew_monitor,
		/datum/nano_module/chem_catalog,
		/datum/nano_module/drink_catalog,
		/datum/nano_module/cook_catalog
	)

/mob/living/silicon/ai/New()
	silicon_subsystems.Cut()
	for(var/subtype in subtypesof(/datum/nano_module))
		var/datum/nano_module/NM = subtype
		if(initial(NM.available_to_ai))
			silicon_subsystems += NM
	for(var/subtype in subtypesof(/datum/tgui_module))
		var/datum/tgui_module/TM = subtype
		if(initial(TM.available_to_ai))
			silicon_subsystems += TM
	..()

/mob/living/silicon/robot/syndicate
	silicon_subsystems = list(
		/datum/nano_module/law_manager,
		/datum/tgui_module/email_client/silicon,
	)

/mob/living/silicon/Destroy()
	for(var/subsystem in silicon_subsystems)
		remove_subsystem(subsystem)
	silicon_subsystems.Cut()
	. = ..()

/mob/living/silicon/proc/init_subsystems()
	for(var/subsystem_type in silicon_subsystems)
		init_subsystem(subsystem_type)

	if(/datum/nano_module/alarm_monitor/all in silicon_subsystems)
		for(var/datum/alarm_handler/AH in SSalarm.all_handlers)
			AH.register_alarm(src, /mob/living/silicon/proc/receive_alarm)
			queued_alarms[AH] = list()	// Makes sure alarms remain listed in consistent order

/mob/living/silicon/proc/init_subsystem(var/subsystem_type)
	var/existing_entry = silicon_subsystems[subsystem_type]
	if(existing_entry && !ispath(existing_entry))
		return FALSE

	var/ui_state = subsystem_type == /datum/nano_module/law_manager ? GLOB.conscious_state : GLOB.self_state
	var/stat_silicon_subsystem/SSS = new(src, subsystem_type, ui_state)
	silicon_subsystems[subsystem_type] = SSS
	silicon_subsystems_by_name[SSS.name] = SSS
	return TRUE

/mob/living/silicon/proc/remove_subsystem(var/subsystem_type)
	var/stat_silicon_subsystem/SSS = silicon_subsystems[subsystem_type]
	if(!istype(SSS))
		return FALSE

	silicon_subsystems_by_name -= SSS.name
	silicon_subsystems -= subsystem_type
	qdel(SSS)
	return TRUE

/mob/living/silicon/proc/open_subsystem(var/subsystem_type, var/mob/given = src)
	var/stat_silicon_subsystem/SSS = silicon_subsystems[subsystem_type]
	if(!istype(SSS))
		return FALSE
	SSS.Click(given)
	return TRUE

/mob/living/silicon/verb/show_crew_sensors()
	set name = "Show Crew Sensors"
	set desc = "Track crew gps beacons"

	open_subsystem(/datum/nano_module/crew_monitor)

/mob/living/silicon/verb/show_email()
	set name = "Show Emails"
	set desc = "Open email subsystem"

	open_subsystem(/datum/tgui_module/email_client/silicon)

/mob/living/silicon/verb/show_alerts()
	set name = "Show Alerts"
	set desc = "Open alerts monitor system"
	open_subsystem(/datum/nano_module/alarm_monitor/all)

/mob/living/silicon/verb/show_chemicals_mixes()
	set name = "Show Chem Catalog"
	set desc = "Open the Chem Catalog"
	open_subsystem(/datum/nano_module/chem_catalog)

/mob/living/silicon/verb/show_drink_mixes()
	set name = "Show Drink Catalog"
	set desc = "Open Neon Cocktails for all your mixing needs."
	open_subsystem(/datum/nano_module/drink_catalog)

/mob/living/silicon/verb/show_cook_catalog()
	set name = "Show VIKA Catalog"
	set desc = "Open Lonestar (and Soteria) Presents: Victoria's Incredible Kitchen Assistant."
	open_subsystem(/datum/nano_module/cook_catalog)

/mob/living/silicon/verb/activate_subsystem()
	set name = "Subsystems"
	set desc = "Activates the given subsystem"
	set category = "Silicon Commands"

	var/subsystem = input(src, "Choose a sybsystem:", "Subsystems") as null|anything in silicon_subsystems_by_name
	var/stat_silicon_subsystem/SSS = silicon_subsystems_by_name[subsystem]

	if(istype(SSS))
		SSS.Click()

/mob/living/silicon/Stat()
	. = ..()
	if(!.)
		return
	if(!silicon_subsystems.len)
		return
	if(!statpanel("Subsystems"))
		return
	for(var/subsystem_type in silicon_subsystems)
		var/stat_silicon_subsystem/SSS = silicon_subsystems[subsystem_type]
		stat(SSS)

/mob/living/silicon/proc/get_subsystem_from_path(subsystem_type)
	var/stat_silicon_subsystem/SSS = silicon_subsystems[subsystem_type]
	if(!istype(SSS))
		return 0
	if(!istype(SSS.subsystem, subsystem_type))
		return 0
	return SSS.subsystem

/stat_silicon_subsystem
	parent_type = /atom/movable
	simulated = 0
	var/ui_state
	var/datum/nano_module/subsystem

/stat_silicon_subsystem/New(var/mob/living/silicon/loc, var/subsystem_type, var/ui_state)
	if(!istype(loc))
		CRASH("Unexpected location. Expected /mob/living/silicon, was [loc.type].")
	src.ui_state = ui_state
	subsystem = new subsystem_type(loc)
	name = subsystem.name
	..()

/stat_silicon_subsystem/Destroy()
	qdel(subsystem)
	subsystem = null
	. = ..()

/stat_silicon_subsystem/Click(mob/user)
	if(!istype(user))
		user = usr

	if(istype(subsystem, /datum/nano_module))
		subsystem.nano_ui_interact(user, state = ui_state)
	else if(istype(subsystem, /datum/tgui_module))
		subsystem.ui_interact(user)

