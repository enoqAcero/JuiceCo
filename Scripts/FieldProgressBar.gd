extends TextureProgressBar

var tween
var fieldNode
var parentName
var index
var remainingTime

# Called when the node enters the scene tree for the first time.
func _ready():
	fieldNode = get_parent().get_parent().get_parent().get_parent().get_parent()
	parentName = get_parent().name
	index = getNumberFromString(parentName)
	self.value = GlobalVariables.player.Fruits[index].currentProgress
	addTween()

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
