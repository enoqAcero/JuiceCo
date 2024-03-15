extends Resource

class_name CurrentHouseData

@export var houseLvl : int = 0
@export var upgradeLvl : int = 1
@export var type : int
@export var currentCapacity : float = 0
@export var juice_liters : Array[float] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

func is_full() -> bool:
	var ocupation = 0.0
	for liters in juice_liters:
		ocupation += liters
	if ocupation >= currentCapacity:
		return true
	return false

func available_space():
	var used_space = 0.0
	for liters in juice_liters:
		used_space += liters
	return max( 0, currentCapacity - used_space )
