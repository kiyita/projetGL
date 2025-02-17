class_name PlayerScript

extends CharacterBody3D

const SPEED = 10.0
const JUMP_VELOCITY = 4.5

enum SpellEnum {FIREBALL, ## Spell fireball
				SPELL2, ## Spell 2
				ELECTRIC ## Spell 3
				}
var selectedSpell : SpellEnum ## The variable where the selected spell is save

# Références des noeuds enfants
@onready var camera: Camera3D = $Camera
@onready var left_hand: Node3D = $LeftHand
@onready var right_hand: Node3D = $RightHand

# @export var name : String
@export var stats : Statistics = Statistics.new()
@export var manaMax : int = 100
var mana : int = manaMax
# @export var armorSet : Set
var inventory : Array[Object]

func _on_equipment(new_stats:Variant) -> void:
	stats.HP += new_stats.HP
	stats.ATK += new_stats.ATK
	stats.DEF += new_stats.DEF
	stats.speed += new_stats.speed
	stats.ATKSpeed *= new_stats.ATKSpeed
	
func _on_unequipment(old_stats:Variant) -> void:
	stats.HP -= old_stats.HP
	stats.ATK -= old_stats.ATK
	stats.DEF -= old_stats.DEF
	stats.speed -= old_stats.speed
	stats.ATKSpeed /= old_stats.ATKSpeed





func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
