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

/datum/computer_file/data/news_article/Official_Marshal_communique
	filename = "Official Marshal communique"
	server_file_path = 'news_articles/Official_Marshal_communique.html'

/datum/computer_file/data/news_article/kros_news
	filename = "Official Marshal communique"
	server_file_path = 'news_articles/kros_news.html'