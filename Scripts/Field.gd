extends Node2D

var rng = RandomNumberGenerator.new()

#Varibles de los botones dentro de cada panel dentro del primer scroll container
var panelNode0Button
var panelNode1Button
var panelNode2Button
var panelNode3Button
var panelNode4Button
var panelNode5Button
var panelNode6Button
var panelNode7Button
var panelNode8Button
var panelNode9Button
var panelNode10Button
var panelNode11Button
var panelNode12Button
var panelNode13Button
var panelNode14Button
var farmersButton


var fruitsScrollContainer
var farmersScrollContainer

#Varibles de los botones dentro de cada panel dentro del segundo scroll container
var farmerPanel0Button
var farmerPanel1Button
var farmerPanel2Button
var farmerPanel3Button
var farmerPanel4Button
var farmerPanel5Button
var farmerPanel6Button
var farmerPanel7Button
var farmerPanel8Button
var farmerPanel9Button
var farmerPanel10Button
var farmerPanel11Button
var farmerPanel12Button
var farmerPanel13Button
var farmerPanel14Button

var mainNode

# Called when the node enters the scene tree for the first time.
func _ready():
	#asignar todas las variables con sus respectivos nodos
	mainNode = get_parent().get_parent()
	
	panelNode0Button = $ScrollContainer/Control/VBoxContainer/Panel0/Button
	panelNode1Button = $ScrollContainer/Control/VBoxContainer/Panel1/Button
	panelNode2Button = $ScrollContainer/Control/VBoxContainer/Panel2/Button
	panelNode3Button = $ScrollContainer/Control/VBoxContainer/Panel3/Button
	panelNode4Button = $ScrollContainer/Control/VBoxContainer/Panel4/Button
	panelNode5Button = $ScrollContainer/Control/VBoxContainer/Panel5/Button
	panelNode6Button = $ScrollContainer/Control/VBoxContainer/Panel6/Button
	panelNode7Button = $ScrollContainer/Control/VBoxContainer/Panel7/Button
	panelNode8Button = $ScrollContainer/Control/VBoxContainer/Panel8/Button
	panelNode9Button = $ScrollContainer/Control/VBoxContainer/Panel9/Button
	panelNode10Button = $ScrollContainer/Control/VBoxContainer/Panel10/Button
	panelNode11Button = $ScrollContainer/Control/VBoxContainer/Panel11/Button
	panelNode12Button = $ScrollContainer/Control/VBoxContainer/Panel12/Button
	panelNode13Button = $ScrollContainer/Control/VBoxContainer/Panel13/Button
	panelNode14Button = $ScrollContainer/Control/VBoxContainer/Panel14/Button
	
	farmersButton = $Button2
	fruitsScrollContainer = $ScrollContainer
	farmersScrollContainer = $ScrollContainer2
	
	farmerPanel0Button = $ScrollContainer2/Control/VBoxContainer/Panel0/Button
	farmerPanel1Button = $ScrollContainer2/Control/VBoxContainer/Panel1/Button
	farmerPanel2Button = $ScrollContainer2/Control/VBoxContainer/Panel2/Button
	farmerPanel3Button = $ScrollContainer2/Control/VBoxContainer/Panel3/Button
	farmerPanel4Button = $ScrollContainer2/Control/VBoxContainer/Panel4/Button
	farmerPanel5Button = $ScrollContainer2/Control/VBoxContainer/Panel5/Button
	farmerPanel6Button = $ScrollContainer2/Control/VBoxContainer/Panel6/Button
	farmerPanel7Button = $ScrollContainer2/Control/VBoxContainer/Panel7/Button
	farmerPanel8Button = $ScrollContainer2/Control/VBoxContainer/Panel8/Button
	farmerPanel9Button = $ScrollContainer2/Control/VBoxContainer/Panel9/Button
	farmerPanel10Button = $ScrollContainer2/Control/VBoxContainer/Panel10/Button
	farmerPanel11Button = $ScrollContainer2/Control/VBoxContainer/Panel11/Button
	farmerPanel12Button = $ScrollContainer2/Control/VBoxContainer/Panel12/Button
	farmerPanel13Button = $ScrollContainer2/Control/VBoxContainer/Panel13/Button
	farmerPanel14Button = $ScrollContainer2/Control/VBoxContainer/Panel14/Button

	#conectar todas las seniales de los botones y mandar un index a la funcion llamada denpendiendo del boton
	panelNode0Button.pressed.connect(Callable(buyFruit).bind(0))
	panelNode1Button.pressed.connect(Callable(buyFruit).bind(1))
	panelNode2Button.pressed.connect(Callable(buyFruit).bind(2))
	panelNode3Button.pressed.connect(Callable(buyFruit).bind(3))
	panelNode4Button.pressed.connect(Callable(buyFruit).bind(4))
	panelNode5Button.pressed.connect(Callable(buyFruit).bind(5))
	panelNode6Button.pressed.connect(Callable(buyFruit).bind(6))
	panelNode7Button.pressed.connect(Callable(buyFruit).bind(7))
	panelNode8Button.pressed.connect(Callable(buyFruit).bind(8))
	panelNode9Button.pressed.connect(Callable(buyFruit).bind(9))
	panelNode10Button.pressed.connect(Callable(buyFruit).bind(10))
	panelNode11Button.pressed.connect(Callable(buyFruit).bind(11))
	panelNode12Button.pressed.connect(Callable(buyFruit).bind(12))
	panelNode13Button.pressed.connect(Callable(buyFruit).bind(13))
	panelNode14Button.pressed.connect(Callable(buyFruit).bind(14))
	
	farmersButton.pressed.connect(showHideFarmers)
	
	farmerPanel0Button.pressed.connect(Callable(buyFarmer).bind(0))
	farmerPanel1Button.pressed.connect(Callable(buyFarmer).bind(1))
	farmerPanel2Button.pressed.connect(Callable(buyFarmer).bind(2))
	farmerPanel3Button.pressed.connect(Callable(buyFarmer).bind(3))
	farmerPanel4Button.pressed.connect(Callable(buyFarmer).bind(4))
	farmerPanel5Button.pressed.connect(Callable(buyFarmer).bind(5))
	farmerPanel6Button.pressed.connect(Callable(buyFarmer).bind(6))
	farmerPanel7Button.pressed.connect(Callable(buyFarmer).bind(7))
	farmerPanel8Button.pressed.connect(Callable(buyFarmer).bind(8))
	farmerPanel9Button.pressed.connect(Callable(buyFarmer).bind(9))
	farmerPanel10Button.pressed.connect(Callable(buyFarmer).bind(10))
	farmerPanel11Button.pressed.connect(Callable(buyFarmer).bind(11))
	farmerPanel12Button.pressed.connect(Callable(buyFarmer).bind(12))
	farmerPanel13Button.pressed.connect(Callable(buyFarmer).bind(13))
	farmerPanel14Button.pressed.connect(Callable(buyFarmer).bind(14))
	
	
	loadAllPanelData()
	
