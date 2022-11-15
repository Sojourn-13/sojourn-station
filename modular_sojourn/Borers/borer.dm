#define BORER_MODE_DETACHED 0
#define BORER_MODE_SEVERED 1
#define BORER_MODE_ATTACHED_HEAD 2
#define BORER_MODE_ATTACHED_CHEST 3
#define BORER_MODE_ATTACHED_ARM 4
#define BORER_MODE_ATTACHED_LEG 5
#define BORER_MODE_INFESTED 6
#define BORER_CAN_ASSUME_CONTROL TRUE

var/global/borer_chem_types_head = typesof(/datum/borer_chem/head) - /datum/borer_chem - /datum/borer_chem/head
var/global/borer_chem_types_chest = typesof(/datum/borer_chem/chest) - /datum/borer_chem - /datum/borer_chem/chest
var/global/borer_chem_types_arm = typesof(/datum/borer_chem/arm) - /datum/borer_chem - /datum/borer_chem/arm
var/global/borer_chem_types_leg = typesof(/datum/borer_chem/leg) - /datum/borer_chem - /datum/borer_chem/leg
var/global/borer_unlock_types_head = typesof(/datum/unlockable/borer/head) - /datum/unlockable/borer - /datum/unlockable/borer/head - /datum/unlockable/borer/head/chem_unlock - /datum/unlockable/borer/head/verb_unlock
var/global/borer_unlock_types_chest = typesof(/datum/unlockable/borer/chest) - /datum/unlockable/borer - /datum/unlockable/borer/chest - /datum/unlockable/borer/chest/chem_unlock - /datum/unlockable/borer/chest/verb_unlock
var/global/borer_unlock_types_arm = typesof(/datum/unlockable/borer/arm) - /datum/unlockable/borer - /datum/unlockable/borer/arm - /datum/unlockable/borer/arm/chem_unlock - /datum/unlockable/borer/arm/verb_unlock
var/global/borer_unlock_types_leg = typesof(/datum/unlockable/borer/leg) - /datum/unlockable/borer - /datum/unlockable/borer/leg - /datum/unlockable/borer/leg/chem_unlock - /datum/unlockable/borer/leg/verb_unlock

/mob/living/simple_animal/borer
	name = "borer"
	real_name = "borer"
	desc = "A small, quivering sluglike creature."
	speak_emote = list("chirrups")
	emote_hear = list("chirrups")
	response_help  = "pokes the"
	response_disarm = "prods the"
	response_harm   = "stomps on the"
	icon_state = "brainslug"
	icon_living = "brainslug"
	icon_dead = "brainslug_dead"
	speed = 6
	hud_type = /datum/hud_data/borer

	mob_size = MOB_MINISCULE

	min_tox = 0
	max_tox = 0

	density = 0
	a_intent = I_HURT
	stop_automated_movement = 1
	status_flags = CANPUSH
	attacktext = "nips"
	friendly = "prods"
	wander = 0
	pass_flags = PASSTABLE
	universal_understand = 1
	heat_damage_per_tick = 1
	cold_damage_per_tick = 1

	colony_friend = 1
	friendly_to_colony = 1

	var/busy = 0 // So we aren't trying to lay many eggs at once.
	var/chemicals = 10                      // Chemicals used for reproduction and spitting neurotoxin.

	var/mob/living/host								// Generic host for the brain worm.
	var/mob/living/captive_brain/host_brain			// Used for swapping control of the body back and forth.
	var/mob/living/carbon/human/H					// Human host for the brain worm.
	var/hostlimb									// Which limb of the host is inhabited by the borer.
	var/mob/living/carbon/superior_animal/symbiont	// Superior host for the brain worm.
	var/mob/living/simple_animal/parasitoid			// Lesser host for the brain worm.

	var/truename                            // Name used for brainworm-speak.
	var/host_name 							// Stores the old name of the host to revert to after namepick

	var/controlling                         // Used in human death check.
	var/list/avail_chems=list()
	var/list/unlocked_chems_head=list()
	var/list/unlocked_chems_chest=list()
	var/list/unlocked_chems_arm=list()
	var/list/unlocked_chems_leg=list()
	var/list/avail_abilities=list()         // Unlocked powers.
	var/list/attached_verbs_head=list(/obj/item/verbs/borer/attached_head)
	var/list/attached_verbs_chest=list(/obj/item/verbs/borer/attached_chest)
	var/list/attached_verbs_arm=list(/obj/item/verbs/borer/attached_arm)
	var/list/attached_verbs_leg=list(/obj/item/verbs/borer/attached_leg)
	var/list/severed_verbs=list(/obj/item/verbs/borer/severed)
	var/list/detached_verbs=list(/obj/item/verbs/borer/detached)
	var/numChildren=0

	var/datum/research_tree/borer/research
	var/list/verb_holders = list()
	var/list/borer_avail_unlocks_head = list()
	var/list/borer_avail_unlocks_chest = list()
	var/list/borer_avail_unlocks_arm = list()
	var/list/borer_avail_unlocks_leg = list()

	var/channeling = 0 //For abilities that require constant expenditure of chemicals.
	var/channeling_brute_resist = 0
	var/channeling_burn_resist = 0
	var/channeling_speed_increase = 0
	var/channeling_bone_talons = 0
	var/channeling_bone_sword = 0
	var/channeling_bone_shield = 0
	var/channeling_bone_hammer = 0
	var/channeling_bone_cocoon = 0
	var/channeling_night_vision = 0

//	var/obj/item/weapon/gun/hookshot/flesh/extend_o_arm = null
//	var/extend_o_arm_unlocked = 0

	// Event handles
	var/eh_emote

	var/static/list/name_prefixes = list("Primary","Secondary","Tertiary","Quaternary","Quinary","Senary","Septenary","Octonary","Nonary","Denary")
	var/name_prefix_index = 1
//	held_item = list()

/mob/living/simple_animal/borer/whisper()
	return FALSE

/mob/living/simple_animal/borer/is_allowed_vent_crawl_item(var/obj/item/carried_item)
	if(carried_item in list(/mob/living/captive_brain, /obj/item/verbs/borer))
		return 1
	return ..()

