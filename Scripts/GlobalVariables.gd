extends Node


var player 



func _ready():
	loadData()
	
	
func loadData():
	if ResourceLoader.exists("res://Save/PlayerSave.tres"):
		player = ResourceLoader.load("res://Save/PlayerSave.tres")
	else:
		var newPlayerData = Player.new()
		ResourceSaver.save(newPlayerData, ("res://Save/PlayerSave.tres"))
		player = ResourceLoader.load("res://Save/PlayerSave.tres")
