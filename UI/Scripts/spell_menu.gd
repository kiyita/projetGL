class_name SpellMenu

extends Node3D

# Variable for debug menu
var debugMenu_scene # debug scene
var zone # the zone where the hand is
var area2 # the area where the hand is

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set the scene for the debug menu
	var debugMenu = get_parent_node_3d().get_node("LeftHand").get_node("#UI").get_node("debug_menu")
	debugMenu_scene = debugMenu.get_scene_instance() 

	
	var right_hand = get_parent_node_3d().get_node("RightHand") # get the scene of the right hand
	position = right_hand.position # set the position of the spell menu at the position of the right hand when it spawn
	
	
	var areaSpellMenu = right_hand.get_node("#UI").get_node("AreaSpellMenu").get_node("MeshInstance3D") #get the scene of the cursor for spell selection
	areaSpellMenu.visible = true # set it visibility at true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position # the spell menu don't move of his position relative to the player
	
	set_angular() # set the angular position of the spell menu in function of player head
	
	debugMenu_scene.update_content(['Spell Menu', zone, area2, get_parent_node_3d().get_node("RightHand").get_node("#UI").get_children()]) # set the debug menu
	
	
	# Set the color of the triangle (juste visual effect)
	if zone == "green":
		self.mesh.material.albedo_color = Color.GREEN
	elif zone == "red":
		self.mesh.material.albedo_color = Color.RED
	elif zone == "blue":
		self.mesh.material.albedo_color = Color.BLUE
	else:
		self.mesh.material.albedo_color = Color.WHITE
	
	

func set_angular():
	var player_position = get_parent_node_3d().get_node("XRCamera3D").position # get the position of the player
	
	var x = position.x - player_position.x # the x distance between player and spell menu
	var y = position.y - player_position.y # the y distance between player and spell menu
	var z = position.z - player_position.z # the z distance between player and spell menu
		
	rotation.y = atan2(x, z) # calculate the y angle 
	rotation.z = -atan2(y, sqrt(x^2 + z^2)) # calculate the z angle 


func destroy():
	var player_scene = get_parent_node_3d() # get the player scene
	var areaSpellMenu = player_scene.get_node("RightHand").get_node("#UI").get_node("AreaSpellMenu").get_node("MeshInstance3D") #get the scen of the cursor for selection
	areaSpellMenu.visible = false # disabled the visibility of the cursor for selection
	
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
		get_parent_node_3d().selected_spell = PlayerScript.SpellEnum.SPELL2

func _on_blue_area_entered(area: Area3D) -> void:
	area2 = area # set area2 for the debug menu
	if area.name == "AreaSpellMenu": # check if the area is the good one
		zone = "blue" # set the variable zone in function of which zone the cursor entered
		get_parent_node_3d().selected_spell = PlayerScript.SpellEnum.ELECTRICARC
