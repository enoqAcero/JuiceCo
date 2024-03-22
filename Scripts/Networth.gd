extends Node2D

@onready var list := $Panel/ScrollContainer/VBoxContainer
var item_scene := load("res://Scenes/networth_item.tscn")
@onready var text = get_node("Panel/Label")

func _ready():
	show_list()

func show_list():
	
	for item in list.get_children():
		item.queue_free()
	
	text.text = "You are currently worth $ " + GlobalVariables.getMoneyString( GlobalVariables.player.money )
	text.text += "\n What you could afford with these numbers: "
	
	for i in GlobalVariables.player.networth_levels.size():
		
		var networth = GlobalVariables.player.networth_levels[i]
		var item = item_scene.instantiate()
		var magnitude = Magnitudes.list[ i+1 ]
		
		if GlobalVariables.player.money < magnitude.value:
#			pass
			return
		
		item.get_node("Money").text = "1" + magnitude.ab + " = " + str( magnitude.zeros ) + " zeros figure"
		item.get_node("Message").text = networth
		list.add_child( item )

func _on_button_pressed():
	hide()
