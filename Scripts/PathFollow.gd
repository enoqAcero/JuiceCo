extends Node2D

var pathFollow : PathFollow2D
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pathFollow = $Path2D/PathFollow2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pathFollow.progress += speed * delta
	if pathFollow.progress_ratio >= 1:
		queue_free()
