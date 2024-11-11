extends Node3D

@onready var projectile: PackedScene = load("res://projectile.tscn")
var target_pos: Vector3 = Vector3.ZERO

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet = projectile.instantiate()
		bullet.target_position = target_pos
		bullet.direction = global_basis
		add_child(bullet)
