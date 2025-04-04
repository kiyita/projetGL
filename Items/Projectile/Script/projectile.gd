class_name Projectile

extends RigidBody3D


var initial_position : Vector3
var destination : Vector3
var speed : float
var damage : float

var direction
var t0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = initial_position
	direction = (destination - initial_position).normalized()
	direction.y = 0
	linear_velocity = direction * speed
	
	t0 = Time.get_ticks_msec()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	linear_velocity = direction*speed

	if Time.get_ticks_msec() - t0 > 5000:
		destroy()


func destroy():
	queue_free()

func _on_area_3d_area_entered(area: Area3D) -> void:
	
	if area.get_parent_node_3d().name == "Player":
		area.get_parent_node_3d().damage_player(damage)
		destroy()
