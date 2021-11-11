//goat
/mob/living/simple_animal/hostile/retaliate/goat
	name = "goat"
	desc = "Not known for their pleasant disposition."
	icon = 'icons/mob/mobs-domestic.dmi'
	icon_state = "goat"
	speak_emote = list("brays")
	emote_see = list("shakes its head", "stamps a foot", "glares around")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/reagent_containers/food/snacks/meat
	meat_amount = 4
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	faction = "goat"
	attacktext = "kicked"
	health = 40
	melee_damage_lower = 1
	melee_damage_upper = 5
	var/datum/reagents/udder = null
	colony_friend = TRUE
	friendly_to_colony = TRUE

/mob/living/simple_animal/hostile/retaliate/goat/Initialize(mapload)
	udder = new(50)
	udder.my_atom = src
	..()

/mob/living/simple_animal/hostile/retaliate/goat/beg(var/atom/thing, var/atom/holder)
	visible_emote("butts insistently at [holder]'s legs and reaches towards their [thing].")

/mob/living/simple_animal/hostile/retaliate/goat/Life()
	. = ..()
	if(.)
		//chance to go crazy and start wacking stuff
		if(!enemies.len && prob(1))
			Retaliate()

		if(enemies.len && prob(10))
			enemies = list()
			LoseTarget()
			src.visible_message("\blue [src] calms down.")

		if(stat == CONSCIOUS)
			if(udder && prob(5))
				var/amount_add = rand(5, 10)
				if(unnatural_mutations.getMutation("MUTATION_ROBUST_MILK", TRUE))
					amount_add = 20
				if(unnatural_mutations.getMutation("MUTATION_CHOC_MILK", TRUE))
					udder.add_reagent("chocolatemilk", amount_add)
				else if(unnatural_mutations.getMutation("MUTATION_PROT_MILK", TRUE))
					udder.add_reagent("protein", amount_add)
				else
					udder.add_reagent("milk", amount_add)

		if(locate(/obj/effect/plant) in loc)
			var/obj/effect/plant/SV = locate() in loc
			SV.die_off(1)

		if(locate(/obj/machinery/portable_atmospherics/hydroponics/soil/invisible) in loc)
			var/obj/machinery/portable_atmospherics/hydroponics/soil/invisible/SP = locate() in loc
			qdel(SP)

		if(!pulledby)
			var/obj/effect/plant/food
			food = locate(/obj/effect/plant) in oview(5,loc)
			if(food)
				var/step = get_step_to(src, food, 0)
				Move(step, glide_size_override=DELAY2GLIDESIZE(0.5 SECONDS))

/mob/living/simple_animal/hostile/retaliate/goat/Retaliate()
	..()
	if(stat == CONSCIOUS)
		visible_message(SPAN_WARNING("[src] gets an evil-looking gleam in their eye."))

/mob/living/simple_animal/hostile/retaliate/goat/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0, var/glide_size_override = 0)
	. = ..()
	if(!stat)
		for(var/obj/effect/plant/SV in loc)
			SV.die_off(1)

/mob/living/simple_animal/hostile/retaliate/goat/attackby(var/obj/item/O as obj, var/mob/user as mob)
	var/obj/item/reagent_containers/G = O
	if(stat == CONSCIOUS && istype(G) && G.is_refillable())
		user.visible_message(SPAN_NOTICE("[user] milks [src] using \the [O]."))
		var/transfered = udder.trans_id_to(G, "milk", rand(5,10))
		if(G.reagents.total_volume >= G.volume)
			to_chat(user, "\red The [O] is full.")
		if(!transfered)
			to_chat(user, "\red The udder is dry. Wait a bit longer...")
	else
		..()
//cow
/mob/living/simple_animal/cow
	name = "cow"
	desc = "Known for their milk, just don't tip them over."
	icon = 'icons/mob/mobs-domestic.dmi'
	icon_state = "cow"
	icon_gib = "cow_gib"
	speak_emote = list("moos","moos hauntingly")
	emote_see = list("shakes its head")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/reagent_containers/food/snacks/meat
	meat_amount = 9
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	attacktext = "kicked"
	health = 100
	autoseek_food = 0
	beg_for_food = 0
	var/datum/reagents/udder = null
	colony_friend = TRUE
	friendly_to_colony = TRUE
	clone_difficulty = CLONE_EASY //Easier to make cows than other animals
	inherent_mutations = list(MUTATION_COW_SKIN, MUTATION_IMBECILE, MUTATION_MOO)

