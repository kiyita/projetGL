extends Sprite3D

@onready var player_scene = get_parent().get_parent().get_parent()

func _ready():
	pass

func _process(delta):
	
	#value is between 0 (0 hp) and 1 (full hp)
	texture.gradient.set_offset(0, 0)
	texture.gradient.set_offset(1, float(player_scene.mana)/float(player_scene.manaMax))
