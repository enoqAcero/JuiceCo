extends StaticBody2D



func _on_area_2d_body_entered(body):
	if body.is_in_group("Fruit"):
		var fruit_id = body.fruit_number
		GlobalVariables.total_fruit_count[ fruit_id ] += 1
#		GlobalVariables.totalMangoCount += 1
		GlobalVariables.multiplier -= GlobalVariables.multiplierSteps
		body.queue_free()
		
	
		
