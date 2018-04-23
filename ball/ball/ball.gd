tool
extends RigidBody

const BALL_SIZE = 1.125

enum Ball{
	SOLID_1, SOLID_2, SOLID_3,
	SOLID_4, SOLID_5, SOLID_6,
	SOLID_7, BALL_8, STRIPE_9,
	STRIPE_10, STRIPE_11, STRIPE_12,
	STRIPE_13, STRIPE_14, STRIPE_15
}

export(Ball) var type setget set_type
var current_style = 0

func _ready():
	pass

func _process(delta):
	pass

func set_type(new_type):
	if type != new_type:
		type = new_type
		$BallMesh.material_override.albedo_texture = get_texture()

func get_texture(): # Create a style class to automate this later
	return load("res://ball/styles/default/" + Ball.keys()[type].to_lower() + ".png")