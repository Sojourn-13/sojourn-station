
// Grants research points when explosion happens nearby
/obj/item/device/radio/beacon/explosion_watcher
	name = "Kinetic Energy Scanner"
	desc = "Scans the level of kinetic energy from explosions. \
	This beacon is, in fact, bombproof and to use it properly you must use the bomb within 10 tiles of this scanner."

	channels = list("Science" = 1)

	//Used for are current limit of points, depleted per successful mini game
	var/stored_points = 250000
/*
| Bomb Power mini game
*/

	//Base points given no matter what if you have a bomb that has power above 0
	var/pitty = 500

	//How many extra points given based on how big the bomb is. Bomb Cap at this time is 40.
	var/points_per_power = 375

/*
| Bomb Target mini game
*/
	//Simpley what we want are bomb power to be.
	var/targetBoom

	//How many points we give for successfully doing Bomb Target mini game
	var/power_points = 30000

	//How far off we can be: this is a range of miss_range(under) + miss_range(over) + 1 (perfect)
	var/miss_range = 4

	//How many points we subtract per power off targetBoom
	var/miss_point_subtractor = 2500

/*
| Building mini game
*/
	//Used for building requirements.
	var/target_wealth = 0 //Used for how much stuff is worth around.

	//Gives us are range for building requirements
	//if your over 150% then you do not get rewarded the points
	var/over_value_punishment = 1.5

	//Reward for matching target building requirements.
	var/wealth_target_reward = 15000

/obj/item/device/radio/beacon/explosion_watcher/examine(mob/user)
	..()
	to_chat(usr, "Power Level expectation - [targetBoom]")
	to_chat(usr, "Points Left - [stored_points]")
	to_chat(usr, "Required Asset Value - [target_wealth] to [target_wealth*over_value_punishment]")
	to_chat(usr, "Assets in view worth - [asset_wealth(give_value=TRUE)]. Note this is assuming that the bomb power is 16 or higher")
	if(iscarbon(user)) //Anti lag from ghost spam examining
		to_chat(usr, "Randomize List Simple For Reaching Target Wealth - [rlsfrtw()]")

/obj/item/device/radio/beacon/explosion_watcher/ex_act(severity)
	return

/obj/item/device/radio/beacon/explosion_watcher/Initialize()
	. = ..()
	GLOB.explosion_watcher_list += src
	targetBoom = rand(10,35)
	target_wealth = 120 //First ones free 100% of the time.

/obj/item/device/radio/beacon/explosion_watcher/Destroy()
	GLOB.explosion_watcher_list -= src
	return ..()

/obj/item/device/radio/beacon/explosion_watcher/proc/react_explosion(turf/epicenter, power)
	var/calculated_research_points = 0

	power = round(power)

	autosay("Detected explosion with power level [power].", name ,"Science")

	if(power > 1)
		calculated_research_points += pitty + (points_per_power * power)

	if(power == 1)
		calculated_research_points += pitty

	//Feedback so people that dont read the code and after 2+ bombs figure out the math.
	if(calculated_research_points)
		//Note that we are not "exta" points. This should tell the player that this is the base/pitty
		autosay("Notice: Viable Explosion Recorded: Rewarding [calculated_research_points] points.", name ,"Science")


	//Feedback if you set items on the edge and cant reach it
	if(power && power < 16)
		autosay("Notice: Power level of test is below 16, Watchers Assets view range descressed to [power/2] rounded.", name ,"Science")


	var/target_wealth_achived = asset_wealth(FALSE, sight = power)
	for(var/obj/machinery/computer/rdconsole/RD in GLOB.computer_list)
		if(RD.id == 1) // only core gets the science
			var/missed

			if(target_wealth_achived)
				autosay("Notice: Explosion environment correctly fielded. Rewarding [wealth_target_reward] extra points.", name ,"Science")
				calculated_research_points += wealth_target_reward

			// each step away from the target will result in 8,000 points less, this is a range of 11.
			missed = abs(power-targetBoom)
			// If it's too far, no points at all, otherwise, penalty
			var/boom_points = missed > miss_range ? 0 : power_points - missed*miss_point_subtractor

			if(boom_points)
				autosay("Notice: Power Level within expectation. Rewarding [boom_points] extra points.", name ,"Science")


			calculated_research_points = clamp(calculated_research_points + boom_points, 0, stored_points)

			stored_points -= calculated_research_points
			RD.files.adjust_research_points(calculated_research_points)

		if(calculated_research_points)
			autosay("Total Rewards: [calculated_research_points] Research Points.", name ,"Science")

	targetBoom = rand(10,35)
	if(target_wealth == initial(target_wealth))
		target_wealth = rand(80, 120)
	else
		if(calculated_research_points)
			var/wealth_mult = initial(stored_points)/(stored_points + 1)
			if(wealth_mult > 3) //Slower scaling
				wealth_mult *= 0.5
			target_wealth = rand(80, 120) * wealth_mult
			target_wealth = round(target_wealth)
	//Each mini game gets its own yapping
	autosay("Next expected Power Level is [targetBoom]. Asset Value Range: [target_wealth] to [target_wealth*over_value_punishment].", name ,"Science")
	autosay("Next expected Asset Value Range: [target_wealth] to [target_wealth*over_value_punishment].", name ,"Science")

	//No more points. Let people know this.
	if(stored_points <= 0)
		autosay("No Additional Data Points Able To Gather.", name ,"Science")

