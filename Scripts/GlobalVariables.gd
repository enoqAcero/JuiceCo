extends Node


var player 






var litersAbbreviation
var moneyAbbreviation
var abbFactor

func _ready():
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
		
#gets the abbreviation needed for the amount of money sent to the function
#and gets the abbFactor to
func getAbb(money : float):
	var abb : String
	abbFactor = 1
	
	if (money / (10**3)) < 999.99:
		abbFactor = (10**3)
		abb = "K"
	elif (money / (10**6)) < 999.99:
		abbFactor = (10**6)
		abb = "M"
	elif (money / (10**9)) < 999.99:
		abbFactor = (10**9)
		abb = "B"
	elif (money / (10**12)) < 999.99:
		abbFactor = (10**12)
		abb = "T"
	elif (money / (10**15)) < 999.99:
		abbFactor = (10**15)
		abb = "q"
	elif (money / (10**18)) < 999.99:
		abbFactor = (10**18)
		abb = "Q"
	elif (money / (10**21)) < 999.99:
		abbFactor = (10**21)
		abb = "s"
	elif (money / (10**24)) < 999.99:
		abbFactor = (10**24)
		abb = "S"
	elif (money / (10**27)) < 999.99:
		abbFactor = (10**27)
		abb = "o"
	elif (money / (10**30)) < 999.99:
		abbFactor = (10**30)
		abb = "N"
	elif (money / (10**33)) < 999.99:
		abbFactor = (10**33)
		abb = "d"
	elif (money / (10**36)) < 999.99:
		abbFactor = (10**36)
		abb = "U"
	elif (money / (10**39)) < 999.99:
		abbFactor = (10**39)
		abb = "D"
	elif (money / (10**42)) < 999.99:
		abbFactor = (10**42)
		abb = "Td"
	elif (money / (10**45)) < 999.99:
		abbFactor = (10**45)
		abb = "qd"
	elif (money / (10**48)) < 999.99:
		abbFactor = (10**48)
		abb = "Qd"
	elif (money / (10**51)) < 999.99:
		abbFactor = (10**51)
		abb = "sd"
	elif (money / (10**54)) < 999.99:
		abbFactor = (10**54)
		abb = "Sd"
	elif (money / (10**57)) < 999.99:
		abbFactor = (10**57)
		abb = "Od"
	elif (money / (10**60)) < 999.99:
		abbFactor = (10**60)
		abb = "Nd"
	elif (money / (10**63)) < 999.99:
		abbFactor = (10**63)
		abb = "V"
	elif (money / (10**66)) < 999.99:
		abbFactor = (10**66)
		abb = "uV"
	elif (money / (10**69)) < 999.99:
		abbFactor = (10**69)
		abb = "dV"
	elif (money / (10**72)) < 999.99:
		abbFactor = (10**72)
		abb = "tV"
	elif (money / (10**75)) < 999.99:
		abbFactor = (10**75)
		abb = "qV"
	elif (money / (10**78)) < 999.99:
		abbFactor = (10**78)
		abb = "QV"
	elif (money / (10**81)) < 999.99:
		abbFactor = (10**81)
		abb = "sV"
	elif (money / (10**84)) < 999.99:
		abbFactor = (10**84)
		abb = "SV"
	elif (money / (10**87)) < 999.99:
		abbFactor = (10**87)
		abb = "OV"
	elif (money / (10**90)) < 999.99:
		abbFactor = (10**90)
		abb = "NV"
	elif (money / (10**93)) < 999.99:
		abbFactor = (10**93)
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
	
