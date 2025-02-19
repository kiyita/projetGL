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
	
	var node_parent_area = area.get_parent()
	
	if !isInvincible:
		hp -= node_parent_area.damages
		if (hp <= 0):
			queue_free()

	var debug = get_parent_node_3d().get_parent_node_3d().get_node("Player/LeftHand/#UI/debug_menu").get_scene_instance()
	debug.ttt = str(node_parent_area.get_script().get_global_name())
	
	
	if str(node_parent_area.get_script().get_global_name()) == "FireBall" :
		node_parent_area.destroy()
