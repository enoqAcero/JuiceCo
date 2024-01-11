extends Camera2D

var previousPosition: Vector2 = Vector2(0, 0)
var moveCamera: bool = false

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		get_viewport().set_input_as_handled()
		if event.is_pressed():
			previousPosition = event.position
			moveCamera = true
		else:
			moveCamera = false
	elif event is InputEventMouseMotion && moveCamera:
		get_viewport().set_input_as_handled()
		position += (previousPosition - event.position)
		previousPosition = event.position
