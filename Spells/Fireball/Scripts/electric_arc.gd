class_name ElectricArc

extends Spell


@onready var mode : int # The electric arc is present when mode = 0 but destroy when mode = 1
@onready var time_last_lost_mana : float # Last time that player lost mana with this spell

@onready var player_scene = get_tree().current_scene.get_node("Player")

@onready var list_area_in_spell : Array # List of the other area into spell area 
@onready var time_last_damage : float # Last time that the spell deals damage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mode = 0
	time_last_lost_mana = Time.get_ticks_msec()
	time_last_damage = Time.get_ticks_msec()
	
	if !player_scene.lost_mana(manaCost): # if the player don't have enough mana, destroy the spell
		mode = 1

	list_area_in_spell = [] 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var left_hand = player_scene.get_node("LeftHand")

	damages_to_entity()
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

## Deal damage to entity
func damages_to_entity():
	if Time.get_ticks_msec() - time_last_damage > reloadTime*1000:
		for i in list_area_in_spell:
			if i.get_parent_node_3d().name == "Entity":
				i.take_damage(damages)
		time_last_damage = Time.get_ticks_msec()

## When a area enter into spell area, add it to list
func _on_area_3d_area_entered(area: Area3D) -> void:
	list_area_in_spell.append(area.get_parent())
	

## When a area exit spell area, remove it to list
func _on_area_3d_area_exited(area: Area3D) -> void:
	list_area_in_spell.erase(area.get_parent())
