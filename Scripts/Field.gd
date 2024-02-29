extends Node2D

var farmer_item_scene = preload("res://Scenes/FarmerItem.tscn")
var epic_farmer_item_scene = preload("res://Scenes/EpicFarmerItem.tscn")

var farmer_general_scene = preload("res://Scenes/FarmerGeneral.tscn")
var farmer_selection_scene = preload("res://Scenes/FarmersSelection.tscn")

@onready var farmer_list := $Panel/FarmerScroll/VBoxContainer

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_farmer_list()
	hide_scrolls()
	for i in range(15):
		var meter = get_node("Panel/FruitsScroll/VBoxContainer/FruitMeter" + str(i))
		meter.get_node("BuyButton").pressed.connect(Callable(buyFruit).bind(i))
	loadAllPanelData()
	
	$Panel/FruitsScroll.show()
	
func loadAllPanelData():
	for i in range (15):
		loadPanelData(i)
		
func loadPanelData(index : int):

	var fruit_data = GlobalVariables.player.Fruits[index]
	var fruit_item = get_node("Panel/FruitsScroll/VBoxContainer/FruitMeter" + str(index)) 
	
	for element in fruit_item.get_children():
		element.hide()
	
	fruit_item.get_node("Fruit").show()
	if fruit_data.acquired:
		fruit_item.get_node("Bar").show()
		fruit_item.get_node("Wood").show()
		fruit_item.get_node("BuyButton").show()
		fruit_item.get_node("Remaining").show()
	else:
		fruit_item.get_node("AcquireButton").show()
		
		var cost_text = "$ " + GlobalVariables.getMoneyString( GlobalVariables.player.Fruits[index].cost )
		
		fruit_item.get_node("AcquireButton/Wood/Cost").text = cost_text
		fruit_item.get_node("AcquireButton/Button/Name").text = "Acquire " + GlobalVariables.player.Fruits[index].name + "!"
		fruit_item.get_node("AcquireButton/Button").pressed.connect(Callable(acquire_fruit).bind(index))

	var currentPanelButtonCost = get_node("Panel/FruitsScroll/VBoxContainer/FruitMeter" + str(index) + "/BuyButton/Amount")
	var currentPanelLvlLabel = get_node("Panel/FruitsScroll/VBoxContainer/FruitMeter" + str(index) + "/Wood/Level")
	
	if GlobalVariables.player.Fruits[index].cost <= 999:
		currentPanelButtonCost.text ="$ %.2f" % GlobalVariables.player.Fruits[index].cost
	else:
		currentPanelButtonCost.text = GlobalVariables.getMoneyString(GlobalVariables.player.Fruits[index].cost)
	if GlobalVariables.player.Fruits[index].speed == 0:
		GlobalVariables.player.Fruits[index].speed = 10000
		
	var tierText = calculateTierLevel(index)
	if tierText == 20:
		currentPanelLvlLabel.text = str(GlobalVariables.player.Fruits[index].level) + "/20"
	else:
		currentPanelLvlLabel.text = str(GlobalVariables.player.Fruits[index].level) + "/" + str(tierText)
			
			
			
func calculateTierLevel(index : int):
	var tierText = 20
	if GlobalVariables.player.Fruits[index].level < 20:
		tierText = 20
	elif GlobalVariables.player.Fruits[index].level < 100:
		tierText = ((GlobalVariables.player.Fruits[index].tier) * 20)
	elif GlobalVariables.player.Fruits[index].level < 1000:
		tierText = ((GlobalVariables.player.Fruits[index].tier - 4) * 100)
	elif GlobalVariables.player.Fruits[index].level < 2000:
		tierText = ((GlobalVariables.player.Fruits[index].tier - 9) * 200)
	elif GlobalVariables.player.Fruits[index].level >= 2000:
		tierText = ((GlobalVariables.player.Fruits[index].tier - 15) * 500)
	
	return tierText

func buyFruit(index : int):
	var cost = GlobalVariables.player.Fruits[index].cost
	var mult = GlobalVariables.player.Fruits[index].multiplier
	var level = GlobalVariables.player.Fruits[index].level
	var tierText = calculateTierLevel(index)
	
	GlobalVariables.player.Fruits[index].cost = cost * mult
	GlobalVariables.player.Fruits[index].level += 1
	
	if level >= tierText - 1:
		GlobalVariables.player.Fruits[index].tier += 1
		saveCurrentProgress(index)
		cashOut(index)

	
	loadPanelData(index)
	get_node("Panel/FruitsScroll/VBoxContainer/FruitMeter"+str(index)+"/Fruit/Sprite2D").play("jump")

