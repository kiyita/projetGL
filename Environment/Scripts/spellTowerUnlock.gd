extends Node



@export var spellToUnlock : PlayerScript.SpellEnum

var spellUnlock : bool = false

@onready var player_scene : PlayerScript = get_tree().current_scene.get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player_scene.spellUnlock["FIREBALL"] == false:
		$Spell/PickableObject/MeshInstance3Dself.mesh.material.albedo_color = Color.RED
	if player_scene.spellUnlock["ELECTRICARC"] == false:
		$Spell/PickableObject/MeshInstance3Dself.mesh.material.albedo_color = Color.BLUE
	if player_scene.spellUnlock["HEALORB"] == false:
		$Spell/PickableObject/MeshInstance3Dself.mesh.material.albedo_color = Color.GREEN



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pickable_object_grabbed(pickable: Variant, by: Variant) -> void:
	$Spell.visible = false
	if spellToUnlock == PlayerScript.SpellEnum.FIREBALL:
		player_scene.spellUnlock["FIREBALL"] = true
	elif spellToUnlock == PlayerScript.SpellEnum.HEALORB:
		player_scene.spellUnlock["HEALORB"] = true
	elif spellToUnlock == PlayerScript.SpellEnum.ELECTRICARC:
		player_scene.spellUnlock["ELECTRICARC"] = true
