tool
extends StaticBody2D

const TABLE_WIDTH = 48.0
const TABLE_HEIGHT = 24.0
const TABLE_INSET = 0.175

const HOLE_RADIUS = 2.0
const HOLE_SIZE = 3.0
const CORNER_HOLE_SIZE = 3.0

const OUTER_WIDTH = 100.0
const OUTER_HEIGHT = 50.0

const ACTUAL_TABLE_WIDTH = TABLE_WIDTH - TABLE_INSET
const ACTUAL_TABLE_HEIGHT = TABLE_HEIGHT - TABLE_INSET

func _ready():
	position_box($TopLeft,
			Vector2(-TABLE_WIDTH + CORNER_HOLE_SIZE, ACTUAL_TABLE_HEIGHT),
			Vector2(-HOLE_SIZE, OUTER_HEIGHT)
	)
	
	position_box($TopRight,
			Vector2(HOLE_SIZE, ACTUAL_TABLE_HEIGHT),
			Vector2(TABLE_WIDTH - CORNER_HOLE_SIZE, OUTER_HEIGHT)
	)
	

static func position_box(box, start, end):
	# Flip y since it's y-down
	start.y = -start.y
	end.y = -end.y
	box.position = (start + end) * 0.5
	box.shape.extents = Vector2(abs(start.x - end.x) * 0.5, abs(start.y - end.y) * 0.5)