/*

Everything for building

*/

/obj/item/device/radio/beacon/explosion_watcher/proc/rlsfrtw()
	var/return_orders = "\n"
	if(asset_wealth())
		return_orders = "Current Area Matches Wealth Requirements"
		return return_orders
	if(asset_wealth(give_value=TRUE) > (target_wealth * over_value_punishment))
		return_orders = "Current Area Matches Has To Much Wealth. Please remove some structures!"
		return return_orders

	var/shopping_list = 0
	var/picked_picker
	//Someone more smart then me should make this into a list
	var/closets = 0
	var/railings = 0
	var/tables = 0
	var/grilles = 0
	var/bookcases = 0
	var/chairstables = 0
	var/lowwalls = 0
	var/windows = 0
	var/barricades = 0

	while(shopping_list < target_wealth)
		picked_picker = pick("Closets","Railings","Tables","Grilles","Bookcases","ChairsTables","LowWalls","Windows", "Barricades")
		switch(picked_picker)
			if("Closets")
				closets += 1
				shopping_list += 10
			if("Railings")
				railings += 1
				shopping_list += 2
			if("Tables")
				tables += 1
				shopping_list += 5
			if("Grilles")
				grilles += 1
				shopping_list += 10
			if("Bookcases")
				bookcases += 1
				shopping_list += 15
			if("ChairsTables")
				chairstables += 1
				shopping_list += 2
			if("LowWalls")
				lowwalls += 1
				shopping_list += 5
			if("Windows")
				windows += 1
				shopping_list += 2
			if("Barricades")
				barricades += 1
				shopping_list += 3

	return_orders += "Closets:[closets].\n"
	return_orders += "Railings:[railings].\n"
	return_orders += "Tables:[tables].\n"
	return_orders += "Grilles:[grilles].\n"
	return_orders += "Bookcases:[bookcases].\n"
	return_orders += "Chairs and Tables:[chairstables].\n"
	return_orders += "Low Walls:[lowwalls].\n"
	return_orders += "Windows (basic glass):[windows].\n"
	return_orders += "Barricades:[barricades].\n"

	return return_orders

/obj/item/device/radio/beacon/explosion_watcher/proc/asset_wealth(give_value = FALSE, sight = 16)
	var/gathered_value = 0
	//Anit cheat, so people are not doing 1 power bombs and never destorying anything
	if(sight <= 16)
		sight *= 0.5
		sight = round(sight)

	if(sight > 16)
		sight = 8

	for(var/obj/structure/S in orange(sight, src))
		if(istype(S, /obj/structure/closet))
			gathered_value += 10

		if(istype(S, /obj/structure/railing))
			gathered_value += 2
			var/obj/structure/railing/R = S
			if(R.reinforced) //If we add a few extra bits of reinforcement then we add a small amount
				gathered_value += 3

		if(istype(S, /obj/structure/low_wall))
			gathered_value += 5

		if(istype(S, /obj/structure/window))
			gathered_value += 2
			if(istype(S, /obj/structure/window/reinforced))
				gathered_value += 1
			if(istype(S, /obj/structure/window/reinforced/plasma))
				gathered_value += 8
			if(istype(S, /obj/structure/window/plasmabasic))
				gathered_value += 3

		if(istype(S, /obj/structure/table))
			gathered_value += 5
		if(istype(S, /obj/structure/bed))
			gathered_value += 2
		if(istype(S, /obj/structure/catwalk))
			gathered_value += 1
		if(istype(S, /obj/structure/bookcase))
			gathered_value += 15
		if(istype(S, /obj/structure/barricade))
			gathered_value += 3
		if(istype(S, /obj/structure/grille))
			gathered_value += 2
		if(istype(S, /obj/structure/filingcabinet))
			gathered_value += 30
		//Bringind trash down or going to a trash ritch area should be rewarded
		if(istype(S, /obj/structure/salvageable))
			gathered_value += 60
		if(istype(S, /obj/structure/scrap_cube))
			gathered_value += 7
		if(istype(S, /obj/structure/flora))
			gathered_value += 2
		if(istype(S, /obj/structure/reagent_dispensers))
			gathered_value += 25 //Rare-ish

	for(var/obj/item/target/T in orange(sight, src))
		if(T)
			gathered_value += 5 //Targets are worth 5 as you can buy and stack like 400 in a single tile!

	for(var/obj/machinery/constructable_frame/machine_frame/CF in orange(sight, src))
		if(CF)
			gathered_value += 15
			if(CF.state > 1)
				gathered_value += 2

	for(var/obj/item/modular_computer/console/PC in orange(sight, src))
		if(PC)
			gathered_value += 18

	for(var/obj/machinery/computer/C in orange(sight, src))
		if(C)
			gathered_value += 17
/*
 Disabled as anti-frustation, people didnt understand what "damaged floors" meant.
 + weldering every floor is lame and unfun
	for(var/turf/simulated/floor/F in orange(8, src))
		if(F.health != F.maxHealth)
			gathered_value -= 2 // Repair the floors you smucks!
*/
	if(give_value)
		return gathered_value

	if(gathered_value > (target_wealth * over_value_punishment))
		return FALSE
	if(gathered_value < target_wealth)
		return FALSE
	return TRUE
