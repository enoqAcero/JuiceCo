extends Node2D

@onready var item_scene := load("res://Scenes/PurchaseItem.tscn")
@onready var upgrades_list := $Panel/ScrollContainer/VBoxContainer

func _ready():
	reset()
	fill_upgrades_list()
	
func fill_upgrades_list():
	
	clean_list()
	
	for i in GlobalVariables.player.Upgrades.size():
		
		var upgrade = GlobalVariables.player.Upgrades[i]
		
		if upgrade.epic or upgrade.active:
			continue
		
		var item = item_scene.instantiate()

		item.get_node("Icon").texture = upgrade.skin
		item.get_node("Button").text = GlobalVariables.getMoneyString( upgrade.cost )
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
	
	if GlobalVariables.player.money >= GlobalVariables.player.Upgrades[index].cost:
		GlobalVariables.player.money -= GlobalVariables.player.Upgrades[index].cost
		if epic:
			GlobalVariables.player.Upgrades[index].epic_active = true
			fill_epic_upgrades_list()
		else:
			GlobalVariables.player.Upgrades[index].active = true
			fill_upgrades_list()
			
	

func _on_close_button_pressed():
	hide()


func _on_button_pressed():
	fill_upgrades_list()


func _on_button_2_pressed():
	fill_epic_upgrades_list()

func reset():
	for upgrade in GlobalVariables.player.Upgrades:
		upgrade.active = false
		upgrade.epic_active = false
