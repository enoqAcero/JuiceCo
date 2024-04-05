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
	
func used_space():
	var used_space = 0.0
	for liters in juice_liters:
		used_space += liters
	return used_space
	
func release_cargo(liters:float):
	
	
	
	var allowed_release = min( used_space(), liters )
	
	print("Allowed cargo: " + str(allowed_release))
	
	var selling_cargo : float = allowed_release
	
	var sold_cargo = 0

	if allowed_release != 0:

		for i in juice_liters.size():
			
			if juice_liters[i] >= allowed_release:
				juice_liters[i] -= allowed_release
				sold_cargo += allowed_release
				allowed_release = 0
			else:
				sold_cargo += allowed_release - juice_liters[i]
				allowed_release -= juice_liters[i]
				juice_liters[i] = 0
				
		print("Sold cargo: " + str(sold_cargo))
		return sold_cargo
	return 0
