extends Spatial

func _ready():
	Game.connect("new_mode", self, "_new_mode")

func _process(delta):
	var cue_pos = global_transform.origin
	cue_pos = Vector2(cue_pos.x, cue_pos.y)
	var cursor_pos = Game.world.cursor_pos
	rotation_degrees.y = cursor_pos.angle_to_point(cue_pos)

func _new_mode(mode):
	pass