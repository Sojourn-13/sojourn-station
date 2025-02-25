/datum/category_item/setup_option/background/bckgrnd/poor
	name = "Poor Upbringing"
	desc = "Your early life was spent in a poor environment, be it from your family's economical position or the place you lived in. This barred access to education, but it let you learn fast \
	that desperate people will use force as commonly as they'll beg for aid. A sharp eye and careful or creative thinking let you avoid getting hurt and allowed you to thrive, so at least you got \
	that going for you."

	restricted_to_species = list(	//Exalted Humans are pay 2 win, they can't be born poor.
		FORM_HUMAN, FORM_SABLEKYNE, FORM_KRIOSAN,
		FORM_AKULA, FORM_MARQUA, FORM_NARAMAD,
		FORM_CINDAR, FORM_FBP, FORM_UNBRANDED,
		FORM_SOTSYNTH, FORM_AGSYNTH, FORM_BSSYNTH,
		FORM_FOLKEN, FORM_MYCUS)

	stat_modifiers = list(
		STAT_ROB = 0,
		STAT_TGH = 3,
		STAT_VIG = 5,
		STAT_BIO = 0,
		STAT_MEC = 8, // Working mechanical jobs for most of your life, you should know how to use tools
		STAT_COG = -5 // No education
	)

/datum/category_item/setup_option/background/bckgrnd/pressered_in_life
	name = "Overwhelming Upbringing"
	desc = "You had quite the start in life, nothing ever was laid back or easy. Always being pressured into things you didn't care for or like. This may have come from parents, peers, or even schools. \
	Your mind is as sharp as ever as a result, but you almost never set foot in a gym, making you physically deficient."

//Idea behind this is that well in younger years you pushed your body to hard and now your paying for it in TOB/TGH
//The main boon of this being a better mind and understanding.
//-14Loss Stats +15Gained Stats

	stat_modifiers = list(
		STAT_ROB = -6,
		STAT_TGH = -6,
		STAT_VIG = -2,
		STAT_BIO = 5,
		STAT_MEC = 5,
		STAT_COG = 5
	)


/datum/category_item/setup_option/background/bckgrnd/wealthy
	name = "Wealthy Upbringing"
	desc = "You grew up with a silver spoon in your mouth all your life. Education, leisure time, and relaxation allowed you to indulge in scholarly pursuits to a degree, letting you pick up a few \
	randomly useful facts about many things. A shame that easy living left you a bit naive and physically weak albeit healthier than most. Not to mention you never quite developed the sense of when \
	danger is present. This certainly made switching to regular life a bit of a culture shock. A major hangup is that filth is not something you particularly find appealing. Spoiled brat.. \
	At least you've brought your heirloom with you. You should protect it well."

	perks = list(PERK_NOBLE)

	stat_modifiers = list(
		STAT_ROB = -5,
		STAT_TGH = -5, // Physically weak
		STAT_VIG = -5, // Low-experience
		STAT_BIO = 5,
		STAT_MEC = 5,
		STAT_COG = 5 // Education
	)

/datum/category_item/setup_option/background/bckgrnd/refugee
	name = "Refugee"
	desc = "Where ever you came from is no more, torn apart by conflict and war. It may have been a civil war or conquest by the Solarian Federation, whatever the reason it has long since lost any \
	meaning after the destruction of your home-world. Or maybe it wasn't your homeworld that was destroyed, maybe it was just your way of life. Regardless, you've left a burned bridge behind you and \
	can no longer go back. Your rough life has hardened you against the worst possible situations."

	perks = list(PERK_SPACE_ASSHOLE)

	stat_modifiers = list(
		STAT_ROB = 0,
		STAT_TGH = 0,
		STAT_VIG = 0,
		STAT_BIO = 0,
		STAT_MEC = 0,
		STAT_COG = 0
	)

/datum/category_item/setup_option/background/bckgrnd/linguist
	name = "Aspiring Linguist"
	desc = "Be it from your education or from a multi-lingual family, you've found yourself studying languages non-stop throughout your childhood and early adulthood. Unlike most you're silver-tongued \
	in both your knowledge of English, your secondary or native language - and your tertiary! Being tri-lingual has its upsides, making you an adept trader of sorts. Though its downside is that you may \
	have not studied as hard as some others have in other subjects."

	perks = list(PERK_LINGUIST)

	stat_modifiers = list(
		STAT_ROB = 0,
		STAT_TGH = 0,
		STAT_VIG = 0,
		STAT_BIO = 0,
		STAT_MEC = 0,
		STAT_COG = 0
	)

