//Contains: Engineering department jumpsuits
/obj/item/clothing/under/rank/exultant
	desc = "A blue-yellow engineering jumpsuit worn by Guild Masters. It has good radiation shielding."
	name = "guild master's jumpsuit"
	icon_state = "chiefengineer"
	item_state = "g_suit"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 30
	)

/obj/item/clothing/under/rank/exultant/skirt
	desc = "A blue-yellow engineering skirt worn by Guild Masters. It has good radiation shielding."
	name = "guild master's skirt"
	icon_state = "artificer_jumpskirt_master"
	item_state = "artificer_jumpskirt_master"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 30
	)

/obj/item/clothing/under/rank/engineer
	desc = "A yellow engineering jumpsuit worn by Guild Adepts. It has minor radiation shielding."
	name = "adept's jumpsuit"
	icon_state = "engine"
	item_state = "engi_suit"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 10
	)

/obj/item/clothing/under/rank/engineer/padded
	desc = "A yellow engineering jumpsuit worn by Guild Adepts. It has minor radiation shielding and some decorative padding."
	name = "adept's jumpsuit"
	icon_state = "artificer_armored_jumpsuit"
	item_state = "artificer_armored_jumpsuit"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 10
	)

/obj/item/clothing/under/rank/engineer/skirt
	desc = "A yellow engineering skirt worn by Guild Adepts. It has minor radiation shielding."
	name = "adept's skirt"
	icon_state = "artificer_apprentice_skirt"
	item_state = "artificer_apprentice_skirt"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 10
	)

/obj/item/clothing/under/rank/engineer_alt
	name = "adept's orange uniform"
	desc = "An Artificer Adept uniform featuring a white shirt with orange sleeves and pants. It has minor radiation shielding."
	icon_state = "adept_alt" // Sprites by Ezoken/Dromkii
	item_state = "engi_suit"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 10
	)

/obj/item/clothing/under/rank/engineer_alt/verb/toggle_style()
	set name = "Adjust Style"
	set category = "Object"
	set src in usr

	if(!isliving(loc))
		return

	var/mob/M = usr
	var/list/options = list()
	options["Long sleeves"] = ""
	options["Rolled sleeves"] = "_rolled"
	options["Shirt down"] = "_pants"

	var/choice = input(M,"What kind of style do you want?","Adjust Style") as null|anything in options

	if(src && choice && !M.incapacitated() && Adjacent(M))
		var/base = initial(icon_state)
		base += options[choice]
		icon_state = base
		item_state = base
		item_state_slots = null
		to_chat(M, "You decided to wear your uniform in the [choice] style.")
		update_icon()
		update_wear_icon()
		usr.update_action_buttons()
		return 1

/obj/item/clothing/under/rank/engineer/skirt/alt
	desc = "A yellow engineering skirt worn by Guild Adepts. It has minor radiation shielding and some decorative padding."
	name = "adept's padded skirt"
	icon_state = "artificer_jumpskirt_adept"
	item_state = "artificer_jumpskirt_adept"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 10
	)

/obj/item/clothing/under/rank/roboticist
	desc = "An orange and tan Soteria jumpsuit designed for mechanical work."
	name = "roboticist's jumpsuit"
	icon_state = "robotics"
	item_state = "bl_suit"

/obj/item/clothing/under/rank/engineer/adv
	desc = "A plastic coated and padded engineering suit worn by Guild Adepts heading into dangerously radioactive areas for repair work. Offers full radiation protection."
	name = "adept's padded emergency suit"
	icon_state = "engineadv"
	item_state = "engineadv"
	armor_list = list(
		melee = 20, //if they are not waring any armor over this then we give *something*
		bullet = 20,
		energy = 25,
		bomb = 40,
		bio = 50,
		rad = 100 //Rad proof
	)

/obj/item/clothing/under/rank/engineer/adv_master
	desc = "A plastic-coated and iron-woven engineering suit worn by Guild Masters heading into dangerously radioactive areas for repair work. Offers full radiation protection."
	name = "adept's padded emergency suit"
	icon_state = "chiefengineeradv"
	item_state = "chiefengineeradv"
	armor_list = list(
		melee = 30, //if they are not waring any armor over this then we give *something*
		bullet = 30,
		energy = 45,
		bomb = 80,
		bio = 70,
		rad = 100 //Rad proof
	)

/obj/item/clothing/under/rank/engineer/emergencyA
	desc = "A state of the art Artificier suit, made to endure harsher conditions than the average jumpsuit."
	name = "Adept's emergency suit"
	icon_state = "GA uniform"
	item_state = "GA uniform"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 10
	)

/obj/item/clothing/under/rank/engineer/emergencyM
	desc = "A state of the art Artificier suit, made to endure harsher conditions than the average jumpsuit. This one is made for Guild Masters"
	name = "Adept's emergency suit"
	icon_state = "GM uniform"
	item_state = "GM uniform"
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 0,
		rad = 30
	)
