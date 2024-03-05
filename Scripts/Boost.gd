extends Node2D

@onready var item_scene := load("res://Scenes/PurchaseItem.tscn")
@onready var boosts_list := $Panel/ScrollContainer/VBoxContainer

func _ready():
	reset_boosts()
	fill_boosts_list()
	
func fill_boosts_list():
	
	clean_list()
	
	for i in GlobalVariables.player.Boosts.size():
		
		var boost = GlobalVariables.player.Boosts[i]
		
		if boost.active:
			continue
		
		var item = item_scene.instantiate()

		item.get_node("Icon").texture = boost.skin
		item.get_node("Button").text = GlobalVariables.getMoneyString( boost.cost )
		item.get_node("Button").show()
		item.get_node("ButtonEpic").hide()
		item.get_node("Name").text = boost.name
		item.get_node("Description").text = boost.description

		if boost.cost > GlobalVariables.player.money:
			item.get_node("Button").disabled = true

		else:
			item.get_node("Button").pressed.connect( Callable(buy_boost).bind( i ) )
		
		boosts_list.add_child( item )

func clean_list():
	for item in boosts_list.get_children():
		item.queue_free()

func buy_boost(index:int):
	if GlobalVariables.player.money >= GlobalVariables.player.Boosts[index].cost:
		GlobalVariables.player.money -= GlobalVariables.player.Boosts[index].cost
		GlobalVariables.player.Boosts[index].active = true
	fill_boosts_list()

func _on_close_button_pressed():
	hide()
	
func reset_boosts():
	for i in range(GlobalVariables.player.Boosts.size()):
		GlobalVariables.player.Boosts[i].active = false
