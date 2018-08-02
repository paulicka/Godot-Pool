extends Spatial

const TABLE_WIDTH = 48.0
const TABLE_HEIGHT = 24.0
const TABLE_INSET = 0.5

func _ready():
	$StaticBody2D/Top.shape.d = -TABLE_HEIGHT + TABLE_INSET
	$StaticBody2D/Bot.shape.d = -TABLE_HEIGHT + TABLE_INSET
	$StaticBody2D/Left.shape.d = -TABLE_WIDTH + TABLE_INSET
	$StaticBody2D/Right.shape.d = -TABLE_WIDTH + TABLE_INSET
