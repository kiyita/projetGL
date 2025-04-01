extends Node

signal new_angle_value(angle)

func _ready():
	$HSlider.value = Global.angle;
	
	change_text_checkbox_main_hand()




func _process(delta: float) -> void:
	$Label2.text = $HSlider.value

func _on_h_slider_drag_ended(value_changed):
	Global.angle = $HSlider.value;
	$Label2.text = str($HSlider.value)

func _on_return_button_pressed():
	$".".visible = false;
	$"../VBoxContainer".visible = true;


func _on_check_box_pressed():
	$HSlider.editable = !$HSlider.editable
	Global.turnmode_changing()



# checkbox to change main hand
func _on_main_hand_check_box_pressed() -> void:
	var player_scene = get_tree().current_scene.get_node("Player")
	if player_scene.main_hand == PlayerScript.Hands.RIGHT:
		player_scene.main_hand = PlayerScript.Hands.LEFT
	else:
		player_scene.main_hand = PlayerScript.Hands.RIGHT
	change_text_checkbox_main_hand()

func change_text_checkbox_main_hand():
	var player_scene = get_tree().current_scene.get_node("Player")
	$MainHandCheckBox.text = "Main hand : "
	if player_scene.main_hand == PlayerScript.Hands.LEFT:
		$MainHandCheckBox.text += "Left"
	else:
		$MainHandCheckBox.text += "Right"
