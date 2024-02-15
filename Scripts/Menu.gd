extends Node2D

var button1
var button2
var button3
var button4
var button5
var button6
# Called when the node enters the scene tree for the first time.
func _ready():
	button1 = $GridContainer/Label/Sprite2D/Button
	button2 = $GridContainer/Label2/Sprite2D/Button
	button3 = $GridContainer/Label3/Sprite2D/Button
	button4 = $GridContainer/Label4/Sprite2D/Button
	button5 = $GridContainer/Label5/Sprite2D/Button
	button6 = $GridContainer/Label6/Sprite2D/Button
	
	button1.pressed.connect(help)
	button2.pressed.connect(reset)
	button3.pressed.connect(settings)
	button4.pressed.connect(about)
	button5.pressed.connect(stats)
	
	
func help():
	pass
func reset():
	pass
func settings():
	pass
func about():
	pass
func stats():
	pass


func _on_bankbutton_pressed():
	$bankmodal.show()
	$GridContainer.hide()

func _on_bankclose_pressed():
	$bankmodal.hide()
	$GridContainer.show()
