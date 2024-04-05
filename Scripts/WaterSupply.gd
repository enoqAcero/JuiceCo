extends Node2D

@onready var water_supply := get_parent().get_node('CanvasLayer/WaterSupply')

func _ready():
	
	update()

func check_tanks():
	for node in get_children() : node.hide()
	for i in range(GlobalVariables.player.water_tanks):
		print("Water tank : " + str(GlobalVariables.player.water_tanks))
		get_node("WaterTank" + str(i) ).show()
	
	
func _on_water_tank_pressed():
	update()
	water_supply.show()


func _on_button_pressed():
	water_supply.hide()

func update():
	var cost = GlobalVariables.player.water_supply_cost[ GlobalVariables.player.water_tanks - 1 ]
	water_supply.get_node('UpgradeWaterTank').text = "Increase capacity " + str( GlobalVariables.getMoneyString( cost ) )
	if GlobalVariables.player.money >= cost and GlobalVariables.player.water_tanks <= GlobalVariables.player.water_supply_cost.size() - 1:
		water_supply.get_node('UpgradeWaterTank').disabled = false
	else:
		water_supply.get_node('UpgradeWaterTank').disabled = true
	if GlobalVariables.player.water_tanks > GlobalVariables.player.water_supply_cost.size() - 1:
		water_supply.get_node('UpgradeWaterTank').hide()
	else:
		water_supply.get_node('UpgradeWaterTank').show()
	water_supply.get_node('time').text = "Idle production time\n " + str( GlobalVariables.player.water_tanks ) + " hrs"
	water_supply.get_node('capacity').text = "Current capacity\n " + str( GlobalVariables.player.water_tanks * 100 * 1000  ) + " Lts"
	check_tanks()
	
func _on_upgrade_water_tank_pressed():
	var cost = GlobalVariables.player.water_supply_cost[ GlobalVariables.player.water_tanks - 1 ]
	if GlobalVariables.player.money >= cost:
		GlobalVariables.player.water_tanks += 1
		GlobalVariables.save()
		update()
		
func reset():
	GlobalVariables.player.water_tanks = 1
	GlobalVariables.save()
	update()
