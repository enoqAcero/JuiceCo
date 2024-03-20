extends Resource

class_name FruitData

@export var name : String

@export var cost : float # Cost to aqcuire the ability to produce a type of fruit
@export var acquired : bool # If the ability to produce the fruit has been purchased

@export var production_time : float
@export var liters_per_fruit : float # Amount of liters a fruit can produce
var production_timer := Timer.new()

var level : int # Increases ( multiplies ) the amount of lters per fruit
var level_cost : float # Cost to get to the nex fruit level
@export var level_cost_multiplier : float # Modifier to increase the cost for the nex level cost ( percentage )

var tier : int # Second modifier for the liters per fruit
@export var tier_multipliers : Array[float] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] # Multiplier to increase the liters per fruit { int(tier) : percentage(modifier }

@export var produced_fruits : int # Amount of fruits produced

@export var skin : Texture2D

