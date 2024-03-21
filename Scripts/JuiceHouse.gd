extends Node2D

var house_item_scene := preload("res://Scenes/JuiceHouseItem.tscn")
var catalog_item_scene := preload("res://Scenes/JuiceHouseCatalogItem.tscn")

@onready var house_list := $"Menus/HouseList/ScrollContainer/VBoxContainer"
@onready var house_catalog := $"Menus/HouseCatalog/ScrollContainer/VBoxContainer"

var bars = [null,null, null, null]
var player_houses : Array

func _ready():
	
	player_houses = []
	
	# Clean panel
	for item in house_list.get_children():
		house_list.remove_child(item)
	
	# Create slots
	for i in range(4):
		var house_item := house_item_scene.instantiate()
		add_house(house_item)
		player_houses.append(house_item)
	
	loadHouses()
	
	GlobalVariables.loadResource()
	SignalManager.loadHouses.connect(loadHouses)

	connect_house_buttons()
	
func _process(delta):
	update_cpacity()
	
	
func connect_house_buttons():
	for i in range(4):
		var id : int = GlobalVariables.player.CurrentJuiceHouse[i].type
		player_houses[i].get_node("Owned/Button").pressed.connect(Callable(show_upgrades).bind(i))
		player_houses[i].get_node("Empty/Button").pressed.connect(Callable(show_catalog).bind(i))
		player_houses[i].get_node("Owned/Button2").pressed.connect(Callable(level_up).bind(i))

func loadHouses():
	
	# Display slot info
	for i in range(4):
		var id : int = GlobalVariables.player.CurrentJuiceHouse[i].type
		player_houses[i].get_node("Empty").visible = not bool(id)
		player_houses[i].get_node("Owned").visible = bool(id)
		player_houses[i].get_node("Owned/Label").text = GlobalVariables.player.JuiceHouse[id-1].name
		player_houses[i].get_node("Owned/Texture").texture = GlobalVariables.player.JuiceHouse[id-1].skin
		player_houses[i].get_node("Owned/Label3").text = "Level " + str( GlobalVariables.player.CurrentJuiceHouse[i].upgradeLvl)
		
		# Level up or upgrade
		var level = GlobalVariables.player.CurrentJuiceHouse[i].upgradeLvl
		if level < 4:
			player_houses[i].get_node("Owned/Button").hide()
			player_houses[i].get_node("Owned/Button2").show()
			
		else:
			player_houses[i].get_node("Owned/Button2").hide()
			player_houses[i].get_node("Owned/Button").show()
		
		# Special Juiceverse animation
		if id == 19:
			player_houses[i].get_node("Owned/Texture").visible = false
			player_houses[i].get_node("Owned/UniverseAnimatedTexture").visible = true
			
		bars[i] = player_houses[i].get_node("Owned/ProgressBar")
		

		if id == 0:
			player_houses[i].hide()
			
		if i > 0:
			if GlobalVariables.player.CurrentJuiceHouse[ i - 1 ].type > 0:
				player_houses[i].show()

	# load Physical houses
	get_parent().get_parent().load_houses()

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
		
		if item.cost[0] > GlobalVariables.player.money or i > ( GlobalVariables.player.CurrentJuiceHouse[id].type ):
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
		catalog_item.get_node("Cost").text = "$ " + GlobalVariables.getMoneyString(item.cost[0])
		catalog_item.get_node("Capacity").text = "Capacity: " + GlobalVariables.getMoneyString(item.capacity) + " liters"
		catalog_item.get_node("Button").text = 'Upgrade'
		catalog_item.get_node("Button").pressed.connect(Callable(upgradeHouse).bind(id, i))
			
		if item.cost[0] > GlobalVariables.player.money or i > ( GlobalVariables.player.CurrentJuiceHouse[id].type ):
			catalog_item.get_node("Button").disabled = true
		
		if item.name == "Pocket Juiceverse":
			catalog_item.get_node("Texture").visible = false
			catalog_item.get_node("UniverseAnimatedTexture").visible = true
		
		if i >= GlobalVariables.player.CurrentJuiceHouse[id].type:
			house_catalog.add_child(catalog_item)
	
	house_catalog.get_node("../").scroll_vertical = 0.0


