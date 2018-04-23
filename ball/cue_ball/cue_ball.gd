tool
extends RigidBody

func _ready():
	$BallMesh.material_override.albedo_texture = get_texture()

func hit(impulse):
	self.apply_impulse(Vector3(), Vector3(impulse.x, 0, impulse.y))

func get_texture(): # Create a style class to automate this later
	return load("res://ball/styles/default/cue_ball.png")