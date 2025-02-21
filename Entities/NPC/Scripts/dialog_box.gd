extends Panel

@onready var label = $Label
@onready var tween = get_tree().create_tween()  # Create a tween instance

func writeText(text: String) -> void :
	label.text = text
	label.visible_ratio = 0.0  # Start with text hidden

	# Animate the visible_ratio from 0 to 1 over time
	tween.tween_property(label, "visible_ratio", 1.0, len(text) * 0.05)  # Adjust speed as needed
	
