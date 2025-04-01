extends Sprite3D


@onready var entity_scene = get_parent_node_3d()

var current_hp : float 
var maxHP : float 

func _ready():

	maxHP = entity_scene.hpMax
	current_hp = entity_scene.hp
	
	texture.gradient.set_offset(1,current_hp/maxHP)

func _process(delta):
	current_hp = entity_scene.hp
	
	#value is between 0 (0 hp) and 1 (full hp)
	texture.gradient.set_offset(1,current_hp/maxHP)
