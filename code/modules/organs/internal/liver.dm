/obj/item/organ/internal/liver
	name = "liver"
	icon_state = "liver"
	organ_efficiency = list(OP_LIVER = 100)
	parent_organ_base = BP_GROIN
	blood_req = 5
	max_blood_storage = 25
	oxygen_req = 7
	nutriment_req = 5
	price_tag = 1800
	w_class = ITEM_SIZE_SMALL

//We got it covered in Process with more detailed thing
/obj/item/organ/internal/liver/handle_regeneration()
	return