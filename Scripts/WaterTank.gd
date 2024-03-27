extends Control

func _on_button_pressed():
	hide()

func _process(delta):
	if visible:
		var total : float
		var capacity : float
		for house in GlobalVariables.player.CurrentJuiceHouse:
			total += house.used_space()
			capacity += house.currentCapacity
		$Panel/ProgressBar.value = total / capacity * 100

func _on_progress_bar_value_changed(value):
	var style = $Panel/ProgressBar.get_theme_stylebox("fill")
	if value > 90:
		style.bg_color = Color( "e42a00" )
	else:
		style.bg_color = Color( "00a6ff" )
