extends Node

signal new_angle_value(angle)
@onready var sfx1 = $"sfx1"
@onready var sfx2 = $"sfx2"

func _ready():
	$HSlider.value = Global.angle;
	
func _process(delta: float) -> void:
	$Label2.text = $HSlider.value

func _on_h_slider_drag_ended(value_changed):
	randomize()  # Initialise the random number generator
	var result = randi_range(1, 2)  #Generate 1 or 2
	if(result == 1):
		sfx1.play()
	else : 
		sfx2.play()
	Global.angle = $HSlider.value;

func _on_return_button_pressed():
	randomize()  # Initialise the random number generator
	var result = randi_range(1, 2)  #Generate 1 or 2
	if(result == 1):
		sfx1.play()
	else : 
		sfx2.play()
	$".".visible = false;
	$"../VBoxContainer".visible = true;


func _on_check_box_pressed():
	randomize()  # Initialise the random number generator
	var result = randi_range(1, 2)  #Generate 1 or 2
	if(result == 1):
		sfx1.play()
	else : 
		sfx2.play()
	$HSlider.editable = !$HSlider.editable
	Global.turnmode_changing()
