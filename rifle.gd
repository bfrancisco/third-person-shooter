extends Node3D

@onready var projectile: PackedScene = load("res://projectile.tscn")
var target_pos: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet = projectile.instantiate()
		bullet.target_position = target_pos
		add_child(bullet)
