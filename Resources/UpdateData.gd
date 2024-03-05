extends Resource

class_name UpdateData

@export var name : String = "Upgrade name"
@export var description : String = "Upgrade description"
@export var epic : bool = false
@export var cost : float = 10000
@export var level : int
@export var maxLevel : int
@export var skin : Texture2D = load("res://Assets/Temp/JuiceGlassGlow.png")
@export var active : bool = false
@export var epic_active : bool = false
