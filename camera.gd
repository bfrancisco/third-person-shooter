extends Node3D

@export var camera_sens: float
@onready var player_shape: CollisionShape3D = $"../CollisionShape3D"
@onready var spring_arm: SpringArm3D = $"TPS Offset/SpringArm3D"

var camrot_h = 0
var camrot_v = 0
const CAMROT_V_MIN = -60
const CAMROT_V_MAX = 90

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x
		camrot_v = clamp(camrot_v + event.relative.y, CAMROT_V_MIN, CAMROT_V_MAX)

func _physics_process(delta: float) -> void:
	rotation_degrees.x = camrot_v
	rotation_degrees.y = camrot_h