/mob/living/simple_animal/cow/Initialize(mapload)
	udder = new(100)
	udder.my_atom = src
	..()

/mob/living/simple_animal/cow/attackby(var/obj/item/O as obj, var/mob/user as mob)
	var/obj/item/reagent_containers/G = O
	if(stat == CONSCIOUS && istype(G) && G.is_refillable())
		user.visible_message(SPAN_NOTICE("[user] milks [src] using \the [O]."))
		var/transfered = udder.trans_to(G, 10)
		if(G.reagents.total_volume >= G.volume)
			to_chat(user, "\red The [O] is full.")
		if(!transfered)
			to_chat(user, "\red The udder is dry. Wait a bit longer...")
	else
		..()

/mob/living/simple_animal/cow/Life()
	. = ..()
	if(stat == CONSCIOUS)
		if(udder && prob(5))
			var/amount_add = rand(5, 10)
			if(unnatural_mutations.getMutation("MUTATION_ROBUST_MILK", TRUE))
				amount_add = 20
			if(unnatural_mutations.getMutation("MUTATION_CHOC_MILK", TRUE))
				udder.add_reagent("chocolatemilk", amount_add)
			else if(unnatural_mutations.getMutation("MUTATION_PROT_MILK", TRUE))
				udder.add_reagent("protein", amount_add)
			else
				udder.add_reagent("milk", amount_add)

/mob/living/simple_animal/cow/attack_hand(mob/living/carbon/M as mob)
	if(!stat && M.a_intent == I_DISARM && icon_state != icon_dead)
		M.visible_message(SPAN_WARNING("[M] tips over [src]."),SPAN_NOTICE("You tip over [src]."))
		Weaken(30)
		icon_state = icon_dead
		spawn(rand(20,50))
			if(!stat && M)
				icon_state = icon_living
				var/list/responses = list(	"[src] looks at you imploringly.",
											"[src] looks at you pleadingly",
											"[src] looks at you with a resigned expression.",
											"[src] seems resigned to her fate.")
				to_chat(M, pick(responses))
	else
		..()

/mob/living/simple_animal/chick
	name = "\improper chick"
	desc = "Adorable! They make such a racket though."
	icon = 'icons/mob/mobs-domestic.dmi'
	icon_state = "chick"
	icon_gib = "chick_gib"
	speak_emote = list("cheeps")
	emote_see = list("pecks at the ground","flaps its tiny wings","cheeps")
	speak_chance = 2
	turns_per_move = 2
	meat_type = /obj/item/reagent_containers/food/snacks/meat
	meat_amount = 1
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	attacktext = "kicked"
	health = 1
	var/amount_grown = 0
	pass_flags = PASSTABLE
	mob_size = MOB_MINISCULE
	autoseek_food = 0
	beg_for_food = 0
	hunger_enabled = FALSE
	colony_friend = TRUE
	friendly_to_colony = TRUE

/mob/living/simple_animal/chick/Initialize(mapload)
	..()
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)

/mob/living/simple_animal/chick/Life()
	. =..()
	if(!.)
		return
	if(!stat)
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			new /mob/living/simple_animal/chicken(src.loc)
			qdel(src)

var/const/MAX_CHICKENS = 10
var/global/chicken_count = 0

/mob/living/simple_animal/chicken
	name = "\improper chicken"
	desc = "Hopefully the eggs are good this season."
	icon = 'icons/mob/mobs-domestic.dmi'
	icon_state = "chicken_brown"
	speak = list("cluck!","BWAAAAARK BWAK BWAK BWAK!","bwaak bwak.")
	emote_see = list("pecks at the ground","flaps its wings viciously")
	speak_chance = 2
	turns_per_move = 3
	meat_type = /obj/item/reagent_containers/food/snacks/meat/chicken
	meat_amount = 4
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	attacktext = "kicked"
	health = 10
	var/eggsleft = 0
	var/body_color
	pass_flags = PASSTABLE
	mob_size = MOB_SMALL
	autoseek_food = 0
	beg_for_food = 0
	hunger_enabled = FALSE
	colony_friend = TRUE
	friendly_to_colony = TRUE

