extends Control

var current : int
@export var data : Array[TutorialData]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	hide()


func evaluate_condition():
	if data[current] != null:
		if data[current].condition.call():
			show()
			
