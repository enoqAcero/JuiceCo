extends ScrollContainer

var player = load("res://Save/PlayerSave.tres")
var item = preload("res://Scenes/GarageItem.tscn")

func _ready():
	var main_container = $VBoxContainer

	for i in range(player.slots):
#		var slot = VBoxContainer.new()
		var slot = item.instantiate()
		main_container.add_child(slot)

		var vehicle_id = player.get("transport" + str(i) + "Id")
		if vehicle_id != null and vehicle_id != 0:
			
			slot.get_node("Panel").visible = true
			
			var vehicle = player.Transport[vehicle_id - 1]
#			var vehicle_image = TextureRect.new()
#			vehicle_image.texture = vehicle.skin
#			slot.add_child(vehicle_image)
			slot.image.texture = vehicle.skin

#			var name_text = HBoxContainer.new()
#			slot.add_child(name_text)
#			var vehicle_name = Label.new()
#			vehicle_name.text = vehicle.name
#			name_text.add_child(vehicle_name)
			slot.vehicle.text = vehicle.name
			
#			var capacity_text = HBoxContainer.new()
#			slot.add_child(capacity_text)
#			var vehicle_capacity = Label.new()
#			vehicle_capacity.text = str(vehicle.capacity)
#			capacity_text.add_child(vehicle_capacity)
			slot.capacity.text = "Capacity: " + str(vehicle.capacity)
			
			#Cost not necessary on already purchassed vehicles
			slot.cost.visible = false

#			var button = Button.new()
#			button.text = "Upgrade"
#			button.pressed.connect(_on_button_pressed)
#			slot.add_child(button)
			slot.upgrade_button.pressed.connect(_on_button_pressed)
			
		elif i == 0 or (i > 0 and player.get("transport" + str(i - 1) + "Id") != null and player.get("transport" + str(i - 1) + "Id") != 0):
#			var button = Button.new()
#			button.text = "Comprar vehículo"
			slot.get_node("PanelBuyVehicle/Button").pressed.connect(_on_button_pressed)
			slot.get_node("PanelBuyVehicle").visible = true
		else:
			var available_label = Label.new()
			available_label.text = "Disponible para un coche"
			slot.get_node("PanelEmpty").visible = true
#			slot.add_child(available_label)

func _on_button_pressed():
	
	#$"../Node2D".position.x= 20
	#$".".position.x= -500
	$"../../AnimationPlayer".play("ven2")
	#var garage = get_tree().get_node("CanvasLayer/Garage")
	#print(garage)
	#garage.position.x = -500
