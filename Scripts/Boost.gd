extends Control

@onready var item_scene := load("res://Scenes/PurchaseItem.tscn")
@onready var boosts_list := $Panel/ScrollContainer/VBoxContainer

func _ready():
	
	initialize_boosts()

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
		
		enable_boost( index, true )
		
		GlobalVariables.save()
		
	fill_boosts_list()

func _on_close_button_pressed():
	hide()

func initialize_boosts():
	
	for i in range( GlobalVariables.player.Boosts.size() ):
		var boost = GlobalVariables.player.Boosts[ i ]
		
		add_child( GlobalVariables.player.Boosts[ i ].timer )
		GlobalVariables.player.Boosts[ i ].timer.wait_time = boost.duration
		GlobalVariables.player.Boosts[ i ].timer.timeout.connect( Callable( enable_boost ).bind( i, false ) )
		
	
		if GlobalVariables.player.Boosts[ i ].active:
			enable_boost( i, true )
		
func enable_boost( index:int, enable:bool ):
	var boost = GlobalVariables.player.Boosts[ index ]
	if enable:
		match boost.type:
			GlobalVariables.BoostType.FEATURE:
				match index:
					0:
						pass
			GlobalVariables.BoostType.EARNINGS:
				GlobalVariables.earnings_multiplier *= boost.multiplier
			
			GlobalVariables.BoostType.JUICE_VALUE:
				GlobalVariables.juice_value_multiplier *= boost.multiplier
				
			GlobalVariables.BoostType.FRUIT_PRODUCTION:
				GlobalVariables.production_multiplier *= boost.multiplier

		GlobalVariables.player.Boosts[ index ].timer.start()
	else:
		match boost.type:
			GlobalVariables.BoostType.FEATURE:
				match index:
					0:
						pass
			GlobalVariables.BoostType.EARNINGS:
				GlobalVariables.earnings_multiplier /= boost.multiplier
			
			GlobalVariables.BoostType.JUICE_VALUE:
				GlobalVariables.juice_value_multiplier /= boost.multiplier
				
			GlobalVariables.BoostType.FRUIT_PRODUCTION:
				GlobalVariables.production_multiplier /= boost.multiplier
				
		GlobalVariables.player.Boosts[ index ].active = false
		GlobalVariables.player.Boosts[ index ].timer.stop()
	
	fill_boosts_list()

func reset():
	for i in range(GlobalVariables.player.Boosts.size()):
		var boost = GlobalVariables.player.Boosts[i]
		if boost != null:
			GlobalVariables.player.Boosts[i].active = false
			
			enable_boost( i, false )
				
			GlobalVariables.save()
			
	fill_boosts_list()
		