/datum/category_item/setup_option/background/bckgrnd/drugaddict
	name = "Chem Addict"
	desc = "For whatever reason, be it from an early age and bad parenting or personal choice you became a devout user of illicit drugs. The constant use over the years has weakened your body \
	and made you extra paranoid, which can be a good thing when evading the law. Your experience with your own body has also let you learn a few medical tricks over the years, along with a tolerance \
	to most drugs so you can inject more varied amounts than others."

	perks = list(PERK_ADDICT)
	restricted_to_species = list(FORM_HUMAN, FORM_KRIOSAN, FORM_AKULA, FORM_MARQUA, FORM_NARAMAD, FORM_OPIFEX, FORM_CHTMANT, FORM_CINDAR)

	stat_modifiers = list(
		STAT_ROB = -5,
		STAT_TGH = -5,
		STAT_VIG = 4,
		STAT_BIO = 6,
		STAT_MEC = 0,
		STAT_COG = -5, // Brain fried from drugs
		STAT_VIV = 5
	)

/datum/category_item/setup_option/background/bckgrnd/klutz
	name = "Klutz"
	desc = "Your entire life has been a series of unlucky and often self-inflicted accidents, you spent enough time hurting yourself due to your own clumsiness that you've built up a more \
	pain tolerance than most of common folks, meaning that due to this clumsiness problem, you've become quite tough and a little stronger too. A shame, this doesn't stop you from time to time failing even the most basic tasks at times. In fact, you find some tasks that require precision damn near impossible, and even handling or using guns is a dangerous prospect. Due to this problem, you have a terrible perception around the area around you."

	perks = list(PERK_KLUTZ)

	stat_modifiers = list(
		STAT_ROB = 10,
		STAT_TGH = 20,
		STAT_VIG = -20,
		STAT_BIO = 0,
		STAT_MEC = 0,
		STAT_COG = -5 // Dumb, or just careless
	)

/datum/category_item/setup_option/background/bckgrnd/no_light
	name = "Umbral Upbringing"
	desc = "Much of your early life was spent in areas which did not have much, if any, natural light. This may have been planetary where stretches of time hid your world from the sun's light \
	or you lived in an area where light wasn't a feasible resource due to economic, biological, or local reasons. Whatever the specifics, you've gotten highly adapted to finding your way through the \
	dark, your pupils widening faster to better take in your surroundings. This quick adaptation however, has led you to become more photosensitive to sudden bright lights and flashes."

	perks = list(PERK_NIGHTCRAWLER)

	stat_modifiers = list(
		STAT_ROB = 0,
		STAT_TGH = 0,
		STAT_VIG = 5, // Eyes of an eagle
		STAT_BIO = 0,
		STAT_MEC = 0,
		STAT_COG = 0
	)

/datum/category_item/setup_option/background/bckgrnd/gifted
	name = "Gifted Nihilist"
	desc = "You were a smart child, gifted in any particular area you wished to embark upon be it intellectual or physical. Unfortunately this approach made you a jack of all trades and severely  \
	hampered your ability to master any one discipline. Sure, you're smart, but without the experience and discipline of practical application it doesn't help you as much as anyone could hope. \
	The one issue you truly suffer is a nihlistic world view; you seem more effected by your surroundings than the normal person."

	perks = list(PERK_NIHILIST)

	stat_modifiers = list(
		STAT_ROB = 0,
		STAT_TGH = 0,
		STAT_VIG = -2,
		STAT_BIO = -4,
		STAT_MEC = -4,
		STAT_COG = 15
	)


/datum/category_item/setup_option/background/bckgrnd/idiotsavant
	name = "Idiot Savant"
	desc = "You're an idiot, no really, you're just a complete brainlet when it comes to anything you're not hyper-focused on. You have an innate knack and understanding with the most conceptual  \
	applications of technology, medicine, and even firearms. The problem is this understanding is instinctual, not intellectual, you have no idea how you know, you just do. You're stuck in the odd \
	position of being able to do complex difficult tasks related to your areas of interest but completely incapable of doing the most basic things in other areas."

	stat_modifiers = list(
		STAT_ROB = 0,
		STAT_TGH = 0,
		STAT_VIG = 4,
		STAT_BIO = 4,
		STAT_MEC = 4,
		STAT_COG = -15
	)

/datum/category_item/setup_option/background/bckgrnd/psionic_harmony
	name = "Peaceful Life"
	desc = "You've lived a life of peace and harmony so idyllic that is has given you a special bit of enlightenment. This is not to say your life was easy, nor without trial or consequence, \
	it merely speaks of your approach being serene in ways that have left lasting effects upon you. This early life has left you so deeply effected that your mind is the calm within the storm, \
	no matter the scenario you cannot be left in turmoil for long. You always find contentment, you always find peace. As such, should you ever become a psion, you're mind is perfectly adapted \
	to make the most of the essence from which your powers are called, granting you three additional uses of your abilities."

	perks = list(PERK_PSI_HARMONY)

	stat_modifiers = list(
		STAT_ROB = -2,
		STAT_TGH = -2, // Peaceful thoughts eschew you from applying violence
		STAT_VIG = 2,
		STAT_BIO = 0,
		STAT_MEC = 0,
		STAT_COG = 5 // A peaceful mind is a focused mind.
	)

