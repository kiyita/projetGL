extends Node

@onready var pauseMenu = $LeftHand/pause_menu
@onready var debugMenu = $LeftHand/debug_menu
# we take the instantiated debug menu UI scene
@onready var debugMenu_scene = debugMenu.get_scene_instance() 
@onready var FunctionPointer = $RightHand/FunctionPointer

signal hit_by_ennemy(damage)

# test values, rememmber to remove !!!
var counter = 0
var btn_presed
var incr = 0

func _process(delta: float) -> void:
	counter += 1
	# print(debugMenu_scene.get_content())
	debugMenu_scene.update_content(['some test values', counter, btn_presed, incr])
 
func _on_area_3d_body_entered(body):
	print("Collision détectée avec :", body.name)

	if (body.name == "Creature"):
		emit_signal("hit_by_ennemy", body.damage)

# function to reload to game when the B button is pressed
# no more needed thanks to the left hand menu

func _on_right_hand_button_pressed(name):
	btn_presed = name
	if name == 'by_button':
		pass
	if name == 'ax_button':
		# create the menu for spell selection
		var spell_menu = load("res://UI/Scenes/SpellMenu.tscn")
		var player_scene = get_tree().current_scene.get_node("Player")
		incr = player_scene
		player_scene.add_child(spell_menu.instantiate())
		
func _on_right_hand_button_released(name):
	if name == 'ax_button':
		# create the menu for spell selection
		var spell_menu_scene = get_tree().current_scene.get_node("Player").get_node("SpellMenu")
		spell_menu_scene.destroy()



func _on_left_hand_button_pressed(name):
	btn_presed = name
	if name == "ax_button":
		debugMenu.visible = !debugMenu.visible
	if name == "menu_button":
		get_tree().paused = !get_tree().paused
		pauseMenu.visible = !pauseMenu.visible
		FunctionPointer.visible = !FunctionPointer.visible
