extends Panel

var target_scene := "res://Scenes/Main.tscn"
var progress : Array[float]

var load_status

func _ready():
	ResourceLoader.load_threaded_request(target_scene)

func _process(delta):
	
	load_status = ResourceLoader.load_threaded_get_status(target_scene, progress)
	
	match load_status:
		ResourceLoader.THREAD_LOAD_LOADED:
			# When done loading, change to the target scene:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene))
		ResourceLoader.THREAD_LOAD_FAILED:
			# Well some error happend:
			print("Error. Could not load Resource")