/mob/living/simple_animal/chicken/Initialize(mapload)
	..()
	if(!body_color)
		body_color = pick( list("brown","black","white") )
	icon_state = "chicken_[body_color]"
	icon_living = "chicken_[body_color]"
	icon_dead = "chicken_[body_color]_dead"
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	chicken_count += 1

/mob/living/simple_animal/chicken/death()
	..()
	chicken_count -= 1

/mob/living/simple_animal/chicken/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O, /obj/item/reagent_containers/food/snacks/grown)) //feedin' dem chickens
		var/obj/item/reagent_containers/food/snacks/grown/G = O
		if(G.seed && G.seed.kitchen_tag == "wheat")
			if(!stat && eggsleft < 8)
				user.visible_message("\blue [user] feeds [O] to [name]! She clucks happily.","\blue You feed [O] to [name]! She clucks happily.")
				user.drop_item()
				qdel(O)
				eggsleft += rand(1, 4)
			else
				to_chat(user, "\blue [name] doesn't seem hungry!")
		else
			to_chat(user, "[name] doesn't seem interested in that.")
	else
		..()

/mob/living/simple_animal/chicken/Life()
	. =..()
	if(!.)
		return
	if(!stat && prob(3) && eggsleft > 0)
		visible_message("[src] [pick("lays an egg.","squats down and croons.","begins making a huge racket.","begins clucking raucously.")]")
		eggsleft--
		var/obj/item/reagent_containers/food/snacks/egg/E = new(get_turf(src))
		E.pixel_x = rand(-6,6)
		E.pixel_y = rand(-6,6)
		if(chicken_count < MAX_CHICKENS && prob(10))
			START_PROCESSING(SSobj, E)


/obj/item/reagent_containers/food/snacks/egg/var/amount_grown = 0
/obj/item/reagent_containers/food/snacks/egg/Process()
	if(isturf(loc))
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			visible_message("[src] hatches with a quiet cracking sound.")
			new /mob/living/simple_animal/chick(get_turf(src))
			STOP_PROCESSING(SSobj, src)
			qdel(src)
	else
		STOP_PROCESSING(SSobj, src)

/mob/living/simple_animal/pig
	name = "pig"
	desc = "Known for their meat, and their status as an invasive species on nearly any human-bearing planet."
	icon = 'icons/mob/mobs-domestic.dmi'
	icon_state = "pig"
	speak_emote = list("oinks","squeals")
	emote_see = list("looks hungry")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/reagent_containers/food/snacks/meat/pork
	meat_amount = 5
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	attacktext = "kicked"
	health = 100
	autoseek_food = 0
	beg_for_food = 0
	colony_friend = TRUE
	friendly_to_colony = TRUE
	inherent_mutations = list(MUTATION_IMBECILE, MUTATION_NERVOUSNESS, MUTATION_RAND_UNSTABLE, MUTATION_RAND_UNSTABLE)
	clone_difficulty = CLONE_EASY


/mob/living/simple_animal/pig/Life()
	. = ..()

/mob/living/simple_animal/pig/attack_hand(mob/living/carbon/M as mob)
	if(!stat && M.a_intent == I_DISARM && icon_state != icon_dead)
		M.visible_message(SPAN_WARNING("[M] tips over [src]."),SPAN_NOTICE("You tip over [src]."))
		Weaken(30)
		icon_state = icon_dead
		spawn(rand(20,50))
			if(!stat && M)
				icon_state = icon_living
				var/list/responses = list(	"[src] looks at you imploringly.",
											"[src] looks at you pleadingly",
											"[src] looks at you with a resigned expression.",
											"[src] seems resigned to her fate.")
				to_chat(M, pick(responses))
	else
		..()