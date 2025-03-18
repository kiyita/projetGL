extends Node

@export var damage : int

@onready var anim_player = $MeshInstance3D/PoisonAnimation


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("PoisonBall")
	anim_player.play("spawning_animation")


func _on_poison_animation_animation_finished(anim_name):
	if anim_name == "spawning_animation":
		$finalmesh.visible = !$finalmesh.visible
		$MeshInstance3D.visible = !$MeshInstance3D.visible
		$CollisionShape3D.disabled = !$CollisionShape3D.disabled
		await get_tree().create_timer(0.1).timeout  # Waiting 0.5 seconds
		queue_free()
