#tool # TODO Add back in 3.1
extends RigidBody

const BALL_SIZE = 1.125
const CIRCUMFERENCE = 2.0 * PI * BALL_SIZE

const COLLISION_PLAYER = preload("collision_player.gd")

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

func _ready():
	$BallSimulator/CircleShape.shape.radius = BALL_SIZE
	$BallSimulator.position = Util.to_vec2(translation)
	#$BallSimulator/CircleShape.disabled = false
	
	$BallSimulator.connect("body_entered", self, "_collided")

func _physics_process(delta):
	# This stops the editor from constantly updating
	if Engine.editor_hint: return
	
	var position = $BallSimulator.position
	translation = Vector3(position.x, BALL_SIZE, position.y)
	
	var velocity = $BallSimulator.linear_velocity * delta
	if velocity != Vector2():
		var axis = velocity.rotated(PI * -0.5).normalized()
		var angle = velocity.length() / BALL_SIZE
		transform.basis = transform.basis.rotated(Util.to_vec3(axis), angle)

func _collided(body):
	if body.name == "BallSimulator" and is_greater_than(body):
		#print("hit")
		Game.world.add_child(COLLISION_PLAYER.new(COLLISION_PLAYER.BALL_COLLISION))

func hit(impulse):
	$BallSimulator.apply_impulse(Vector2(), impulse)

func is_still():
	return $BallSimulator.linear_velocity.length_squared() < 0.05

func force_still():
	$BallSimulator.linear_velocity = Vector2()

func set_type(new_type):
	if type != new_type:
		type = new_type
		$BallMesh.material_override.albedo_texture = get_texture()

func get_texture(): # TODO Create a style class to automate this later
	return load("res://ball/styles/default/" + Ball.keys()[type].to_lower() + ".png")