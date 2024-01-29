extends Control

var rand = RandomNumberGenerator.new()

var multGananciasBtn
var gemYdineroBtn
var gemasBtn

var multGananciasTimer
var gemYdineroTimer
var gemasTimer

var adModalNode
var adRewardNode
var adRewardLabel
var adRewardSprite

#0 = multGanancias, 1 = gemYdinero, 2 = gemas
var adIndex = -1



func _ready():	
	randomize()
	
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
	
	multGananciasTimer.wait_time = 5#60 * 60 * 4
	gemYdineroTimer.wait_time = 5#60 * 30
	gemasTimer.wait_time = 5#60 * 5
	
	multGananciasBtn.pressed.connect(adMultGanancias)
	gemYdineroBtn.pressed.connect(adGemYdinero)
	gemasBtn.pressed.connect(adGemas)
	
	multGananciasTimer.timeout.connect(Callable(powerUpEnd).bind(0))
	gemYdineroTimer.timeout.connect(Callable(powerUpEnd).bind(1))
	gemasTimer.timeout.connect(Callable(powerUpEnd).bind(2))
	
	$adModal.get_node("VBoxContainer/accept").pressed.connect(accept)
	$adModal.get_node("VBoxContainer/cancel").pressed.connect(cancel)
	$adRewardModal.get_node("VBoxContainer/close").pressed.connect(cancel)
	

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
		multGananciasBtn.show()
	elif powerUpIndex == 1:
		GlobalVariables.player.gemYdineroActive = false
		gemYdineroBtn.show()
	elif powerUpIndex == 2:
		GlobalVariables.player.gemasActive = false
		gemasBtn.show()
		
func accept():
	if adIndex == 0:
		multGananciasTimer.start()
		GlobalVariables.player.multGananciasActive = true
		multGananciasBtn.hide()
	elif adIndex == 1:
		gemYdineroTimer.start()
		GlobalVariables.player.gemYdineroActive = true
		gemYdineroBtn.hide()
		adRewardNode.show()
	elif adIndex == 2:
		gemasTimer.start()
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
				
		elif adIndex == 2:
			var reward = gemReward * 5
			GlobalVariables.player.gems += reward
