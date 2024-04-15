extends Control


func _ready():
	GlobalVariables.player.tutorial_data[ 0 ].condition = func(): return true
	GlobalVariables.player.tutorial_data[ 1 ].condition = acquire_first
	GlobalVariables.player.tutorial_data[ 2 ].condition = produce_first
	GlobalVariables.save()
	$Timer.start()

func _on_button_pressed():
	GlobalVariables.player.current_tutorial += 1
	GlobalVariables.save()
	hide()


func evaluate_condition():
	if GlobalVariables.player.current_tutorial >= GlobalVariables.player.tutorial_data.size():
		$Timer.stop()
		return
	
	var i : int = GlobalVariables.player.current_tutorial
	if GlobalVariables.player.tutorial_data[ i ].condition.call():
		$Panel/Text.text = GlobalVariables.player.tutorial_data[ i ].text
		$Panel/Image.texture = GlobalVariables.player.tutorial_data[ i ].image
		show()
		
func reset():
	GlobalVariables.player.current_tutorial = 0
	GlobalVariables.save()
	$Timer.start()


func acquire_first():
	if get_tree().get_root().get_node('Main/CanvasLayer/Field').visible: 
		return true
	return false
	
func produce_first():
	if GlobalVariables.player.Fruits[0].acquired:
		return true
	return false
