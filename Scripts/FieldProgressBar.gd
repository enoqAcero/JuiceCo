extends ProgressBar

var tween
var fieldNode
var parentName
var index
var remainingTime
var firstTweenFlag = false

# Called when the node enters the scene tree for the first time.
func _ready():
	fieldNode = get_parent().get_parent().get_parent().get_parent().get_parent()
	parentName = get_parent().name
	index = getNumberFromString(parentName)
	self.value = GlobalVariables.player.Fruits[index].currentProgress
	if GlobalVariables.player.Fruits[index].level >= 1 and GlobalVariables.player.Farmer[index].active == true:
		firstTweenFlag = true
		addTween()

func _process(_delta):
	if GlobalVariables.player.Fruits[index].level >= 1 and firstTweenFlag == false and GlobalVariables.player.Farmer[index].active == true:
		addTween()
		firstTweenFlag = true
		
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
	
func calcRemainingTime():
	var speed =  GlobalVariables.player.Fruits[index].speed
	var currentProgress = GlobalVariables.player.Fruits[index].currentProgress
	remainingTime = speed - (currentProgress/100) * speed
	
	
	
func getNumberFromString(nodeName : String):
	var result = ""
	var resultInt
	for c in nodeName:
		if c.is_valid_int():
			result = c
	
	resultInt = int(result)
	return resultInt
