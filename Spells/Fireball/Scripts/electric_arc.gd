class_name ElectricArc

extends Spell

var mode : int #The Fireball is inactive at 0, 1 it is visible and 2 the ball is thrown


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mode = 0

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var left_hand = get_parent_node_3d().get_parent_node_3d().get_node("Player/LeftHand")

	if mode == 0:
		position = left_hand.global_position
		rotation = left_hand.global_rotation
	elif mode == 1:
		queue_free() # destroy the current scene
