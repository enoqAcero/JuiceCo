extends Node2D



func _on_button_pressed():
	hide()


func _on_close_pressed():
	$AnimationPlayer.play("venclose")
