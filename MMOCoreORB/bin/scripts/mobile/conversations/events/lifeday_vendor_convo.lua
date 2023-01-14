--		PROPERTY OF Warfront.com 12/17/2018			DO NOT: DISTRIBUTE, COPY, SELL

--VENDOR
--Created With: SWG Talk Dirty ver(0.B.02) 	Updated: 12/01/2017
--Created By: Nexxus 				UID: lifeday_vendor
--Date Created: 12/17/2018			File Path: /home/swgemu/Desktop
--Vendor Description:desc


-- lifeday_vendor convoTemplate
--Template Initialization
lifeday_vendor_convo_template = ConvoTemplate:new {
   initialScreen = "first_screen",
   templateType = "Lua",
   luaClassHandler = "lifeday_vendor_convo_handler",
   screens = {}
}

-- Main Screen
lifeday_vendor_convo_first_screen = ConvoScreen:new {
   id = "first_screen",
   customDialogText = "Hi! I'm Krispie Kringle, your HOLIDAY LIFE DAY VENDOR! I will happly echange my items for your HOLIDAY CURRENCY",
   stopConversation = "false",
   options = {
	{"[View Options]", "purchase"}
   }
}
lifeday_vendor_convo_template:addScreen(lifeday_vendor_convo_first_screen);

-- purchase
lifeday_vendor_convo_purchase = ConvoScreen:new {
	id = "purchase",
	customDialogText = "Happy Life Day!",
	stopConversation = "true",
	options = {}
}
lifeday_vendor_convo_template:addScreen(lifeday_vendor_convo_purchase);

-- error
lifeday_vendor_convo_error = ConvoScreen:new {
	id = "error",
	customDialogText = "I am busy at the moment...",
	stopConversation = "true",
	options = {}
}
lifeday_vendor_convo_template:addScreen(lifeday_vendor_convo_error);

-- Finalize template
addConversationTemplate("lifeday_vendor_convo_template", lifeday_vendor_convo_template);

--		PROPERTY OF Warfront.com 12/17/2018			DO NOT: DISTRIBUTE, COPY, SELL
