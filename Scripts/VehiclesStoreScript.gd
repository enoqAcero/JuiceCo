extends ScrollContainer

# Preload garage item template
@onready var item_scene = preload("res://Scenes/GarageItem.tscn")
@onready var main_container = get_node("VBoxContainer")

func fill_vehicle_catalog(transaction:String, slot:int, base_item = null):
	
	var upgrade_found := false
	
	for son in main_container.get_children():
		son.queue_free()
	
	for i in range(len(GlobalVariables.player.Transport)):
		var vehicle = GlobalVariables.player.Transport[i]
		if transaction == "Upgrade":
			
			if vehicle == base_item.data:
				upgrade_found = true
				continue
			
			elif not upgrade_found:
				continue
		
		var item = item_scene.instantiate()
		
		main_container.add_child(item)
		
		item.data = vehicle
		item.get_node("Panel").visible = true
		item.cost.visible = true
		item.image.texture = vehicle.skin
		item.vehicle.text = vehicle.name
		item.cost.text = "Cost: $" + GlobalVariables.getMoneyString(vehicle.cost)
		item.capacity.text = "Capacity: " + GlobalVariables.getMoneyString(vehicle.capacity) + " Lts"
		item.upgrade_button.text = transaction
		item.id = i
		match transaction:
			'Buy':
				item.upgrade_button.pressed.connect(Callable(purchase_vehicle).bind(slot, item))
			'Upgrade':
				item.upgrade_button.pressed.connect(Callable(upgrade_vehicle).bind(slot, item))
				
		if i > ( GlobalVariables.player.Vehicles[ slot ] ):
			item.upgrade_button.disabled = true
	
	scroll_vertical = 0.0

func purchase_vehicle(slot:int, item):
	if GlobalVariables.player.money >= item.data.cost:
		var vehicle_id = GlobalVariables.player.Vehicles[ slot ]
		GlobalVariables.player.Vehicles[ slot ] = item.id + 1
		var remaining_mobey = float(GlobalVariables.player.money) - item.data.cost
		GlobalVariables.player.set('money', remaining_mobey)
		$"../../AnimationPlayer".play("venclose")
	else:
		item.upgrade_button.disabled = true
	GlobalVariables.save()
	get_tree().get_root().get_node("Main").check_garages()
	
func upgrade_vehicle(slot:int, item):
	if GlobalVariables.player.money >= item.data.cost:
		var vehicle_id = GlobalVariables.player.Vehicles[ slot ]
		GlobalVariables.player.Vehicles[ slot ] = item.id + 1
		var remaining_mobey = float(GlobalVariables.player.money) - item.data.cost
		GlobalVariables.player.set('money', remaining_mobey)
		$"../../AnimationPlayer".play("venclose")
	else:
		item.upgrade_button.disabled = true
	get_tree().get_root().get_node("Main").check_garages()
	GlobalVariables.save()

