tool
extends StaticBody2D

const TABLE_WIDTH = 48.0
const TABLE_HEIGHT = 24.0
const TABLE_INSET = 0.175

const HOLE_RADIUS = 2.0
const HOLE_SIZE = 3.0
const CORNER_HOLE_SIZE = 3.1

const OUTER_WIDTH = 80.0
const OUTER_HEIGHT = 50.0

const ACTUAL_TABLE_WIDTH = TABLE_WIDTH - TABLE_INSET
const ACTUAL_TABLE_HEIGHT = TABLE_HEIGHT - TABLE_INSET

onready var top_hole = $TopHoleArea
onready var bot_hole = $BotHoleArea
onready var top_left_hole = $TopLeftHoleArea
onready var top_right_hole = $TopRightHoleArea
onready var bot_left_hole = $BotLeftHoleArea
onready var bot_right_hole = $BotRightHoleArea

func _ready():
	position_box($TopLeft,
			Vector2(-TABLE_WIDTH + CORNER_HOLE_SIZE, ACTUAL_TABLE_HEIGHT),
			Vector2(-HOLE_SIZE, OUTER_HEIGHT)
	)
	position_box($TopRight,
			Vector2(HOLE_SIZE, ACTUAL_TABLE_HEIGHT),
			Vector2(TABLE_WIDTH - CORNER_HOLE_SIZE, OUTER_HEIGHT)
	)
	position_box($BotLeft,
			Vector2(-TABLE_WIDTH + CORNER_HOLE_SIZE, -ACTUAL_TABLE_HEIGHT),
			Vector2(-HOLE_SIZE, -OUTER_HEIGHT)
	)
	position_box($BotRight,
			Vector2(HOLE_SIZE, -ACTUAL_TABLE_HEIGHT),
			Vector2(TABLE_WIDTH - CORNER_HOLE_SIZE, -OUTER_HEIGHT)
	)
	position_box($Left,
			Vector2(-OUTER_WIDTH, -TABLE_HEIGHT + CORNER_HOLE_SIZE),
			Vector2(-ACTUAL_TABLE_WIDTH, TABLE_HEIGHT - CORNER_HOLE_SIZE)
	)
	position_box($Right,
			Vector2(OUTER_WIDTH, -TABLE_HEIGHT + CORNER_HOLE_SIZE),
			Vector2(ACTUAL_TABLE_WIDTH, TABLE_HEIGHT - CORNER_HOLE_SIZE)
	)

static func position_box(box, start, end):
	# Flip y since it's y-down
	start.y = -start.y
	end.y = -end.y
	box.position = (start + end) * 0.5
	box.shape.extents = Vector2(abs(start.x - end.x) * 0.5, abs(start.y - end.y) * 0.5)