extends Spatial

var rot = 0.0
var power = 0.0

func _ready():
	Game.connect("new_mode", self, "_new_mode")

func _process(delta):
	match Game.mode:
		Game.Mode.PICK_ANGLE:
			var cue_pos = global_transform.origin
			cue_pos = Vector2(cue_pos.x, cue_pos.y)
			var cursor_pos = Game.world.cursor_pos
			rot = -cursor_pos.angle_to_point(cue_pos)
		Game.Mode.PICK_POWER:
			var cue_pos = global_transform.origin
			cue_pos = Vector2(cue_pos.x, cue_pos.y)
			var cursor_pos = Game.world.cursor_pos
			var dist = cursor_pos - cue_pos
			#TODO FIX!!!!
			dist.rotated(rot)
			power = -dist.x
			power = clamp(power, 2, 12)
	
	rotation.y = rot
	$CueTip/CueMesh.translation.x = -32 - power

func _new_mode(mode):
	match mode:
		Game.Mode.PICK_ANGLE:
			$AngleInfo.show()
			$PowerInfo.hide()
		Game.Mode.PICK_POWER:
			$AngleInfo.hide()
			$PowerInfo.show()
		Game.Mode.PICK_IMPACT:
			$AngleInfo.hide()
			$PowerInfo.hide()
		Game.Mode.NONE:
			$AngleInfo.hide()
			$PowerInfo.hide()