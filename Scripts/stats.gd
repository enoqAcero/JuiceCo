extends Node2D

@onready var label := $Panel/Label

func _ready():
	show_stats()

func show_stats():
	label.text = "Money: $" + GlobalVariables.getMoneyString( GlobalVariables.player.money )
	label.text += "\n Total earnings: $" + GlobalVariables.getMoneyString( GlobalVariables.player.total_earnings )
	label.text += "\n Fruits produced: " + GlobalVariables.getMoneyString( GlobalVariables.player.total_fruit_production ) + " fruits"
	label.text += "\n Juice produced: " + GlobalVariables.getMoneyString( GlobalVariables.player.total_juice_production ) + " liters"
	label.text += "\n Total spent: $" + GlobalVariables.getMoneyString( GlobalVariables.player.total_expenses )
	label.text += "\n Farm value: $" + GlobalVariables.getMoneyString( GlobalVariables.player.farm_value )

func _on_button_pressed():
	hide()
