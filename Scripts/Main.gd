extends Node2D

var rng = RandomNumberGenerator.new()

var savePath = "res://Save/PlayerSave.tres"
var controlEscenasField = false
var controlEscenasUpgrades = false
var controlEscenasBoost = false
var controlEscenasMenu = false
var controlEscenasShop = false
var controlEscenasModalJuiceLvl = false

var totalTransportCapacity = 0
var totalJuiceHouseCapacity = 0

var mango = preload("res://Scenes/Fruits/Mango.tscn")
var aguacate = preload("res://Scenes/Fruits/Aguacate.tscn")
var cereza = preload("res://Scenes/Fruits/Cereza.tscn")
var blueberry = preload("res://Scenes/Fruits/Blueberry.tscn")
var coco = preload("res://Scenes/Fruits/Coco.tscn")
var dragonfruit = preload("res://Scenes/Fruits/Dragonfruit.tscn")
var durazno = preload("res://Scenes/Fruits/Durazno.tscn")
var fresa = preload("res://Scenes/Fruits/Fresa.tscn")
var limon = preload("res://Scenes/Fruits/Limon.tscn")
var manzana = preload("res://Scenes/Fruits/Manzana.tscn")
var melon = preload("res://Scenes/Fruits/Melon.tscn")
var naranja = preload("res://Scenes/Fruits/Naranja.tscn")
var papaya = preload("res://Scenes/Fruits/Papaya.tscn")
var pina = preload("res://Scenes/Fruits/Pina.tscn")
var sandia = preload("res://Scenes/Fruits/Sandia.tscn")
var fruits = [aguacate, blueberry, cereza, coco, dragonfruit, durazno, fresa, limon, manzana, melon, naranja, papaya, pina, sandia]
var fruitInstance = []
var runTimerNode
var runButtonControl = false

var multiplierOn = false
var multiplierLabel
var juiceLevelLabel
var juiceLevelIcon

var farmValue : float = 0.0

@onready var spawn_spots := $NavigationRegion2D/Spawners.get_children()
var spawn_list : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	
	runTimerNode = $CanvasLayer/runButton/RunTimer
	multiplierLabel = $CanvasLayer/Multiplier
	juiceLevelLabel = $CanvasLayer/JuiceLvl/Level
	juiceLevelLabel.text = GlobalVariables.player.JuiceLevel[GlobalVariables.player.juiceLevel].name
	juiceLevelIcon = $CanvasLayer/JuiceLvl/Icon
	
	GlobalVariables.loadResource()
	SignalManager.loadData.connect(loadData)
	
	SignalManager.loadData.emit()
	SignalManager.loadHouses.emit()
	
	spawn_spots.reverse()
	

func _process(_delta):

	# Control del marcador del multiplicador		
	if GlobalVariables.multiplier <= GlobalVariables.multiplierSteps/10:
		GlobalVariables.multiplier = 0

	# Actualizacion del marcador del multiplicador
	if GlobalVariables.multiplier > 0:
		multiplierLabel.text = "x " + str("%.1f" % GlobalVariables.multiplier)
	
	# Actualizacion del icono de jugo
	juiceLevelIcon.texture = GlobalVariables.player.JuiceLevel[GlobalVariables.player.juiceLevel].skin

#obtener la capacidad total de los transportes
func getTotalTransportCapacity():
	totalTransportCapacity = 0
	var trasportIdArray = [GlobalVariables.player.transport0Id, GlobalVariables.player.transport1Id,GlobalVariables.player.transport2Id,GlobalVariables.player.transport3Id,GlobalVariables.player.transport4Id,GlobalVariables.player.transport5Id,GlobalVariables.player.transport6Id,GlobalVariables.player.transport7Id,GlobalVariables.player.transport8Id,GlobalVariables.player.transport9Id,GlobalVariables.player.transport10Id,GlobalVariables.player.transport11Id,GlobalVariables.player.transport12Id,GlobalVariables.player.transport13Id,GlobalVariables.player.transport14Id]
	
	for i in range (0, trasportIdArray.size()):
		if trasportIdArray[i] >= 1:
			var id = trasportIdArray[i]
			totalTransportCapacity += GlobalVariables.player.Transport[id - 1].capacity

	
			
