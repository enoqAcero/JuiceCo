extends Node2D

@onready var item_scene := load("res://Scenes/PurchaseItem.tscn")
@onready var upgrades_list := $Panel/ScrollContainer/VBoxContainer

func _ready():

	initialize_upgrades()

	fill_upgrades_list()

func fill_upgrades_list():
	
	clean_list()
	
	for i in GlobalVariables.player.Upgrades.size():
		
		var upgrade = GlobalVariables.player.Upgrades[i]
		
		if upgrade == null:
			GlobalVariables.player.Upgrades[i] = UpdateData.new()
			upgrade = GlobalVariables.player.Upgrades[i]
			
		if upgrade.epic or upgrade.active:
			continue
		
		var item = item_scene.instantiate()

		item.get_node("Icon").texture = upgrade.skin
		item.get_node("Button").text = GlobalVariables.getMoneyString( upgrade.cost * GlobalVariables.upgrade_cost_multiplier )
		item.get_node("Button").show()
		item.get_node("ButtonEpic").hide()
		item.get_node("Name").text = upgrade.name
		item.get_node("Description").text = upgrade.description

		if upgrade.cost > GlobalVariables.player.money:
			item.get_node("Button").disabled = true

		else:
			item.get_node("Button").pressed.connect( Callable(buy_upgrade).bind( i, false ) )

		upgrades_list.add_child( item )

func fill_epic_upgrades_list():
	
	clean_list()
	
	for i in GlobalVariables.player.Upgrades.size():
		
		var upgrade = GlobalVariables.player.Upgrades[i]
		
		if not upgrade.epic or upgrade.epic_active:
			continue

		var item = item_scene.instantiate()

		item.get_node("Icon").texture = upgrade.skin
		item.get_node("ButtonEpic").text = GlobalVariables.getMoneyString( upgrade.cost )
		item.get_node("Button").hide()
		item.get_node("ButtonEpic").show()
		item.get_node("Name").text = upgrade.name
		item.get_node("Description").text = upgrade.description

		if upgrade.cost > GlobalVariables.player.money:
			
			item.get_node("ButtonEpic").disabled = true

		else:
			item.get_node("ButtonEpic").pressed.connect( Callable(buy_upgrade).bind( i, true ) )
		
		upgrades_list.add_child( item )

func clean_list():
	for item in upgrades_list.get_children():
		item.queue_free()

func buy_upgrade(index:int, epic:bool):
	
	var upgrade = GlobalVariables.player.Upgrades[index]
	
	
	print(index)	
	
	if GlobalVariables.player.money >= upgrade.cost * GlobalVariables.upgrade_cost_multiplier:
		GlobalVariables.player.money -= upgrade.cost * GlobalVariables.upgrade_cost_multiplier
		if epic:
			GlobalVariables.player.Upgrades[index].epic_active = true
			fill_epic_upgrades_list()
		else:
			GlobalVariables.player.Upgrades[index].active = true
			fill_upgrades_list()
		enable_feature_upgrade( index, true )
		GlobalVariables.save()

func initialize_upgrades():

	for i in range( GlobalVariables.player.Upgrades.size() ):
		
		var upgrade = GlobalVariables.player.Upgrades[i]
		if upgrade.active or upgrade.epic_active:
			enable_feature_upgrade( i, true )

func enable_feature_upgrade( index, enable ):
	var upgrade = GlobalVariables.player.Upgrades[ index ]
	match upgrade.type:
		GlobalVariables.UpgradeType.FEATURE:
			match index:
				0: # Enable the fruit race switch
					var run_switch = get_parent().get_node("runButton")
					run_switch.toggle_mode = enable
					run_switch.button_pressed = enable
					if not enable:
						run_switch.get_node("SwitchTimer").stop()
						print( "Disabling switch" )
		
		GlobalVariables.UpgradeType.FARMER:
			pass
		GlobalVariables.UpgradeType.FRUIT_PRODUCTION:
			if upgrade.target == -1:
				GlobalVariables.production_multiplier *= upgrade.multiplier
			else:
				GlobalVariables.fruit_production_multiplier[ upgrade.target ] *= upgrade.multiplier
			
		GlobalVariables.UpgradeType.VEHICLE_CAPACITY:
			GlobalVariables.vehicle_capacity_multiplier *= upgrade.multiplier
			
		GlobalVariables.UpgradeType.HOUSE_CAPACITY:
			GlobalVariables.house_capacity_multiplier *= upgrade.multiplier
			for i in GlobalVariables.player.CurrentJuiceHouse.size():
				if GlobalVariables.player.CurrentJuiceHouse[i].type >= 0:
					GlobalVariables.player.CurrentJuiceHouse[i].currentCapacity *= GlobalVariables.house_capacity_multiplier
			
		GlobalVariables.UpgradeType.JUICE_VALUE:
			GlobalVariables.juice_value_multiplier *= upgrade.multiplier
			
		GlobalVariables.UpgradeType.JUICE_PRODUCTION:
			GlobalVariables.juice_production_multiplier *= upgrade.multiplier
			
		GlobalVariables.UpgradeType.RACE_SPEED:
			GlobalVariables.fruit_race_multiplier *= upgrade.multiplier
			
		GlobalVariables.UpgradeType.RACE_SPAWN:
			GlobalVariables.race_spawn_multiplier *= upgrade.multiplier
			
		GlobalVariables.UpgradeType.UPGRADE_COST:
			GlobalVariables.upgrade_cost_multiplier *= upgrade.multiplier

func _on_close_button_pressed():
	hide()

func _on_button_pressed():
	fill_upgrades_list()

func _on_button_2_pressed():
	fill_epic_upgrades_list()

func reset():
	for i in GlobalVariables.player.Upgrades.size():
		var upgrade = GlobalVariables.player.Upgrades[i]
		if upgrade != null:
			GlobalVariables.player.Upgrades[i].active = false
#			GlobalVariables.player.Upgrades[i].epic_active = false
			
			if upgrade.type == GlobalVariables.UpgradeType.FEATURE and not upgrade.epic:
				enable_feature_upgrade(i, false)
			
			GlobalVariables.save()

	fill_upgrades_list()
