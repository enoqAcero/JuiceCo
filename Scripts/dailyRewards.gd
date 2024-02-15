extends Node2D

var last_reward_time : String = ""
var current_day : int = 0

# Botones de Recompensas
func _ready():
	if last_reward_time != "":
		var saved_time = parse_time(last_reward_time)
		var current_time = parse_time(Time.get_datetime_string_from_system())
		current_day = (current_time - saved_time) / 60
	for i in range(1, current_day + 1):
		var button = $ColorRect.get_node("dia" + str(i))
		button.disabled = false

func _process(delta):
	if current_day < 7 and Time.get_datetime_string_from_system() != last_reward_time:
		last_reward_time = Time.get_datetime_string_from_system()
		current_day += 1
		$ColorRect.get_node("dia" + str(current_day)).disabled = false

func parse_time(time_string):
	var parts = time_string.split(" ")
	var date_parts = parts[0].split("-")
	var time_parts = parts[1].split(":")
	return int(date_parts[0]) * 31536000 + int(date_parts[1]) * 2592000 + int(date_parts[2]) * 86400 + int(time_parts[0]) * 3600 + int(time_parts[1]) * 60 + int(time_parts[2])

# Aquí van tus funciones _on_dia_X_pressed()

# Botones de Recompensas
func _on_dia_1_pressed():
	# boost
	$ColorRect.get_node("dia1").disabled = true

func _on_dia_2_pressed():
	var reward = (GlobalVariables.player.farmValue * 0.2)
	GlobalVariables.player.money += reward
	print("Has recibido " + str(reward) + " de dinero como recompensa!")
	$ColorRect.get_node("dia2").disabled = true

func _on_dia_3_pressed():
	GlobalVariables.player.bankgems += 25
	print("Has recibido 25 gemas como recompensa!")
	$ColorRect.get_node("dia3").disabled = true

func _on_dia_4_pressed():
	# boost
	$ColorRect.get_node("dia4").disabled = true

func _on_dia_5_pressed():
	var reward = (GlobalVariables.player.farmValue * 0.5)
	GlobalVariables.player.money += reward
	print("Has recibido " + str(reward) + " de dinero como recompensa!")
	$ColorRect.get_node("dia5").disabled = true

func _on_dia_6_pressed():
	var reward = max (1,(GlobalVariables.player.farmValue * 0.03 ))
	GlobalVariables.player.seeds += reward
	print("Has recibido " + str(reward) + " semillas como recompensa!")
	$ColorRect.get_node("dia6").disabled = true

func _on_dia_7_pressed():
	var randNum = randi() % 100
	if randNum < 30:
		GlobalVariables.player.bankgems += 100
		print("Has recibido 100 gemas como recompensa!")
	else:
		var reward = (GlobalVariables.player.farmValue / 10) * 100
		GlobalVariables.player.money += reward
		print("Has recibido " + str(reward) + " de dinero como recompensa!")
	$ColorRect.get_node("dia7").disabled = true
