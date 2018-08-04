extends Spatial

const TABLE_WIDTH = 48.0
const TABLE_HEIGHT = 24.0
const TABLE_INSET = 0.175

const ACTUAL_TABLE_WIDTH = TABLE_WIDTH - TABLE_INSET
const ACTUAL_TABLE_HEIGHT = TABLE_HEIGHT - TABLE_INSET

func _ready():
	$StaticBody2D/Top.shape.d = -ACTUAL_TABLE_HEIGHT
	$StaticBody2D/Bot.shape.d = -ACTUAL_TABLE_HEIGHT
	$StaticBody2D/Left.shape.d = -ACTUAL_TABLE_WIDTH
	$StaticBody2D/Right.shape.d = -ACTUAL_TABLE_WIDTH
