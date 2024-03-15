extends StaticBody2D

func _ready():
	
	if GlobalVariables.player.CurrentJuiceHouse[0].type == 0:
		get_parent().get_node("CanvasLayer/JuiceHouse").buyHouse(0, 0)
	
	for item in get_children():
		item.hide()
		if item is Sprite2D:
			item.get_node("Button").pressed.connect(get_parent().juice_house_menu)

func show_type(i:int):
	for item in get_children():
		item.hide()
	get_node("type" + str(i)).show()

func _on_area_2d_body_entered(fruit):
	if fruit.is_in_group("Fruit"):
		var fruit_id = fruit.fruit_number
		var liters_on_house = GlobalVariables.player.CurrentJuiceHouse[ fruit.house ].juice_liters[ fruit.fruit_number ] 
		print( str(fruit.liters) + " liters stored in house " + str(fruit.house))
		print( str( liters_on_house + fruit.liters ) + " liters in total" )
		GlobalVariables.player.CurrentJuiceHouse[ fruit.house ].juice_liters[ fruit.fruit_number ] = liters_on_house + fruit.liters
		GlobalVariables.save()
		get_parent().get_node("CanvasLayer/JuiceHouse").loadHouses()
		fruit.queue_free()
		
	
		
