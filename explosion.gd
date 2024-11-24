extends Node3D
@onready var explosion: GPUParticles3D = $GPUParticles3D


func _ready() -> void:
	explosion.emitting = true

func _process(delta: float) -> void:
	pass


func _on_gpu_particles_3d_finished() -> void:
	queue_free()
