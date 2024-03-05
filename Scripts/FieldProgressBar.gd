extends TextureProgressBar

var tween
var fieldNode
var parentName
var index
var remainingTime
var timer := Timer.new()
var timer_remaining

# Called when the node enters the scene tree for the first time.
func _ready():
	fieldNode = get_parent().get_parent().get_parent().get_parent().get_parent()
	parentName = get_parent().name
	index = getNumberFromString(parentName)
	self.value = GlobalVariables.player.Fruits[index].currentProgress
	add_child(timer)
	timer.wait_time = 1.0
	timer.timeout.connect(update_remaining_time)
	addTween()


func _process(delta):
	if self.value >= self.max_value:
		self.value = 0
		fieldNode.cashOut(index)
		GlobalVariables.player.Fruits[index].currentProgress = 0
		tween.kill()
		addTween()
		
func addTween():
	calcRemainingTime()
	tween = get_tree().create_tween()
	tween.tween_property(self, "value", 100, remainingTime).set_trans(Tween.TRANS_LINEAR)
	if GlobalVariables.player.Fruits[index].level < 80:
		get_parent().get_node("Remaining/Time").text = str(remainingTime).substr(0, 3) + "s"
	else:
		get_parent().get_node("Remaining/Time").text = "0s"
	timer_remaining = remainingTime
	timer.start()
	
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

func update_remaining_time():
	if GlobalVariables.player.Fruits[index].level < 80:
		timer_remaining -= 1
		get_parent().get_node("Remaining/Time").text =  str(timer_remaining).substr(0, 3) + "s"
		
	else:
		get_parent().get_node("Remaining/Time").text =  "0s"
