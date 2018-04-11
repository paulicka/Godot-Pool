extends Node

enum Ball{
	SOLID_1, SOLID_2, SOLID_3,
	SOLID_4, SOLID_5, SOLID_6,
	SOLID_7, BALL_8, STRIPE_9,
	STRIPE_10, STRIPE_11, STRIPE_12,
	STRIPE_13, STRIPE_14, STRIPE_15,
	CUE_BALL
}

const styles = [
	"default"
]

var current_style = 0

func _ready():
	for ball_name in Ball:
		ball_name = ball_name.to_lower()
		
	pass

func _process(delta):
	pass

func create_triangle():
	var balls = []
	for ball in Ball:
		balls.push_back(create_ball(Ball[ball]))
	var root = Spatial.new()
	

func fix_triangle(balls):
	pass

func create_ball(type):
	pass