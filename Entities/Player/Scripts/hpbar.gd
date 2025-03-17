extends Sprite3D


@onready var player = get_tree().current_scene.get_node("Player")

var current_hp : float 
var maxHP : float 

func _ready():
	current_hp = player.stats.HP;
	maxHP = player.stats.HP;
	
	current_hp = player.hp
	maxHP = player.hpMax
	
	texture.gradient.set_offset(1,current_hp/maxHP)

func _process(delta):
	current_hp = player.hp
	
	#value is between 0 (0 hp) and 1 (full hp)
	texture.gradient.set_offset(1,current_hp/maxHP)
