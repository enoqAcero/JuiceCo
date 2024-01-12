extends ScrollContainer


func _ready():
	
	var main_container = get_node("Control/VboxPrincipalVShop")

	for i in range(len(GlobalVariables.player.Transport)):
		var vehicle_container = VBoxContainer.new()
		main_container.add_child(vehicle_container)

		var vehicle = GlobalVariables.player.Transport[i]
		
		var vehicle_image = TextureRect.new()
		vehicle_image.texture = vehicle.skin
		vehicle_container.add_child(vehicle_image)
		
		var info_container = HBoxContainer.new()
		vehicle_container.add_child(info_container)
		
		var vehicle_name = Label.new()
		vehicle_name.text = vehicle.name
		info_container.add_child(vehicle_name)

		var vehicle_cost = Label.new()
		vehicle_cost.text = str(vehicle.cost)
		info_container.add_child(vehicle_cost)

		var vehicle_capacity = Label.new()
		vehicle_capacity.text = str(vehicle.capacity)
		info_container.add_child(vehicle_capacity)

		var button = Button.new()
		button.text = "Buy"
		vehicle_container.add_child(button)
