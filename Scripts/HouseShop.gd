extends ScrollContainer


func _ready():
	
	var main_container = get_node("Control/VboxPrincipalVShop")

	for i in range(len(GlobalVariables.player.JuiceHouse)):
		var house_container = VBoxContainer.new()
		main_container.add_child(house_container)

		var house = GlobalVariables.player.JuiceHouse[i]
		
		var house_image = TextureRect.new()
		house_image.texture = house.skin
		house_container.add_child(house_image)
		
		var info_container = HBoxContainer.new()
		house_container.add_child(info_container)
		
		var house_name = Label.new()
		house_name.text = house.name
		info_container.add_child(house_name)

		var house_cost = Label.new()
		house_cost.text = str(house.cost)
		info_container.add_child(house_cost)

		var house_capacity = Label.new()
		house_capacity.text = str(house.capacity)
		info_container.add_child(house_capacity)

		var button = Button.new()
		button.text = "Buy"
		house_container.add_child(button)
