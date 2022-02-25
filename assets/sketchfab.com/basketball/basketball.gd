extends XRToolsPickable

var start_transform : Transform3D

func pick_up(by, with_controller):
	super.pick_up(by, with_controller)
	
	$AnimationPlayer.stop()
	$scene.visible = true

func let_go(p_linear_velocity = Vector3(), p_angular_velocity = Vector3()):
	super.let_go(p_linear_velocity, p_angular_velocity)
	
	$AnimationPlayer.play("Lifetime")

func _ready():
	start_transform = global_transform
	super()

func _reset():
	# Reset
	linear_velocity = Vector3()
	angular_velocity = Vector3()
	global_transform = start_transform
