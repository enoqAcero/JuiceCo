extends Node2D

var house_item_scene := preload("res://Scenes/JuiceHouseItem.tscn")
var catalog_item_scene := preload("res://Scenes/JuiceHouseCatalogItem.tscn")

@onready var house_list := $"Menus/HouseList/ScrollContainer/VBoxContainer"
@onready var house_catalog := $"Menus/HouseCatalog/ScrollContainer/VBoxContainer"

var player_houses : Array

func _ready():
	
	loadHouses()
	
	GlobalVariables.loadResource()
	SignalManager.loadHouses.connect(loadHouses)


func loadHouses():
	
	player_houses = []
	
	# Clean panel
	for item in house_list.get_children():
		house_list.remove_child(item)
	
	# Create slots
	for i in range(4):
		var house_item := house_item_scene.instantiate()
		add_house(house_item)
		player_houses.append(house_item)
	
	# Display slot info
	for i in range(4):
		var id = GlobalVariables.player.get("house"+str(i)+"Id")
		player_houses[i].get_node("Empty").visible = not bool(id)
		player_houses[i].get_node("Owned").visible = bool(id)
		if player_houses[i].get_node("Owned").visible:
			player_houses[i].get_node("Owned/Label").text = GlobalVariables.player.JuiceHouse[id-1].name
			player_houses[i].get_node("Owned/Texture").texture = GlobalVariables.player.JuiceHouse[id-1].skin
			player_houses[i].get_node("Owned/Button").pressed.connect(Callable(show_upgrades).bind(i))
			player_houses[i].get_node("Owned/Label3").text = "Level " + str( GlobalVariables.player.CurrentJuiceHouse[i].upgradeLvl)
		else:
			player_houses[i].get_node("Empty/Button").pressed.connect(Callable(show_catalog).bind(i))
		
		# Levle up or upgrade
		var level = GlobalVariables.player.CurrentJuiceHouse[i].upgradeLvl
		if level < 4:
			player_houses[i].get_node("Owned/Button2").show()
			player_houses[i].get_node("Owned/Button2").pressed.connect(Callable(level_up).bind(i))
		else:
			player_houses[i].get_node("Owned/Button").show()
		
		# Special Juiceverse animation
		if id == 19:
			player_houses[i].get_node("Owned/Texture").visible = false
			player_houses[i].get_node("Owned/UniverseAnimatedTexture").visible = true

func show_catalog(id:int):
	$AnimationPlayer.play("ShowCatalog")
	
	for item in house_catalog.get_children():
		house_catalog.remove_child(item)
	
	var catalog_items = GlobalVariables.player.JuiceHouse
	for i in catalog_items.size():
		var item = catalog_items[i]
		var catalog_item = catalog_item_scene.instantiate()
		catalog_item.get_node("Texture").texture = item.skin
		catalog_item.get_node("Type").text = item.name
		catalog_item.get_node("Cost").text = GlobalVariables.getMoneyString(item.cost[0])
		catalog_item.get_node("Capacity").text = str(item.capacity)
		catalog_item.get_node("Button").text = 'Buy'
		catalog_item.get_node("Button").pressed.connect(Callable(buyHouse).bind(id, i))
		
		if item.cost[0] > GlobalVariables.player.money:
			catalog_item.get_node("Button").disabled = true
		
		if item.name == "Pocket Juiceverse":
			catalog_item.get_node("Texture").visible = false
			catalog_item.get_node("UniverseAnimatedTexture").visible = true

		house_catalog.add_child(catalog_item)
	
	house_list.get_node("../").scroll_vertical = 0.0

func show_upgrades(id:int):
	$AnimationPlayer.play("ShowCatalog")
	for item in house_catalog.get_children():
		house_catalog.remove_child(item)
	
	var catalog_items = GlobalVariables.player.JuiceHouse
	for i in catalog_items.size():
		var item = catalog_items[i]
		var catalog_item = catalog_item_scene.instantiate()
		catalog_item.get_node("Texture").texture = item.skin
		catalog_item.get_node("Type").text = item.name
		catalog_item.get_node("Cost").text = GlobalVariables.getMoneyString(item.cost[0])
		catalog_item.get_node("Capacity").text = str(item.capacity)
		catalog_item.get_node("Button").text = 'Upgrade'
		catalog_item.get_node("Button").pressed.connect(Callable(upgradeHouse).bind(id, i))
		
		if item.cost[0] > GlobalVariables.player.money:
			catalog_item.get_node("Button").disabled = true
		
		if item.name == "Pocket Juiceverse":
			catalog_item.get_node("Texture").visible = false
			catalog_item.get_node("UniverseAnimatedTexture").visible = true
		
		if i > int( GlobalVariables.player.get("house"+str(id)+"Id") ):
			house_catalog.add_child(catalog_item)
	
	house_catalog.get_node("../").scroll_vertical = 0.0


func buyHouse(slot:int, index : int):
	var money = GlobalVariables.player.money
	var cost = GlobalVariables.player.JuiceHouse[index].cost[0]
	if money >= cost:
		GlobalVariables.player.set("house"+str(slot)+"Id", index+1)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("upgradeLvl", 1)
		save()
	$AnimationPlayer.play("HideCatalog")
#	save()

func upgradeHouse(slot:int, index : int):
	var money = GlobalVariables.player.money
	var cost = GlobalVariables.player.JuiceHouse[index].cost[0]
	if money >= cost:
		GlobalVariables.player.set("house"+str(slot)+"Id", index+1)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("upgradeLvl", 1)
		save()
	$AnimationPlayer.play("HideCatalog")
#	save()


func save():
	ResourceSaver.save(GlobalVariables.player, "res://Save/PlayerSave.tres")

func _on_close_button_pressed():
	hide()
	
func add_house(house):
	var container
	if house_list.get_child_count() > 0:
		if house_list.get_child(house_list.get_child_count() - 1).get_child_count() == 2:
			container = HBoxContainer.new()
			house_list.add_child(container)
		else:
			container = house_list.get_child(house_list.get_child_count() - 1)
	else:
		container = HBoxContainer.new()
		house_list.add_child(container)
	
	container.add_child(house)


func _on_close_pressed():
	loadHouses()
	$AnimationPlayer.play("HideCatalog")
	
func level_up(slot:int):
	var house_type = GlobalVariables.player.get("house"+str(slot)+"Id")
	var current_level = GlobalVariables.player.CurrentJuiceHouse[slot].upgradeLvl
	var cost : float = GlobalVariables.player.JuiceHouse[int(house_type)].cost[current_level]
	if GlobalVariables.player.money > cost:
		GlobalVariables.player.set("money", float(GlobalVariables.player.money) - cost)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("upgradeLvl", current_level+1)
		save()
		print(GlobalVariables.player.money)
	loadHouses()
