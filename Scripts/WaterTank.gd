extends Node2D

func _on_button_pressed():
	hide()


func _on_progress_bar_value_changed(value):
	var style = $Panel/ProgressBar.get_theme_stylebox("fill")
	if value > 90:
		style.bg_color = Color( "e42a00" )
	else:
		style.bg_color = Color( "00a6ff" )
