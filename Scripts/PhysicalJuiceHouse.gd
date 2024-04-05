extends StaticBody2D

func _ready():
	
	if GlobalVariables.player.CurrentJuiceHouse[0].type == 0:
		get_parent().get_node("CanvasLayer/JuiceHouse").buyHouse(0, 0)
	
	for item in get_children():
		if item is Sprite2D:
			item.hide()
		if item is Sprite2D:
			item.get_node("Button").pressed.connect(get_parent().juice_house_menu)

func show_type(i:int):
	for item in get_children():
		if item is Sprite2D:
			item.hide()
	get_node("type" + str(i)).show()

func _on_area_2d_body_entered(fruit):
	if fruit.is_in_group("Fruit"):
		var house = GlobalVariables.player.CurrentJuiceHouse[ fruit.house ]
		var fruit_id = fruit.fruit_number
		var liters_on_house = house.juice_liters[ fruit.fruit_number ] 
		var liters_allowed = house.available_space()
#		print( str(fruit.liters) + " liters stored in house " + str(fruit.house))
#		print( str( liters_on_house + fruit.liters ) + " liters in total" )
		GlobalVariables.player.CurrentJuiceHouse[ fruit.house ].juice_liters[ fruit.fruit_number ] = liters_on_house + min( liters_allowed, fruit.liters )
		if min( liters_allowed, fruit.liters ) > 0:
			get_tree().get_root().get_node('Main/Liters' + str( fruit.house + 1 ) ).text = '+' + GlobalVariables.getMoneyString( min( liters_allowed, fruit.liters )  ) + ' Lts'
		else:
			get_tree().get_root().get_node('Main/Liters' + str( fruit.house + 1 ) ).text = 'No space'
		
		if get_tree().get_root().get_node('Main/Liters' + str( fruit.house + 1) + '/AnimationPlayer').is_playing():
			get_tree().get_root().get_node('Main/Liters' + str( fruit.house + 1) + '/AnimationPlayer').stop()
		get_tree().get_root().get_node('Main/Liters' + str( fruit.house + 1) + '/AnimationPlayer').play('appear')
		GlobalVariables.save()
		get_parent().get_node("CanvasLayer/JuiceHouse").loadHouses()
		fruit.queue_free()
		
	
		
