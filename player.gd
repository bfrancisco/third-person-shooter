extends CharacterBody3D


#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5

@onready var spring_arm: SpringArm3D = $"Camroot/TPS Offset/SpringArm3D"
@onready var camroot: Node3D = $Camroot
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
	camroot.rotation_degrees.x = camrot_v
	camroot.rotation_degrees.y = camrot_h
	
	#Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("left", "right", "forward", "backward")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
