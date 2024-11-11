extends CharacterBody3D

@export var SPEED = 0.4
var target_position: Vector3 = Vector3.ZERO
var direction

func _ready() -> void:
	look_at(target_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	global_position += global_basis * Vector3.FORWARD * SPEED
	
func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	queue_free()
	print('collided')
