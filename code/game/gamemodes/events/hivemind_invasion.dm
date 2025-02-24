//Hivemind is rogue AI that uses unknown nanotech to follow some strange objective
//In fact, it's just hostile structures, wireweeds spreading event with some mobs
//Requires hard teamwork at late stages, but easily can be handled at the beginning

//All code stored in modules/hivemind


/datum/storyevent/hivemind
	id = "hivemind"
	name = "Hivemind Invasion"


	event_type = /datum/event/hivemind
	event_pools = list(EVENT_LEVEL_MAJOR = POOL_THRESHOLD_MAJOR*0.90)
	tags = list(TAG_COMMUNAL, TAG_DESTRUCTIVE, TAG_NEGATIVE, TAG_SCARY)
//============================================

/datum/event/hivemind
	var/turf/start_location
	var/failed_to_spawn = FALSE
	announceWhen	= 30 SECONDS
	endWhen = 10 MINUTES

/datum/event/hivemind/announce()
	level_eight_announcement() //new announcment so the crew doesn't have to fuck around trying to figure out if its a blob, hivemind, or a literal fungus

#define AMOUNT_OF_THREAT_PER_PLAYER 7 //The tipping point when the multi goes above 1 or lower than 1
#define THREAT_MIN_MULTI 0.3 //Keep this value always lower than 1 and above 0
#define THREAT_MAX_MULTI 2	//Keep this value above 1
#define STEPS_PER_PLAYER 0.08 //How much each extra is added to the multi for each extra player

/datum/event/hivemind/start()
	var/active_players = 0
	var/threat_scale = 1
	var/mob/living/carbon/human/fighter
	for(fighter in GLOB.player_list)
		if(!fighter.mind)
			log_and_message_admins("[fighter.name] Is in the player_list without having a mind.")
			return
		if(fighter.mind.assigned_role in list(JOBS_ANTI_HIVEMIND))
			active_players++

	for(var/i=1 to 100)
		var/area/A = random_ship_area(filter_players = TRUE, filter_maintenance = TRUE, filter_critical = TRUE)
		start_location = A.random_space()
		if(!start_location && i == 100)
			log_and_message_admins("Hivemind failed to find a viable turf.")
			failed_to_spawn = TRUE
			kill()
			return
		if(start_location)
			break

	log_and_message_admins("Active Hivemind combative players number is [active_players].")
	if(GLOB.hive_data_bool["pop_lock"])
		if(active_players > AMOUNT_OF_THREAT_PER_PLAYER)
			threat_scale = min(1 + (active_players - AMOUNT_OF_THREAT_PER_PLAYER) * STEPS_PER_PLAYER, THREAT_MAX_MULTI)
		else
			threat_scale = max(active_players / AMOUNT_OF_THREAT_PER_PLAYER, THREAT_MIN_MULTI)

		if(active_players < 1)
			log_and_message_admins("Hivemind failed to spawn as there were less then 1 active player expected to combat the hivemind.")
			failed_to_spawn = TRUE
			kill()
			return

	message_admins("Hivemind spawned at \the [jumplink(start_location)]")
	var/obj/machinery/hivemind_machine/node/quickset = new /obj/machinery/hivemind_machine/node(start_location)
	quickset.threat_scale = threat_scale

/datum/event/hivemind/end()
	if(GLOB.hive_data_bool["reveal_location"] && !failed_to_spawn)
		command_announcement.Announce("Electromagneticfield triangulation suggests a Hivemind presence at [start_location.loc.name] | x:[start_location.x], y:[start_location.y], z:[start_location.z].", "Biohazard Alert")

#undef AMOUNT_OF_THREAT_PER_PLAYER
#undef THREAT_MIN_MULTI
#undef THREAT_MAX_MULTI
#undef STEPS_PER_PLAYER
