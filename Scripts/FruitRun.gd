extends CharacterBody2D

var rng = RandomNumberGenerator.new()

var speed = 80
var accel = 20
var navAgent : NavigationAgent2D
var TargetZone = null
var follow = false
var houseName : String

var targetControl = false
var dirX
var dirY
var initialTarget = 200


func _ready():
	navAgent = $Navigation/NavigationAgent2D
	$posTimer.wait_time = rng.randf_range(1, 1.5)
	
	TargetZone = get_parent().get_node(houseName)
	
	navAgent.path_desired_distance = 1
	navAgent.target_desired_distance = 1
	
	follow = false
	dirX = rng.randf_range((global_position.x - initialTarget),(global_position.x + initialTarget))
	dirY = rng.randf_range((global_position.y - initialTarget),(global_position.y + initialTarget))
	navAgent.target_position = Vector2(dirX,dirY)
	
	
	
func _physics_process(delta):
	var direction = Vector2()
		
	if follow == true:
		direction = navAgent.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, accel * delta)
		
	else: 
		direction = navAgent.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, accel * delta)
		
	move_and_slide()


func _on_timer_timeout():
	if follow == false:
		follow = true
		navAgent.target_position = TargetZone.position
	else:
		$randPosTimer.wait_time = rng.randf_range(0.2, 0.5)
		$randPosTimer.start()
		follow = false
		dirX = rng.randf_range((global_position.x - initialTarget),(global_position.x + initialTarget))
		dirY = rng.randf_range((global_position.y - initialTarget),(global_position.y + initialTarget))
		navAgent.target_position = Vector2(dirX,dirY)


func _on_rand_pos_timer_timeout():
	follow = true
	navAgent.target_position = TargetZone.position
