extends Node3D
@onready var debris: GPUParticles3D = $debris
@onready var fire: GPUParticles3D = $fire
@onready var smoke: GPUParticles3D = $smoke

var finished_count: int = 0

func _ready() -> void:
	debris.emitting = true
	smoke.emitting = true
	fire.emitting = true
	
	debris.connect("finished", Callable(self, "_on_particle_finished"))
	smoke.connect("finished", Callable(self, "_on_particle_finished"))
	fire.connect("finished", Callable(self, "_on_particle_finished"))
	
func _on_particle_finished():
	finished_count += 1
	if finished_count == 3: 
		queue_free()
