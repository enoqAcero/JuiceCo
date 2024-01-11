extends Node2D

var player

var EmptyHouseButtonNodePath = "Panel/VBoxContainer/BuildHouse"
var UpgradeHouseButtonNodePath = "Panel/Upgrade"

###house variables
var houseNamePath = "Panel/VBoxContainer/Name"
var houseProgressBarPath = "Panel/VBoxContainer/HBoxContainer/ProgressBar"
var houseSpritePath = "Panel/Sprite2D"
####house 0 variables
var houseID0
var house0Name
var house0ProgressBar
var house0Sprite
####house 1 variables
var houseID1
var house1Name
var house1ProgressBar
var house1Sprite
####house 2 variables
var houseID2
var house2Name
var house2ProgressBar
var house2Sprite
####house 3 variables
var houseID3
var house3Name
var house3ProgressBar
var house3Sprite

func _ready():
	$Empty1.get_node(EmptyHouseButtonNodePath).pressed.connect(Callable(buyHouse).bind(0))
	$Empty2.get_node(EmptyHouseButtonNodePath).pressed.connect(Callable(buyHouse).bind(1))
	$Empty3.get_node(EmptyHouseButtonNodePath).pressed.connect(Callable(buyHouse).bind(2))
	$Empty4.get_node(EmptyHouseButtonNodePath).pressed.connect(Callable(buyHouse).bind(3))
	$House1.get_node(UpgradeHouseButtonNodePath).pressed.connect(Callable(upgradeHouse).bind(0))
	$House2.get_node(UpgradeHouseButtonNodePath).pressed.connect(Callable(upgradeHouse).bind(1))
	$House3.get_node(UpgradeHouseButtonNodePath).pressed.connect(Callable(upgradeHouse).bind(2))
	$House4.get_node(UpgradeHouseButtonNodePath).pressed.connect(Callable(upgradeHouse).bind(3))
	
	####house 1 variables
	house0Name = $House1.get_node(houseNamePath)
	house0ProgressBar = $House1.get_node(houseProgressBarPath)
	house0Sprite = $House1.get_node(houseSpritePath)
	####house 2 variables
	house1Name = $House2.get_node(houseNamePath)
	house1ProgressBar = $House2.get_node(houseProgressBarPath)
	house1Sprite = $House2.get_node(houseSpritePath)
	####house 3 variables
	house2Name = $House3.get_node(houseNamePath)
	house2ProgressBar = $House3.get_node(houseProgressBarPath)
	house2Sprite = $House3.get_node(houseSpritePath)
	####house 4 variables
	house3Name = $House4.get_node(houseNamePath)
	house3ProgressBar = $House4.get_node(houseProgressBarPath)
	house3Sprite = $House4.get_node(houseSpritePath)
	
	loadData()

#Carga y actualiza la casa correspondiente actual
func loadHouses():
	print("LOad HOuse")
	houseID0 = player.house0Id - 1
	houseID1 = player.house1Id - 1
	houseID2 = player.house2Id - 1
	houseID3 = player.house3Id - 1
	
	if houseID0 < 0:
		$Empty1.show()
		$House1.hide()
	else:
		$Empty1.hide()
		$House1.show()
		house0Name.text =  player.JuiceHouse[houseID0].name
		
	if houseID1 < 0:
		$Empty2.show()
		$House2.hide()
	else:
		$Empty2.hide()
		$House2.show()
		house1Name.text =  player.JuiceHouse[houseID1].name
		
	if houseID2 < 0:
		$Empty3.show()
		$House3.hide()
	else:
		$Empty3.hide()
		$House3.show()
		house2Name.text =  player.JuiceHouse[houseID2].name
		
	if houseID3 < 0:
		$Empty4.show()
		$House4.hide()
	else:
		$Empty4.hide()
		$House4.show()
		house3Name.text =  player.JuiceHouse[houseID3].name
	save()
	
#funcion cuando se compra una casa cuando antes no se tenia nada
func buyHouse(index : int):
	print("BUYHOUSE",index)

	if index == 0:
		player.house0Id += 1
	elif index == 1:
		player.house1Id += 1
	elif index == 2:
		player.house2Id += 1
	elif index == 3:
		player.house3Id += 1
	loadHouses()
		
	
#funcion cuando se quiere mejorar una casa que ya existe
func upgradeHouse(index : int):
	player.house0Id += 1
	loadHouses()
	
	



func _on_close_pressed():
	hide()
	
func save():
	ResourceSaver.save(player, "res://Save/PlayerSave.tres")

func loadData():
	if ResourceLoader.exists("res://Save/PlayerSave.tres"):
		player = ResourceLoader.load("res://Save/PlayerSave.tres")
	else:
		var newPlayerData = Player.new()
		ResourceSaver.save(newPlayerData, ("res://Save/PlayerSave.tres"))
		player = ResourceLoader.load("res://Save/PlayerSave.tres")
		
	loadHouses()