func acquire_fruit(index:int):
	if GlobalVariables.player.money > GlobalVariables.player.Fruits[index].cost:
		GlobalVariables.player.money = GlobalVariables.player.money - GlobalVariables.player.Fruits[index].cost
		GlobalVariables.player.Fruits[index].acquired = true
	loadAllPanelData()


func saveCurrentProgress(index : int):
	var currentProgressBar = get_node("Panel/FruitsScroll/VBoxContainer/FruitMeter" + str(index) + "/Bar")
	var currentProgressValueInMin = (GlobalVariables.player.Fruits[index].currentProgress * GlobalVariables.player.Fruits[index].speed)/ 100
	var nextSpeed = GlobalVariables.player.Fruits[index].speed/2
	var nextProgressValueInPer
	
	if currentProgressValueInMin >= GlobalVariables.player.Fruits[index].speed:
		currentProgressValueInMin = 0
	else:
		nextProgressValueInPer = (currentProgressValueInMin * 100)/nextSpeed
		
	if currentProgressValueInMin == 0:
		GlobalVariables.player.Fruits[index].currentProgress = 0
	else:
		GlobalVariables.player.Fruits[index].currentProgress = nextProgressValueInPer
	
	GlobalVariables.player.Fruits[index].speed = GlobalVariables.player.Fruits[index].speed / 2
	currentProgressBar.value = GlobalVariables.player.Fruits[index].currentProgress

func cashOut(index : int):

	var houseId = rng.randi_range(0, GlobalVariables.houseCount)
	var houseLvl
	var frutasObtenidas = GlobalVariables.player.Fruits[index].level
	
	
	if GlobalVariables.player.CurrentJuiceHouse[houseId].fullSandiaHouse == true:
		for i in range (0, GlobalVariables.houseCount):
			if GlobalVariables.player.CurrentJuiceHouse[i].fullSandiaHouse == false:
				houseId = i
				break
			elif i == 3:
				GlobalVariables.maxHouseCapacity = true
				
	
		
	if GlobalVariables.maxHouseCapacity == false:
		
		houseLvl = GlobalVariables.player.CurrentJuiceHouse[houseId].houseLvl
		
		if GlobalVariables.player.CurrentJuiceHouse[houseId].currentCapacity >= GlobalVariables.player.JuiceHouse[houseLvl].capacity:
			GlobalVariables.player.CurrentJuiceHouse[houseId].fullHouse = true
		else:
			GlobalVariables.player.CurrentJuiceHouse[houseId].fullHouse = false
			
	
		if GlobalVariables.player.CurrentJuiceHouse[houseId].fullHouse == true and GlobalVariables.player.CurrentJuiceHouse[houseId].fullSandiaHouse == false:
			SandiaExchange(houseId)

		if GlobalVariables.player.CurrentJuiceHouse[houseId].fullHouse == false and GlobalVariables.player.CurrentJuiceHouse[houseId].fullSandiaHouse == false:			
			if index == 0:
				GlobalVariables.player.CurrentJuiceHouse[houseId].blueberryCount += frutasObtenidas
				GlobalVariables.totalBlueberryCount += frutasObtenidas
			elif index == 1:
				GlobalVariables.player.CurrentJuiceHouse[houseId].cerezaCount += frutasObtenidas
				GlobalVariables.totalCerezaCount += frutasObtenidas
			elif index == 2:
				GlobalVariables.player.CurrentJuiceHouse[houseId].fresaCount += frutasObtenidas
				GlobalVariables.totalFresaCount += frutasObtenidas
			elif index == 3:
				GlobalVariables.player.CurrentJuiceHouse[houseId].limonCount += frutasObtenidas
				GlobalVariables.totalLimonCount += frutasObtenidas
			elif index == 4:
				GlobalVariables.player.CurrentJuiceHouse[houseId].duraznoCount += frutasObtenidas
				GlobalVariables.totalDuraznoCount += frutasObtenidas
			elif index == 5:
				GlobalVariables.player.CurrentJuiceHouse[houseId].manzanaCount += frutasObtenidas
				GlobalVariables.totalManzanaCount += frutasObtenidas
			elif index == 6:
				GlobalVariables.player.CurrentJuiceHouse[houseId].naranjaCount += frutasObtenidas
				GlobalVariables.totalNaranjaCount += frutasObtenidas
			elif index == 7:
				GlobalVariables.player.CurrentJuiceHouse[houseId].aguacateCount += frutasObtenidas
				GlobalVariables.totalAguacateCount += frutasObtenidas
			elif index == 8:
				GlobalVariables.player.CurrentJuiceHouse[houseId].mangoCount += frutasObtenidas
				GlobalVariables.totalMangoCount += frutasObtenidas
			elif index == 9:
				GlobalVariables.player.CurrentJuiceHouse[houseId].dragonfruitCount += frutasObtenidas
				GlobalVariables.totalDragonfruitCount += frutasObtenidas
			elif index == 10:
				GlobalVariables.player.CurrentJuiceHouse[houseId].cocoCount += frutasObtenidas
				GlobalVariables.totalCocoCount += frutasObtenidas
			elif index == 11:
				GlobalVariables.player.CurrentJuiceHouse[houseId].ananaCount += frutasObtenidas
				GlobalVariables.totalAnanaCount += frutasObtenidas
			elif index == 12:
				GlobalVariables.player.CurrentJuiceHouse[houseId].papayaCount += frutasObtenidas
				GlobalVariables.totalPapayaCount += frutasObtenidas
			elif index == 13:
				GlobalVariables.player.CurrentJuiceHouse[houseId].melonCount += frutasObtenidas
				GlobalVariables.totalMelonCount += frutasObtenidas
			elif index == 14:
				GlobalVariables.player.CurrentJuiceHouse[houseId].sandiaCount += frutasObtenidas
				GlobalVariables.totalSandiaCount += frutasObtenidas
				
			GlobalVariables.player.CurrentJuiceHouse[houseId].currentCapacity += frutasObtenidas
			
			if GlobalVariables.player.CurrentJuiceHouse[houseId].currentCapacity >= GlobalVariables.player.JuiceHouse[houseLvl].capacity:
				GlobalVariables.player.CurrentJuiceHouse[houseId].fullHouse = true
				
		if GlobalVariables.player.CurrentJuiceHouse[houseId].fullHouse == true and GlobalVariables.player.CurrentJuiceHouse[houseId].fullSandiaHouse == false:
			SandiaExchange(houseId)
		
