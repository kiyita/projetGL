class_name ElectricArc

extends Spell

signal lost_mana

var mode : int #The Fireball is inactive at 0, 1 it is visible and 2 the ball is thrown
var time_last_lost_mana : float

@onready var player_scene = get_parent_node_3d().get_parent_node_3d().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mode = 0
	time_last_lost_mana = Time.get_ticks_msec()
	
	if !player_scene.lost_mana(manaCost):
		mode = 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var left_hand = player_scene.get_node("LeftHand")

	if Time.get_ticks_msec() - time_last_lost_mana > 1000:
		time_last_lost_mana = Time.get_ticks_msec()
		if !player_scene.lost_mana(manaCost):
			mode = 1

	if mode == 0:
		position = left_hand.global_position
		rotation = left_hand.global_rotation
	elif mode == 1:
		queue_free() # destroy the current scene
