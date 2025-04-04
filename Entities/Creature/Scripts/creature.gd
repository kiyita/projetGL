class_name Creature

extends Entity

@export var damage : int ## Amount of damage it deals when attacking
@export var attackSpeed : float ## Number of seconds between two attacks
var drop : Array[Object] ## Array containing the items dropped once dead

@onready var time_last_deal_damage : float


func _ready() -> void:
	time_last_deal_damage = Time.get_ticks_msec() 
	

# Say if the player took mob's aggro
func isMobAggro() -> bool:
	pass
	return false
	
func distanceEuclidienne(posA : Vector3, posB : Vector3):
	return sqrt(pow(posA.x - posB.x, 2) + pow(posA.y - posB.y, 2) + pow(posA.z - posB.z, 2))
	
	
func attack() -> void:
	var disToPlayer = distanceEuclidienne(position, player_scene.position)
	
	if Time.get_ticks_msec() - time_last_deal_damage > attackSpeed*1000:
		if aMode == aggressiveMode.MELEE:
			if disToPlayer <= melee_distance+0.2:
				player_scene.damage_player(damage)
				time_last_deal_damage = Time.get_ticks_msec()
		elif aMode == aggressiveMode.DISTANCE:
			if disToPlayer <= dist_distance+0.2:
				var node_entities = get_tree().current_scene.get_node("Entities")
				var projectile_scene : Projectile = load("res://Items/Projectile/Scene/projectile.tscn").instantiate()
				projectile_scene.initial_position = global_position
				projectile_scene.destination = player_scene.global_position
				projectile_scene.speed = 10
				projectile_scene.damage = damage
				node_entities.add_child(projectile_scene)
				time_last_deal_damage = Time.get_ticks_msec()
		else :
			pass
			
		
	
	


func _process(delta: float) -> void:
	super._process(delta)
	
	attack()
