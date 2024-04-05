extends CharacterBody2D

var rng = RandomNumberGenerator.new()

var speed = 100
var accel = 20
var navAgent : NavigationAgent2D
var house : int


@export var fruit_number : int
var liters : float

func _ready():
	navAgent = $Navigation/NavigationAgent2D as NavigationAgent2D

	
	$Sprite2D.play("walk")
	self.add_to_group("Fruit")

	navAgent.target_position = get_parent().get_node("house" + str(house) + '/Marker1').global_position
	navAgent.target_reached.connect( _on_navigation_agent_2d_target_reached )
	navAgent.velocity_computed.connect( _on_navigation_agent_2d_velocity_computed )
	
	navAgent.path_desired_distance = 20
	navAgent.target_desired_distance = 25
	navAgent.path_max_distance = 10
	navAgent.radius = 15
	navAgent.max_neighbors = 50
	
func _physics_process(delta):
	var direction = Vector2()
		
#	if follow == true:
	direction = navAgent.get_next_path_position() - global_position
	direction = direction.normalized()
	navAgent.set_velocity( direction * speed * GlobalVariables.fruit_race_multiplier )
#		velocity = velocity.lerp(direction * speed, accel * delta) * GlobalVariables.fruit_race_multiplier
		
#	else: 
#		direction = navAgent.get_next_path_position() - global_position
#		direction = direction.normalized()
#		velocity = velocity.lerp(direction * speed, accel * delta)
	



func _on_timer_timeout():
	pass
#	TargetZone = get_parent().get_node("house" + str(house))
#	$Sprite2D.play("walk")
#	if follow == false:
#		follow = true
#		navAgent.target_position = TargetZone.position
#	else:
#	$randPosTimer.wait_time = rng.randf_range(0.0, 0.25)
#	$randPosTimer.start()

#	dirX = rng.randf_range((global_position.x - initialTarget),(global_position.x + initialTarget))
#	dirY = rng.randf_range((global_position.y - initialTarget),(global_position.y + initialTarget))
#	navAgent.target_position = Vector2(dirX,dirY)
#	follow = true
#	navAgent.target_position = TargetZone.position

#func _on_rand_pos_timer_timeout():
#	follow = true
#	navAgent.target_position = TargetZone.position
	


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
#	print('House:' + str(house) )
	velocity = safe_velocity
#	print( str( global_position.distance_to( get_parent().get_node("house" + str(house) + '/Marker1').global_position ) ) )
	move_and_slide()


func _on_navigation_agent_2d_target_reached():
#	print('HEEEEEEEEEEREEEEE')
	navAgent.target_position = get_parent().get_node("house" + str(house) + '/Marker2').global_position
	
