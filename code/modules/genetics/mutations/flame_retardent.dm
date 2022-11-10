//Macro: MUTATION_FLAME_RETARDENT
//runs a process every now and then to extinguish the holder
/datum/genetics/mutation/flame_retardant
	name = "Flame Retardant"
	key = "MUTATION_FLAME_RETARDANT"
	desc = "Causes a flame smothering fluid to be produced on the skin."
	gain_text = "Your skin feels hydrated."
	instability = 10
	exclusive_type = MUT_TYPE_SKIN

/datum/genetics/mutation/flame_retardent/onMobImplant()
	initializeProcessing()

/datum/genetics/mutation/flame_retardent/onMobRemove()
	haltProcessing()

/datum/genetics/mutation/flame_retardent/Process()
	if(!..())
		return
	if(container.holder.bodytemperature >= 350)
		container.holder.bodytemperature -= 20
	if((container.holder.fire_stacks >= 1) || container.holder.on_fire)
		container.holder.ExtinguishMob()
