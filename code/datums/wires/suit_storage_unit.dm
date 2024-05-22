/datum/wires/suit_storage_unit
	holder_type = /obj/machinery/suit_storage_unit
	wire_count = 3
	descriptions = list(
		new /datum/wire_description(SUIT_STORAGE_WIRE_ELECTRIFY, "Shock"),
		new /datum/wire_description(SUIT_STORAGE_WIRE_SAFETY, "Failsafe"),
		new /datum/wire_description(SUIT_STORAGE_WIRE_LOCKED, "ID scanner")
	)

var/const/SUIT_STORAGE_WIRE_ELECTRIFY	= 1
var/const/SUIT_STORAGE_WIRE_SAFETY		= 2
var/const/SUIT_STORAGE_WIRE_LOCKED		= 4

/datum/wires/suit_storage_unit/CanUse(var/mob/living/L)
	var/obj/machinery/suit_storage_unit/S = holder
	if(!issilicon(L))
		if(S.electrified)
			if(S.shock(L, 100))
				return 0
	if(S.panel_open)
		return 1
	return 0

/datum/wires/suit_storage_unit/get_status(mob/living/user)
	var/obj/machinery/suit_storage_unit/S = holder
	. = ..()
	. += "The orange light is [S.electrified ? "off" : "on"]."
	. += "The red light is [S.safeties ? "off" : "blinking"]."
	. += "The yellow light is [S.locked ? "on" : "off"]."

/datum/wires/suit_storage_unit/UpdatePulsed(var/index)
	var/obj/machinery/suit_storage_unit/S = holder
	switch(index)
		if(SUIT_STORAGE_WIRE_SAFETY)
			S.safeties = !S.safeties
		if(SUIT_STORAGE_WIRE_ELECTRIFY)
			S.electrified = 30
		if(SUIT_STORAGE_WIRE_LOCKED)
			S.locked = !S.locked

/datum/wires/suit_storage_unit/UpdateCut(var/index, var/mended)
	var/obj/machinery/suit_storage_unit/S = holder
	switch(index)
		if(SUIT_STORAGE_WIRE_SAFETY)
			S.safeties = mended
		if(SUIT_STORAGE_WIRE_LOCKED)
			S.locked = mended
		if(SUIT_STORAGE_WIRE_ELECTRIFY)
			if(mended)
				S.electrified = 0
			else
				S.electrified = -1