#carga todos los datos en los paneles
func loadAllPanelData():
	for i in range (0, GlobalVariables.player.Fruits.size()):
		loadPanelData(i)
		
#carga los datos de un solo panel	
func loadPanelData(index : int):
	var currentPanelSprite
	var currentPanelButtonCost
	var currentPanelLvlLabel
	var currentFarmerPanelButton
	var currentFarmerSprite
	var currentFarmerLabel
	
	#obtener los nodos del sprite, costo y nivel en cada panel de frutas dependiendo del index
	currentPanelSprite = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/A")
	currentPanelButtonCost = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/Button/CostNumber")
	currentPanelLvlLabel = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/Lvl")
	
	#obtener los nodos del sprite, costo y descripcion de los farmers
	currentFarmerPanelButton = get_node("ScrollContainer2/Control/VBoxContainer/Panel" + str(index) + "/Button")
	currentFarmerSprite = get_node("ScrollContainer2/Control/VBoxContainer/Panel" + str(index) + "/Sprite2D")
	currentFarmerLabel = get_node("ScrollContainer2/Control/VBoxContainer/Panel" + str(index) + "/Label")
	
	currentPanelSprite.texture = GlobalVariables.player.Fruits[index].skin
	if GlobalVariables.player.Fruits[index].cost <= 999:
		currentPanelButtonCost.text = str(GlobalVariables.player.Fruits[index].cost)
	else:
		currentPanelButtonCost.text = GlobalVariables.getMoneyString(GlobalVariables.player.Fruits[index].cost)
	if GlobalVariables.player.Fruits[index].speed == 0:
		GlobalVariables.player.Fruits[index].speed = 10000
		
	var tierText = calculateTierLevel(index)
	if tierText == 20:
		currentPanelLvlLabel.text = str(GlobalVariables.player.Fruits[index].level) + "/20"
	else:
		currentPanelLvlLabel.text = str(GlobalVariables.player.Fruits[index].level) + "/" + str(tierText)
			
	if GlobalVariables.player.Farmer[index].active == true: currentFarmerPanelButton.disabled = true
	else: currentFarmerPanelButton.disabled = false
	
	#falta poner el sprite correcto del farmer almacenado en player save y la descripcion
	
#calcula el el siguiente numero que se pondra en el label de niveles para desbloquear el siguiente tier
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

#compra la fruta y la sube de nivel. si se alcanza un nuevo tier se manda actualizar para tener un nuevo tier
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
	
#salva el progreso de cada barra de fruta para que cuando se cierre y abra el juego, no se pierda el progreso
func saveCurrentProgress(index : int):
	var currentProgressBar = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/ProgressBar")
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

#se manda a ejecutar cada vez que la barra de progreso de cada fruta llega al 100% dentro de esta funcion se manda a llamar el sandiaExchange
func cashOut(index : int):

	var houseId = rng.randi_range(0, GlobalVariables.houseCount)
	var houseLvl
	var frutasObtenidas = GlobalVariables.player.Fruits[index].level
	
	
	#asegurarse que la casa escogida al asar si este vacia, si no lo esta, asignar una nueva
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
	
		#sumar las frutas correspondientes. esto depende del index recibido. index 0 = blueberry, index 1 = cereza,....
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
		
#convertir todas las frutas que estan almacenadas en una casa de jugo a sandia y poner las frutas en 0 menos la sandia
func SandiaExchange(houseId : int):
	
	var litros : float = 0
	var sandiaCount : float = 0
	var divisor : float = (126180517478400*40)
	
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


func showHideFarmers():
	if fruitsScrollContainer.visible == true:
		fruitsScrollContainer.hide()
		farmersScrollContainer.show()
	else:
		fruitsScrollContainer.show()
		farmersScrollContainer.hide()
		
#activar al granjero al momento de comprarlo
func buyFarmer(index : int):
	var currentFarmerPanelButton
	currentFarmerPanelButton = get_node("ScrollContainer2/Control/VBoxContainer/Panel" + str(index) + "/Button")
	currentFarmerPanelButton.disabled = true
	GlobalVariables.player.Farmer[index].active = true
	mainNode.save()
