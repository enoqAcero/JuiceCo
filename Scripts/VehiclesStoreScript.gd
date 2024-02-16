extends ScrollContainer

var item = preload("res://Scenes/GarageItem.tscn")

func _ready():
	
	var main_container = get_node("VBoxContainer")
	

	for i in range(len(GlobalVariables.player.Transport)):
		
		var vehicle = GlobalVariables.player.Transport[i]
		var slot = item.instantiate()
#		var vehicle_container = VBoxContainer.new()
		main_container.add_child(slot)
		slot.get_node("Panel").visible = true
		slot.cost.visible = true
#		var vehicle_image = TextureRect.new()
		slot.image.texture = vehicle.skin
#		vehicle_container.add_child(vehicle_image)
#		vehicle_image.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
		
#		var info_container = HBoxContainer.new()
#		vehicle_container.add_child(info_container)

#		var vehicle_name = Label.new()
#		vehicle_name.text = vehicle.name
#		info_container.add_child(vehicle_name)
		slot.vehicle.text = vehicle.name

#		var vehicle_cost = Label.new()
#		vehicle_cost.text = str(vehicle.cost).substr(0, 4)
#		info_container.add_child(vehicle_cost)
		slot.cost.text = "Cost: " + str(vehicle.cost)

#		var vehicle_capacity = Label.new()
#		vehicle_capacity.text = str(vehicle.capacity)
#		info_container.add_child(vehicle_capacity)
		slot.capacity.text = "Capacity" + str(vehicle.capacity)

#		var button = Button.new()
#		button.text = "Buy"
#		vehicle_container.add_child(button)
		slot.upgrade_button.text = "Buy"

