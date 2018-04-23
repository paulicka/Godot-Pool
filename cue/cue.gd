extends Spatial

const min_dist = 2.0
const max_dist = 12.0

const min_power = 1.0
const max_power = 200.0

var rot = 0.0
var power = 0.0

func _ready():
	Game.connect("new_mode", self, "_new_mode")

func _process(delta):
	match Game.mode:
		Game.Mode.PICK_ANGLE:
			var cue_pos = global_transform.origin
			cue_pos = Util.to_vec2(cue_pos)
			var cursor_pos = Game.world.cursor_pos
			rot = -cursor_pos.angle_to_point(cue_pos)
		Game.Mode.PICK_POWER:
			var cue_pos = global_transform.origin
			cue_pos = Util.to_vec2(cue_pos)
			var cursor_pos = Game.world.cursor_pos
			var dist = cursor_pos - cue_pos
			dist = dist.rotated(rot)
			power = -dist.x
			power = clamp(power, min_dist, max_dist)
	
	rotation.y = rot
	$CueTip/CueMesh.translation.x = -32 - power

func get_power():
	return range_lerp(power, min_dist, max_dist, min_power, max_power)

func get_angle():
	return rot

func hit():
	pass

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