func buyHouse(slot:int, index : int):
	var money = GlobalVariables.player.money
	var cost = GlobalVariables.player.JuiceHouse[index].cost[0]
	var capacity = GlobalVariables.player.JuiceHouse[index].capacity
	if money >= cost:
		GlobalVariables.player.CurrentJuiceHouse[slot].set("type", index + 1)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("upgradeLvl", 1)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("currentCapacity", capacity * GlobalVariables.house_capacity_multiplier) 
		GlobalVariables.save()
	$AnimationPlayer.play("HideCatalog")
	GlobalVariables.save()
	
	# load Physical houses
	get_parent().get_parent().load_houses()
	
	print("House capacity: " + str( GlobalVariables.player.CurrentJuiceHouse[slot].currentCapacity ))

func upgradeHouse(slot:int, index : int):
	var money = GlobalVariables.player.money
	var cost = GlobalVariables.player.JuiceHouse[index].cost[0]
	var capacity = GlobalVariables.player.JuiceHouse[index].capacity
	if money >= cost:
		GlobalVariables.player.CurrentJuiceHouse[slot].set("type", index + 1)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("upgradeLvl", 1)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("currentCapacity", capacity * GlobalVariables.house_capacity_multiplier) 
		GlobalVariables.save()
	$AnimationPlayer.play("HideCatalog")
	GlobalVariables.save()
	
	# load Physical houses
	get_parent().get_parent().load_houses()
	
	print("House capacity: " + str( GlobalVariables.player.CurrentJuiceHouse[slot].currentCapacity ))

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
	
	GlobalVariables.save()
	
	# load Physical houses
	get_parent().get_parent().load_houses()
	


func _on_close_pressed():
	loadHouses()
	$AnimationPlayer.play("HideCatalog")
	
func level_up(slot:int):
	var house_type = GlobalVariables.player.CurrentJuiceHouse[slot].type
	if house_type > 18:
		return
	
	var current_level = GlobalVariables.player.CurrentJuiceHouse[slot].upgradeLvl
	var cost : float = GlobalVariables.player.JuiceHouse[house_type].cost[current_level]
	var capacity = GlobalVariables.player.CurrentJuiceHouse[slot].currentCapacity
	if GlobalVariables.player.money > cost:
		GlobalVariables.player.set("money", float(GlobalVariables.player.money) - cost)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("upgradeLvl", current_level+1)
		GlobalVariables.player.CurrentJuiceHouse[slot].set("currentCapacity", capacity * 1.1) 
		player_houses[slot].get_node("AnimationPlayer").play("level_up")
		
#		player_houses[slot].hide()
		GlobalVariables.save()
#		print(GlobalVariables.player.money)
	loadHouses()
	
	print("House capacity: " + str( GlobalVariables.player.CurrentJuiceHouse[slot].currentCapacity ))

func reset():

	for i in GlobalVariables.player.CurrentJuiceHouse.size():
		GlobalVariables.player.CurrentJuiceHouse[i].houseLvl = 0
		GlobalVariables.player.CurrentJuiceHouse[i].upgradeLvl = 0
		GlobalVariables.player.CurrentJuiceHouse[i].type = 0
		GlobalVariables.player.CurrentJuiceHouse[i].currentCapacity = 0.0
		for j in GlobalVariables.player.CurrentJuiceHouse[i].juice_liters.size():
			GlobalVariables.player.CurrentJuiceHouse[i].juice_liters[j] = 0.0
	buyHouse(0, 0)
	loadHouses()
	
func update_cpacity():
	for i in bars.size():
		var bar = bars[i]
		if bar != null:
			bar.value = 100 * ( GlobalVariables.player.CurrentJuiceHouse[i].used_space() / GlobalVariables.player.CurrentJuiceHouse[i].currentCapacity )
