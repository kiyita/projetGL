extends Node


signal torchLit(torch)
signal torchUnlit(torch)

var isLit : bool
@onready var lit_scene = get_node("Lit")
@onready var unlit_scene = get_node("Unlit")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Torch") # DO NOT REMOVE
	isLit = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if isLit == false:
		lit_scene.visible = false
		unlit_scene.visible = true
		emit_signal("torchUnlit", self)
	else:
		lit_scene.visible = true
		unlit_scene.visible = false
		emit_signal("torchLit", self)
