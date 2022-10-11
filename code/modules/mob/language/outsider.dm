/datum/language/xenocommon
	name = LANGUAGE_XENOMORPH
	colour = "alien"
	desc = "The common tongue of the xenomorphs."
	speech_verb = list("hisses")
	ask_verb = list("hisses")
	exclaim_verb = list("hisses")
	key = "4"
	flags = RESTRICTED
	syllables = list("sss","sSs","SSS")
	shorthand = "Xeno"
	has_written_form = FALSE

/*
/datum/language/xenos
	name = LANGUAGE_HIVEMIND
	desc = "Xenomorphs have the strange ability to commune over a psychic hivemind."
	speech_verb = list("hisses")
	ask_verb = list("hisses")
	exclaim_verb = list("hisses")
	colour = "alien"
	key = "a"
	flags = RESTRICTED | HIVEMIND
	shorthand = "N/A"

/datum/language/xenos/check_special_condition(var/mob/other)

	var/mob/living/carbon/M = other
	if(!istype(M))
		return 1
	if(locate(/obj/item/organ/internal/xenos/hivenode) in M.internal_organs)
		return 1

	return 0
*/

/datum/language/cultcommon
	name = LANGUAGE_CULT
	desc = "The chants of the occult, the incomprehensible."
	speech_verb = list("intones")
	ask_verb = list("intones")
	exclaim_verb = list("chants")
	colour = "cult"
	key = "f"
	flags = RESTRICTED
	space_chance = 100
	has_written_form = TRUE		//I҉̵̴̢҉̶̸̴̵̸̷̷̴̷̷̶̷̴̵̡̨̡̢̧̨̧̡̛̛̛̛̛̀́̀́̀̀̕͘̕͜͢͢͢͜͜͢͜͢͡͞͠͠͠͝͠͡͠͠͞͠ ͜͢҉̴̷̵̨̧̢̛̛̛͝͏̧́̀́̀̕̕͘̕͘͜͢͠͡͏̴̸̶̴̧̛́́́͟͢͡͞͠͞͏̴̴̵̵̵̵̢̨̢̧͟͟͠͞͡͠͞͝͡ḉ̷̸̶̧̢̧̀́͟͢͟͟͢͜͠͡҉̢̛͟͏̷̶̸̡̡̨̡̛̛́͘͢͜͢͠͏̡̧̕͝͏̸̶́́̀͢͢͢͢͡͠͠ ͞͞͏̷̷̀̕͠҉͡͏̸̶̸̷̨̧̨̢̨̨̨́́̀̕̕͜͞͡͏͏̵̴̶̸̀́͟͠u̶̵̡̢̧̕͟͢͝͏̵̶҉̧҉̛͠͝͡҉̶̸̴̶̨̡̀́̀̀́̀͢͢͡͝͝͡͞͡
	syllables = list("ire","ego","nahlizet","certum","veri","jatkaa","mgar","balaq", "karazet", "geeri", \
		"orkan", "allaq", "sas'so", "c'arta", "forbici", "tarem", "n'ath", "reth", "sh'yro", "eth", "d'raggathnor", \
		"mah'weyh", "pleggh", "at", "e'ntrath", "tok-lyr", "rqa'nap", "g'lt-ulotf", "ta'gh", "fara'qha", "fel", "d'amar det", \
		"yu'gular", "faras", "desdae", "havas", "mithum", "javara", "umathar", "uf'kal", "thenar", "rash'tla", \
		"sektath", "mal'zua", "zasan", "therium", "viortia", "kla'atu", "barada", "nikt'o", "fwe'sh", "mah", "erl", "nyag", "r'ya", \
		"gal'h'rfikk", "harfrandid", "mud'gib", "fuu", "ma'jin", "dedo", "ol'btoh", "n'ath", "reth", "sh'yro", "eth", \
		"d'rekkathnor", "khari'd", "gual'te", "nikka", "nikt'o", "barada", "kla'atu", "barhah", "hra" ,"zar'garis")
	shorthand = "CT"

/datum/language/vox
	name = LANGUAGE_OPIFEXEE
	desc = "The chants of the opifex, the incomprehensible garbling of birds."
	speech_verb = list("squawks")
	ask_verb = list("chirps")
	exclaim_verb = list("screeches")
	colour = "cult"
	key = "f"
	flags = RESTRICTED
	partial_understanding = list(
		LANGUAGE_YASSARI = 15
	)
	space_chance = 100
	has_written_form = TRUE
	syllables = list("ire","ego","nahlizet","certum","veri","jatkaa","mgar","balaq", "karazet", "geeri", \
		"orkan", "allaq", "sas'so", "c'arta", "forbici", "tarem", "n'ath", "reth", "sh'yro", "eth", "d'raggathnor", \
		"mah'weyh", "pleggh", "at", "e'ntrath", "tok-lyr", "rqa'nap", "g'lt-ulotf", "ta'gh", "fara'qha", "fel", "d'amar det", \
		"yu'gular", "faras", "desdae", "havas", "mithum", "javara", "umathar", "uf'kal", "thenar", "rash'tla", \
		"sektath", "mal'zua", "zasan", "therium", "viortia", "kla'atu", "barada", "nikt'o", "fwe'sh", "mah", "erl", "nyag", "r'ya", \
		"gal'h'rfikk", "harfrandid", "mud'gib", "fuu", "ma'jin", "dedo", "ol'btoh", "n'ath", "reth", "sh'yro", "eth", \
		"d'rekkathnor", "khari'd", "gual'te", "nikka", "nikt'o", "barada", "kla'atu", "barhah", "hra" ,"zar'garis")
	shorthand = "N/A"

