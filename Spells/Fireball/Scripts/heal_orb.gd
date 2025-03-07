class_name HealOrb

extends Spell

@onready var mode : int # The heal orb is present when mode = 0 but destroy when mode = 1
@onready var time_last_lost_mana : float # Last time that player lost mana with this spell

@onready var player_scene = get_tree().current_scene.get_node("Player")

@onready var time_last_heal : float # Last time that the spell heal the player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mode = 0
	time_last_lost_mana = Time.get_ticks_msec()
	time_last_heal = Time.get_ticks_msec()
	
	if !player_scene.lost_mana(manaCost): # if the player don't have enough mana, destroy the spell
		mode = 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var left_hand = player_scene.get_node("LeftHand")

	heal_player()
	cost_mana()
	
	if mode == 0:
		position = left_hand.global_position
		rotation = left_hand.global_rotation
	elif mode == 1:
		queue_free() # destroy the current scene

## Reduce the number of player's mana point
func cost_mana():
	if Time.get_ticks_msec() - time_last_lost_mana > reloadTime*1000:
		time_last_lost_mana = Time.get_ticks_msec()
		if !player_scene.lost_mana(manaCost):
			mode = 1

## Heal the player
func heal_player():
	if Time.get_ticks_msec() - time_last_heal > reloadTime*1000:
		player_scene.heal_player(damages)
		time_last_heal = Time.get_ticks_msec()