/*
/mob/living/simple_animal/borer/defected_borer
	name = "special borer"
	real_name = "special borer"
	desc = "A slightly defected, yet incredibly happy little brainslug."
	speak_emote = list("borks")
	emote_hear = list("barks")
	attacktext = "barks at"
	friendly = "barks at"
	icon_state = "bestborer"
	icon_living = "bestborer"
	icon_dead = "bestborer"

/mob/living/simple_animal/borer/defected_borer/singularity_act(current_size, obj/machinery/singularity/S)
	if(S.modifier != "special_")
		to_chat(world, "<span class='numb'><font size='15'>You feel Very Nice.</font></span>")
		S.modifier = "special_"
		S.name = "specialarity"
		world << sound('sound/effects/explosionfar.ogg')
	..()
*/
/mob/living/simple_animal/borer/New(var/loc, var/egg_prefix_index = 1)
	..(loc)
	name_prefix_index = min(egg_prefix_index, 10)
	truename = "[pick("Primary","Secondary","Tertiary","Quaternary")] [rand(1000,9999)]"
	host_brain = new/mob/living/captive_brain(src)

	if(name == initial(name)) // Easier reporting of griff.
		name = "[name] ([rand(1, 1000)])"
		real_name = name
	update_verbs(BORER_MODE_DETACHED)

	research = new (src)

	for(var/ultype in borer_unlock_types_head)
		var/datum/unlockable/borer/head/U = new ultype()
		if(U.id!="")
			borer_avail_unlocks_head.Add(U)
	for(var/ultype in borer_unlock_types_chest)
		var/datum/unlockable/borer/chest/U = new ultype()
		if(U.id!="")
			borer_avail_unlocks_chest.Add(U)
	for(var/ultype in borer_unlock_types_arm)
		var/datum/unlockable/borer/arm/U = new ultype()
		if(U.id!="")
			borer_avail_unlocks_arm.Add(U)
	for(var/ultype in borer_unlock_types_leg)
		var/datum/unlockable/borer/leg/U = new ultype()
		if(U.id!="")
			borer_avail_unlocks_leg.Add(U)
/*
	extend_o_arm = new /obj/item/weapon/gun/hookshot/flesh(src, src)



/mob/living/simple_animal/borer/Login()
	..()
	if(mind)
		RemoveAllFactionIcons(mind)*/

/mob/living/simple_animal/borer/Life()
	.=..()
	if(host && !stat && !(host.stat == 2))
		if(health < 20)
			health += 0.5
		if(chemicals < 250 && !channeling)
			chemicals++
		host.AI_inactive = TRUE

/mob/living/simple_animal/borer/proc/update_verbs(var/mode)
	if(verb_holders.len>0)
		for(var/VH in verb_holders)
			qdel(VH)
	verb_holders=list()
	var/list/verbtypes = list()
	avail_chems.len = 0
	switch(mode)
		if(BORER_MODE_DETACHED) // 0
			verbtypes=detached_verbs
		if(BORER_MODE_SEVERED) // 1
			verbtypes=severed_verbs
		if(BORER_MODE_ATTACHED_HEAD) // 2
			verbtypes=attached_verbs_head
			for(var/chemtype in borer_chem_types_head)
				var/datum/borer_chem/C = new chemtype()
				if(!C.unlockable)
					avail_chems[C.name]=C
			avail_chems += unlocked_chems_head
		if(BORER_MODE_ATTACHED_CHEST) // 3
			verbtypes=attached_verbs_chest
			for(var/chemtype in borer_chem_types_chest)
				var/datum/borer_chem/C = new chemtype()
				if(!C.unlockable)
					avail_chems[C.name]=C
			avail_chems += unlocked_chems_chest
		if(BORER_MODE_ATTACHED_ARM) // 4
			verbtypes=attached_verbs_arm
			for(var/chemtype in borer_chem_types_arm)
				var/datum/borer_chem/C = new chemtype()
				if(!C.unlockable)
					avail_chems[C.name]=C
			avail_chems += unlocked_chems_arm
		if(BORER_MODE_ATTACHED_LEG) // 5
			verbtypes=attached_verbs_leg
			for(var/chemtype in borer_chem_types_leg)
				var/datum/borer_chem/C = new chemtype()
				if(!C.unlockable)
					avail_chems[C.name]=C
			avail_chems += unlocked_chems_leg
//		if(BORER_MODE_INFESTED)

	if(host && !host.key && BORER_CAN_ASSUME_CONTROL) //allow borers to control empty minds
		to_chat(src, "<span class='danger'>This host appears sufficiently simple for you to assume control.</span>")
		verb_holders+=new /obj/item/verbs/borer/special(src)
	for(var/verbtype in verbtypes)
		verb_holders+=new verbtype(src)
/*
/mob/living/simple_animal/borer/player_panel_controls(var/mob/user)
	var/html="<h2>[src] Controls</h2>"
	if(host)
		html +="<b>Host:</b> [host] (<A HREF='?_src_=holder;adminmoreinfo=\ref[host]'>?</A> | <a href='?_src_=vars;mob_player_panel=\ref[host]'>PP</a>)"
	else
		html += "<em>No host</em>"
	html += "<ul>"
	if(user.check_rights(R_ADMIN))
		html += "<li><a href=\"?src=\ref[src]&act=add_chem\">Give Chem</a></li>" // PARTY SLUG
		html += "<li><a href=\"?src=\ref[src]&act=detach\">Detach</a></li>"
		html += "<li><a href=\"?src=\ref[src]&act=verbs\">Resend Verbs</a></li>"
		if(host)
			html += "<li><a href=\"?src=\ref[src]&act=release\">Release Control</a></li>"
	return html + "</ul>"

/mob/living/simple_animal/borer/Topic(href, href_list)
	if(!usr.check_rights(R_ADMIN))
		to_chat(usr, "<span class='danger'>Hell no.</span>")
		return

	switch(href_list["act"])
		if("detach")
			to_chat(src, "<span class='danger'>You feel dazed, and then appear outside of your host!</span>")
			if(host)
				to_chat(host, "<span class='info'>You no longer feel the presence in your mind!</span>")
			detach()
		if("release")
			if(host)
				host.do_release_control()
		if("verbs")
			update_verbs(!isnull(host))
		if("add_chem")
			var/chemID = input("Chem name (ex: creatine):","Chemicals") as text|null
			if(isnull(chemID))
				return
			var/datum/borer_chem/C = new /datum/borer_chem()
			C.id=chemID
			var/datum/reagent/chem = GLOB.chemical_reagents_list[C.id]
			C.name = chem.name
			C.cost=0
			avail_chems[C.name]=C
			to_chat(usr, "ADDED!")
			to_chat(src, "<span class='info'>You learned how to secrete [C.name]!</span>")
*/
/*
/mob/living/simple_animal/borer/handle_inherent_channels(var/datum/speech/speech, var/message_mode)
	. = ..()
	if(.)
		return .

	var/mob/living/simple_animal/borer/B = src
	var/mob/living/carbon/human/host = B.host
	if(host)
		speech.message = trim(speech.message)
		if (!speech.message)
			return
		var/encoded_message = html_encode(speech.message)

		to_chat(src, "You drop words into [host]'s body: <span class='borer'>\"[encoded_message]\"</span>")
		if(host.transmogged_to)
			to_chat(host.transmogged_to, "<b>Something speaks within you:</b> <span class='borer'>\"[encoded_message]\"</span>")
		else if(hostlimb == BP_HEAD)
			to_chat(host, "<b>Your mind speaks to you:</b> <span class='borer'>\"[encoded_message]\"</span>")
		else
			to_chat(host, "<b>Your [limb_to_name(hostlimb)] speaks to you:</b> <span class='borer'>\"[encoded_message]\"</span>")
		var/list/borers_in_host = host.get_brain_worms()
		borers_in_host.Remove(src)
		if(borers_in_host.len)
			for(var/I in borers_in_host)
				to_chat(I, "<b>[truename]</b> speaks from your host's [limb_to_name(hostlimb)]: <span class='borer'>\"[encoded_message]\"</span>")

		var/turf/T = get_turf(src)
		log_say("[truename] [key_name(src)] (@[T.x],[T.y],[T.z]) -> [host]([key_name(host)]) Borer->Host Speech: [encoded_message]")

		for(var/mob/M in player_list)
			if(istype(M, /mob/new_player))
				continue
			if(istype(M,/mob/dead/observer)  && (M.client && M.client.prefs.toggles & CHAT_GHOSTEARS || (get_turf(src) in view(M))))
				var/controls = "<a href='byond://?src=\ref[M];follow2=\ref[M];follow=\ref[src]'>Follow</a>"
				if(M.client.holder)
					controls+= " | <A HREF='?_src_=holder;adminmoreinfo=\ref[src]'>?</A>"
				var/rendered="<span class='borer'>Thought-speech, <b>[truename]</b> ([controls]) in <b>[host]</b>'s [limb_to_name(hostlimb)]: [encoded_message]</span>"
				M.show_message(rendered, 2) //Takes into account blindness and such.
		return 1
	else
		to_chat(src, "You have no host to speak to.")
		return 1 //this ensures we don't end up speaking out loud
*/


