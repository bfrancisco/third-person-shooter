extends Node3D
@onready var destroyexplosion: GPUParticles3D = $GPUParticles3D


func _ready() -> void:
	destroyexplosion.emitting = true

func _process(delta: float) -> void:
	pass


func _on_gpu_particles_3d_finished() -> void:
	queue_free()