/datum/language/cult
	name = LANGUAGE_OCCULT
	desc = "The initiated can share their thoughts by means defying all reason."
	speech_verb = list("intones")
	ask_verb = list("intones")
	exclaim_verb = list("chants")
	colour = "cult"
	key = "y"
	flags = RESTRICTED | HIVEMIND
	shorthand = "N/A"
	has_written_form = FALSE	//Hiveminds don't get a written language.

/datum/language/chtmant
	name = LANGUAGE_CHTMANT
	desc = "The hivemind linking all cht'mants who share a common hive ancestry."
	speech_verb = list("chitters")
	ask_verb = list("clocks")
	exclaim_verb = list("screes")
	colour = "cult"
	key = "o"
	flags = RESTRICTED | HIVEMIND
	shorthand = "N/A"
	has_written_form = FALSE	//Hiveminds don't get a written language.

/datum/language/kriosan
	name = LANGUAGE_KRIOSAN
	desc = "The main language of Krios, Kriosan Creole. Mostly consiting of quill-hound noises, posturing and many German borrow words."
	speech_verb = list("states", "rumbles")
	ask_verb = list("stipulates", "huffs")
	exclaim_verb = list("barks", "yips")
	colour = "kriosan"
	key = "k"
	flags = RESTRICTED
	has_written_form = FALSE	//Lore reason - Creolized German and their ancient native language. Therefor their written language is 'dead' effectively.
	partial_understanding = list(
		LANGUAGE_GERMAN = 75,
		LANGUAGE_COMMON = 10
	)
	shorthand = "KO"
	syllables = list("Frau", "Mann", "Waffe", "Schiff", "Bombe", "Explosion", "Grenze", "Strasse", "Halle", "Pistole", "Gewehr", "Uniform", "Kind", "Arzt", \
					 "und", "ja", "nein", "vielleicht", "ob", "Hund", "Hundt", "katse", "Rüde", "Pleite", "Schreckschraube", "Klammer", "fahren","Raumschiff", \
 					 "Serbien", "Eisenhammer", "Soteria", "Atmosphaere", "Generator", "Ingenieur", "Religion", "Ratte", "Priester", "Käfer", "Armee", "Regierung", "neu", \
 					 "fuß", "braver", "Hoffnung", "schauen", "sterben", "elektrisch", "Teufel", "kurieren", "Fleisch", "trinken", "Auftrag", "Hilfe", "Medizin", "zeppelin", \
 					 "verfallen", "Verfall", "National", "Laser", "Strom", "Gruppe", "Verteidigung", "verteidigen", "suche", "Auge", "Hand", "Bein", "Kopf", \
 					 "Flucht", "teufel", "Ritter", "Einfluss", "Einfall", "Muesli", "Wand", "Fenster", "Metall", "Holz", "Glas", "platz",  \
 					 "Bleib", "gib laut", "hunden", "sitz", "Weltraum", "Turbine", "Treibstoff", "platt", "dunkel", "hell", "tauchen", "Licht", "scheinen", \
 					 "Kaiser", "bekaempfen", "Tastatur", "Augenlicht", "verwerfen", "analysieren", "verschieben", \
 					 "Flammen", "Feuer", "Batterie", "laser", "Unwetter", "Abflug", "behandeln", "Roboter", "Regierung", \
					 "Unterhaltung", "Platituede", "Pferd", "Poker", "spielen", "Stopp", "Baum", "Raumschlacht", "Kolonie", "kolonisieren", \
 					 "Gas", "Schaltung", "umstuerzen", "Umsturz", "Wissenschaft", "erforschen", "Forschung", "Psychologe", "Schmerz", \
 					 "Schmerzen", "gebrochen", "brechen", "alle", "Musik", "also", "Interesse", "Pruegel", "Alkohol", "Getraenk", \
 					 "dynamisch", "Dynamik", "Organisation", "hauptsache", "ueberhaupt", "weil", "denn", "deshalb", "mir", "dir", \
 					 "dein", "mein", "ihr", "eure", "seine", "meine", "Hier", "Fisch", "Ziege")
