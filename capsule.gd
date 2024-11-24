extends StaticBody3D

@onready var destroyexplosion: PackedScene = load("res://destroyexplosion.tscn")
@onready var destroyexplosiongroup: Node3D = get_tree().get_first_node_in_group("DestroyExplosionGroup")
@export var hp = 3

func take_damage(amount: int) -> void:
	hp -= amount
	if hp <= 0:
		spawndestroyexplosion()
		queue_free()

func spawndestroyexplosion() -> void:
	var destroyexplosionscene = destroyexplosion.instantiate()
	destroyexplosionscene.position = position
	destroyexplosiongroup.add_child(destroyexplosionscene)
