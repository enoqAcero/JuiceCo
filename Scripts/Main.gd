extends Node2D

var playerData : Player
var savePath = "res://Save/PlayerSave.tres"
var controlEscenasField = false
var controlEscenasUpgrades = false
var controlEscenasBoost = false
var controlEscenasMenu = false
var controlEscenasShop = false

# Called when the node enters the scene tree for the first time.
func _ready():
	loadData()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func loadData():
	if ResourceLoader.exists(savePath):
		playerData = ResourceLoader.load(savePath)
	else:
		var newPlayerData = Player.new()
		ResourceSaver.save(newPlayerData, (savePath))
		playerData = ResourceLoader.load(savePath)
	
func save():
	ResourceSaver.save(playerData, savePath)
	
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		save()
	

# Oculta todas las escenas
func hideScene():
	$CanvasLayer/Field.visible = false
	$CanvasLayer/Upgrades.visible = false
	$CanvasLayer/Boost.visible = false
	$CanvasLayer/Menu.visible = false
	$CanvasLayer/Shop.visible = false

# Muestra la escena especificada
func showScene(scene, controlEscenas):
	hideScene()
	if !controlEscenas:
		scene.visible = true
	return !controlEscenas

#Abir Field
func _on_field_button_pressed():
	controlEscenasField = showScene($CanvasLayer/Field, controlEscenasField)

#Abir Upgrades
func _on_upgrade_button_pressed():
	controlEscenasUpgrades = showScene($CanvasLayer/Upgrades, controlEscenasUpgrades)

#Abir Boosts
func _on_boost_button_pressed():
	controlEscenasBoost = showScene($CanvasLayer/Boost, controlEscenasBoost)

#Abir Menu
func _on_menu_button_pressed():
	controlEscenasMenu = showScene($CanvasLayer/Menu, controlEscenasMenu)

#Abir Shop
func _on_shop_button_pressed():
	controlEscenasShop = showScene($CanvasLayer/Shop, controlEscenasShop)






func _on_button_pressed():
	$CanvasLayer/JuiceHouse.show()