#obtener la capacidad total de las casas de jugo
func getJuiceHouseCapacity():
	totalJuiceHouseCapacity = 0
	GlobalVariables.houseCount = 0
	var houseIdArray = [GlobalVariables.player.house0Id, GlobalVariables.player.house1Id,GlobalVariables.player.house2Id,GlobalVariables.player.house3Id]
	for i in range (0, houseIdArray.size()):
		if houseIdArray[i] >= 1:
			GlobalVariables.houseCount += 1
			var id = houseIdArray[i]
			totalJuiceHouseCapacity += GlobalVariables.player.JuiceHouse[id - 1].capacity
	if GlobalVariables.houseCount >= 3:
		GlobalVariables.houseCount = 3	
				
func countFruits():
	for i in range(GlobalVariables.total_fruit_count.size()):
		GlobalVariables.total_fruit_count[i] = 0
		
	var houseIdArray = [GlobalVariables.player.house0Id, GlobalVariables.player.house1Id,GlobalVariables.player.house2Id,GlobalVariables.player.house3Id]
	for i in range (0, houseIdArray.size()):
		if houseIdArray[i] >= 1:
			for j in range(GlobalVariables.player.Fruits.size()):
				GlobalVariables.total_fruit_count[j] += GlobalVariables.player.CurrentJuiceHouse[i].fruit_count[j]
				GlobalVariables.totalFruits += GlobalVariables.total_fruit_count[j]
