extends Resource

class_name BoostData

@export var name : String = "Boost name"
@export var description : String = "Boost description"
@export var cost : float = 10000
@export var skin : Texture2D = load("res://Assets/Buttons/scroll.png")
@export var active : bool = false

@export var type : GlobalVariables.UpgradeType
@export var target : int
@export var multiplier : float

var timer : Timer = Timer.new()

