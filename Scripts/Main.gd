extends Node2D

var savePath = "res://Save/PlayerSave.tres"
var controlEscenasField = false
var controlEscenasUpgrades = false
var controlEscenasBoost = false
var controlEscenasMenu = false
var controlEscenasShop = false

var litersString : String

var totalTransportCapacity = 0
var totalJuiceHouseCapacity = 0


var fruitScriptPath = preload("res://Scripts/PathFollow.gd")
var mango = preload("res://Scenes/Fruits/Fruit1Path.tscn")
var fruits =[mango, mango]
var fruitInstance = []
var runTimerNode
var runButtonControl = false

# Called when the node enters the scene tree for the first time.
func _ready():

	GlobalVariables.loadResource()
	SignalManager.loadData.connect(loadData)
	
	runTimerNode = $CanvasLayer/runButton/RunTimer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	litersString =  GlobalVariables.getMoneyString(GlobalVariables.player.liters)
	$CanvasLayer/Money.text ="Liters: " + litersString


#obtener la capacidad total de los transportes
func getTotalTransportCapacity():
	var trasportIdArray = [GlobalVariables.player.transport0Id, GlobalVariables.player.transport1Id,GlobalVariables.player.transport2Id,GlobalVariables.player.transport3Id,GlobalVariables.player.transport4Id,GlobalVariables.player.transport5Id,GlobalVariables.player.transport6Id,GlobalVariables.player.transport7Id,GlobalVariables.player.transport8Id,GlobalVariables.player.transport9Id,GlobalVariables.player.transport10Id,GlobalVariables.player.transport11Id,GlobalVariables.player.transport12Id,GlobalVariables.player.transport13Id,GlobalVariables.player.transport14Id]
	
	for i in range (0, trasportIdArray.size()):
		if trasportIdArray[i] >= 1:
			var id = trasportIdArray[i]
			totalTransportCapacity += GlobalVariables.player.Transport[id - 1].capacity
			
#obtener la capacidad total de las casas de jugo
func getJuiceHouseCapacity():
	var houseIdArray = [GlobalVariables.player.house0Id, GlobalVariables.player.house1Id,GlobalVariables.player.house2Id,GlobalVariables.player.house3Id]
	
	for i in range (0, houseIdArray.size()):
		if houseIdArray[i] >= 1:
			var id = houseIdArray[i]
			totalJuiceHouseCapacity += GlobalVariables.player.JuiceHouse[id - 1].capacity
	
#esta  funcion se manda a ejecturar despues de cargar el recurso en la variabale player
#se usa para evitar utilizar una variable antes de cargar los datos de player
func loadData():
	getTotalTransportCapacity()
	getJuiceHouseCapacity()
	
func save():
	ResourceSaver.save(GlobalVariables.player, savePath)
	
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


func _on_button_2_pressed():
	$CanvasLayer/Garage.show()




func _on_run_button_pressed():
	if runButtonControl == false:
		instanceFruit()
		runTimerNode.start()
		runButtonControl = true
	
func instanceFruit():
	var fruitType = fruits[randi() % (fruits.size() - 1)]
	var fruit = fruitType.instantiate()
	#fruit.set_script(fruitScriptPath)
	add_child(fruit)
	#fruitInstance.append(fruit)


func _on_run_timer_timeout():
	runButtonControl = false
