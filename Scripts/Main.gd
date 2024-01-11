extends Node2D

var playerData : Player
var savePath = "res://Save/PlayerSave.tres"

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
	
