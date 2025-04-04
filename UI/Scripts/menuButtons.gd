extends Button
@onready var sfx1 = $"sfx1"
@onready var sfx2 = $"sfx2"
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.reset_menu.connect(reset_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_button_pressed() -> void:
	playRandomSfx()
	get_tree().paused = !get_tree().paused
	playSfx()
	get_tree().current_scene.get_node("Player/LeftHand/#UI/pause_menu").visible = false
	get_tree().current_scene.get_node("Player/RightHand/#XR_PLUGIN/FunctionPointer").visible = false




func _on_reset_button_pressed():
	get_tree().paused = !get_tree().paused
	playSfx()
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	playSfx()
	get_tree().quit()


func _on_parameters_button_pressed():
	playSfx()
	$"..".visible = false;
	$"../../VBoxContainerParameter".visible = true;

func reset_menu():
	playSfx()
	$"..".visible = true;
	$"../../VBoxContainerParameter".visible = false;
	
	
func playSfx():
	randomize()  # Initialise the random number generator
	var result = randi_range(1, 2)  #Generate 1 or 2
	if(result == 1):
		sfx1.play()
	else : 
		sfx2.play()
