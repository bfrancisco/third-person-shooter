extends CharacterBody3D

# Camera
@onready var spring_arm: SpringArm3D = $"Camroot/TPS Offset/SpringArm3D"
@onready var camroot: Node3D = $Camroot
@export var cam_rotate_min: float
@export var cam_rotate_max: float
@export var camera_sensitivity: float
var camrot_h: float = 0
var camrot_v: float = 0

# Player
@onready var player_mesh: Node3D = $Mesh
var direction = Vector3.FORWARD
var target_velocity = Vector3.ZERO
const GRAVITY: float = 50
@export var normal_speed: float 
@export var sprint_speed: float 
@export var move_acceleration: float
var move_speed: float
@onready var anim_tree: AnimationTree = $AnimationTree
@export var anim_acceleration: float


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spring_arm.add_excluded_object(self)
	
	move_speed = normal_speed
	
func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x * camera_sensitivity
		camrot_v = clamp(camrot_v + event.relative.y * camera_sensitivity, cam_rotate_min, cam_rotate_max)
	
func _physics_process(delta: float) -> void:
	# Camera rotation + player rotation sync
	camroot.rotation_degrees.x = camrot_v
	camroot.rotation_degrees.y = camrot_h
	player_mesh.rotation_degrees.y = camrot_h
	
	# Player movement
	var rot_h = player_mesh.global_transform.basis.get_euler().y
	direction = Vector3(Input.get_action_strength("left") - Input.get_action_strength("right"),
				0,
				Input.get_action_strength("forward") - Input.get_action_strength("backward"))
	direction = direction.rotated(Vector3.UP, rot_h).normalized()
	
	move_speed = (sprint_speed if Input.is_action_pressed("sprint") else normal_speed)
	
	target_velocity.x = lerp(target_velocity.x, direction.x * move_speed, delta * move_acceleration)
	target_velocity.z = lerp(target_velocity.z, direction.z * move_speed, delta * move_acceleration)
	target_velocity.y = (0 if is_on_floor() else target_velocity.y - (GRAVITY * delta))
	
	# Handle idle, walk, run animations
	if Input.is_action_pressed("sprint"):
		anim_tree.set("parameters/iwr_blend/blend_amount",
					lerp(anim_tree.get("parameters/iwr_blend/blend_amount"), 1.0, delta * anim_acceleration)
					)
	elif target_velocity.length() < 1:
		anim_tree.set("parameters/iwr_blend/blend_amount",
					lerp(anim_tree.get("parameters/iwr_blend/blend_amount"), -1.0, delta * anim_acceleration)
					)
	else:
		anim_tree.set("parameters/iwr_blend/blend_amount",
					lerp(anim_tree.get("parameters/iwr_blend/blend_amount"), 0.0, delta * anim_acceleration)
					)
	
	velocity = target_velocity
	move_and_slide()
	
	
