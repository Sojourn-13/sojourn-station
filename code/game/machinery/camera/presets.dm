// PRESETS
var/global/list/station_networks = list(
	NETWORK_COLONY_SURFACE,
	NETWORK_COLONY_UNDERGROUND,
	NETWORK_COLONY_TRANSITION,
	NETWORK_CHURCH,
	NETWORK_PROP,
	NETWORK_COMMAND,
	NETWORK_ENGINE,
	NETWORK_ENGINEERING,
	NETWORK_CEV_ERIS,
	NETWORK_MEDICAL,
	NETWORK_MINE,
	NETWORK_RESEARCH,
	NETWORK_ROBOTS,
	NETWORK_CARGO,
	NETWORK_SECURITY,
	NETWORK_PLASMA_TAG
)

var/global/list/engineering_networks = list(
	NETWORK_ENGINE,
	NETWORK_ENGINEERING,
	"Atmosphere Alarms",
	"Fire Alarms",
	"Power Alarms"
)

/obj/machinery/camera/network/crescent
	network = list(NETWORK_CRESCENT)

/obj/machinery/camera/network/gate
	network = list(NETWORK_GATE)

/obj/machinery/camera/network/cargo
	network = list(NETWORK_CARGO)

/obj/machinery/camera/network/colony_surface
	network = list(NETWORK_COLONY_SURFACE)

/obj/machinery/camera/network/colony_underground
	network = list(NETWORK_COLONY_UNDERGROUND)

/obj/machinery/camera/network/colony_transition
	network = list(NETWORK_COLONY_TRANSITION)

/obj/machinery/camera/network/church
	network = list(NETWORK_CHURCH)

/obj/machinery/camera/network/propis
	network = list(NETWORK_PROP)

/obj/machinery/camera/network/plasma_tag
	network = list(NETWORK_PLASMA_TAG)

/obj/machinery/camera/network/command
	network = list(NETWORK_COMMAND)

/obj/machinery/camera/network/engine
	network = list(NETWORK_ENGINE)

/obj/machinery/camera/network/engineering
	network = list(NETWORK_ENGINEERING)

/obj/machinery/camera/network/cev_eris
	network = list(NETWORK_CEV_ERIS)

/obj/machinery/camera/network/mining
	network = list(NETWORK_MINE)

/obj/machinery/camera/network/prison
	network = list(NETWORK_PRISON)

/obj/machinery/camera/network/medbay
	network = list(NETWORK_MEDICAL)

/obj/machinery/camera/network/research
	network = list(NETWORK_RESEARCH)

/obj/machinery/camera/network/research_outpost
	network = list(NETWORK_RESEARCH_OUTPOST)

/obj/machinery/camera/network/security
	network = list(NETWORK_SECURITY)

/obj/machinery/camera/network/telecom
	network = list(NETWORK_TELECOM)

/obj/machinery/camera/network/thunder
	network = list(NETWORK_THUNDER)

// EMP

/obj/machinery/camera/emp_proof/New()
	..()
	upgradeEmpProof()

// X-RAY

/obj/machinery/camera/xray
	icon_state = "xraycam" // Thanks to Krutchen for the icons.

/obj/machinery/camera/xray/security
	network = list(NETWORK_SECURITY)

/obj/machinery/camera/xray/medbay
	network = list(NETWORK_MEDICAL)

/obj/machinery/camera/xray/research
	network = list(NETWORK_RESEARCH)

/obj/machinery/camera/xray/New()
	..()
	upgradeXRay()

// MOTION

/obj/machinery/camera/motion/New()
	..()
	upgradeMotion()

/obj/machinery/camera/motion/security
	network = list(NETWORK_SECURITY)

// ALL UPGRADES


/obj/machinery/camera/all/command
	network = list(NETWORK_COMMAND)

/obj/machinery/camera/all/New()
	..()
	upgradeEmpProof()
	upgradeXRay()
	upgradeMotion()

// CHECKS

/obj/machinery/camera/proc/isEmpProof()
	var/O = locate(/obj/item/stack/material/osmium) in assembly.upgrades
	return O

/obj/machinery/camera/proc/isXRay()
	var/obj/item/stock_parts/scanning_module/O = locate(/obj/item/stock_parts/scanning_module) in assembly.upgrades
	if (O && O.rating >= 2)
		return O
	return null

/obj/machinery/camera/proc/isMotion()
	var/O = locate(/obj/item/device/assembly/prox_sensor) in assembly.upgrades
	return O

// UPGRADE PROCS

/obj/machinery/camera/proc/upgradeEmpProof()
	assembly.upgrades.Add(new /obj/item/stack/material/osmium(assembly))
	setPowerUsage()
	update_coverage()

/obj/machinery/camera/proc/upgradeXRay()
	assembly.upgrades.Add(new /obj/item/stock_parts/scanning_module/adv(assembly))
	setPowerUsage()
	update_coverage()

/obj/machinery/camera/proc/upgradeMotion()
	assembly.upgrades.Add(new /obj/item/device/assembly/prox_sensor(assembly))
	setPowerUsage()
	START_PROCESSING(SSmachines, src)
	update_coverage()

/obj/machinery/camera/proc/setPowerUsage()
	var/mult = 1
	if (isXRay())
		mult++
	if (isMotion())
		mult++
	active_power_usage = mult*initial(active_power_usage)
