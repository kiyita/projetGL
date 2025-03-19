extends Node3D

var xr_interface: XRInterface
@onready var musicbg = $musicbg

func _ready():
	musicbg.volume_db = -20
	musicbg.play()
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")

func _unhandled_input(event):
	if event.is_action_pressed("by_button"):
		# This restarts the current scene.
		get_tree().reload_current_scene()
