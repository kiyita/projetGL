class_name SpellMenu

extends Node3D

# Variable for debug menu
var zone # the zone where the hand is
var area2 # the area where the hand is

@onready var player_scene : PlayerScript = get_tree().current_scene.get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var main_hand_sm = select_hand_player() # get the scene of the right hand
	position = main_hand_sm.position # set the position of the spell menu at the position of the right hand when it spawn
	
	main_hand_sm.get_node("#UI").add_child(load("res://UI/Scenes/spell_menu_selector.tscn").instantiate())

	if player_scene.spellUnlock["FIREBALL"] == false:
		$Red.visible = false
	if player_scene.spellUnlock["ELECTRICARC"] == false:
		$Blue.visible = false
	if player_scene.spellUnlock["HEALORB"] == false:
		$Green.visible = false
	
	self.mesh.material.albedo_color = Color.WHITE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position # the spell menu don't move of his position relative to the player
	
	set_angular() # set the angular position of the spell menu in function of player head
		
	
	# Set the color of the triangle (juste visual effect)
	if zone == "green":
		self.mesh.material.albedo_color = Color.GREEN
	elif zone == "red":
		self.mesh.material.albedo_color = Color.RED
	elif zone == "blue":
		self.mesh.material.albedo_color = Color.BLUE
	else:
		self.mesh.material.albedo_color = Color.WHITE



func select_hand_player():
	if player_scene.main_hand == PlayerScript.Hands.RIGHT:
		return player_scene.get_node("LeftHand")
	else :
		return player_scene.get_node("RightHand")


	
## Set angular position of the spell menu
func set_angular():
	var player_position = get_parent_node_3d().get_node("XRCamera3D").position # get the position of the player
	
	var x = position.x - player_position.x # the x distance between player and spell menu
	var y = position.y - player_position.y # the y distance between player and spell menu
	var z = position.z - player_position.z # the z distance between player and spell menu
		
	rotation.y = atan2(x, z) # calculate the y angle 
	rotation.z = -atan2(y, sqrt(x^2 + z^2)) # calculate the z angle 


## Hide the selection cursor and destroy the spell menu
func destroy():
	# destroy cursor
	select_hand_player().get_node("#UI").get_node("AreaSpellMenu").queue_free()
	
	queue_free() # destroy the current scene



func _on_red_area_entered(area: Area3D) -> void:
	area2 = area # set area2 for the debug menu
	if area.name == "AreaSpellMenu": # check if the area is the good one
		zone = "red" # set the variable zone in function of which zone the cursor entered
		get_parent_node_3d().selected_spell = PlayerScript.SpellEnum.FIREBALL

func _on_green_area_entered(area: Area3D) -> void:
	area2 = area # set area2 for the debug menu
	if area.name == "AreaSpellMenu": # check if the area is the good one
		zone = "green" # set the variable zone in function of which zone the cursor entered
		get_parent_node_3d().selected_spell = PlayerScript.SpellEnum.HEALORB

func _on_blue_area_entered(area: Area3D) -> void:
	area2 = area # set area2 for the debug menu
	if area.name == "AreaSpellMenu": # check if the area is the good one
		zone = "blue" # set the variable zone in function of which zone the cursor entered
		get_parent_node_3d().selected_spell = PlayerScript.SpellEnum.ELECTRICARC
