extends Control

var rand = RandomNumberGenerator.new()

var mainNode

var multGananciasBtn
var gemYdineroBtn
var gemasBtn

var multGananciasTimer
var gemYdineroTimer
var gemasTimer
var waitTimeControl = false

var timercontrol1 = false
var timercontrol2 = false
var timercontrol3 = false

var adModalNode
var adRewardNode
var adRewardLabel
var adRewardSprite

#0 = multGanancias, 1 = gemYdinero, 2 = gemas
var adIndex = -1



func _ready():	
	randomize()
	
	mainNode = get_parent().get_parent()
	
	multGananciasBtn = $VBoxContainer/multGanancias
	gemYdineroBtn = $VBoxContainer/gemYdinero
	gemasBtn = $VBoxContainer/gemas
	
	multGananciasTimer = $VBoxContainer/multGanancias/Timer
	gemYdineroTimer = $VBoxContainer/gemYdinero/Timer
	gemasTimer = $VBoxContainer/gemas/Timer
	
	adModalNode = $adModal
	adRewardNode = $adRewardModal
	adRewardLabel = $adRewardModal.get_node("VBoxContainer/Label")
	adRewardSprite = $adRewardModal.get_node("VBoxContainer/Sprite2D")
	
	multGananciasTimer.one_shot = true
	gemYdineroTimer.one_shot = true
	gemasTimer.one_shot = true
	
	mainNode.calculateAdTime()
	
	multGananciasBtn.pressed.connect(adMultGanancias)
	gemYdineroBtn.pressed.connect(adGemYdinero)
	gemasBtn.pressed.connect(adGemas)
	
	multGananciasTimer.timeout.connect(Callable(powerUpEnd).bind(0))
	gemYdineroTimer.timeout.connect(Callable(powerUpEnd).bind(1))
	gemasTimer.timeout.connect(Callable(powerUpEnd).bind(2))
	
	$adModal.get_node("VBoxContainer/accept").pressed.connect(accept)
	$adModal.get_node("VBoxContainer/cancel").pressed.connect(cancel)
	$adRewardModal.get_node("VBoxContainer/close").pressed.connect(cancel)
	
func _process(_delta):
	if waitTimeControl == false:
		multGananciasTimer.wait_time = GlobalVariables.multGananciasAdRemainingTime
		gemYdineroTimer.wait_time = GlobalVariables.gemYdineroAdRemainingTime
		gemasTimer.wait_time = GlobalVariables.gemasAdRemainingTime
		waitTimeControl = true
		
		
	#multGanancias timer
	if GlobalVariables.player.multGananciasActive == true:
		multGananciasBtn.hide()
		if timercontrol1 == false:
			timercontrol1 = true
			multGananciasTimer.start()
	else:
		multGananciasBtn.show()
		
	#gem y dinero timer
	if GlobalVariables.player.gemYdineroActive == true:
		gemYdineroBtn.hide()
		if timercontrol2 == false:
			timercontrol2 = true
			gemYdineroTimer.start()
	else:
		gemYdineroBtn.show()
		
	#gemas timer
	if GlobalVariables.player.gemasActive == true:
		gemasBtn.hide()
		if timercontrol3 == false:
			timercontrol3 = true
			gemasTimer.start()
	else:
		gemasBtn.show()
		
	if adModalNode.visible == true:
		multGananciasBtn.hide()
		gemYdineroBtn.hide()
		gemasBtn.hide()

		
func adMultGanancias():
	adIndex = 0
	adModalNode.show()
func adGemYdinero():
	adIndex = 1
	adModalNode.show()
func adGemas():
	adIndex = 2
	adModalNode.show()
	
func powerUpEnd(powerUpIndex : int):
	if powerUpIndex == 0:
		GlobalVariables.player.multGananciasActive = false
		multGananciasTimer.wait_time = GlobalVariables.maxMultGananciasTime
	elif powerUpIndex == 1:
		GlobalVariables.player.gemYdineroActive = false
		gemYdineroTimer.wait_time = GlobalVariables.maxGemYdineroTime
	elif powerUpIndex == 2:
		GlobalVariables.player.gemasActive = false
		gemasTimer.wait_time = GlobalVariables.maxGemasTime
		
		
		
func accept():
	if adIndex == 0:
		multGananciasTimer.start()
		GlobalVariables.player.multGananciasAdTimer = Time.get_datetime_string_from_system()
		GlobalVariables.player.multGananciasActive = true
		multGananciasBtn.hide()
	elif adIndex == 1:
		gemYdineroTimer.start()
		GlobalVariables.player.gemYdineroAdTimer = Time.get_datetime_string_from_system()
		GlobalVariables.player.gemYdineroActive = true
		gemYdineroBtn.hide()
		adRewardNode.show()
	elif adIndex == 2:
		gemasTimer.start()
		GlobalVariables.player.gemasAdTimer = Time.get_datetime_string_from_system()
		GlobalVariables.player.gemasActive = true
		gemasBtn.hide()
		adRewardNode.show()
		
	adModalNode.hide()
	
func cancel():
	print("cancel")
	adModalNode.hide()
	adRewardNode.hide()


func _on_ad_reward_modal_visibility_changed():
	if adRewardNode.visible == true:
		var gemReward = 3
		if adIndex == 1:
			var farmValueMultiplier = 5
			var moneyReward = GlobalVariables.player.farmValue * farmValueMultiplier
			var prob = rand.randi_range(0, 100)
			
			if prob < 80:
				var reward : String
				print(moneyReward)
				reward = GlobalVariables.getMoneyString(moneyReward)
				GlobalVariables.player.money += moneyReward
				adRewardLabel.text = "You Won:	" + reward
				
			else:
				GlobalVariables.player.gems += gemReward
				adRewardLabel.text = "You Won:	" + gemReward + "Gems"
		elif adIndex == 2:
			var reward = gemReward * 5
			GlobalVariables.player.gems += reward
			adRewardLabel.text = "You Won:	" + str(reward) + "Gems"
			