func SandiaExchange(houseId : int):
	
	var litros : float = 0
	var sandiaCount : float = 0
	var divisor = (126180517478400*40)
	
	var houseLvl = GlobalVariables.player.CurrentJuiceHouse[houseId].houseLvl
	
	
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].blueberryCount * GlobalVariables.player.Fruits[0].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].cerezaCount * GlobalVariables.player.Fruits[1].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].fresaCount * GlobalVariables.player.Fruits[2].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].limonCount * GlobalVariables.player.Fruits[3].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].duraznoCount * GlobalVariables.player.Fruits[4].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].manzanaCount * GlobalVariables.player.Fruits[5].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].naranjaCount * GlobalVariables.player.Fruits[6].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].aguacateCount * GlobalVariables.player.Fruits[7].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].mangoCount * GlobalVariables.player.Fruits[8].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].dragonfruitCount * GlobalVariables.player.Fruits[9].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].cocoCount * GlobalVariables.player.Fruits[10].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].ananaCount * GlobalVariables.player.Fruits[11].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].papayaCount * GlobalVariables.player.Fruits[12].liters
	litros += GlobalVariables.player.CurrentJuiceHouse[houseId].melonCount * GlobalVariables.player.Fruits[13].liters
	
	GlobalVariables.player.CurrentJuiceHouse[houseId].blueberryCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].cerezaCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].fresaCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].limonCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].duraznoCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].manzanaCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].naranjaCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].aguacateCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].mangoCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].dragonfruitCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].cocoCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].ananaCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].papayaCount = 0
	GlobalVariables.player.CurrentJuiceHouse[houseId].melonCount = 0

	
	sandiaCount = (litros/divisor)
	GlobalVariables.player.CurrentJuiceHouse[houseId].sandiaCount += sandiaCount
	GlobalVariables.player.CurrentJuiceHouse[houseId].currentCapacity = sandiaCount

	if GlobalVariables.player.CurrentJuiceHouse[houseId].sandiaCount >= GlobalVariables.player.JuiceHouse[houseLvl].capacity:
		GlobalVariables.player.CurrentJuiceHouse[houseId].fullSandiaHouse = true
	
