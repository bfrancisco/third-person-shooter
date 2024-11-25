extends Node3D

@onready var capsule_scene: PackedScene = load("res://capsule.tscn")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if get_child_count() == 0:
		var capsule = capsule_scene.instantiate()
		capsule.position += Vector3(rng.randf_range(-20, 20), rng.randf_range(-5, 5), rng.randf_range(-7, 7)) 
		add_child(capsule)
	
	
