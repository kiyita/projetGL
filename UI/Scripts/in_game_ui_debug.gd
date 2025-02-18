extends Node2D

var content = ['premierTruc', 'deuxiemeTruc', 'troisiemeTruc']
@onready var label = $Control/ColorRect/DebugMarginContainer/DebugVBoxContainer/content

@export var process_while_paused: bool = true

func _ready():
	set_process(true)  
	set_process_unhandled_input(true)
	set_process_input(true)
	set_process_internal(true)


func update_content(newContent):
	content = newContent
	refresh_display()  

func refresh_display():
	label.text = "salut!\n"
	for item in content:
		label.text += str(item) + "\n"
	label.text += str(get_parent().get_parent().get_parent().get_parent().get_parent().manaMax) + " mana \n"
	label.text += str(get_parent().get_parent().get_parent().get_parent().get_parent().mana) + " mana \n"


func get_content():
	return content
	
func _process(delta: float) -> void:
	refresh_display()