/mob/living/simple_animal/borer/Stat()
	..()
	if(statpanel("Status"))
		stat("Health",health)
		stat("Chemicals",chemicals)
		if(host)
			stat("Host's Health",host.health)
		var/mob/living/carbon/human/H = host
		var/obj/item/organ/internal/psionic_tumor/B = H.random_organ_by_process(BP_PSION)
		if(B)
			stat("Psi Essence", "[B.psi_points]/[B.max_psi_points]")


/mob/living/simple_animal/borer/verb/Examine_host_stats()
	set name		= "Examine Host Biology"
	set desc		= "Browse your Host's capabilities."
	set category	= "Alien"

	if(iscarbon(host) || issilicon(host))
		browse_hst_stats(src)
	else
		to_chat(usr, "It is hardly worth our attention.")

/mob/living/simple_animal/borer/proc/browse_hst_stats()
	var/additionalcss = {"
		<style>
			table {
				float: left;
			}
			table, th, td {
				border: #3333aa solid 1px;
				border-radius: 5px;
				padding: 5px;
				text-align: center;
			}
			th{
				background:#633;
			}
		</style>
	"}
	var/table_header = "<th>Stat Name<th>Stat Value"
	var/list/S = list()
	for(var/TS in ALL_STATS)
		S += "<td>[TS]<td>[host.getStatStats(TS)]"
	var/data = {"
		[additionalcss]
		["[host.name]'s stats"]<br>
		<table width=20%>
			<tr>[table_header]
			<tr>[S.Join("<tr>")]
		</table>
	"}
	// Perks
	var/list/Plist = list()
	var/column = 1
	for(var/perk in host.stats.perks)
		var/datum/perk/P = perk
		//var/filename = sanitizeFileName("[P.type].png")
		//var/asset = asset_cache.cache[filename] // this is definitely a hack, but getAtomCacheFilename accepts only atoms for no fucking reason whatsoever.
		//if(asset)
		if( column == 1)
			Plist += "<td valign='middle'><span style='text-align:center'>[P.name]<br>[P.desc]</span></td>"
			column = 2
		else
			Plist += "<td valign='middle'><span style='text-align:center'>[P.name]<br>[P.desc]</span></td><tr></tr>"
			column = 1
	data += {"
		<table width=80%>
			<th colspan=2>Perks</th>
			<tr>[Plist.Join()]</tr>
		</table>
	"}

	var/datum/browser/B = new(src, "StatsBrowser","[host.name]'s stats", 1000, 400)
	B.set_content(data)
	B.set_window_options("can_minimize=0")
	B.open()

/mob/living/simple_animal/borer/eyecheck()
	if(host)
		return host.eyecheck()
	else
		return ..()

/mob/living/simple_animal/borer/verb/read_mind()
	set category = "Alien"
	set name = "Devour Thoughts"
	set desc = "Extract information, languages and skills out of host's brain. May cause confusion and brain damage."

	if(stat)
		return

	if(!host)
		to_chat(src, SPAN_WARNING("You are not inside a host body."))
		return

	var/list/copied_stats = list()
	if(host.stats)
		for(var/stat_name in ALL_STATS_FOR_LEVEL_UP)
			var/host_stat = host.stats.getStat(stat_name, pure=TRUE)
			var/borer_stat = stats.getStat(stat_name, pure=TRUE)
			if(host_stat > borer_stat)
				var/devour = host_stat * (rand(5, 25)/100)
				host.stats.changeStat(stat_name, round(-devour))
				stats.changeStat(stat_name, round(devour))
				copied_stats += stat_name

	var/list/copied_languages = list()
	for(var/datum/language/L in host.languages)
		if(!(L.flags & HIVEMIND) && !can_speak(L))
			add_language(L.name)
			copied_languages += L.name

	if(host.mind)
		host.mind.show_memory(src)

	var/copied_amount = length(copied_stats) + length(copied_languages)
	if(copied_amount)
		if(length(copied_stats))
			to_chat(src, SPAN_NOTICE("You extracted some knowledge on [english_list(copied_stats)]."))

		if(length(copied_languages))
			to_chat(src, SPAN_NOTICE("You learned [english_list(copied_languages)]."))

		to_chat(host, SPAN_DANGER("Your head spins, your memories thrown in disarray!"))
		H.adjustBrainLoss(copied_amount * 4)
		H?.sanity.onPsyDamage(copied_amount * 4)

		host.make_dizzy(copied_amount * 4)
		host.confused = max(host.confused, copied_amount * 4)

/mob/living/simple_animal/borer/proc/write_mind()
	set category = "Abilities"
	set name = "Feed Mind"
	set desc = "Write known skills and languages to host's brain. May cause confusion and brain damage."

	if(stat)
		return

	if(!host)
		to_chat(src, SPAN_WARNING("You are not inside a host body."))
		return

	var/list/copied_stats = list()
	for(var/stat_name in ALL_STATS_FOR_LEVEL_UP)
		var/borer_stat = stats.getStat(stat_name, pure=TRUE)
		if(istype(host, /mob/living/carbon/human))
			var/feast = borer_stat * (rand(25, 75)/100)
			host.stats.changeStat(stat_name, feast)
			copied_stats += stat_name
		else if(istype(host, /mob/living/simple_animal))
			host.stats.changeStat(stat_name, borer_stat)
			copied_stats += stat_name

	var/list/copied_languages = list()
	for(var/datum/language/L in languages)
		if(!(L.flags & HIVEMIND) && !host.can_speak(L))
			host.add_language(L.name)
			copied_languages += L.name


	var/copied_amount = length(copied_stats) + length(copied_languages)
	if(copied_amount)
		if(length(copied_stats))
			to_chat(src, SPAN_NOTICE("You put some knowledge on [english_list(copied_stats)] into your host's mind."))

		if(length(copied_languages))
			to_chat(src, SPAN_NOTICE("You teach your host [english_list(copied_languages)]."))

		to_chat(host, SPAN_DANGER("Your head spins as new information fills your mind!"))
		host.adjustBrainLoss(copied_amount * 2)
		H?.sanity.onPsyDamage(copied_amount * 2)

		host.make_dizzy(copied_amount * 2)
		host.confused = max(host.confused, copied_amount * 2)

// VERBS!
/obj/item/verbs/borer/special/verb/bond_brain()
	set category = "Alien"
	set name = "Assume Control"
	set desc = "Fully connect to the brain of your host."

	var/mob/living/simple_animal/borer/B=loc
	if(!istype(B))
		return
	B.bond_brain()

/mob/living/simple_animal/borer/proc/bond_brain()
	set category = "Alien"
	set name = "Assume Control"
	set desc = "Fully connect to the brain of your host."

	if(!check_can_do())
		return

	if(hostlimb != BP_HEAD)
		to_chat(src, "You are not attached to your host's brain.")
		return

	if(host.ckey)
		to_chat(src, "<span class='danger'>The host consciousness resists your attempts to overwhelm it!</span>")
		return

	to_chat(src, "You begin delicately adjusting your connection to the host brain...")

	var/mod = max(300 - host.brainloss, 0) //braindamaged hosts are overwhelmed faster
	spawn(mod)
		if(!host || !src || controlling)
			return
		else
			do_bonding(rptext=1)

/mob/living/simple_animal/borer/proc/do_bonding(var/rptext=1, var/hud_type)
	if(!host || host.stat==DEAD || !src || research.unlocking)
		return

	if(host.ckey) //check again just to be sure
		to_chat(src, "<span class='danger'>You attempt to interface with the host's nervous system, but their consciousness resists!</span>")
		return

	if (rptext)
		to_chat(src, "<span class='danger'>You plunge your probosci deep into the cortex of the host brain, interfacing directly with their nervous system.</span>")
		to_chat(host, "<span class='danger'>You feel a strange shifting sensation behind your eyes as an alien consciousness displaces yours.</span>")

	if(!controlling)
		host_brain.ckey = host.ckey
		host_brain.name = host.real_name
		host.ckey = src.ckey
		var/mob/living/simple_animal/H = host
		if(istype(H, /mob/living/simple_animal) || istype(H, /mob/living/carbon/superior_animal))
			update_hud()
		controlling = 1
		host.AI_inactive = TRUE
	host.verbs += /mob/living/proc/release_control
/*	var/newname			/// uncancerfy renaming proc ///
	for(var/i = 1 to 3)
		newname = host.rename_self(stripped_input(host,"You may assume a new identity for the host you've infested. Enter a name, or cancel to keep your host's original name.", "Name change [4-i] [0-i != 1 ? "tries":"try"] left",""),1,MAX_NAME_LEN)
		if(!newname || newname == "")
			if(alert(host,"Are you sure you want to keep your host's original name?",,"Yes","No") == "Yes")
				break
		else
			if(alert(host,"Do you really want the name:\n[newname]?",,"Yes","No") == "Yes")
				break
	if(newname)
		host_name = host.real_name //store the old host name in the borer
		host.fully_replace_character_name(null, newname)
	////////////////////////Broken////////////////////////
	host.verbs += /mob/living/carbon/proc/punish_host
	host.verbs += /mob/living/carbon/proc/spawn_larvae
	*/

/**
 * Kill switch for shit hosts.
 */
/mob/living/simple_animal/borer/proc/kill_host()
	set category = "Alien"
	set name = "Kill Host"
	set desc = "Give the host massive brain damage, killing them nearly instantly."

	if(!check_can_do())
		return

	var/reason = sanitize(input(usr,"Please enter a brief reason for killing the host, or press cancel.\n\nThis will be logged, and presented to the host.","Oh snap") as null|text, MAX_MESSAGE_LEN)
	if(isnull(reason) || reason=="")
		return

	to_chat(src, "<span class='danger'>You thrash your probosci around the host's brain, triggering massive brain damage and stopping your host's heart.</span>")
	to_chat(host, "<span class='sinister'>You get a splitting headache, and then, as blackness descends upon you, you hear: [reason]</span>")

	spawn(10)
		if(!host || !src || stat)
			return

		host.adjustBrainLoss(100)
		if(host.stat != DEAD)
			host.death(0)
			host.attack_log += "\[[time_stamp()]\]<font color='red'>Killed by an unhappy borer: [key_name(src)] Reason: [reason]</font>"

			message_admins("Borer [key_name_admin(src)] killed [key_name_admin(host)] for reason: [reason]")
		detach()

/mob/living/simple_animal/borer/proc/damage_brain()
	set category = "Alien"
	set name = "Retard Host"
	set desc = "Give the host a bit of brain damage.  Can be healed with alkysine."

	if(!check_can_do())
		return

	to_chat(src, "<span class='danger'>You twitch your probosci.</span>")
	to_chat(host, "<span class='sinister'>You feel something twitch, and get a headache.</span>")

	host.adjustBrainLoss(15)

/mob/living/simple_animal/borer/proc/evolve()
	set category = "Alien"
	set name = "Evolve"
	set desc = "Upgrade yourself or your host."

	if(!check_can_do())
		return

	research.display(src)

/mob/living/simple_animal/borer/proc/secrete_chemicals()
	set category = "Alien"
	set name = "Secrete Chemicals"
	set desc = "Push some chemicals into your host's bloodstream."

	if(!check_can_do())
		return

	var/chem_name = input("Select a chemical to secrete.", "Chemicals") as null|anything in avail_chems
	if(!chem_name)
		return

	var/datum/borer_chem/chem = avail_chems[chem_name]

	var/max_amount = 50
	if(chem.cost>0)
		max_amount = round(chemicals / chem.cost)

	if(max_amount==0)
		to_chat(src, "<span class='warning'>You don't have enough energy to even synthesize one unit!</span>")
		return

	var/units = input("Enter dosage in units.\n\nMax: [max_amount]\nCost: [chem.cost]/unit","Chemicals") as num

	units = round(units)

	if(units < 1)
		to_chat(src, "<span class='warning'>You cannot synthesize this little.</span>")
		return

	if(chemicals < chem.cost*units)
		to_chat(src, "<span class='warning'>You don't have enough energy to synthesize this much!</span>")
		return

	var/datum/reagent/C = GLOB.chemical_reagents_list[chem.id] //we need to get the datum for this reagent to read the overdose threshold
	if(units >= C.overdose - host.reagents.get_reagent_amount(chem.id) && C.overdose > 0)
		if(alert("Secreting that much [chem.name] would cause an overdose in your host. Are you sure?", "Secrete Chemicals", "Yes", "No") != "Yes")
			return
//		add_gamelogs(src, "intentionally overdosed \the [host] with '[chem.id]' ([chem.name])", admin = TRUE, tp_link = TRUE, span_class = "danger")

	if(!host || controlling || !src || stat) //Sanity check.
		return

	if(chem.id == "blood")
		var/mob/living/carbon/human/hoomin = host
		if(istype(hoomin, /mob/living/carbon/human) && !(hoomin.species.flags & NO_BLOOD))
			hoomin.vessel.add_reagent(chem.id, units)
		else
			to_chat(src, "<span class='notice'>Your host seems to be a species that doesn't use blood.<span>")
			return
	else
		host.reagents.add_reagent(chem.id, units)

	to_chat(src, "<span class='info'>You squirt a measure of [chem.name] from your reservoirs into [host]'s bloodstream.</span>")
//	add_gamelogs(src, "secreted [units]U of '[chem.id]' ([chem.name]) into \the [host]", admin = TRUE, tp_link = TRUE, span_class = "message")

	chemicals -= chem.cost*units

// We've been moved to someone's head.
/mob/living/simple_animal/borer/proc/infest_limb(var/obj/item/organ/external/limb)
	detach()
	limb.borer=src
	forceMove(limb)

	update_verbs(BORER_MODE_SEVERED)

/mob/living/simple_animal/borer/proc/abandon_host()
	set category = "Alien"
	set name = "Abandon Host"
	set desc = "Slither out of your host."

	var/severed = istype(loc, /obj/item/organ/external)
	if(!host && !severed)
		to_chat(src, "<span class='warning'>You are not inside a host body.</span>")
		return

	if(stat == UNCONSCIOUS)
		to_chat(src, "<span class='warning'>You cannot leave your host while unconscious.</span>")
		return

	if(channeling)
		to_chat(src, "<span class='warning'>You cannot do this while your focus is directed elsewhere.</span>")
		return

	if(stat)
		to_chat(src, "<span class='warning'>You cannot leave your host in your current state.</span>")
		return

	if(research.unlocking && !severed)
		to_chat(src, "<span class='warning'>You are busy evolving.</span>")
		return

	var/response = alert(src, "Are you -sure- you want to abandon your current host?\n(This will take a few seconds and cannot be halted!)","Are you sure you want to abandon host?","Yes","No")
	if(response != "Yes")
		return

	if(!src)
		return

	if(severed)
		if(istype(loc, /obj/item/organ/external/head))
			to_chat(src, "<span class='info'>You begin disconnecting from \the [loc]'s synapses and prodding at its internal ear canal.</span>")
		else
			to_chat(src, "<span class='info'>You begin disconnecting from \the [loc]'s nerve endings and prodding at the surface of its skin.</span>")
	else
		if(hostlimb == BP_HEAD)
			to_chat(src, "<span class='info'>You begin disconnecting from \the [host]'s synapses and prodding at their internal ear canal.</span>")
		else
			to_chat(src, "<span class='info'>You begin disconnecting from \the [host]'s nerve endings and prodding at the surface of their skin.</span>")

	var/leave_time = 5 SECONDS
	if(severed)
		leave_time = 2 SECONDS

	spawn(leave_time)

		if((!host && !severed) || !src)
			return

		if(src.stat)
			to_chat(src, "<span class='warning'>You cannot abandon [host ? host : "\the [loc]"] in your current state.</span>")
			return

		if(channeling)
			to_chat(src, "<span class='warning'>You cannot abandon [host ? host : "\the [loc]"] while your focus is directed elsewhere.</span>")
			return

		if(controlling)
			to_chat(src, "<span class='warning'>You're too busy controlling your host.</span>")
			return

		if(research.unlocking)
			to_chat(src, "<span class='warning'>You are busy evolving.</span>")
			return

		if(severed)
			if(istype(loc, /obj/item/organ/external/head))
				to_chat(src, "<span class='info'>You wiggle out of the ear of \the [loc] and plop to the ground.</span>")
			else
				to_chat(src, "<span class='info'>You wiggle out of \the [loc] and plop to the ground.</span>")
		else
			if(hostlimb == BP_HEAD)
				to_chat(src, "<span class='info'>You wiggle out of \the [host]'s ear and plop to the ground.</span>")
			else
				to_chat(src, "<span class='info'>You wiggle out of \the [host]'s [limb_to_name(hostlimb)] and plop to the ground.</span>")
		host.AI_inactive = FALSE
		detach()

// Try to reset everything, also while handling invalid host/host_brain states.
/mob/living/simple_animal/borer/proc/detach()
	if(host)
		if(istype(host,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = host
			var/obj/item/organ/external/implanted = H.get_organ(hostlimb)
			implanted.implants -= src

	src.forceMove(get_turf(src))
	controlling = 0

	reset_view(null)
	machine = null

	if(host)
		host.reset_view(null)
		host.machine = null

		host.verbs -= /mob/living/proc/release_control
		host.verbs -= /mob/living/proc/punish_host

		// Remove any unlocks that affect the host.
		for(var/uid in research.unlocked.Copy())
			var/datum/unlockable/borer/U = research.get(uid)
			if(U)
				if(U.remove_on_detach)
					U.relock()
				U.on_detached()

	if(host_brain && host_brain.ckey)
		src.ckey = host.ckey
		host.ckey = host_brain.ckey
		host_brain.ckey = null
		host_brain.name = "host brain"
		host_brain.real_name = "host brain"

	host = null
	hostlimb = null
	channeling = 0
	channeling_brute_resist = 0
	channeling_burn_resist = 0
	channeling_speed_increase = 0
	channeling_bone_talons = 0
	channeling_bone_sword = 0
	channeling_bone_shield = 0
	channeling_bone_hammer = 0
	channeling_bone_cocoon = 0
	update_verbs(BORER_MODE_DETACHED)
/*
	extend_o_arm.forceMove(src)
*/
/client/proc/borer_infest()
	set category = "Alien"
	set name = "Infest"
	set desc = "Infest a suitable host."

	var/mob/living/simple_animal/borer/B=mob
	if(!istype(B))
		return
	B.infest()

/mob/living/simple_animal/borer/proc/limb_to_name(var/limb = null)
	if(!limb)
		return
	var/limbname = ""
	switch(limb)
		if(BP_HEAD)
			limbname = BP_HEAD
		if(BP_CHEST)
			limbname = BP_CHEST
		if(BP_R_ARM)
			limbname = "right arm"
		if(BP_L_ARM)
			limbname = "left arm"
		if(BP_R_LEG)
			limbname = "right leg"
		if(BP_L_LEG)
			limbname = "left leg"
	return limbname

/mob/living/simple_animal/borer/proc/limb_to_mode(var/limb = null)
	var/mode = 0
	if(!istype(host, /mob/living/carbon/human))
		mode = BORER_MODE_INFESTED
		return mode
	if(!limb)
		return
	switch(limb)
		if(BP_HEAD)
			mode = BORER_MODE_ATTACHED_HEAD
		if(BP_CHEST)
			mode = BORER_MODE_ATTACHED_CHEST
		if(BP_R_ARM)
			mode = BORER_MODE_ATTACHED_ARM
		if(BP_L_ARM)
			mode = BORER_MODE_ATTACHED_ARM
		if(BP_R_LEG)
			mode = BORER_MODE_ATTACHED_LEG
		if(BP_L_LEG)
			mode = BORER_MODE_ATTACHED_LEG
	return mode

/mob/living/simple_animal/borer/proc/limb_covered(var/mob/living/carbon/C = null, var/limb = null)
	if(!limb || !C)
		return

	if(!istype(C,/mob/living/carbon/human))
		return 0

	var/mob/living/carbon/human/H = C
	for(var/obj/item/clothing/clothing in H.get_equipped_items())
		switch(limb)
			if(BP_HEAD)
				if(clothing.body_parts_covered & EARS)
					return 1
			if(BP_CHEST)
				if(clothing.body_parts_covered & UPPER_TORSO && limb_covered(C, BP_R_ARM) && limb_covered(C, BP_L_ARM) && limb_covered(C, BP_R_LEG) && limb_covered(C, BP_L_LEG)) //any gap in protection will allow a borer to squeeze underneath chest protection
					return 1
			if(BP_R_ARM)
				if(clothing.body_parts_covered & ARM_RIGHT)
					return 1
			if(BP_L_ARM)
				if(clothing.body_parts_covered & ARM_LEFT)
					return 1
			if(BP_R_LEG)
				if(clothing.body_parts_covered & LEG_RIGHT)
					return 1
			if(BP_L_LEG)
				if(clothing.body_parts_covered &LEG_LEFT)
					return 1
	return 0

/mob/living/simple_animal/borer/proc/infest()
	set category = "Alien"
	set name = "Infest"
	set desc = "Infest a suitable host."

	if(host)
		to_chat(src, "You are already within a host.")
		return

	if(stat == UNCONSCIOUS)
		to_chat(src, "<span class='warning'>You cannot infest a target while unconscious.</span>")
		return

	if(channeling)
		to_chat(src, "<span class='warning'>You cannot do this while your focus is directed elsewhere.</span>")

	if(stat)
		to_chat(src, "You cannot infest a target in your current state.")
		return

	if(research.unlocking)
		to_chat(src, "<span class='warning'>You are busy evolving.</span>")
		return

	var/list/choices = list()
	for(var/mob/living/carbon/C in view(1,src))
		if(C.stat != 2 && src.Adjacent(C))
			choices += C

	var/mob/living/M = input(src,"Who do you wish to infest?") in null|choices

	if(!M || !src)
		return

	if(!(src.Adjacent(M)))
		return

	if(!istype(M, /mob/living/carbon/human))
		if(!do_after(src,50,M,0))
			to_chat(src, "As [M] moves away, you are dislodged and fall to the ground.")
			return
		if(M in view(1, src))
			to_chat(src, "You burrow into [M]'s body.")
			src.perform_infestation(M, BP_HEAD)


	var/area = src.targeted_organ
	var/region = BP_HEAD

	if(istype(M, /mob/living/carbon/human))
		switch(area)
			if(BP_HEAD)
				region = BP_HEAD
			if("mouth")
				region = BP_HEAD
			if("eyes")
				region = BP_HEAD
			if(BP_CHEST)
				region = BP_CHEST
			if(BP_GROIN)
				region = BP_CHEST
			if(BP_R_ARM)
				region = BP_R_ARM
			if(BP_R_HAND)
				region = BP_R_ARM
			if(BP_L_ARM)
				region = BP_L_ARM
			if(BP_L_HAND)
				region = BP_L_ARM
			if(BP_R_LEG)
				region = BP_R_LEG
			if(BP_R_FOOT)
				region = BP_R_LEG
			if(BP_L_LEG)
				region = BP_L_LEG
			if(BP_L_FOOT)
				region = BP_L_LEG

	var/mob/living/carbon/human/H = M
	for(var/obj/item/organ/external/O in H.organs)
		if(!BP_IS_ORGANIC(O))
			to_chat(src, "You cannot infest this host's inorganic [limb_to_name(region)]!")
			return
		if(BP_IS_REMOVED(O))
			to_chat(src, "This host does not have a [limb_to_name(region)]!")
			return
		if(M.has_brain_worms(region))
			to_chat(src, "This host's [limb_to_name(region)] is already infested!")
			return

	switch(region)
		if(BP_HEAD)
			to_chat(src, "You slither up [M] and begin probing at their ear canal...")
			to_chat(M, "<span class='sinister'>You feel something slithering up your leg and probing at your ear canal...</span>")
		if(BP_CHEST)
			to_chat(src, "You slither up [M] and begin probing just below their sternum...")
			to_chat(M, "<span class='sinister'>You feel something slithering up your leg and probing just below your sternum...</span>")
		if(BP_R_ARM)
			to_chat(src, "You slither up [M] and begin probing at their right arm...")
			to_chat(M, "<span class='sinister'>You feel something slithering up your leg and probing at your right arm...</span>")
		if(BP_L_ARM)
			to_chat(src, "You slither up [M] and begin probing at their left arm...")
			to_chat(M, "<span class='sinister'>You feel something slithering up your leg and probing at your left arm...</span>")
		if(BP_R_LEG)
			to_chat(src, "You slither up [M]'s right leg and begin probing at the back of their knee...")
			to_chat(M, "<span class='sinister'>You feel something slithering up your right leg and probing just behind your knee...</span>")
		if(BP_L_LEG)
			to_chat(src, "You slither up [M]'s left leg and begin probing at the back of their knee...")
			to_chat(M, "<span class='sinister'>You feel something slithering up your left leg and probing just behind your knee...</span>")

	if(!do_after(src,50,M,0))
		to_chat(src, "As [M] moves away, you are dislodged and fall to the ground.")
		return

	if(!M || !src)
		return

	if(src.stat)
		to_chat(src, "You cannot infest a target in your current state.")
		return

	if(M.stat == DEAD)
		to_chat(src, "That is not an appropriate target.")
		return

	if(M.has_brain_worms(region))
		to_chat(src, "This host's [limb_to_name(region)] is already infested!")
		return

	if(M in view(1, src))
		to_chat(src, "[region == BP_HEAD ? "You wiggle into [M]'s ear." : "You burrow under [M]'s skin."]")
		src.perform_infestation(M, region)

		return
	else
		to_chat(src, "They are no longer in range!")
		return

/mob/living/simple_animal/borer/proc/perform_infestation(var/mob/living/M, var/body_region = BP_HEAD)
	if(!M || !istype(M))
		error("[src]: Unable to perform_infestation on [M]!")
		return 0

	hostlimb = body_region
	src.host = M

	update_verbs(limb_to_mode(hostlimb)) // Must be called before being removed from turf. (BYOND verb transfer bug)

	src.forceMove(M)

	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/implanted = H.get_organ(body_region)
		implanted.implants += src

	host_brain.name = M.name
	host_brain.real_name = M.real_name

	if(!istype(M,/mob/living/carbon/human))
		M.update_hud()
	// Tell our upgrades that we've attached.
	for(var/uid in research.unlocked.Copy())
		var/datum/unlockable/borer/U = research.get(uid)
		if(U)
			U.on_attached()
/*
	// /vg/ - Our users are shit, so we start with control over host.
	if(config.borer_takeover_immediately)
		do_bonding(rptext=1)

	extend_o_arm.forceMove(host)
*/
// So we can hear our host doing things.
// NOTE:  We handle both visible and audible emotes because we're a brainslug that can see the impulses and shit.

/mob/living/simple_animal/borer/proc/host_emote(var/list/args)
	src.show_message(args["message"], args["m_type"])
	host_brain.show_message(args["message"], args["m_type"])

/mob/living/simple_animal/borer/ventcrawl()
	set name = "Crawl through Vent"
	set desc = "Enter an air vent and crawl through the pipe system."
	set category = "Alien"

	if(stat == UNCONSCIOUS)
		to_chat(src, "<span class='warning'>You cannot ventcrawl while unconscious.</span>")
		return

	if(stat)
		to_chat(src, "You cannot ventcrawl in your current state.")
		return

	if(research.unlocking)
		to_chat(src, "<span class='warning'>You are busy evolving.</span>")
		return

	var/pipe = start_ventcrawl()
	if(pipe)
		handle_ventcrawl(pipe)

//copy paste from alien/larva, if that func is updated please update this one alsoghost
/mob/living/simple_animal/borer/hide()
	set name = "Hide"
	set desc = "Allows to hide beneath tables or certain items. Toggled on or off."
	set category = "Alien"

	if(stat == UNCONSCIOUS)
		return

	if (plane != HIDING_MOB_PLANE)
		plane = HIDING_MOB_PLANE
		to_chat(src, text("<span class='notice'>You are now hiding.</span>"))
	else
		plane = PLANE_WORLD
		to_chat(src, text("<span class='notice'>You have stopped hiding.</span>"))



/mob/living/simple_animal/borer/proc/reproduce()
	set name = "Reproduce"
	set desc = "Spawn offspring in the form of an egg."
	set category = "Alien"

	if(stat == UNCONSCIOUS)
		to_chat(src, "<span class='warning'>You cannot reproduce while unconscious.</span>")
		return

	if(stat)
		to_chat(src, "You cannot reproduce in your current state.")
		return

	if(research.unlocking)
		to_chat(src, "<span class='warning'>You are busy evolving.</span>")
		return

	if(busy)
		to_chat(src, "<span class='warning'>You are already doing something.</span>")
		return

	if(chemicals >= 100)
		busy=1
		to_chat(src, "<span class='warning'>You strain, trying to push out your young...</span>")
		visible_message("<span class='warning'>\The [src] begins to struggle and strain!</span>")
		var/turf/T = get_turf(src)
		if(do_after(src, T, 5 SECONDS))
			to_chat(src, "<span class='danger'>You twitch and quiver as you rapidly excrete an egg from your sluglike body.</span>")
			visible_message("<span class='danger'>\The [src] heaves violently, expelling a small, gelatinous egg!</span>")
			chemicals -= 100

			numChildren++

			playsound(T, 'sound/effects/splat.ogg', 50, 1)
			if(istype(T, /turf/simulated))
				T.add_vomit_floor(null, 1)
			var/obj/item/reagent_containers/food/snacks/borer_egg/E = new (T)
			E.child_prefix_index = (name_prefix_index + 1)
		busy=0

	else
		to_chat(src, "You do not have enough chemicals stored to reproduce.")
		return

//Procs for grabbing players.
/mob/living/simple_animal/borer/proc/request_player()
	var/datum/ghosttrap/G = get_ghost_trap("cortical borer")
	G.request_player(src, "A cortical borer needs a player.", ANIMAL)

/mob/living/simple_animal/borer/proc/transfer_personality(var/client/candidate)


	if(!candidate)
		return

	src.ckey = candidate.ckey
	if(src.mind)
		src.mind.assigned_role = "Borer"

		// tl;dr
		to_chat(src, "<span class='danger'>You are a Borer!</span>")
		to_chat(src, "<span class='info'>You are a small slug-like symbiote that attaches to your host's body.  Your only goals are to survive and procreate. However, there are those who would like to destroy you, and hosts don't take kindly to jerks.  Being as helpful to your host as possible is the best option for survival.</span>")
		to_chat(src, "<span class='info'>Borers can speak with other borers over the Cortical Link by prefixing their messages with :&.  To communicate with your host only, speak normally.</span>")
		to_chat(src, "<span class='info'><b>New:</b> To get new abilities for you and your host, use <em>Evolve</em> to unlock things.  Borers are now symbiotic biological pAIs.</span>")

/mob/living/simple_animal/borer/proc/analyze_host()
	set name = "Analyze Health"
	set desc = "Check the health of your host."
	set category = "Alien"

	to_chat(src, "<span class='info'>You listen to the song of your host's nervous system, hunting for discordant notes...</span>")
	spawn(5)
		medical_scan_results(host, 1) // TODO... Make it more immersive

/mob/living/simple_animal/borer/proc/taste_blood()
	set name = "Taste Blood"
	set desc = "See if there's anything within the blood of your host."
	set category = "Alien"

	if(!check_can_do())
		return

	to_chat(src, "<span class='info'>You taste the blood of your host, and process it for abnormalities.</span>")
	if(!isnull(host.reagents))
		var/dat = ""
		if(host.reagents.reagent_list.len > 0)
			for (var/datum/reagent/R in host.reagents.reagent_list)
				if(R.id == "blood")
					continue // Like we need to know that blood contains blood.
				dat += "\n \t <span class='notice'>[R] ([R.volume] units)</span>"
		if(dat)
			to_chat(src, "<span class='notice'>Chemicals found: [dat]</span>")
		else
			to_chat(src, "<span class='notice'>No active chemical agents found in [host]'s blood.</span>")
	else
		to_chat(src, "<span class='notice'>No significant chemical agents found in [host]'s blood.</span>")


/mob/living/simple_animal/borer/proc/ghost_enter(mob/user)
	if(stat || key)
		return FALSE
	var/confirmation = alert("Would you like to occupy \the [src]?", "", "Yes", "No")
	if(confirmation == "No" || QDELETED(src))
		return TRUE
	if(key)
		to_chat(user, SPAN_WARNING("Someone is already occupying this body."))
		return TRUE
	key = user.key
	update_hud()
	return TRUE

/mob/living/simple_animal/borer/attack_ghost(mob/user)
	. = ..()
	if(!.)
		. = ghost_enter(user)


/mob/living/simple_animal/borer/proc/passout(var/wait_time = 0, var/show_message = 0)
	if(show_message)
		to_chat(src, "<span class='warning'>You lose consciousness due to overexertion.</span>")

	wait_time = min(wait_time, 60)
	stat = UNCONSCIOUS
	spawn()
		sleep(wait_time*10)
		stat = CONSCIOUS
		to_chat(src, "<span class='notice'>You have regained consciousness.</span>")

/mob/living/simple_animal/borer/proc/check_can_do(var/check_channeling = 1)
	if(!host)
		to_chat(src, "<span class='warning'>You are not inside a host body.</span>")
		return 0

	if(stat == UNCONSCIOUS)
		to_chat(src, "<span class='warning'>You cannot do this while unconscious.</span>")
		return 0

	if(stat)
		to_chat(src, "<span class='warning'>You cannot do this in your current state.</span>")
		return 0

	if(controlling)
		to_chat(src, "<span class='warning'>You're too busy controlling your host.</span>")
		return 0

	if(host.stat==DEAD)
		to_chat(src, "<span class='warning'>You cannot do that in your host's current state.</span>")
		return 0

	if(research.unlocking)
		to_chat(src, "<span class='warning'>You are busy evolving.</span>")
		return 0

	if(check_channeling)
		if(channeling)
			to_chat(src, "<span class='warning'>You can't do this while your focus is directed elsewhere.</span>")
			return 0

	return 1

/mob/living/simple_animal/borer/ClickOn( var/atom/A, var/params )
	..()
	if(params2list(params)["shift"])
		return
/*	if(host)
		if(extend_o_arm_unlocked)
			if(hostlimb == BP_R_ARM || hostlimb == BP_L_ARM)
				if(!extend_o_arm)
					extend_o_arm = new /obj/item/weapon/gun/hookshot/flesh(src, src)
					extend_o_arm.forceMove(host)
				if(!check_can_do())
					return
				if(is_held_twohanded(host)) //If the host is two-handing something.
					to_chat(src, "<span class='warning'>You cannot swing this item while your host holds it with both hands!</span>")
					return
				if(host.stunned)
					to_chat(src, "<span class='warning'>Your host's muscles are tightened. You can't extend your arm!</span>")
					return
				var/datum/reagents/R = host.reagents
				if(R)
					if(R.has_reagent(SILICATE))
						to_chat(src, "<span class='warning'>Something in your host's bloodstream is tightening their muscles. You can't extend your arm!</span>")
						return
				if(host.Adjacent(A))
					if(hostlimb == BP_R_ARM)
						if(host.is_holding_in_r_hand())
							if(check_attack_cooldown())
								return
							else
								A.attackby(host.is_holding_in_r_hand(), host, 1, src)
								set_attack_cooldown()
								return
						else if(istype(A, /obj/item))
							var/obj/item/I = A
							if(!I.anchored)
								host.put_in_r_hand(A)
								return
					else
						if(host.is_holding_in_l_hand())
							if(check_attack_cooldown())
								return
							else
								A.attackby(host.is_holding_in_l_hand(), host, 1, src)
								set_attack_cooldown()
								return
						else if(istype(A, /obj/item))
							var/obj/item/I = A
							if(!I.anchored)
								host.put_in_l_hand(A)
								return
				if(get_turf(A) == get_turf(host) && !istype(A, /obj/item))
					return
				if(hostlimb == BP_R_ARM)
					if(host.is_holding_in_r_hand())
						if(istype(host.is_holding_in_r_hand(), /obj/item/weapon/gun/hookshot)) //I don't want to deal with the fleshshot interacting with hookshots
							return
						if(chemicals < 10)
							to_chat(src, "<span class='warning'>You don't have enough chemicals stored to swing an item with this arm!</span>")
							return
						else
							if(!(extend_o_arm.hook || extend_o_arm.chain_datum || extend_o_arm.rewinding))	//If the arm is not currently extended.
								chemicals -= 10		//It costs 10 chems to fire the fleshshot while holding an item.
				else if(hostlimb == BP_L_ARM)
					if(host.is_holding_in_l_hand())
						if(istype(host.get_held_item_by_index(GRASP_LEFT_HAND), /obj/item/weapon/gun/hookshot))
							return
						if(chemicals < 10)
							to_chat(src, "<span class='warning'>You don't have enough chemicals stored to swing an item with this arm!</span>")
							return
						else
							if(!(extend_o_arm.hook || extend_o_arm.chain_datum || extend_o_arm.rewinding))
								chemicals -= 10
				extend_o_arm.afterattack(A, host)


/mob/living/simple_animal/borer/proc/check_attack_cooldown()
	var/datum/delay_controller/host_attack_delayer = host.next_click
	return host_attack_delayer.isBlocked()

/mob/living/simple_animal/borer/proc/set_attack_cooldown()
	host.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
*/
#undef BORER_CAN_ASSUME_CONTROL
