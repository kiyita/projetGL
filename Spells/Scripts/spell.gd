class_name Spell

extends RigidBody3D

# @export var name : String (already instancied in Node3d)
@export var description : String ## a description of the spell
@export var damages : int ## how many damages dispenses the spell
@export var manaCost : int ## how many manapoint cost the spell
@export var reloadTime : float ## how many time we have to wait before launch another spell
@export var castTime : float ## the time we have to wait before the spell is ready to launch

@onready var player_scene : PlayerScript = get_tree().current_scene.get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass    
		

func select_hand_player():
	if player_scene.main_hand == PlayerScript.Hands.RIGHT:
		return player_scene.get_node("RightHand")
	else :
		return player_scene.get_node("LeftHand")
