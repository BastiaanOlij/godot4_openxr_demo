extends Node3D

var interface : XRInterface

func _ready():
	# Find our interface and check if it was successfully initialised.
	# Note that Godot should initialise this automatically IF you've
	# enabled it in project settings!
	interface = XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		print("OpenXR initialised successfully")

		var vp : SubViewport = $HMDOutput
		vp.use_xr = true

		# vp.vrs_mode = Viewport.VRS_XR
		$DesktopOutputContainer/DesktopOutput/CanvasLayer/TextureRect.texture = vp.get_texture()
	else:
		print("OpenXR not initialised, please check if your headset is connected")

func _on_right_hand_button_pressed(p_name):
	print("Pressed " + str(p_name))
