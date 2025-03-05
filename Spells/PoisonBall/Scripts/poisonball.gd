extends Node

@export var damage : int

@onready var anim_player = $MeshInstance3D/PoisonAnimation
@onready var areaCollisionShape = $Area3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("spawning_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_poison_animation_animation_finished(anim_name):
	areaCollisionShape.disabled = false
	await get_tree().create_timer(0.5).timeout  # Waiting 2 seconds
	queue_free()


func _on_area_3d_body_entered(body):
	if (body.name == "Player"):
		body.hp -= damage
