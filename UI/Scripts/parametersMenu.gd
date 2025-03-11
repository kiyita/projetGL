extends Node

signal new_angle_value(angle)

func _ready():
	$HSlider.value = Global.angle;
	
	if Global.main_hand_glb == PlayerScript.Hands.RIGHT:
		_on_main_hand_check_box_button_up()
	else :
		_on_main_hand_check_box_button_down()
	
	
	
	
func _process(delta: float) -> void:
	$Label2.text = $HSlider.value

func _on_h_slider_drag_ended(value_changed):
	Global.angle = $HSlider.value;

func _on_return_button_pressed():
	$".".visible = false;
	$"../VBoxContainer".visible = true;


func _on_check_box_pressed():
	$HSlider.editable = !$HSlider.editable
	Global.turnmode_changing()



# checkbox to change main hand
func _on_main_hand_check_box_button_up() -> void:
	Global.main_hand_glb = PlayerScript.Hands.RIGHT
	$MainHandCheckBox.text = Global.main_hand_glb

func _on_main_hand_check_box_button_down() -> void:
	Global.main_hand_glb = PlayerScript.Hands.LEFT
	$MainHandCheckBox.text = Global.main_hand_glb
