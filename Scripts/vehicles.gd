extends ScrollContainer

var player = load("res://Save/PlayerSave.tres")
var item_scene = preload("res://Scenes/GarageItem.tscn")
@onready var main_container = $VBoxContainer

func fill_vehicle_list():
	
	for item in main_container.get_children():
		item.queue_free()
	
	for i in range(player.slots):
		
		var vehicle_id = player.get("transport" + str(i) + "Id")
		var item = item_scene.instantiate()
		main_container.add_child(item)
		item.slot = i
		
		if vehicle_id != null and vehicle_id != 0:
			var vehicle = player.Transport[vehicle_id - 1]
			item.data = vehicle
			item.get_node("Panel").visible = true
			item.image.texture = vehicle.skin
			item.vehicle.text = vehicle.name
			item.capacity.text = "Capacity: " + str(vehicle.capacity)
			item.cost.visible = false
			item.upgrade_button.pressed.connect(Callable(_on_upgrade_button_pressed).bind(item.slot, item))
		elif i == 0 or (i > 0 and player.get("transport" + str(i - 1) + "Id") != null and player.get("transport" + str(i - 1) + "Id") != 0):
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