#			GlobalVariables.totalBlueberryCount += GlobalVariables.player.CurrentJuiceHouse[i].blueberryCount
#			GlobalVariables.totalFruits += GlobalVariables.totalBlueberryCount
#
#			GlobalVariables.totalCerezaCount += GlobalVariables.player.CurrentJuiceHouse[i].cerezaCount
#			GlobalVariables.totalFruits += GlobalVariables.totalCerezaCount
#
#			GlobalVariables.totalFresaCount += GlobalVariables.player.CurrentJuiceHouse[i].fresaCount
#			GlobalVariables.totalFruits += GlobalVariables.totalFresaCount
#
#			GlobalVariables.totalLimonCount += GlobalVariables.player.CurrentJuiceHouse[i].limonCount
#			GlobalVariables.totalFruits += GlobalVariables.totalLimonCount
#
#			GlobalVariables.totalDuraznoCount += GlobalVariables.player.CurrentJuiceHouse[i].duraznoCount
#			GlobalVariables.totalFruits += GlobalVariables.totalDuraznoCount
#
#			GlobalVariables.totalManzanaCount += GlobalVariables.player.CurrentJuiceHouse[i].manzanaCount
#			GlobalVariables.totalFruits += GlobalVariables.totalManzanaCount
#
#			GlobalVariables.totalNaranjaCount += GlobalVariables.player.CurrentJuiceHouse[i].naranjaCount
#			GlobalVariables.totalFruits += GlobalVariables.totalNaranjaCount
#
#			GlobalVariables.totalAguacateCount += GlobalVariables.player.CurrentJuiceHouse[i].aguacateCount
#			GlobalVariables.totalFruits += GlobalVariables.totalAguacateCount
#
#			GlobalVariables.totalMangoCount += GlobalVariables.player.CurrentJuiceHouse[i].mangoCount
#			GlobalVariables.totalFruits += GlobalVariables.totalMangoCount
#
#			GlobalVariables.totalDragonfruitCount += GlobalVariables.player.CurrentJuiceHouse[i].dragonfruitCount
#			GlobalVariables.totalFruits += GlobalVariables.totalDragonfruitCount
#
#			GlobalVariables.totalCocoCount += GlobalVariables.player.CurrentJuiceHouse[i].cocoCount
#			GlobalVariables.totalFruits += GlobalVariables.totalCocoCount
#
#			GlobalVariables.totalAnanaCount += GlobalVariables.player.CurrentJuiceHouse[i].ananaCount
#			GlobalVariables.totalFruits += GlobalVariables.totalAnanaCount
#
#			GlobalVariables.totalPapayaCount += GlobalVariables.player.CurrentJuiceHouse[i].papayaCount
#			GlobalVariables.totalFruits += GlobalVariables.totalPapayaCount
#
#			GlobalVariables.totalMelonCount += GlobalVariables.player.CurrentJuiceHouse[i].melonCount
#			GlobalVariables.totalFruits += GlobalVariables.totalMelonCount
#
#			GlobalVariables.totalSandiaCount += GlobalVariables.player.CurrentJuiceHouse[i].sandiaCount
#			GlobalVariables.totalFruits += GlobalVariables.totalSandiaCount
			
			
func calculateMoneyFromLiters(litrosPorSegundo : float):
	#print("litrosPor segundo: ", litrosPorSegundo)

	var currentJuiceLevel = GlobalVariables.player.juiceLevel
	var earningBonus = 1 + (GlobalVariables.player.seeds/100)
	var moneyString : String
	var multGananciasMultiplier = 1
	
	if GlobalVariables.player.multGananciasActive == true:
		multGananciasMultiplier = 2
		
	#print("litros multiplier: ",multGananciasMultiplier)
	if litrosPorSegundo >= totalTransportCapacity:
		litrosPorSegundo = totalTransportCapacity
		GlobalVariables.maxTransportCapacity = true 
	
	
	GlobalVariables.player.money += ((litrosPorSegundo * GlobalVariables.player.JuiceLevel[currentJuiceLevel].value * (GlobalVariables.multiplier + 1)) * multGananciasMultiplier) * earningBonus
	moneyString = GlobalVariables.getMoneyString(GlobalVariables.player.money)
	$CanvasLayer/JuiceLvl/Money.text = "$ " + moneyString
	moneyString = GlobalVariables.getMoneyString(litrosPorSegundo * multGananciasMultiplier * earningBonus)
	$CanvasLayer/moneyPerSec.text = "MoneyPerSec: " + moneyString


#esta  funcion se manda a ejecturar despues de cargar el recurso en la variabale player
#se usa para evitar utilizar una variable antes de cargar los datos de player
func loadData():
	getTotalTransportCapacity()
	getJuiceHouseCapacity()
	countFruits()
	
	
func save():
	ResourceSaver.save(GlobalVariables.player, savePath)
	
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST or what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		GlobalVariables.player.time = Time.get_datetime_string_from_system()
		save()
		get_tree().paused = true
	if what == NOTIFICATION_APPLICATION_FOCUS_IN or what == NOTIFICATION_READY:
		get_tree().paused = false
		calculateTime()
		
		
func calculateTime():
	var maxTime = GlobalVariables.player.WaterTank.time * GlobalVariables.player.WaterTank.count
	var prevTime = Time.get_unix_time_from_datetime_string(GlobalVariables.player.time)
	var currentTime = Time.get_unix_time_from_datetime_string(Time.get_datetime_string_from_system())
	var elapsedTime = currentTime - prevTime
	
	var timeProgressBarNode = $CanvasLayer/WaterTank.get_node("Panel/ProgressBar")
	
	if maxTime <= elapsedTime:
		elapsedTime = maxTime
	
	timeProgressBarNode.max_value = maxTime
	timeProgressBarNode.value = (maxTime - elapsedTime)
	
	calculateMoneyFromTime(elapsedTime)
	

