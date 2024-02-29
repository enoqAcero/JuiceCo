extends Area2D

@export var id : int
var entered_count := 0
var full := false

func _on_body_entered(body):
	
	entered_count += 1
	if entered_count > 0:
		$CollisionShape.debug_color = Color.RED
		full = true
	


func _on_body_exited(body):
	
	entered_count -=  1
	if entered_count == 0:
		$CollisionShape.debug_color = Color.SKY_BLUE
		full = false
	
