extends Node2D

var panelNode0Button
var panelNode1Button
var panelNode2Button
var panelNode3Button
var panelNode4Button
var panelNode5Button
var panelNode6Button
var panelNode7Button
var panelNode8Button
var panelNode9Button
var panelNode10Button
var panelNode11Button
var panelNode12Button
var panelNode13Button
var panelNode14Button

var panelNode0ProgressBar
var panelNode1ProgressBar
var panelNode2ProgressBar
var panelNode3ProgressBar
var panelNode4ProgressBar
var panelNode5ProgressBar
var panelNode6ProgressBar
var panelNode7ProgressBar
var panelNode8ProgressBar
var panelNode9ProgressBar
var panelNode10ProgressBar
var panelNode11ProgressBar
var panelNode12ProgressBar
var panelNode13ProgressBar
var panelNode14ProgressBar

var animationPlayer : AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	panelNode0Button = $ScrollContainer/Control/VBoxContainer/Panel0/Button
	panelNode1Button = $ScrollContainer/Control/VBoxContainer/Panel1/Button
	panelNode2Button = $ScrollContainer/Control/VBoxContainer/Panel2/Button
	panelNode3Button = $ScrollContainer/Control/VBoxContainer/Panel3/Button
	panelNode4Button = $ScrollContainer/Control/VBoxContainer/Panel4/Button
	panelNode5Button = $ScrollContainer/Control/VBoxContainer/Panel5/Button
	panelNode6Button = $ScrollContainer/Control/VBoxContainer/Panel6/Button
	panelNode7Button = $ScrollContainer/Control/VBoxContainer/Panel7/Button
	panelNode8Button = $ScrollContainer/Control/VBoxContainer/Panel8/Button
	panelNode9Button = $ScrollContainer/Control/VBoxContainer/Panel9/Button
	panelNode10Button = $ScrollContainer/Control/VBoxContainer/Panel10/Button
	panelNode11Button = $ScrollContainer/Control/VBoxContainer/Panel11/Button
	panelNode12Button = $ScrollContainer/Control/VBoxContainer/Panel12/Button
	panelNode13Button = $ScrollContainer/Control/VBoxContainer/Panel13/Button
	panelNode14Button = $ScrollContainer/Control/VBoxContainer/Panel14/Button
	
	panelNode0ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel0/ProgressBar
	panelNode1ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel1/ProgressBar
	panelNode2ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel2/ProgressBar
	panelNode3ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel3/ProgressBar
	panelNode4ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel4/ProgressBar
	panelNode5ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel5/ProgressBar
	panelNode6ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel6/ProgressBar
	panelNode7ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel7/ProgressBar
	panelNode8ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel8/ProgressBar
	panelNode9ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel9/ProgressBar
	panelNode10ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel10/ProgressBar
	panelNode11ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel11/ProgressBar
	panelNode12ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel12/ProgressBar
	panelNode13ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel13/ProgressBar
	panelNode14ProgressBar = $ScrollContainer/Control/VBoxContainer/Panel14/ProgressBar
	
	animationPlayer = $AnimationPlayer

	
	panelNode0Button.pressed.connect(Callable(buyFruit).bind(0))
	panelNode1Button.pressed.connect(Callable(buyFruit).bind(1))
	panelNode2Button.pressed.connect(Callable(buyFruit).bind(2))
	panelNode3Button.pressed.connect(Callable(buyFruit).bind(3))
	panelNode4Button.pressed.connect(Callable(buyFruit).bind(4))
	panelNode5Button.pressed.connect(Callable(buyFruit).bind(5))
	panelNode6Button.pressed.connect(Callable(buyFruit).bind(6))
	panelNode7Button.pressed.connect(Callable(buyFruit).bind(7))
	panelNode8Button.pressed.connect(Callable(buyFruit).bind(8))
	panelNode9Button.pressed.connect(Callable(buyFruit).bind(9))
	panelNode10Button.pressed.connect(Callable(buyFruit).bind(10))
	panelNode11Button.pressed.connect(Callable(buyFruit).bind(11))
	panelNode12Button.pressed.connect(Callable(buyFruit).bind(12))
	panelNode13Button.pressed.connect(Callable(buyFruit).bind(13))
	panelNode14Button.pressed.connect(Callable(buyFruit).bind(14))
	
	loadAllPanelData()
	startAnimations()
	
func loadAllPanelData():
	for i in range (0, GlobalVariables.player.Fruits.size()):
		loadPanelData(i)
		
