tool
extends RigidBody

const BALL_SIZE = 1.125
const CIRCUMFERENCE = 2.0 * PI * BALL_SIZE

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

var last_position

func _ready():
	last_position = Vector2(translation.x, translation.z)
	$BallSimulator.position = last_position
	$BallSimulator/CircleShape.shape.radius = BALL_SIZE

func _physics_process(delta):
	# This stops the editor from constantly updating
	if Engine.editor_hint: return
	
	last_position = Vector2(translation.x, translation.z)
	var position = $BallSimulator.position
	translation = Vector3(position.x, BALL_SIZE, position.y)
	
	var velocity = position - last_position
	if velocity != Vector2():
		var axis = velocity.rotated(PI / -2.0).normalized()
		var angle = velocity.length() / CIRCUMFERENCE * 2.0
		transform.basis = transform.basis.rotated(Vector3(axis.x, 0, axis.y), angle)

func hit(impulse):
	$BallSimulator.apply_impulse(Vector2(), impulse)

func set_type(new_type):
	if type != new_type:
		type = new_type
		$BallMesh.material_override.albedo_texture = get_texture()

func get_texture(): # TODO Create a style class to automate this later
	return load("res://ball/styles/default/" + Ball.keys()[type].to_lower() + ".png")