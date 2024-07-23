# Carvery Job
A standalone Carvery Job utilising ox_lib. Locations and ingredients are configurable through config.lua.

# Dependencies
- ox_lib
- qb-menu

# Extras and Info
Add to items.lua:
```
-- Carvery Job
    orange 			         = {name = 'orange', 			 	    label = 'Orange', 		        weight = 0, 		type = 'item', 		image = 'orange.png', 	        unique = false, 	useable = false, 	shouldClose = false,	   combinable = nil,   description = 'Something to Eat!'},
    apple 			         = {name = 'apple', 			 	    label = 'Apple', 		        weight = 0, 		type = 'item', 		image = 'apple.png', 	        unique = false, 	useable = false, 	shouldClose = false,	   combinable = nil,   description = 'Something to Eat!'},
    carrot 			         = {name = 'carrot', 			 	    label = 'Carrot', 		        weight = 0, 		type = 'item', 		image = 'carrot.png', 	        unique = false, 	useable = false, 	shouldClose = false,	   combinable = nil,   description = 'Something to Eat!'},
	flour 				 = {name = 'flour', 			  	label = 'Flour', 			weight = 0, 		type = 'item', 		image = 'wheatflour.png', 		unique = false, 	useable = false, 	shouldClose = false,	   combinable = nil,   description = 'Something to Eat!'},
	sugarpacket 			 = {name = 'sugarpacket', 			  	label = 'Sugar Packet', 		weight = 0, 		type = 'item', 		image = 'sugarpacket.png', 		unique = false, 	useable = false, 	shouldClose = false,	   combinable = nil,   description = 'Something to Eat!'},
	applejuice 				 = {name = 'applejuice', 			  	label = 'Apple Juice', 			weight = 0, 		type = 'item', 		image = 'applejuice.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = 'Something to Drink!'},
	orangejuice 			 = {name = 'orangejuice', 			  	label = 'Orange Juice', 		weight = 0, 		type = 'item', 		image = 'orangejuice.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = 'Something to Drink!'},
	peas 			 = {name = 'peas', 			  	label = 'Peas', 		weight = 0, 		type = 'item', 		image = 'peas.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	oil 			 = {name = 'oil', 			  	label = 'Oil', 		weight = 0, 		type = 'item', 		image = 'oil.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	yorkshires 			 = {name = 'yorkshires', 			  	label = 'Yorkshire Pudding', 		weight = 0, 		type = 'item', 		image = 'yorkshires.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	roastpotato 			 = {name = 'roastpotato', 			  	label = 'Roast Potato', 		weight = 0, 		type = 'item', 		image = 'roastpotato.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	beefjoint			 = {name = 'beefjoint', 			  	label = 'Beef Joint', 		weight = 0, 		type = 'item', 		image = 'beefjoint.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	roastchicken 			 = {name = 'roastchicken', 			  	label = 'Roast Chicken', 		weight = 0, 		type = 'item', 		image = 'roastchicken.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	roastgammon 			 = {name = 'roastgammon', 			  	label = 'Roast Gammon', 		weight = 0, 		type = 'item', 		image = 'roastgammon.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	broccoli 			 = {name = 'broccoli', 			  	label = 'Broccoli', 		weight = 0, 		type = 'item', 		image = 'broccoli.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	yeast 			 = {name = 'yeast', 			  	label = 'Yeast', 		weight = 0, 		type = 'item', 		image = 'yeast.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	beefstock 			 = {name = 'beefstock', 			  	label = 'Beef Stock', 		weight = 0, 		type = 'item', 		image = 'beefstock.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	egg 			 = {name = 'egg', 			  	label = 'Egg', 		weight = 0, 		type = 'item', 		image = 'egg.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	gravy 			 = {name = 'gravy', 			  	label = 'Gravy', 		weight = 0, 		type = 'item', 		image = 'gravy.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	mixedcarvery 			 = {name = 'mixedcarvery', 			  	label = 'Mixed Carvery', 		weight = 0, 		type = 'item', 		image = 'mixedcarvery.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	veggiecarvery 			 = {name = 'veggiecarvery', 			  	label = 'Veggie Carvery', 		weight = 0, 		type = 'item', 		image = 'veggiecarvery.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	beefcarvery 			 = {name = 'beefcarvery', 			  	label = 'Beef Carvery', 		weight = 0, 		type = 'item', 		image = 'beefcarvery.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	chickencarvery 			 = {name = 'chickencarvery', 			  	label = 'Chicken Carvery', 		weight = 0, 		type = 'item', 		image = 'chickencarvery.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
	gammoncarvery 			 = {name = 'gammoncarvery', 			  	label = 'Gammon Carvery', 		weight = 0, 		type = 'item', 		image = 'gammoncarvery.png', 		unique = false, 	useable = true, 	shouldClose = false,	   combinable = nil,   description = ''},
```

If using seperate multijob remove from cl_carvery:
```
RegisterNetEvent('stag_carvery:ToggleDuty', function()
    TriggerServerEvent('QBCore:ToggleDuty')
end)
```
