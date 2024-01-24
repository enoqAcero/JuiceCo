extends StaticBody2D



func _on_area_2d_body_entered(body):
	if body.is_in_group("mango"):
		GlobalVariables.totalMangoCount += 1
	

	if body.is_in_group("fruit"):
		GlobalVariables.multiplier -= GlobalVariables.multiplierSteps
		body.queue_free()
		
	
		
