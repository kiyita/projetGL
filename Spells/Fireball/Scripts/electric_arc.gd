class_name ElectricArc

extends Spell


@onready var mode : int #The Fireball is inactive at 0, 1 it is visible and 2 the ball is thrown
@onready var time_last_lost_mana : float

@onready var player_scene = get_parent_node_3d().get_parent_node_3d().get_node("Player")

@onready var debugmenu

@onready var list_area_in_spell : Array
@onready var time_last_damage : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mode = 0
	time_last_lost_mana = Time.get_ticks_msec()
	time_last_damage = Time.get_ticks_msec()
	
	debugmenu = player_scene.get_node("LeftHand/#UI/debug_menu").get_scene_instance()
	
	
	if !player_scene.lost_mana(manaCost):
		mode = 1

	list_area_in_spell = [] 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var left_hand = player_scene.get_node("LeftHand")

	damages_to_creature()
	cost_mana()
	
	debugmenu.update_content(list_area_in_spell)

	if mode == 0:
		position = left_hand.global_position
		rotation = left_hand.global_rotation
	elif mode == 1:
		queue_free() # destroy the current scene


func cost_mana():
	if Time.get_ticks_msec() - time_last_lost_mana > reloadTime*1000:
		time_last_lost_mana = Time.get_ticks_msec()
		if !player_scene.lost_mana(manaCost):
			mode = 1

func damages_to_creature():
	if Time.get_ticks_msec() - time_last_damage > reloadTime*1000:
		for i in list_area_in_spell:
			if i.get_parent_node_3d().name == "Entity":
				i.take_damage(damages)
		time_last_damage = Time.get_ticks_msec()


func _on_area_3d_area_entered(area: Area3D) -> void:
	list_area_in_spell.append(area.get_parent())
	


func _on_area_3d_area_exited(area: Area3D) -> void:
	list_area_in_spell.erase(area.get_parent())
