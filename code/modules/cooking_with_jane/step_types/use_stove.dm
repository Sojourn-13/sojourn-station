//A cooking step that involves adding a reagent to the food.
/datum/cooking_with_jane/recipe_step/use_stove
	class=CWJ_USE_STOVE
	auto_complete_enabled = TRUE
	var/time
	var/heat

//reagent_id: The id of the required reagent to be added, E.G. 'salt'.
//amount: The amount of the required reagent that needs to be added.
//base_quality_award: The quality awarded by following this step.
//our_recipe: The parent recipe object,
/datum/cooking_with_jane/recipe_step/use_stove/New(var/set_time,  var/set_heat, var/datum/cooking_with_jane/recipe/our_recipe)

	desc = "Cook on a stove set to [heat] for [ticks_to_text(time)]."

	time = set_time
	heat = set_heat

	..(our_recipe)


/datum/cooking_with_jane/recipe_step/use_stove/check_conditions_met(var/obj/used_item, var/datum/cooking_with_jane/recipe_tracker/tracker)

	if(!istype(used_item, /obj/machinery/cooking_with_jane/stove))
		return CWJ_CHECK_INVALID

	return CWJ_CHECK_VALID

//Reagents are calculated prior to object creation
/datum/cooking_with_jane/recipe_step/use_stove/calculate_quality(var/obj/used_item, var/datum/cooking_with_jane/recipe_tracker/tracker)
	var/obj/item/cooking_with_jane/cooking_container/container = tracker.holder_ref.resolve()

	var/bad_cooking = 0
	for (var/key in container.cook_data)
		if (heat != key)
			bad_cooking += container.cook_data[key]

	bad_cooking = round(bad_cooking/(5 SECONDS))

	//Wierd rounding here allows for cooking product to be slightly late due to lag.
	var/overcooking = round((time - container.cook_data[heat]), 10 SECONDS)/ 1 SECONDS

	var/good_cooking = round(time/3 SECONDS) - bad_cooking - overcooking

	return clamp_quality(good_cooking)


/datum/cooking_with_jane/recipe_step/use_stove/follow_step(var/obj/used_item, var/datum/cooking_with_jane/recipe_tracker/tracker)
	var/obj/machinery/cooking_with_jane/stove/our_stove = used_item
	var/obj/item/cooking_with_jane/cooking_container/container = tracker.holder_ref.resolve()
	container.cook_data[our_stove.temperature[our_stove.active_input]] += our_stove.reference_time

	return CWJ_SUCCESS

/datum/cooking_with_jane/recipe_step/use_stove/is_complete(var/obj/used_item, var/datum/cooking_with_jane/recipe_tracker/tracker)

	var/obj/item/cooking_with_jane/cooking_container/container = tracker.holder_ref.resolve()

	if(container.cook_data[heat] >= time)
		return TRUE

	return FALSE

