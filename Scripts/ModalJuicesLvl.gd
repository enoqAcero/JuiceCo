extends Node2D

var player = load("res://Save/PlayerSave.tres")
var JuiceLevel = player.JuiceLevel
var currentJuiceIndex = player.juiceLevel

func _ready():
	
	updateJuiceInfo()

func updateJuiceInfo():
	currentJuiceIndex = player.juiceLevel
	$"Panel/JuiceName".text = JuiceLevel[currentJuiceIndex].name
	$Panel/JuiceDescription.text = JuiceLevel[currentJuiceIndex].description
	var juice_value = GlobalVariables.player.JuiceLevel[currentJuiceIndex].cost
	$Panel/JuiceValue.text = "$ " + ( GlobalVariables.getMoneyString( juice_value ) )
		
	var juice_img = JuiceLevel[currentJuiceIndex].skin
	if juice_img is Texture2D:
		$Panel/TextureRect.texture = juice_img



func _on_next_pressed():
#	currentJuiceIndex = min(currentJuiceIndex + 1, JuiceLevel.size() - 1)
	next_juice_level()
	updateJuiceInfo()


func _on_back_pressed():
	currentJuiceIndex = max(currentJuiceIndex - 1, 0)
	updateJuiceInfo()


func next_juice_level():
	if currentJuiceIndex < GlobalVariables.player.JuiceLevel.size() - 1:
		var limit = GlobalVariables.player.JuiceLevel[ currentJuiceIndex + 1 ].limit
		var magnitude = Magnitudes.list[ GlobalVariables.player.JuiceLevel[ currentJuiceIndex + 1 ].limit_magnitude ].value
		limit*=magnitude
		if GlobalVariables.player.money >= limit:
			currentJuiceIndex += 1
