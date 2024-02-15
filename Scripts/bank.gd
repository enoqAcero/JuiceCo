extends Node2D


func _ready():
	$ColorRect/bankcounter.text = str(GlobalVariables.player.bankgems)
	$ColorRect/gems.text = str(GlobalVariables.player.gems)
	updateCashOutButton()


func _on_cashout_gems_pressed():
	GlobalVariables.player.gems += GlobalVariables.player.bankgems
	$ColorRect/gems.text = str(GlobalVariables.player.gems)
	GlobalVariables.player.bankgems = 0
	$ColorRect/bankcounter.text = str(GlobalVariables.player.bankgems)
	updateCashOutButton()

func updateCashOutButton():
	$cashoutGems.disabled = GlobalVariables.player.bankgems == 0
