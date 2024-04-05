extends Resource

class_name Player

@export var liters : float
@export var money : float
@export var gems : int
@export var litersPerSecond : float
@export var sandiasPerSecond : float
@export var farmValue : float
@export var time : String


#adPowerUps
@export var multGananciasActive : bool
@export var gemYdineroActive : bool
@export var gemasActive : bool

#stats variables
@export var seeds : float
@export var resets : int
@export var sesionEarnings : float
@export var lifetimeEarnings : float

#JuiceHouse Variables
@export var JuiceHouse : Array[JuiceHouseData]

#Current JuiceHouse Data
@export var CurrentJuiceHouse : Array[CurrentHouseData]

#FruitsVariables
@export var Fruits : Array[FruitData]

#Transport Variables
@export var Transport : Array[TransportData]
@export var Vehicles : Array[int]

#WaterTank variables
@export var WaterTank : WaterTankData

#Juice Level variables
@export var JuiceLevel : Array[JuiceLevelData]
@export var juiceLevel : int

#Updates variabls
@export var Upgrades : Array[UpdateData]

#Farmer variables
@export var Farmer : Array[FarmerData]

#Cochinito
@export var bankgems = 0

#Boosts
@export var Boosts : Array[BoostData]

# Stats
@export var earnings : float
@export var fruit_production : float
@export var juice_production : float

@export var networth_levels : Array[String]

@export var total_earnings : float
@export var total_fruit_production : float
@export var total_juice_production : float
@export var total_expenses : float
@export var farm_value : float
@export var water_tanks : int = 1
@export var water_supply_cost : Array[float]

@export var new_version : bool