func loadPanelData(index : int):
	var currentPanelProgressBar
	var currentPanelSprite
	var currentPanelButtonCost
	var currentPanelButtonAbb
	var currentPanelLvlLabel
	
	currentPanelProgressBar = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/ProgressBar")
	currentPanelSprite = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/A")
	currentPanelButtonCost = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/Button/CostNumber")
	currentPanelButtonAbb = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/Button/CostAbb")
	currentPanelLvlLabel = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/Lvl")
	
	currentPanelSprite.texture = GlobalVariables.player.Fruits[index].skin
	currentPanelButtonCost.text = str(GlobalVariables.player.Fruits[index].cost)
	currentPanelButtonAbb.text = "NoAbb"
	
	var tierText = calculateTierLevel(index)
	if tierText == 20:
		currentPanelLvlLabel.text = str(GlobalVariables.player.Fruits[index].level) + "/20"
	else:
		currentPanelLvlLabel.text = str(GlobalVariables.player.Fruits[index].level) + "/" + str(tierText)
			
			
			
func calculateTierLevel(index : int):
	var tierText = 20
	if GlobalVariables.player.Fruits[index].level < 20:
		tierText = 20
	elif GlobalVariables.player.Fruits[index].level < 100:
		tierText = ((GlobalVariables.player.Fruits[index].tier) * 20)
	elif GlobalVariables.player.Fruits[index].level < 1000:
		tierText = ((GlobalVariables.player.Fruits[index].tier - 4) * 100)
	elif GlobalVariables.player.Fruits[index].level < 2000:
		tierText = ((GlobalVariables.player.Fruits[index].tier - 9) * 200)
	elif GlobalVariables.player.Fruits[index].level >= 2000:
		tierText = ((GlobalVariables.player.Fruits[index].tier - 15) * 500)
	
	return tierText

func buyFruit(index : int):
	var cost = GlobalVariables.player.Fruits[index].cost
	var mult = GlobalVariables.player.Fruits[index].multiplier
	var level = GlobalVariables.player.Fruits[index].level
	var speed = GlobalVariables.player.Fruits[index].speed
	var tierText = calculateTierLevel(index)
	
	GlobalVariables.player.Fruits[index].cost = cost * mult
	GlobalVariables.player.Fruits[index].level += 1
	
	if level >= tierText - 1:
		GlobalVariables.player.Fruits[index].tier += 1
		GlobalVariables.player.Fruits[index].speed = speed / 2
		saveCurrentTime(index)
		updateAnimation("Panel" + str(index) + "ProgressBar", GlobalVariables.player.Fruits[index].speed)
	
	loadPanelData(index)
	

		
func startAnimations():
	for i in range (0, GlobalVariables.player.Fruits.size()):
		updateAnimation("Panel" + str(i) + "ProgressBar", GlobalVariables.player.Fruits[i].speed)
		$AnimationPlayer.play("Panel" + str(i) + "ProgressBar")
		

func _on_animation_player_animation_finished(animName):
	if animName == "Panel0ProgressBar":
		panelNode0ProgressBar.value = 0
		$AnimationPlayer.play("Panel0ProgressBar")
		
		
func updateAnimation(animName : String, time : float):
	if animationPlayer.has_animation(animName):
		# Set the new length for the specified animation
		var animation = animationPlayer.get_animation(animName)
		animation.length = time
		# Update the final property key to the animation length
		updateFinalKey(animName, time)
	else:
		print("Animation", animName, "not found in AnimationPlayer")


func updateFinalKey(animName : String, time : float):
	
	# Iterate through tracks in the animation
	var animation = animationPlayer.get_animation(animName)
	for track_index in range(animation.get_track_count()):
	# Iterate through keyframes in the track
		for key_index in range(animation.track_get_key_count(track_index)):
		# Get the time of the keyframe
			# Check if it's the last keyframe in the track
			if key_index == animation.track_get_key_count(track_index) - 1:
				# Update the time of the last keyframe to the animation length
				animation.track_set_key_time(track_index,key_index,time)
				
	animationPlayer.play(animName)
	for i in range (0, GlobalVariables.player.Fruits.size()):
		var currentProgressBar = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(i) + "/ProgressBar")
		currentProgressBar.value = GlobalVariables.player.Fruits[i].currentValue
			
	
func _on_button_pressed():
	hide()


func saveCurrentTime(index : int):
	var currentProgressBar = get_node("ScrollContainer/Control/VBoxContainer/Panel" + str(index) + "/ProgressBar")
	GlobalVariables.player.Fruits[index].currentValue = currentProgressBar.value