/datum/category_item/setup_option/background/bckgrnd/psionic_mania
	name = "Bedlam"
	desc = "Your life has been nothing but conflict, violence, and bedlam for as long as you can remember. You were fighting the moment you can stand and nothing has changed. You're always \
	ready to throw down. You may not be outwardly confrontational, hell, people might not even know the capacity for hurting others you have deep down. But you cannot see violence as anything \
	but the ultimate authority from which all authority is granted. This bedlam has changed how your mind works and, should you ever become a psion, has made you the perfect example of what \
	a destructive mind can do. You always deal the maximum level of destruction when using your psionic powers which scale with your body and mind."

	perks = list(PERK_PSI_MANIA)

	stat_modifiers = list(
		STAT_ROB = 2,
		STAT_TGH = 2, // Hardened by violent thoughts probably put to practice
		STAT_VIG = 0,
		STAT_BIO = 0,
		STAT_MEC = 0,
		STAT_COG = -5 // Violence clouds the mind, tradeoff for a good perk that never had any mechanical drawbacks
	)

/datum/category_item/setup_option/background/bckgrnd/razor_maniac
	name = "Razor Girl/Boy"
	desc = "Razor Girls/Boys are those who heavily augment themselves, often times for the purpose of combat or merely because they enjoy the utility offered. Razors, sometimes called metal heads, \
	are a distinctly human and abhuman sub-culture and benefit greatly from the advanced cybernetics humans are known, though outliers from other races also adopt it. The most common and consistent \
	sign that someone is a razor is the implantation of metal claws implanted in the arm, serving as a hidden and potentially deadly weapon. Most razors further augment this by using cybernetics to \
	enhance their physical strength and endurance or replace organic limbs with stronger synthetics."

	restricted_to_species = list(
		FORM_HUMAN, FORM_EXALT_HUMAN, FORM_SABLEKYNE, FORM_KRIOSAN,
		FORM_AKULA, FORM_MARQUA, FORM_NARAMAD,
		FORM_CINDAR)

	racial_implants = (/obj/item/organ_module/active/simple/wolverine)

	stat_modifiers = list(
		STAT_ROB = 3,
		STAT_TGH = 2,
		STAT_VIG = 0,
		STAT_BIO = 0,
		STAT_MEC = 0,
		STAT_COG = 0
	)

/datum/category_item/setup_option/background/bckgrnd/true_data
	name = "Introspective"
	desc = "Do to being more in-tune with what you are and whats around you things that were once hidden behind probability or guessing are shown to you as factual odds."
	perks = list(PERK_NO_OBFUSCATION)

	stat_modifiers = list(
		STAT_VIG = 5,
		STAT_MEC = -5,
		STAT_COG = 5,
		STAT_VIV = -5
	)

/datum/category_item/setup_option/background/bckgrnd/blood_lust
	name = "Always Targeted"
	desc = "Whether learned through combat or training, you can manipulate simple combatives into targeting you through a killing intent, making the simple-minded, target you before anyone else."
	perks = list(PERK_BLOOD_LUST)

	//Makes you little less good with chems and sanity
	stat_modifiers = list(
		STAT_ROB = 5,
		STAT_VIG = -5,
		STAT_TGH = 5,
		STAT_VIV = -5
	)

/datum/category_item/setup_option/background/bckgrnd/natural_style
	name = "Natural Style"
	desc = "Due to intense training and study into how to replicate sheath arts you can weather both a mental storm, and a battle field. \
	All melee weapons that attack at range have a little bit extra reach when you wield them."
	perks = list(PERK_NATURAL_STYLE)

	//You have been trainning with a sword for speed and hitting a target
	//+1 range to all ranged melee + sanity stablization, this perk is **good**
	stat_modifiers = list(
		STAT_ROB = 5,
		STAT_TGH = 5,
		STAT_BIO = 2,
		STAT_VIG = -10,
		STAT_COG = -10,
		STAT_VIV = -30
	)

/datum/category_item/setup_option/background/bckgrnd/map_maker
	name = "Map Making"
	desc = "Your enhanced perception allows you to visualize the terrain around you, marking down walls, foes, and loot nearby."
	perks = list(PERK_MAP_MAKER)

	//Weak perk if you already know the map, also takes resources to use
	stat_modifiers = list(
		STAT_BIO = -5,
		STAT_COG = 10,
	)

/datum/category_item/setup_option/background/bckgrnd/close_minded
	name = "Close Minded"
	desc = "You cannot be inspired, and as such, artistic pursuits are beyond you. Though what you have already learned, you can apply very well."
	perks = list(PERK_NO_INSPIRO)

	restricted_to_species = list(
		FORM_HUMAN, FORM_EXALT_HUMAN, FORM_SABLEKYNE, FORM_KRIOSAN,
		FORM_AKULA, FORM_MARQUA, FORM_NARAMAD, FORM_OPIFEX, FORM_CHTMANT,
		FORM_CINDAR, FORM_SLIME, FORM_MYCUS, FORM_FOLKEN)

	stat_modifiers = list(
		STAT_ROB = 25,
		STAT_TGH = 25,
		STAT_VIG = 25,
		STAT_BIO = 35,
		STAT_MEC = 35,
		STAT_COG = 35
	)