func _on_button_pressed():
	hide()



func _on_burguer_toggled(button_pressed):
	if button_pressed:
		$Panel/Options/AnimationPlayer.play("show")
	else:
		$Panel/Options/AnimationPlayer.play("hide")
		
func hide_scrolls():
	$Panel/FruitsScroll.hide()
	$Panel/FarmerScroll.hide()
	$Panel/Options/AnimationPlayer.play("hide")
	$Panel/Menu/Burguer.button_pressed = false


func _on_fruits_pressed():
	hide_scrolls()
	$Panel/FruitsScroll.show()
	


func _on_farmers_pressed():
	hide_scrolls()
	$Panel/FarmerScroll.show()
	
	
func load_farmer_list():
	
	
	
	var general_info = farmer_general_scene.instantiate()
	var farmer_selection = farmer_selection_scene.instantiate()
	
	farmer_selection.get_node("Farmers").pressed.connect(load_farmer_list)
	farmer_selection.get_node("EpicFarmers").pressed.connect(load_epic_farmer_list)
	
	general_info.get_node("FarmerTitle").show()
	general_info.get_node("FarmerDescription").show()
	
	for item in farmer_list.get_children():
		item.queue_free()
		
	farmer_list.add_child(farmer_selection)
	farmer_list.add_child(general_info)
		
	for i in range(GlobalVariables.player.Farmer.size()):
		var farmer = GlobalVariables.player.Farmer[i]
		var farmer_item = farmer_item_scene.instantiate()
		
		if farmer.epic:
			continue
		
		farmer_item.get_node("Name").text = farmer.name
		farmer_item.get_node("Icon").texture = farmer.skin
		farmer_item.get_node("Description").text = farmer.description
		farmer_item.get_node("Cost").text = "$ " + GlobalVariables.getMoneyString(farmer.cost)
		farmer_item.get_node("Button").pressed.connect(Callable(buy_farmer).bind(i))
		
		if farmer.active:
			farmer_item.get_node("Aquired").show()
			farmer_item.get_node("Button").hide()
			
		if farmer.cost >= GlobalVariables.player.money:
			farmer_item.get_node("Button").disabled = true
		
		farmer_list.add_child(farmer_item)
		
func load_epic_farmer_list():
	
	var general_info = farmer_general_scene.instantiate()
	var farmer_selection = farmer_selection_scene.instantiate()
	
	farmer_selection.get_node("Farmers").pressed.connect(load_farmer_list)
	farmer_selection.get_node("EpicFarmers").pressed.connect(load_epic_farmer_list)
	
	general_info.get_node("EpicFarmerTitle").show()
	general_info.get_node("EpicFarmerDescription").show()
	
	for item in farmer_list.get_children():
		item.queue_free()
		
	farmer_list.add_child(farmer_selection)
	farmer_list.add_child(general_info)
		
	for i in range(GlobalVariables.player.Farmer.size()):
		var farmer = GlobalVariables.player.Farmer[i]
		var farmer_item = epic_farmer_item_scene.instantiate()
		
		farmer_item.get_node("Name").text = farmer.name
		farmer_item.get_node("Icon").texture = farmer.skin
		farmer_item.get_node("Description").text = farmer.description
		farmer_item.get_node("Cost").text = "$ " + GlobalVariables.getMoneyString(farmer.epic_cost)
		farmer_item.get_node("Button").pressed.connect(Callable(buy_epic_farmer).bind(i))
		
		if farmer.epic_cost >= GlobalVariables.player.money:
			farmer_item.get_node("Button").disable - true
		
		if not farmer.active:
			continue
		
		if farmer.epic:
			farmer_item.get_node("Aquired").show()
			farmer_item.get_node("Button").hide()
			
		
		
		farmer_list.add_child(farmer_item)

func buy_farmer(i:int):
	if GlobalVariables.player.money >= GlobalVariables.player.Farmer[i].cost:
		GlobalVariables.player.money = GlobalVariables.player.money - GlobalVariables.player.Farmer[i].cost
		GlobalVariables.player.Farmer[i].active = true
		load_farmer_list()
		
func buy_epic_farmer(i:int):
	if GlobalVariables.player.money >= GlobalVariables.player.Farmer[i].epic_cost:
		GlobalVariables.player.money = GlobalVariables.player.money - GlobalVariables.player.Farmer[i].epic_cost
		GlobalVariables.player.Farmer[i].epic = true
		load_farmer_list()
		
		
