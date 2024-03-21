extends Node2D

var player = load("res://Save/PlayerSave.tres")
var JuiceLevel = player.JuiceLevel
var currentJuiceIndex = player.juiceLevel

func _ready():
	
	updateJuiceInfo()

func updateJuiceInfo():

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
	currentJuiceIndex -= 1
	currentJuiceIndex = max( currentJuiceIndex, 0 )
	updateJuiceInfo()


func next_juice_level():
	var level = GlobalVariables.player.JuiceLevel[ currentJuiceIndex + 1 ]
	var cost = level.cost
	var magnitude = Magnitudes.list[ level.cost_magnitude ].value
	cost *= magnitude
	print( "COST " + str(cost) )
	if (GlobalVariables.player.money >= cost) or (GlobalVariables.player.juiceLevel >=  currentJuiceIndex+1 ):
		currentJuiceIndex += 1
