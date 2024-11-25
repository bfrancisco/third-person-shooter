extends Node3D

@onready var projectile: PackedScene = load("res://projectile.tscn")
var target_pos: Vector3 = Vector3.ZERO
@onready var bulletgroup: Node3D = get_tree().get_first_node_in_group("BulletGroup")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		#print(position)
		var bullet = projectile.instantiate()
		bullet.position = global_position
		bullet.target_position = target_pos
		bullet.direction = global_basis
		bulletgroup.add_child(bullet)
