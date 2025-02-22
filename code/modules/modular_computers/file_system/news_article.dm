// /data/ files store data in string format.
// They don't contain other logic for now.
/datum/computer_file/data/news_article
	filetype = "XNML"
	filename = "Unknown News Entry"
	block_size = 5000 		// Results in smaller files
	read_only = 1			// Editing the file breaks most formatting due to some HTML tags not being accepted as input from average user.
	var/server_file_path 	// File path to HTML file that will be loaded on server start. Example: '/news_articles/space_magazine_1.html'. Use the /news_articles/ folder!
	var/archived			// Set to 1 for older stuff
	var/cover				//filename of cover.

/datum/computer_file/data/news_article/New(var/load_from_file = 0)
	..()
	if(server_file_path && load_from_file)
		stored_data = file2text(server_file_path)
	calculate_size()


// NEWS DEFINITIONS BELOW THIS LINE

//TODO: Make this more modular so new entries don't require a PR, perhaps SQL Database integration.

//SOJ ADDS - All from discord
/datum/computer_file/data/news_article/Psionic_Ascension
	filename = "Psionic Ascension"
	server_file_path = 'news_articles/Psionic_Ascension.html'
	archived = 1

/datum/computer_file/data/news_article/Psionic_Medicine
	filename = "Psionic Medicine"
	server_file_path = 'news_articles/Psionic_Medicine.html'
	archived = 1

/datum/computer_file/data/news_article/Progress
	filename = "Progress!"
	server_file_path = 'news_articles/Progress.html'
	archived = 1

/datum/computer_file/data/news_article/Call_to_Action
	filename = "Call to Action"
	server_file_path = 'news_articles/Call_to_Action.html'
	archived = 1

/datum/computer_file/data/news_article/Morning_Star
	filename = "Morning Star"
	server_file_path = 'news_articles/Morning_Star.html'
	archived = 1

/datum/computer_file/data/news_article/Scrap_Haven
	filename = "Scrap Haven"
	server_file_path = 'news_articles/Scrap_Haven.html'

/datum/computer_file/data/news_article/Catastrophic_Outbreak
	filename = "Catastrophic Outbreak"
	server_file_path = 'news_articles/Catastrophic_Outbreak.html'
	archived = 1

/datum/computer_file/data/news_article/Deep_Maint_Psychosis
	filename = "Deep Maint Psychosis"
	server_file_path = 'news_articles/Deep_Maint_Psychosis.html'
	archived = 1

/datum/computer_file/data/news_article/Didnt_think_to_ask_if_they_should
	filename = "Didn't think to ask if they should"
	server_file_path = 'news_articles/Didnt_think_to_ask_if_they_should.html'
	archived = 1

/datum/computer_file/data/news_article/Agent_Captured
	filename = "Agent Captured"
	server_file_path = 'news_articles/Agent_Captured.html'
	archived = 1

/datum/computer_file/data/news_article/Gatehouse_Clusterfuck
	filename = "Gatehouse Clusterfuck"
	server_file_path = 'news_articles/Gatehouse_Clusterfuck.html'
	archived = 1

/datum/computer_file/data/news_article/CardCarp
	filename = "CardCarp"
	server_file_path = 'news_articles/CardCarp.html'
	archived = 1

/datum/computer_file/data/news_article/Whoever_fights_monsters
	filename = "Whoever fights monsters"
	server_file_path = 'news_articles/Whoever_fights_monsters.html'
	archived = 1

/datum/computer_file/data/news_article/Official_Marshal_communique
	filename = "Official Marshal communique"
	server_file_path = 'news_articles/Official_Marshal_communique.html'
	archived = 1

/datum/computer_file/data/news_article/kros_news
	filename = "Trouble in Sector N-1"
	server_file_path = 'news_articles/kros_news.html'
	archived = 1

/datum/computer_file/data/news_article/kros_news_ii
	filename = "Trouble in Sector N-2"
	server_file_path = 'news_articles/kros_news_ii.html'

/datum/computer_file/data/news_article/fire_in_jungle
	filename = "Fire In The Jungle"
	server_file_path = 'news_articles/FIRE_IN_THE_JUNGLE.html'

/datum/computer_file/data/news_article/Mangos_Untitled_Stream
	filename = "Mango's Untitled Stream #473"
	server_file_path = 'news_articles/Mangos_Untitled_Stream.html'

/datum/computer_file/data/news_article/The_month_in_recap
	filename = "The month in recap!"
	server_file_path = 'news_articles/The_month_in_recap.html'

/datum/computer_file/data/news_article/Full_stop
	filename = "Full stop"
	server_file_path = 'news_articles/Full_stop.html'

/datum/computer_file/data/news_article/An_odd_twist_of_fate
	filename = "An odd twist of fate"
	server_file_path = 'news_articles/An_odd_twist_of_fate.html'

/datum/computer_file/data/news_article/Emily_chu
	filename = "Emily Chu's Report"
	server_file_path = 'news_articles/Emily_chu.html'

/datum/computer_file/data/news_article/wanted_issue_terran
	filename = "WANTED ISSUE - JACK TERRAN."
	server_file_path = 'news_articles/wanted_issue_terran.html'

/datum/computer_file/data/news_article/Kar_Thil_Kor
	filename = "Marqua \"Kar Thil Kor\" Trade Ship."
	server_file_path = 'news_articles/Kar_Thil_Kor.html'

/datum/computer_file/data/news_article/zoo_revamp_news_cluster
	filename = "Zoo Incursion Chronicals."
	server_file_path = 'news_articles/zoo_revamp_news_cluster.html'



