extends Spatial

enum Hole{
	HOLE_TOP
	HOLE_BOT
	HOLE_TOP_LEFT
	HOLE_BOT_LEFT
	HOLE_TOP_RIGHT
	HOLE_BOT_RIGHT
}

signal ball_in(ball, hole)

func _ready():
	$TableCollider.top_hole.connect("body_entered", self, "ball_in", [HOLE_TOP])
	$TableCollider.bot_hole.connect("body_entered", self, "ball_in", [HOLE_BOT])
	$TableCollider.top_left_hole.connect("body_entered", self, "ball_in", [HOLE_TOP_LEFT])
	$TableCollider.top_right_hole.connect("body_entered", self, "ball_in", [HOLE_TOP_RIGHT])
	$TableCollider.bot_left_hole.connect("body_entered", self, "ball_in", [HOLE_BOT_LEFT])
	$TableCollider.bot_right_hole.connect("body_entered", self, "ball_in", [HOLE_BOT_RIGHT])

func ball_in(ball, hole):
	ball = ball.get_parent()
	ball.ball_in()
	emit_signal("ball_in", ball, hole)