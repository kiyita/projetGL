extends Node

@onready var menu_sfx1 = $"menu_sfx1"
@onready var menu_sfx2 = $"menu_sfx2"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_return_button_control_pressed() -> void:
	playSfx()
	$".".visible = false;
	$"../VBoxContainerParameter".visible = true;

func playSfx():
	randomize()  # Initialise the random number generator
	var result = randi_range(1, 2)  #Generate 1 or 2
	if(result == 1):
		menu_sfx1.play()
	else : 
		menu_sfx2.play()
