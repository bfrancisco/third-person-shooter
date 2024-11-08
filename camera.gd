extends Node3D

@onready var player_shape: CollisionShape3D = $"../CollisionShape3D"
@onready var spring_arm: SpringArm3D = $"TPS Offset/SpringArm3D"

@export var cam_rotate_min: float
@export var cam_rotate_max: float
@export var camera_sensitivity: float
var camrot_h: float = 0
var camrot_v: float = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spring_arm.add_excluded_object(self)
	
func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x * camera_sensitivity
		camrot_v = clamp(camrot_v + event.relative.y * camera_sensitivity, cam_rotate_min, cam_rotate_max)

func _physics_process(delta: float) -> void:
	rotation_degrees.x = camrot_v
	rotation_degrees.y = camrot_h
