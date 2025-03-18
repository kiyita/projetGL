extends Sprite3D


var hpMax : float
var currentHp : float

@onready var parent = get_parent_node_3d()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture.gradient.set_offset(1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:


	hpMax = parent.hpMax
	
	currentHp = parent.hp
	
	#print(hpMax)
	#print("Hp Max: ", currentHp/hpMax)
	 
	
	texture.gradient.set_offset(1, currentHp/hpMax)
	
