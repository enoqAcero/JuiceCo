extends Node2D
var player = preload("res://Save/PlayerSave.tres")
var JuiceLevel = player.JuiceLevel
var currentJuiceIndex = 0
var base_value : float = .05

func _ready():
	editorValorJuegos()
	updateJuiceInfo()

func updateJuiceInfo():
	var juiceValue : String
	$JuiceName.bbcode_text = JuiceLevel[currentJuiceIndex].name
	$JuiceDescription.bbcode_text = JuiceLevel[currentJuiceIndex].description
	
	if JuiceLevel[currentJuiceIndex].value > 699 and JuiceLevel[currentJuiceIndex].value < 701:
		$JuiceValue.bbcode_text = str(int(JuiceLevel[currentJuiceIndex].value))
	elif JuiceLevel[currentJuiceIndex].value < 1000:
		$JuiceValue.bbcode_text = str(JuiceLevel[currentJuiceIndex].value)
	else:
		juiceValue = GlobalVariables.getMoneyString(JuiceLevel[currentJuiceIndex].value)
		$JuiceValue.bbcode_text = juiceValue



func _on_next_pressed():
	currentJuiceIndex = min(currentJuiceIndex + 1, JuiceLevel.size() - 1)
	updateJuiceInfo()


func _on_back_pressed():
	currentJuiceIndex = max(currentJuiceIndex - 1, 0)
	updateJuiceInfo()

func editorValorJuegos():
	JuiceLevel[0].value = base_value  # Asegúrate de que este es el índice del jugo normal
	var percentages : Array[float] = [500.0, 500.0, 480.0, 500.0, 466.6666667, 428.5714286, 416.6666667, 400.0, 350.0, 300.0, 285.7142857, 666.6666667, 10000.0]
	for i in range(1, JuiceLevel.size()):  # Comienza desde 1 para saltarte el jugo normal
		JuiceLevel[i].value = float(JuiceLevel[i-1].value * (percentages[i-1] / 100.0))  # Usa i-1 para los porcentajes porque saltaste el primer elemento
