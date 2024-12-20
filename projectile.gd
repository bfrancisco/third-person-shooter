extends CharacterBody3D

@onready var explosion: PackedScene = load("res://explosion.tscn")
@onready var explosiongroup: Node3D = get_tree().get_first_node_in_group("ExplosionGroup")
@export var SPEED = 50
var target_position: Vector3 = Vector3.ZERO
var direction: Basis = Basis.IDENTITY

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	global_position += direction * Vector3.FORWARD * (delta * SPEED)
	
func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	print('collided with ', body.name)
	if body.has_method("take_damage"):
		body.take_damage(1)
	spawn_explosion()
	queue_free()

func spawn_explosion() -> void:
	var explosion_scene = explosion.instantiate()
	explosion_scene.position = position 
	explosiongroup.add_child(explosion_scene)
