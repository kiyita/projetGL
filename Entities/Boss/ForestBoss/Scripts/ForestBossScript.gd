class_name ForestBoss

extends Entity

# Spell scene
var spell_scene = preload("res://Spells/PoisonBall/Scene/PoisonBall.tscn") 
# Mob scene
var mob_scene = preload("res://Entities/Creature/Scenes/Tuto.tscn") 

var TAU = 2 * PI # for the second attack pattern

var not_launched_battle_phase = true # if true : the boss fight hasn't started. 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	#stop_fleeing_distance = 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if isTrackingPlayer and not_launched_battle_phase:
		not_launched_battle_phase = false
		boss_fight()
	
	if !isTrackingPlayer and !not_launched_battle_phase: # if the player leave
		hp = hpMax
		not_launched_battle_phase = true

func boss_fight():
	#setTarget()
	if isTrackingPlayer: # we need to check if the player is still in the boss' place
		await throw_on_player()
	if isTrackingPlayer:
		await get_tree().create_timer(160.0).timeout  # Waiting 2 seconds
	if isTrackingPlayer:
		await spawn_mob_around_player()

# first attack pattern
func throw_on_player():
	for i in range(10):
		if !isTrackingPlayer:
			break
		await get_tree().create_timer(2.0).timeout  # Waiting 2 seconds
		var player_pos = get_parent_node_3d().get_parent_node_3d().get_node("Player").global_position
		# Spell instantiation
		var spell_instance = spell_scene.instantiate()
		# Spell positioning
		spell_instance.global_position = player_pos
		# Adding the spell to the scene
		get_tree().current_scene.add_child(spell_instance)

# second attack pattern
func spawn_mob_around_player():
	var player_pos = get_parent_node_3d().get_parent_node_3d().get_node("Player").global_position

	# Random angle (radians)
	var angle = randf() * TAU  # TAU = 2 * PI (toutes les directions possibles)

	# Random distance between 5 and 10 meters
	var distance = randf_range(5.0, 10.0)

	# Position around the player
	var spawn_pos = player_pos + Vector3(cos(angle) * distance, 0, sin(angle) * distance)
	
	var mob_instance = mob_scene.instantiate()
	
	mob_instance.global_position = spawn_pos
	
	# Adding the mob to the scene
	get_tree().current_scene.add_child(mob_instance)
