extends Resource

class_name BoostData

@export var name : String = "Boost name"
@export var description : String = "Boost description"
@export var cost : float = 10000
@export var cost_magnitude : Magnitudes.group
@export var skin : Texture2D = load("res://Assets/Buttons/scroll.png")
@export var active : bool = false
@export var level_required : int

@export var type : GlobalVariables.BoostType
@export var target : int
@export var multiplier : float
@export var duration : float = 5.0

var timer : Timer = Timer.new()

