extends RigidBody2D

var rand = RandomNumberGenerator.new()

var gravity = 0.05
var speed = Vector2(200, 0)
var pi = 3.1415169

var falling = false
var clickControl = false

var spriteNode

var cameraNode
var xOffset
var yOffset

func _ready():
	spriteNode = $Sprite2D
	cameraNode = get_parent().get_node("Camera2D")
	xOffset = cameraNode.position.x
	yOffset = cameraNode.position.y
	# Set the drone's initial position to a random point outside the screen
	position = Vector2(rand.randf_range(-100, -50), rand.randf_range(0, get_viewport_rect().size.y)) + Vector2(xOffset, yOffset)
	var center = get_viewport_rect().size / 2
	var direction = (center - position).normalized()
	# Apply a constant velocity to the drone in the direction of the screen
	linear_velocity = speed.rotated(direction.angle())

func _physics_process(delta):
	if falling == true:
		spriteNode.scale -= Vector2(0.03, 0.03) * delta
	if spriteNode.scale.x <= 0.02:
		queue_free()


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if clickControl == false:
			clickControl = true
			var farmValue = GlobalVariables.player.farmValue
			var gemReward = 5
			var richReward : float = farmValue * 0.05
			var poorReward : float  = farmValue * 0.01
		# Make the drone fall when clicked
			gravity_scale = gravity
			linear_damp = 0.2
			falling = true
			if self.is_in_group("flyRewardGems"):
				print("reward was: ", gemReward)
				GlobalVariables.player.gems += gemReward
			elif self.is_in_group("flyRewardRich"):
				print("reward was: ", richReward)
				GlobalVariables.player.money += richReward
			elif self.is_in_group("flyRewardPoor"):
				print("reward was: ", poorReward)
				GlobalVariables.player.money += poorReward

