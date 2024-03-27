extends ScrollContainer


var item_scene = preload("res://Scenes/GarageItem.tscn")
@onready var main_container = $VBoxContainer

func fill_vehicle_list():
	
	for item in main_container.get_children():
		item.queue_free()
	
	for i in range(GlobalVariables.player.Vehicles.size()):
		
		var vehicle_id = GlobalVariables.player.Vehicles[i]
		var item = item_scene.instantiate()
		main_container.add_child(item)
		item.slot = i
		
		if vehicle_id != 0:
			var vehicle = GlobalVariables.player.Transport[vehicle_id - 1]
			item.data = vehicle
			item.get_node("Panel").visible = true
			item.image.texture = vehicle.skin
			item.vehicle.text = vehicle.name
			item.capacity.text = "Capacity: " + str(vehicle.capacity)
			item.cost.visible = false
			item.upgrade_button.pressed.connect(Callable(_on_upgrade_button_pressed).bind(item.slot, item))
		elif i == 0 or (i > 0 and GlobalVariables.player.Vehicles[ i-1 ] != 0):
			item.get_node("PanelBuyVehicle/Button").pressed.connect(Callable(_on_purchase_button_pressed).bind(item.slot))
			item.get_node("PanelBuyVehicle").visible = true
		else:
			item.get_node("PanelEmpty").visible = true

func _on_purchase_button_pressed(slot:int):
	$"../../VehicleCatalog/ScrollContainer".fill_vehicle_catalog("Buy", slot)
	$"../../AnimationPlayer".play("ven2")
	
func _on_upgrade_button_pressed(slot:int, item):
	$"../../VehicleCatalog/ScrollContainer".fill_vehicle_catalog("Upgrade", slot, item)
	$"../../AnimationPlayer".play("ven2")
