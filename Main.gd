extends Node3D

var interface : XRInterface

func _ready():
	# Find our interface and check if it was successfully initialised.
	# Note that Godot should initialise this automatically IF you've
	# enabled it in project settings!
	interface = XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		print("OpenXR initialised successfully")

		var vp : Viewport = get_viewport()
		vp.use_xr = true
		
		# vp.vrs_mode = Viewport.VRS_XR
	else:
		print("OpenXR not initialised, please check if your headset is connected")

func _on_right_hand_button_pressed(p_name):
	print("Pressed " + str(p_name))

func _process(delta):
	$XROrigin3D/XRCamera3D/FPS.text = "FPS: %d" % Engine.get_frames_per_second()
