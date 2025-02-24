/obj/machinery/vending/one_star
	name = "Greyson Positronic Vendor"
	desc = "A holographic vendor made by Greyson Positronic."
	icon = 'icons/obj/machines/one_star/vending.dmi'
	icon_state = "vendor_guns"
	icon_vend = "vendor_printing"
	//product_slogans = "Usually no carcinogens!;Best sports!;Become the strongest!"
	//product_ads = "Strength!;Cheap!;There are contraindications, it is recommended to consult a medical specialist."
	vendor_department = DEPARTMENT_GREYSON
	alt_currency_path = /obj/item/stack/os_cash

/obj/machinery/vending/one_star/Initialize()
	. = ..()
	set_light(1.4, 1, COLOR_LIGHTING_CYAN_BRIGHT)
	earnings_account = department_accounts[DEPARTMENT_GREYSON]

/obj/machinery/vending/one_star/guns
	desc = "A vendor of the One Star variety typical made by GP. This one sells firearms of the GP variety."
	icon_state = "vendor_guns"

	products = list(
		/obj/item/gun/energy/cog = 3,
		/obj/item/gun/projectile/spring = 2,
		/obj/item/gun/projectile/rivet = 1
		)

	prices = list(
		/obj/item/gun/energy/cog = 50,
		/obj/item/gun/projectile/spring = 100,
		/obj/item/gun/projectile/rivet = 200
		)

/obj/machinery/vending/one_star/food
	desc = "A holographic vendor made by Greyson Positronic. This one sells a variety of food."
	product_slogans = "It's a Vending Machine!;We all eat lunch from a Vending Machine!"
	product_ads = "You must be the new guy!;Hows is your child doing?;Real Meals!;Some people say its not real food but many quite like and many think you will to!"

	icon_state = "vendor_food"

	products = list(
		/obj/item/clothing/mask/smokable/cigarette/os = 12,
		/obj/item/reagent_containers/drinks/os_coffee = 12,
		/obj/item/reagent_containers/snacks/openable/os_soypack = 6,
		/obj/item/reagent_containers/snacks/openable/os_bun = 6,
		/obj/item/reagent_containers/snacks/openable/os_meat = 6,
		/obj/item/reagent_containers/snacks/openable/candy/os = 6,
		/obj/item/reagent_containers/snacks/openable/mre/os = 6,
		/obj/item/reagent_containers/snacks/os_paste = 3,
		/obj/item/reagent_containers/snacks/openable/os_heart = 2,
		/obj/item/reagent_containers/snacks/openable/os_liver = 2
		)

	prices = list(
		/obj/item/clothing/mask/smokable/cigarette/os = 5,
		/obj/item/reagent_containers/drinks/os_coffee = 7,
		/obj/item/reagent_containers/snacks/openable/os_soypack = 60,
		/obj/item/reagent_containers/snacks/openable/os_bun = 30,
		/obj/item/reagent_containers/snacks/openable/os_meat = 75,
		/obj/item/reagent_containers/snacks/openable/candy/os = 50,
		/obj/item/reagent_containers/snacks/openable/mre/os = 65,
		/obj/item/reagent_containers/snacks/os_paste = 80,
		/obj/item/reagent_containers/snacks/openable/os_heart = 200,
		/obj/item/reagent_containers/snacks/openable/os_liver = 120
		)

/obj/machinery/vending/one_star/health
	desc = "A holographic vendor made by Greyson Positronic. This one sells medical paraphernalia of the GP variety."
	icon_state = "vendor_health"


	products = list(
		/obj/item/device/scanner/health/greyson = 2,
		/obj/item/greyson_inhaler = 6,
		/obj/item/greyson_inhaler/burn = 6,
		/obj/item/storage/firstaid/greyson = 2,
		/obj/item/stack/medical/bruise_pack/greyson = 72,
		/obj/item/storage/firstaid/greyson/burn = 2,
		/obj/item/stack/medical/ointment/greyson = 72,
		//obj/item/reagent_containers/food/drinks/os_coffee = 12,
		/obj/item/clothing/mask/smokable/cigarette/os = 12
		)

	prices = list(
		/obj/item/device/scanner/health/greyson = 250,
		/obj/item/greyson_inhaler = 150,
		/obj/item/greyson_inhaler/burn = 150,
		/obj/item/storage/firstaid/greyson = 200,
		/obj/item/stack/medical/bruise_pack/greyson = 25,
		/obj/item/storage/firstaid/greyson/burn = 200,
		/obj/item/stack/medical/ointment/greyson = 25,
		//obj/item/reagent_containers/food/drinks/os_coffee = 7,
		/obj/item/clothing/mask/smokable/cigarette/os = 5
		)

//Based off a event that the colony helped a distress signal from the greyson. Mostly fluff and cosmetic

/obj/machinery/vending/greyson_colony_ally
	name = "Greyson Star Traders Vending Machine"
	desc = "A holographic vendor made by a unknown Greyson Positronic sub-brand that owns a trading vessel, that said vessel constantly trades with lonestar and in a effort of good will by the mainframe GSTPMF Nova Greyson they have given this vendor to the colony containing greyson goods... This one sells a variety of items."
	product_slogans = "It's a Vending Machine! Well... we think you might enjoy it?; Again thank you for saving one of our representatives! The GSTPMF Nova Greyson sends her regards to the colony."
	product_ads = "We thank your colony for saving our Representative in the past! We hope to make more deals for tomorrow!;Hows are you doing? Hope you have a wonderful day!;We really do hope the colony fares well! Contact us anytime soon!;Some people really want to see the world shine! As do us!"
	icon = 'icons/obj/machines/one_star/vending.dmi'
	icon_state = "vendor_items"
	icon_vend = "vendor_printing"
	vendor_department = DEPARTMENT_GREYSON

/obj/machinery/vending/greyson_colony_ally/Initialize()
	. = ..()
	set_light(1.4, 1, COLOR_LIGHTING_CYAN_BRIGHT)
	earnings_account = department_accounts[DEPARTMENT_GREYSON]


	products = list(
		/obj/item/clothing/mask/smokable/cigarette/os/nova = 25,
		/obj/item/clothing/suit/space/void/os/nova = 15,
		/obj/item/clothing/suit/greatcoat/os/nova = 10,
		/obj/item/clothing/under/os_jumpsuit/nova = 10,
		/obj/item/clothing/under/os_jumpsuit/bdu/nova = 10,
		/obj/item/clothing/under/iron_lock_security = 10,
		/obj/item/clothing/head/os_cap/nova = 10,
 		)

	prices = list(
		/obj/item/clothing/mask/smokable/cigarette/os/nova = 5,
		/obj/item/clothing/suit/space/void/os/nova = 210,
		/obj/item/clothing/suit/greatcoat/os/nova = 70,
		/obj/item/clothing/under/os_jumpsuit/nova = 25,
		/obj/item/clothing/under/os_jumpsuit/bdu/nova = 35,
		/obj/item/clothing/under/iron_lock_security = 70,
		/obj/item/clothing/head/os_cap/nova = 45,
		)
