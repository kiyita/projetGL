class_name SpellTowerUnlock

extends Node



@export_enum("FireBall", "ElectricArc", "HealOrb") var spellToUnlock : String


@onready var player_scene : PlayerScript = get_tree().current_scene.get_node("Player")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_color()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pickable_object_grabbed(pickable: Variant, by: Variant) -> void:
	$Spell.queue_free()
	if spellToUnlock == "FireBall":
		player_scene.spellUnlock["FIREBALL"] = true
	elif spellToUnlock == "HealOrb":
		player_scene.spellUnlock["HEALORB"] = true
	elif spellToUnlock == "ElectricArc":
		player_scene.spellUnlock["ELECTRICARC"] = true


func change_color():
	if spellToUnlock == "FireBall":
		get_node("Spell/FireBallBall").visible = true
		get_node("Spell/ElectricArcBall").enabled = false
		get_node("Spell/HealOrdBall").enabled = false
	elif spellToUnlock == "ElectricArc":
		get_node("Spell/ElectricArcBall").visible = true
		get_node("Spell/FireBallBall").enabled = false
		get_node("Spell/HealOrdBall").enabled = false
	elif spellToUnlock == "HealOrb":
		get_node("Spell/HealOrbBall").visible = true
		get_node("Spell/ElectricArcBall").enabled = false
		get_node("Spell/FireBallBall").enabled = false
