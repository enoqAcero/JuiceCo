extends TextureProgressBar

var tween
var fieldNode
var parentName
var index
var remainingTime
var timerWait

var timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	fieldNode = get_parent().get_parent().get_parent().get_parent().get_parent()
	parentName = get_parent().name
	index = getNumberFromString(parentName)
	self.value = GlobalVariables.player.Fruits[index].currentProgress
	addTween()
	add_child(timer)
	

func _process(delta):
	if self.value >= self.max_value:
		self.value = 0
#		print(get_parent().name + " Bar value: " +str(value))
		fieldNode.cashOut(index)
		GlobalVariables.player.Fruits[index].currentProgress = 0
		tween.kill()
		addTween()
		
func addTween():
	calcRemainingTime()
	tween = get_tree().create_tween()
	tween.tween_property(self, "value", 100, remainingTime).set_trans(Tween.TRANS_LINEAR)
	timer.wait_time = 1.0
	timer.connect("timeout", Callable(update_remaining_label))
	timer.start()
	timerWait = remainingTime
	get_parent().get_node("Remaining/Time").text = str( remainingTime )
	
func calcRemainingTime():
	var speed =  GlobalVariables.player.Fruits[index].speed
	var currentProgress = GlobalVariables.player.Fruits[index].currentProgress
	remainingTime = speed - (currentProgress/100) * speed

func getNumberFromString(name : String):
	var result = ""
	var resultInt
	for char in name:
		if char.is_valid_int():
			result = char
	
	resultInt = int(result)
	return resultInt
	
func update_remaining_label():
	timerWait -= 1.0
	get_parent().get_node("Remaining/Time").text = str( timerWait )
