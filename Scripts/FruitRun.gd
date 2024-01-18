extends CharacterBody2D

var rng = RandomNumberGenerator.new()

var speed = 80
var TargetZone = null
var follow = false
var houseName : String

var dirX
var dirY
var initialTarget = 200


func _ready():
	$Timer.wait_time = 1
	
	TargetZone = get_parent().get_node(houseName)
	dirX = rng.randf_range((position.x - initialTarget),(position.x + initialTarget))
	dirY = rng.randf_range((position.y - initialTarget),(position.y + initialTarget))
	
	
func _physics_process(_delta):
	if follow == true:
		position += (TargetZone.position - position)/speed
	else:
		position.x += (dirX - position.x)/speed
		position.y += (dirY - position.y)/speed
			
	
	move_and_slide()


func _on_timer_timeout():
	follow = true
