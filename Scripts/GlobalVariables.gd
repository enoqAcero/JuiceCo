extends Node


var player 

var abbFactor : float

# Upgrades multipliers
var fruit_race_multiplier : float = 1.0
var juice_value_multiplier : float = 1.0
var juice_production_multiplier : float = 1.0
var fruit_production_multiplier : Array = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0]
var production_multiplier : float = 1.0
var house_capacity_multiplier : float = 1.0
var vehicle_capacity_multiplier : float = 1.0
var race_spawn_multiplier : float = 1.0
var upgrade_cost_multiplier : float = 1.0

# Boosts multipliers
var earnings_multiplier : float = 1.0
#var farm_value_multiplier : float = 1.0
#var seeds_multiplier : float = 1.0

enum UpgradeType { FEATURE, FARMER, FRUIT_PRODUCTION, VEHICLE_CAPACITY, HOUSE_CAPACITY, JUICE_VALUE, JUICE_PRODUCTION, RACE_SPEED, RACE_SPAWN, UPGRADE_COST }
enum BoostType { FEATURE, EARNINGS, FRUIT_PRODUCTION, JUICE_VALUE }

var save_path = "res://Save/PlayerSave.tres"

func save():
	
	ResourceSaver.save(GlobalVariables.player, save_path)
#	print("Saving from global")
	
func _ready():
	
	set_initial_values()
	
	loadResource()
	
	
func loadResource():
	if ResourceLoader.exists("res://Save/PlayerSave.tres"):
		player = ResourceLoader.load("res://Save/PlayerSave.tres")
	else:
		var newPlayerData = Player.new()
		ResourceSaver.save(newPlayerData, ("res://Save/PlayerSave.tres"))
		player = ResourceLoader.load("res://Save/PlayerSave.tres")
	
	SignalManager.loadData.emit()
	SignalManager.loadHouses.emit()
#	getHouseLvl()
		
#gets the abbreviation needed for the amount of money sent to the function
#and gets the abbFactor to
func getAbb(money : float):
	var abb : String
	abbFactor = 1.0
	
	if money < 999.99:
#		abbFactor = (10.0**3.0)
		abb = ""
	
	elif (money / (10.0**3.0)) < 999.99:
		abbFactor = (10.0**3.0)
		abb = "K"
	elif (money / (10.0**6.0)) < 999.99:
		abbFactor = (10.0**6.0)
		abb = "M"
	elif (money / (10.0**9.0)) < 999.99:
		abbFactor = (10.0**9.0)
		abb = "B"
	elif (money / (10.0**12.0)) < 999.99:
		abbFactor = (10.0**12.0)
		abb = "T"
	elif (money / (10.0**15.0)) < 999.99:
		abbFactor = (10.0**15.0)
		abb = "q"
	elif (money / (10.0**18.0)) < 999.99:
		abbFactor = (10.0**18.0)
		abb = "Q"
	elif (money / (10.0**21.0)) < 999.99:
		abbFactor = (10.0**21)
		abb = "s"
	elif (money / (10.0**24.0)) < 999.99:
		abbFactor = (10.0**24.0)
		abb = "S"
	elif (money / (10.0**27.0)) < 999.99:
		abbFactor = (10.0**27.0)
		abb = "o"
	elif (money / (10.0**30.0)) < 999.99:
		abbFactor = (10.0**30.0)
		abb = "N"
	elif (money / (10.0**33.0)) < 999.99:
		abbFactor = (10.0**33.0)
		abb = "d"
	elif (money / (10.0**36.0)) < 999.99:
		abbFactor = (10.0**36.0)
		abb = "U"
	elif (money / (10.0**39.0)) < 999.99:
		abbFactor = (10.0**39.0)
		abb = "D"
	elif (money / (10.0**42.0)) < 999.99:
		abbFactor = (10.0**42.0)
		abb = "Td"
	elif (money / (10.0**45.0)) < 999.99:
		abbFactor = (10.0**45.0)
		abb = "qd"
	elif (money / (10.0**48.0)) < 999.99:
		abbFactor = (10.0**48.0)
		abb = "Qd"
	elif (money / (10.0**51.0)) < 999.99:
		abbFactor = (10.0**51.0)
		abb = "sd"
	elif (money / (10.0**54.0)) < 999.99:
		abbFactor = (10.0**54.0)
		abb = "Sd"
	elif (money / (10.0**57.0)) < 999.99:
		abbFactor = (10.0**57.0)
		abb = "Od"
	elif (money / (10.0**60.0)) < 999.99:
		abbFactor = (10.0**60.0)
		abb = "Nd"
	elif (money / (10.0**63.0)) < 999.99:
		abbFactor = (10.0**63.0)
		abb = "V"
	elif (money / (10.0**66.0)) < 999.99:
		abbFactor = (10.0**66.0)
		abb = "uV"
	elif (money / (10.0**69.0)) < 999.99:
		abbFactor = (10.0**69.0)
		abb = "dV"
	elif (money / (10.0**72.0)) < 999.99:
		abbFactor = (10.0**72.0)
		abb = "tV"
	elif (money / (10.0**75.0)) < 999.99:
		abbFactor = (10.0**75.0)
		abb = "qV"
	elif (money / (10.0**78.0)) < 999.99:
		abbFactor = (10.0**78.0)
		abb = "QV"
	elif (money / (10.0**81.0)) < 999.99:
		abbFactor = (10.0**81.0)
		abb = "sV"
	elif (money / (10.0**84.0)) < 999.99:
		abbFactor = (10.0**84.0)
		abb = "SV"
	elif (money / (10.0**87.0)) < 999.99:
		abbFactor = (10.0**87.0)
		abb = "OV"
	elif (money / (10.0**90.0)) < 999.99:
		abbFactor = (10.0**90.0)
		abb = "NV"
	elif (money / (10.0**93.0)) < 999.99:
		abbFactor = (10.0**93.0)
		abb = "TG"
		
	return abb
	
#gets the only the first numbers in order to display max 999.99 and then change the number and abbreviation
#ex 999.99 K + 0.01K  --> 1.00M
func getMoneyString(money : float):
	var abb = getAbb(money)
	var moneyString : String
	var newMoneyString = ""
	var result : String
	var i = 0
	var flag = false
	
	money = money / abbFactor
			
	moneyString = str(money)
	
	for letter in moneyString:
		newMoneyString += letter
		if letter == ".":
			flag = true
		if flag == true:
			i += 1
		if i > 2:
			break
	
	result = newMoneyString + abb
	
	return result
	
func set_initial_values():
	fruit_race_multiplier = 1.0
	juice_value_multiplier = 1.0
	for i in fruit_production_multiplier.size():
		fruit_production_multiplier[i] = 1.0
	production_multiplier = 1.0
	juice_production_multiplier = 1.0
	house_capacity_multiplier = 1.0
	vehicle_capacity_multiplier = 1.0
	race_spawn_multiplier = 1.0
	upgrade_cost_multiplier = 1.0
	earnings_multiplier = 1.0
#	farm_value_multiplier = 1.0
#	seeds_multiplier = 1.0
	save()

func reset():
	set_initial_values()
	player.money = 1000000
	save()
	
func hard_reset():
	player.total_earnings = 0
	player.total_fruit_production = 0
	player.total_juice_production = 0
	player.total_expenses = 0
	player.farm_value = 0
	
	save()
