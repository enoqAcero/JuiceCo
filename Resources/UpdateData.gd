extends Resource

class_name UpdateData

enum UpgradeType { FEATURE, FARMER, FRUIT, TRANSPORT, JUICE }

@export var name : String = "Upgrade name"
@export var description : String = "Upgrade description"
@export var epic : bool = false
@export var cost : float = 10000
@export var cost_magnitude : Magnitudes.group
@export var active : bool = false
@export var epic_active : bool = false

@export var type : UpgradeType
@export var target : int
@export var multiplier : float

@export var skin : Texture2D = load("res://Assets/Temp/JuiceGlassGlow.png")