func calculateMoneyFromTime(elapsedTime):
	var moneyEarned = GlobalVariables.player.litersPerSecond * elapsedTime
	var earningBonus = 1 + (GlobalVariables.player.seeds/100)
	var moneyEarnedString : String
	var moneyEarnedLabel = $CanvasLayer/WaterTank.get_node("Panel/Money")
	
	moneyEarnedString = GlobalVariables.getMoneyString(moneyEarned)
	moneyEarnedLabel.text = "Money Earned: \n" + moneyEarnedString
	$CanvasLayer/WaterTank.show()
	GlobalVariables.player.money += moneyEarned * earningBonus
	calculateFruitsFromTime(elapsedTime)
	save()
	
func calculateFruitsFromTime(elapsedTime):
	var frutasTotal : float = 0
	var litrosTotal : float = 0
	var fruitsEarnedString : String
	var fruitsEarnedLabel = $CanvasLayer/WaterTank.get_node("Panel/Fruits")
	
	var fruit_count : Array[int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	
	var houseIdArray = [GlobalVariables.player.house0Id, GlobalVariables.player.house1Id,GlobalVariables.player.house2Id,GlobalVariables.player.house3Id]

	
	if not elapsedTime == 1:
		for i in range(fruit_count.size()):
			fruit_count[i] = ( elapsedTime / GlobalVariables.player.Fruits[i].speed ) * GlobalVariables.player.Fruits[i].level
			
			frutasTotal += fruit_count[i]
			
			for j in range( 0, GlobalVariables.houseCount ):
				if houseIdArray[j] >= 1:
					GlobalVariables.player.CurrentJuiceHouse[j].fruit_count[i] += (fruit_count[i] ) / GlobalVariables.houseCount
				else:
					GlobalVariables.player.CurrentJuiceHouse[i].fruit_count = 0
					
		if frutasTotal <= 999:
			fruitsEarnedString = str(frutasTotal)
		else:
			fruitsEarnedString = GlobalVariables.getMoneyString(frutasTotal)
		fruitsEarnedLabel.text = "Fruits Earned: \n" + fruitsEarnedString
		
			
	else:
		for i in range( GlobalVariables.player.Fruits.size() ):
			var fruit = GlobalVariables.player.Fruits[i]
			fruit_count[i] = (elapsedTime / fruit.speed) * fruit.level *fruit.liters
		
	
	countFruits()
	
	#sucede cuando se calcula el farm value elapsed time = 1
#	if not elapsedTime == 1:
#		BlueberryCount = (elapsedTime / GlobalVariables.player.Fruits[0].speed) * GlobalVariables.player.Fruits[0].level
#		CerezaCount = (elapsedTime / GlobalVariables.player.Fruits[1].speed) * GlobalVariables.player.Fruits[1].level
#		FresaCount = (elapsedTime / GlobalVariables.player.Fruits[2].speed) * GlobalVariables.player.Fruits[2].level
#		LimonCount = (elapsedTime / GlobalVariables.player.Fruits[3].speed) * GlobalVariables.player.Fruits[3].level
#		DuraznoCount = (elapsedTime / GlobalVariables.player.Fruits[4].speed) * GlobalVariables.player.Fruits[4].level
#		ManzanaCount = (elapsedTime / GlobalVariables.player.Fruits[5].speed) * GlobalVariables.player.Fruits[5].level
#		NaranjaCount = (elapsedTime / GlobalVariables.player.Fruits[6].speed) * GlobalVariables.player.Fruits[6].level
#		AguacateCount = (elapsedTime / GlobalVariables.player.Fruits[7].speed) * GlobalVariables.player.Fruits[7].level
#		MangoCount = (elapsedTime / GlobalVariables.player.Fruits[8].speed) * GlobalVariables.player.Fruits[8].level
#		DragonfruitCount = (elapsedTime / GlobalVariables.player.Fruits[9].speed) * GlobalVariables.player.Fruits[9].level
#		CocoCount = (elapsedTime / GlobalVariables.player.Fruits[10].speed) * GlobalVariables.player.Fruits[10].level
#		AnanaCount = (elapsedTime / GlobalVariables.player.Fruits[11].speed) * GlobalVariables.player.Fruits[11].level
#		PapayaCount = (elapsedTime / GlobalVariables.player.Fruits[12].speed) * GlobalVariables.player.Fruits[12].level
#		MelonCount = (elapsedTime / GlobalVariables.player.Fruits[13].speed) * GlobalVariables.player.Fruits[13].level
#		SandiaCount = (elapsedTime / GlobalVariables.player.Fruits[14].speed) * GlobalVariables.player.Fruits[14].level
#
#		frutasTotal = BlueberryCount+CerezaCount+FresaCount+LimonCount+DuraznoCount+ManzanaCount+NaranjaCount+AguacateCount+MangoCount+DragonfruitCount+CocoCount+AnanaCount+PapayaCount+MelonCount+SandiaCount
#
#
#
#		for i in range (0, GlobalVariables.houseCount):
#			if houseIdArray[i] >= 1:
#				GlobalVariables.player.CurrentJuiceHouse[i].blueberryCount += (BlueberryCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].cerezaCount += (CerezaCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].fresaCount += (FresaCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].limonCount += (LimonCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].duraznoCount += (DuraznoCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].manzanaCount += (ManzanaCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].naranjaCount += (NaranjaCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].aguacateCount += (AguacateCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].mangoCount += (MangoCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].dragonfruitCount += (DragonfruitCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].cocoCount += (CocoCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].ananaCount += (AnanaCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].papayaCount += (PapayaCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].melonCount += (MelonCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].sandiaCount += (SandiaCount ) / GlobalVariables.houseCount
#				GlobalVariables.player.CurrentJuiceHouse[i].currentCapacity += frutasTotal  / GlobalVariables.houseCount
#			else:
#				GlobalVariables.player.CurrentJuiceHouse[i].blueberryCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].cerezaCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].fresaCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].limonCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].duraznoCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].manzanaCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].naranjaCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].aguacateCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].mangoCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].dragonfruitCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].cocoCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].ananaCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].papayaCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].melonCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].sandiaCount = 0
#				GlobalVariables.player.CurrentJuiceHouse[i].currentCapacity = 0
#
#
#		if frutasTotal <= 999:
#			fruitsEarnedString = str(frutasTotal)
#		else:
#			fruitsEarnedString = GlobalVariables.getMoneyString(frutasTotal)
#		fruitsEarnedLabel.text = "Fruits Earned: \n" + fruitsEarnedString
#
#	else: 
#		BlueberryCount = (elapsedTime / GlobalVariables.player.Fruits[0].speed) * GlobalVariables.player.Fruits[0].level * GlobalVariables.player.Fruits[0].liters
#		CerezaCount = (elapsedTime / GlobalVariables.player.Fruits[1].speed) * GlobalVariables.player.Fruits[1].level * GlobalVariables.player.Fruits[1].liters
#		FresaCount = (elapsedTime / GlobalVariables.player.Fruits[2].speed) * GlobalVariables.player.Fruits[2].level * GlobalVariables.player.Fruits[2].liters
#		LimonCount = (elapsedTime / GlobalVariables.player.Fruits[3].speed) * GlobalVariables.player.Fruits[3].level * GlobalVariables.player.Fruits[3].liters
#		DuraznoCount = (elapsedTime / GlobalVariables.player.Fruits[4].speed) * GlobalVariables.player.Fruits[4].level * GlobalVariables.player.Fruits[4].liters
#		ManzanaCount = (elapsedTime / GlobalVariables.player.Fruits[5].speed) * GlobalVariables.player.Fruits[5].level * GlobalVariables.player.Fruits[5].liters
#		NaranjaCount = (elapsedTime / GlobalVariables.player.Fruits[6].speed) * GlobalVariables.player.Fruits[6].level * GlobalVariables.player.Fruits[6].liters
#		AguacateCount = (elapsedTime / GlobalVariables.player.Fruits[7].speed) * GlobalVariables.player.Fruits[7].level * GlobalVariables.player.Fruits[7].liters
#		MangoCount = (elapsedTime / GlobalVariables.player.Fruits[8].speed) * GlobalVariables.player.Fruits[8].level * GlobalVariables.player.Fruits[8].liters
#		DragonfruitCount = (elapsedTime / GlobalVariables.player.Fruits[9].speed) * GlobalVariables.player.Fruits[9].level * GlobalVariables.player.Fruits[9].liters
#		CocoCount = (elapsedTime / GlobalVariables.player.Fruits[10].speed) * GlobalVariables.player.Fruits[10].level * GlobalVariables.player.Fruits[10].liters
#		AnanaCount = (elapsedTime / GlobalVariables.player.Fruits[11].speed) * GlobalVariables.player.Fruits[11].level * GlobalVariables.player.Fruits[11].liters
#		PapayaCount = (elapsedTime / GlobalVariables.player.Fruits[12].speed) * GlobalVariables.player.Fruits[12].level * GlobalVariables.player.Fruits[12].liters
#		MelonCount = (elapsedTime / GlobalVariables.player.Fruits[13].speed) * GlobalVariables.player.Fruits[13].level * GlobalVariables.player.Fruits[13].liters
#		SandiaCount = (elapsedTime / GlobalVariables.player.Fruits[14].speed) * GlobalVariables.player.Fruits[14].level * GlobalVariables.player.Fruits[14].liters
#		litrosTotal = BlueberryCount+CerezaCount+FresaCount+LimonCount+DuraznoCount+ManzanaCount+NaranjaCount+AguacateCount+MangoCount+DragonfruitCount+CocoCount+AnanaCount+PapayaCount+MelonCount+SandiaCount
#
#		SandiasTotales = SandiasPorSeg(litrosTotal)
#		GlobalVariables.player.sandiasPerSecond = SandiasTotales/elapsedTime
#
#	countFruits()
	
func SandiasPorSeg(litros : float):
	var sandias : float
	sandias = litros/5047220699136000.00
	return sandias
	
# Oculta todas las escenas
func hideScene():
	$CanvasLayer/Field.visible = false
	$CanvasLayer/Upgrades.visible = false
	$CanvasLayer/Boost.visible = false
	$CanvasLayer/Menu.visible = false
	$CanvasLayer/Shop.visible = false
	$CanvasLayer/ModalJuiceLvl.visible = false

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
	$CanvasLayer/Garage/VehicleList/ScrollContainer.fill_vehicle_list()


func _on_run_button_pressed():
	if runButtonControl == false:
		instanceFruit()
		runTimerNode.start()
		runButtonControl = true
	
func instanceFruit():
	var randFruit = randi_range(0, fruits.size()-1)
	var fruitType = fruits[randFruit]
	var fruit = fruitType.instantiate()
	var fruitI = fruit
	
	fruitI.add_to_group("fruit")

	if randFruit == 0:
		fruitI.add_to_group("mango")
		
	fruit.houseName = "house"

#	var dirX = rng.randi_range(-10,10)
#	var dirY = rng.randi_range(-10,10)

#	fruit.position.x = $FruitSpawn.position.x + dirX
#	fruit.position.y = $FruitSpawn.position.y + dirY

#	add_child(fruit)
#	fruit.get_node("Sprite2D").play("walk")

	fruitInstance.append(fruitI)
	GlobalVariables.multiplier += GlobalVariables.multiplierSteps#	
	fruit.scale = Vector2(2.0, 2.0)
	spawn_list.append(fruit)

func fruit_spawner():
	
	if not spawn_list.is_empty():
		for spawner in spawn_spots:
			if not spawner.full:
				add_child(spawn_list[0])
				spawn_list[0].global_position = spawner.global_position
				spawn_list.pop_at(0)
				break
			else:
				continue


func _on_run_timer_timeout():
	runButtonControl = false


func _on_produce_juice_timer_timeout():
	var litros : float = 0.0
	var litrosPorSegundo : float = 0.0
	
	for i in range( GlobalVariables.player.Fruits.size() ):
		litros += GlobalVariables.total_fruit_count[i] * GlobalVariables.player.Fruits[i].liters
	
#	litros += GlobalVariables.totalBlueberryCount * GlobalVariables.player.Fruits[0].liters
#	litros += GlobalVariables.totalCerezaCount * GlobalVariables.player.Fruits[1].liters
#	litros += GlobalVariables.totalFresaCount * GlobalVariables.player.Fruits[2].liters
#	litros += GlobalVariables.totalLimonCount * GlobalVariables.player.Fruits[3].liters
#	litros += GlobalVariables.totalDuraznoCount * GlobalVariables.player.Fruits[4].liters
#	litros += GlobalVariables.totalManzanaCount * GlobalVariables.player.Fruits[5].liters
#	litros += GlobalVariables.totalNaranjaCount * GlobalVariables.player.Fruits[6].liters
#	litros += GlobalVariables.totalAguacateCount * GlobalVariables.player.Fruits[7].liters
#	litros += GlobalVariables.totalMangoCount * GlobalVariables.player.Fruits[8].liters
#	litros += GlobalVariables.totalDragonfruitCount * GlobalVariables.player.Fruits[9].liters
#	litros += GlobalVariables.totalCocoCount * GlobalVariables.player.Fruits[10].liters
#	litros += GlobalVariables.totalAnanaCount * GlobalVariables.player.Fruits[11].liters
#	litros += GlobalVariables.totalPapayaCount * GlobalVariables.player.Fruits[12].liters
#	litros += GlobalVariables.totalMelonCount * GlobalVariables.player.Fruits[13].liters
#	litros += GlobalVariables.totalSandiaCount * GlobalVariables.player.Fruits[14].liters
	
	litrosPorSegundo = litros * 0.1
		
	GlobalVariables.player.litersPerSecond = litrosPorSegundo
	calculateMoneyFromLiters(litrosPorSegundo)


func calculateFarmValue():
	getJuiceHouseCapacity()
	calculateFruitsFromTime(1)
	
	var farmValueString : String
	var houseCapacity = totalJuiceHouseCapacity
	var P = GlobalVariables.total_fruit_count[14]
	var Pc = P * ((GlobalVariables.player.litersPerSecond/GlobalVariables.player.sandiasPerSecond) * 60)
	var Pu = (P - Pc)
	var Pv = (houseCapacity - P)
	var Pp = ((GlobalVariables.player.sandiasPerSecond * 60)/4) * GlobalVariables.player.WaterTank.time
	var L = GlobalVariables.player.juiceLevel + 1
	var juiceValue = GlobalVariables.player.JuiceLevel[L -1].value
	var sandiasPerMin = GlobalVariables.player.sandiasPerSecond * 60
	var earningBonus = 1 + (GlobalVariables.player.seeds/100)
	var maxRunningFruitBonus = 5
	var maxRunningFruitBonusEq = ((maxRunningFruitBonus - 4)**0.25)


	farmValue = 30000 * juiceValue * sandiasPerMin * earningBonus * maxRunningFruitBonusEq * L * (Pc + (0.2 * Pu) + (-1 * (abs(Pv)**0.6)) + (0.25 * Pp))
	
	GlobalVariables.player.farmValue = farmValue
	if farmValue <= 999:
		farmValueString = str(farmValue)
	else:
		farmValueString = GlobalVariables.getMoneyString(farmValue)
	$CanvasLayer/FarmValue.text = "FarmValue: " + farmValueString
	

func _on_timer_timeout():
	calculateFarmValue()


func _on_juice_lvl_pressed():
	controlEscenasModalJuiceLvl = showScene($CanvasLayer/ModalJuiceLvl, controlEscenasModalJuiceLvl)


func _on_spawn_timer_timeout():
	fruit_spawner()
	

