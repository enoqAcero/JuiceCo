extends Node2D
var player = preload("res://Save/PlayerSave.tres")
var JuiceLevel = player.JuiceLevel
var currentJuiceIndex = 0
var base_value : float = .05

func _ready():
	editorValorJuegos(base_value)
	updateJuiceInfo()

func updateJuiceInfo():
	var juiceValue : String
	$"Panel/JuiceName".text = JuiceLevel[currentJuiceIndex].name
	$Panel/JuiceDescription.text = JuiceLevel[currentJuiceIndex].description
	
	if JuiceLevel[currentJuiceIndex].value > 699 and JuiceLevel[currentJuiceIndex].value < 701:
		$Panel/JuiceValue.text = str(int(JuiceLevel[currentJuiceIndex].value))
	elif JuiceLevel[currentJuiceIndex].value < 1000:
		$Panel/JuiceValue.text = str(JuiceLevel[currentJuiceIndex].value)
	else:
		juiceValue = GlobalVariables.getMoneyString(JuiceLevel[currentJuiceIndex].value)
		$Panel/JuiceValue.text = juiceValue
		
	var juice_img = JuiceLevel[currentJuiceIndex].skin
	if juice_img is Texture2D:
		$Panel/TextureRect.texture = juice_img



func _on_next_pressed():
	currentJuiceIndex = min(currentJuiceIndex + 1, JuiceLevel.size() - 1)
	updateJuiceInfo()


func _on_back_pressed():
	currentJuiceIndex = max(currentJuiceIndex - 1, 0)
	updateJuiceInfo()

func editorValorJuegos (base_value: float):
	JuiceLevel[0].value = base_value  # Asegúrate de que este es el índice del jugo normal
	var percentages : Array[float] = [500.0, 500.0, 480.0, 500.0, 466.6666667, 428.5714286, 416.6666667, 400.0, 350.0, 300.0, 285.7142857, 666.6666667, 10000.0]
	for i in range(1, JuiceLevel.size()):  # Comienza desde 1 para saltarte el jugo normal
		JuiceLevel[i].value = float(JuiceLevel[i-1].value * (percentages[i-1] / 100.0))  # Usa i-1 para los porcentajes porque saltaste el primer elemento


func _on_button_pressed():
	pass # Replace with function body.
