
/obj/machinery/slotmachine
	name = "slotmachine"
	desc = "Wasting your credits with style."
	icon = 'icons/obj/vending.dmi'
	icon_state = "slotmachine"
	density = 1
	anchored = 1.0
	var/spinning = 0
	var/bet = 0
	var/jackpot = 0
	var/plays = 0
	var/list/slots = list()
	var/list/slots_possible = list("Seven", "Diamond", "Cherry","Bar","Lemon","Heart","Watermelon", "Bell", "Bell", "Jester")
	var/list/slots_payouts = list("Diamond" = 10, "Heart" = 8, "Cherry" = 8,"Bar" = 6,"Lemon" = 4, "Watermelon" = 3, "Seven" = 7, "Bell" = 2, "Jester" = 0)
	var/icon_type
	var/auto_win //If set, the next spin will automatically roll three of this symbol.
	use_power = IDLE_POWER_USE
	idle_power_usage = 10

/obj/machinery/slotmachine/Initialize(mapload)
	..()
	icon_type = initial(icon_state)
	power_change()

/obj/machinery/slotmachine/Initialize()
	. = ..()
	jackpot = rand(10000,20000);
	plays = rand(1,50)
	slots = list("1" = "Seven","2" = "Seven","3" = "Seven")
	update_icon()

/obj/machinery/slotmachine/power_change()
	..()
	if(stat & BROKEN)
		icon_state = "[icon_type]_broken"
	else
		if( !(stat & NOPOWER) )
			icon_state = icon_type
		else
			spawn(rand(0, 15))
				icon_state = "[icon_type]_off"

/obj/machinery/slotmachine/update_icon()
	overlays.Cut()
	//From left to right
	var/offset = -6
	var/image/img
	for(var/slot in slots)
		img = new/image(src.icon, "slot_[slots[slot]]")
		img.pixel_x += offset
		overlays += img
		offset += 6

/obj/machinery/slotmachine/proc/check_win()
	var/bell = FALSE
	var/jester = FALSE
	var/win_slot = null
	var/lose = FALSE
	for(var/slot in slots)
		switch(slots[slot])
			if("Jester")
				jester = TRUE
			if("Bell")
				bell = TRUE
		switch(win_slot)
			if(null)
				win_slot = slots[slot]
			if("Jester")
				win_slot = slots[slot]
			else
				if(slots[slot] != "Jester" && win_slot != slots[slot])
					lose = TRUE
	if(lose) return jester ? "Zero" : (bell ? "Refund" : "Lose")
	. = jester ? win_slot : (win_slot == "Seven" ? "Jackpot" : win_slot)
	if(. == "Bell")
		if(jester)
			return "Zero"
		return "Refund"

/obj/machinery/slotmachine/attack_hand(mob/user as mob)
	if (spinning)
		to_chat(user, SPAN_WARNING("It is currently spinning."))
		return
	if (bet == 0)
		to_chat(user, SPAN_NOTICE("Today's jackpot: $[jackpot]. Insert 1-1000 Credits."))
	else
		spinning = 1
		plays++
		for(var/slot in slots)
			slots[slot] = "spin"
		update_icon()
		src.visible_message("<b>[name]</b> states, \"Your bet is $[bet]. Good Luck, buddy!\"")
		playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
		icon_state = "[icon_type]_pull"
		update_icon()
		var/last_slot = null
		var/aw = (auto_win in slots_possible) ? auto_win : null
		for(var/slot in slots)
			sleep(10)
			if(aw)
				slots[slot] = aw
			else if(prob(plays) && (last_slot != null))
				plays -= rand(1, plays)
				slots[slot] = last_slot
			else
				slots[slot] = pick(slots_possible)
				last_slot = slots[slot]
			icon_state = "[icon_type]"
			update_icon()
			src.visible_message(SPAN_NOTICE("The reel stops at... \the [slots[slot]]!"), null, 2)
			playsound(src.loc, 'sound/machines/ping.ogg', 50, 1)
		if(aw) auto_win = null
		sleep(5)
		var/wintype = check_win()
		var/prize = 0
		var/jester = FALSE
		for(var/slot in slots)
			if(slots[slot] == "Jester")
				jester = TRUE
		switch(wintype)
			if("Jackpot")
				playsound(src.loc, 'sound/machines/ping.ogg', 50, 1)
				prize = jackpot
				jackpot = 0
				src.visible_message("<b>[name]</b> states, \"Damn son! JACKPOT!!! Congratulations!\"")
			if("Refund")
				playsound(src.loc, 'sound/machines/synth_yes.ogg', 50, 1)
				src.visible_message("<b>[name]</b> states, \"Saved by the bell! That spin was free!\"")
				spawn_money(bet,src.loc,user)
			if("Zero")
				playsound(src.loc, 'sound/machines/buzz-sigh.ogg', 50, 1)
				src.visible_message("<b>[name]</b> states, \"A Jester! Unlucky!\"")
			if("Lose")
				playsound(src.loc, 'sound/machines/synth_no.ogg', 50, 1)
				src.visible_message("<b>[name]</b> states, \"Sorry, maybe, next time...\"")
				jackpot += bet
			if("Jester")
				playsound(src.loc, 'sound/machines/fortune_riff.ogg', 50, 1)
				src.visible_message("<b>[name]</b> states, \"Triple Jesters! The Jackpot has Doubled!\"")
				jackpot *= 2
			else
				playsound(src.loc, 'sound/machines/ping.ogg', 50, 1)
				prize = bet*slots_payouts[wintype]
		if(prize > 0)
			src.visible_message("<b>[name]</b> states, \"Congratulations! You won [prize] Credits!\"")
			if(jester)
				jackpot = max(jackpot - prize, 0)
			spawn_money(prize,src.loc,user)
	src.add_fingerprint(user)
	update_icon()
	bet = 0
	spinning = 0

/obj/machinery/slotmachine/attackby(obj/item/S as obj, mob/user as mob)
	if (spinning)
		return
	if (istype(S, /obj/item/spacecash))
		var/obj/item/spacecash/cash = S
		if ((cash.worth > 0) && (cash.worth<=1000) && (bet + cash.worth <= 1000))
			to_chat(user, SPAN_NOTICE("You insert [cash.worth] Credits into [src]."))
			bet += cash.worth
			user.drop_from_inventory(cash)
			qdel(cash)
		else
			to_chat(user, SPAN_WARNING("You must bet 1-1000 Credits!"))
	else if (istype(S, /obj/item/coin))
		to_chat(user, SPAN_NOTICE("You add the [S.name] into the [src]. It will slightly increase chance to win."))
		user.drop_from_inventory(S)
		bet = 100
		plays = 45
		qdel(S)
	src.add_fingerprint(user)
	return