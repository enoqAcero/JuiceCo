extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$seedsCount.text = str (GlobalVariables.player.seeds) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_reset_all_pressed():
	GlobalVariables.player.resets += 1
	GlobalVariables.player.seeds += GlobalVariables.player.farmValue * 0.1
	$seedsCount.text = str (GlobalVariables.player.seeds) 
	GlobalVariables.player.money = 0.0
	GlobalVariables.player.liters = 0.0
	GlobalVariables.player.litersPerSecond = 0.0
	GlobalVariables.player.sandiasPerSecond = 0.0
	GlobalVariables.player.farmValue = 0.0
	GlobalVariables.player.house0Id = 1
	GlobalVariables.player.house1Id = 0
	GlobalVariables.player.house2Id = 0
	GlobalVariables.player.house3Id = 0
	GlobalVariables.player.transport0Id = 1
	
	for i in range(0, GlobalVariables.player.CurrentJuiceHouse.size()):
		GlobalVariables.player.CurrentJuiceHouse[i].houseLvl = 0
		GlobalVariables.player.CurrentJuiceHouse[i].fullHouse = false
		GlobalVariables.player.CurrentJuiceHouse[i].fullSandiaHouse = false
		GlobalVariables.player.CurrentJuiceHouse[i].currentCapacity = 0
		GlobalVariables.player.CurrentJuiceHouse[i].blueberryCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].cerezaCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].fresaCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].limonCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].duraznoCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].manzanaCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].naranjaCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].aguacateCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].mangoCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].dragonfruitCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].cocoCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].ananaCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].papayaCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].melonCount = 0
		GlobalVariables.player.CurrentJuiceHouse[i].sandiaCount = 0
		
	for i in range(0, GlobalVariables.player.Fruits.size()):
		GlobalVariables.player.Fruits[i].level = 0
		GlobalVariables.player.Fruits[i].tier  = 0
		GlobalVariables.player.Fruits[i].cost = GlobalVariables.player.Fruits[i].initialCost
		GlobalVariables.player.Fruits[i].speed = GlobalVariables.player.Fruits[i].initialSpeed
		GlobalVariables.player.Fruits[i].currentProgress = 0
	
	GlobalVariables.player.transport0Id = 1
	GlobalVariables.player.transport1Id = 0
	GlobalVariables.player.transport2Id = 0
	GlobalVariables.player.transport3Id = 0
	GlobalVariables.player.transport4Id = 0
	GlobalVariables.player.transport5Id = 0
	GlobalVariables.player.transport6Id = 0
	GlobalVariables.player.transport7Id = 0
	GlobalVariables.player.transport8Id = 0
	GlobalVariables.player.transport9Id = 0
	GlobalVariables.player.transport10Id = 0
	GlobalVariables.player.transport11Id = 0
	GlobalVariables.player.transport12Id = 0
	GlobalVariables.player.transport13Id = 0
	GlobalVariables.player.transport14Id = 0
	GlobalVariables.player.WaterTank.count = 1
	GlobalVariables.player.juiceLevel = 0
	
