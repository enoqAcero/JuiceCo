extends Node2D



func _on_button_pressed():
	hide()


func _on_close_pressed():
	$AnimationPlayer.play("venclose")
	
func reset():
	for i in GlobalVariables.player.Vehicles.size():
		GlobalVariables.player.Vehicles[i] = 0
	GlobalVariables.player.Vehicles[0] = 1
