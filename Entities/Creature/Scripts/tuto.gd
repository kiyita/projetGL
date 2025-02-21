class_name Tuto

extends Creature

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

# Called when an area 3D enters this creature's area 3D
func _on_area_3d_area_entered(area: Area3D) -> void:
	if !isInvincible:
		var node_weapon = area.get_parent()
		# hp -= node_weapon.damages
		hp -= 3
		if (hp <= 0):
			queue_free()
