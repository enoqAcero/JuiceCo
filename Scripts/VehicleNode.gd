extends Node2D

var i := 0

func set_vehicle():
	if i > 3 : i = 0
	for node in get_children():
		if node is Sprite2D : node.hide()
	var vehicle = GlobalVariables.player.Vehicles[ i ] - 1
	if vehicle < 0:
		i += 1
		set_vehicle()
		return
	get_node( str( vehicle ) ).show()
	i += 1
