extends Node

signal new_angle_value(angle)

func _ready():
	$HSlider.value = Global.angle;
	
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
