tool
extends RigidBody

const BALL_SIZE = 1.125
const DAMPENING = 50.0
const MAX_ITERATIONS = 4

enum Ball{
	CUE_BALL,
	SOLID_1, SOLID_2, SOLID_3,
	SOLID_4, SOLID_5, SOLID_6,
	SOLID_7, BALL_8, STRIPE_9,
	STRIPE_10, STRIPE_11, STRIPE_12,
	STRIPE_13, STRIPE_14, STRIPE_15
}

export(Ball) var type setget set_type
var current_style = 0

var velocity = Vector2()

func _ready():
	$BallSimulator.position = Vector2(translation.x, translation.z)
	$BallSimulator/CircleShape.shape.radius = BALL_SIZE

func _physics_process(delta):
	# This stops the editor from constantly updating
	if Engine.editor_hint: return
	
	var position = $BallSimulator.position
	translation = Vector3(position.x, BALL_SIZE, position.y)

func hit(impulse):
	$BallSimulator.apply_impulse(Vector2(), impulse)

func set_type(new_type):
	if type != new_type:
		type = new_type
		$BallMesh.material_override.albedo_texture = get_texture()

func get_texture(): # TODO Create a style class to automate this later
	return load("res://ball/styles/default/" + Ball.keys()[type].to_lower() + ".png")