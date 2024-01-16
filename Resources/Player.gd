extends Resource

class_name Player

@export var liters : float
@export var money : float
@export var gems : int

#stats variables
@export var seeds : int
@export var resets : int
@export var sesionEarnings : float
@export var lifetimeEarnings : float

#JuiceHouse Variables
@export var JuiceHouse : Array[JuiceHouseData]
@export var house0Id = 1
@export var house1Id : int
@export var house2Id : int
@export var house3Id : int

#FruitsVariables
@export var Fruits : Array[FruitData]

#Transport Variables
@export var Transport : Array[TransportData]
@export var slots = 4
@export var transport0Id = 1
@export var transport1Id : int
@export var transport2Id : int
@export var transport3Id : int
@export var transport4Id : int
@export var transport5Id : int
@export var transport6Id : int
@export var transport7Id : int
@export var transport8Id : int
@export var transport9Id : int
@export var transport10Id : int
@export var transport11Id : int
@export var transport12Id : int
@export var transport13Id : int
@export var transport14Id : int

#WaterTank variables
@export var WaterTank : WaterTankData

#Juice Level variables
@export var JuiceLevel : Array[JuiceLevelData]
@export var juiceLevel : int

#Updates variabls
@export var Update : Array[UpdateData]
@export var updateCount : int

#Farmer variables
@export var Farmer : Array[FarmerData]
