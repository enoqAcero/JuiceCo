extends TextureProgressBar

var index
var timer := Timer.new()
var timer_remaining : int = 0
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	index = get_number()
	add_child(timer)
	timer.wait_time = 1.0
	timer.timeout.connect(update_remaining_time)
	
	get_parent().get_node("Remaining/Time").text = "0s"
	

func start_progress( index:int ):
	tween = get_tree().create_tween()
	print( "Producing " )
	var fruit = GlobalVariables.player.Fruits[index]
	var time = GlobalVariables.player.Fruits[index].production_timer.time_left
	show()
	value = 0
	tween.tween_property(self, "value", 100, time)
	get_parent().get_node("Remaining/Time").text = str(time).substr(0, 3) + "s"
	timer.start()
	timer_remaining = time
#	var production_time = fruit.production_time / ( ( fruit.level + 1 ) * 2 )
	if time < 1.0:
		get_node("FullBar").show()
	else:
		get_node("FullBar").hide()
	
	
func get_number():
	var result = ""
	var resultInt
	var _name = get_parent().name
	for char in str(_name):
		if char.is_valid_int():
			result = char

	resultInt = int(result)
	return resultInt

func update_remaining_time():
	if GlobalVariables.player.Fruits[index].level < 80:
		timer_remaining -= 1
		timer_remaining = max(0, timer_remaining)
		get_parent().get_node("Remaining/Time").text =  str(timer_remaining).substr(0, 3) + "s"
		
	else:
		get_parent().get_node("Remaining/Time").text =  "0s"
