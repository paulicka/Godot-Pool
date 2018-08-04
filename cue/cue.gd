extends Spatial

const min_dist = 2.0
const max_dist = 12.0

const min_power = 1.0
const max_power = 200.0

var rot = 0.0
var power = min_dist

var time = 0.0

func _ready():
	Game.connect("new_mode", self, "_new_mode")
	Game.connect("new_stage", self, "_new_stage")
	$CueTip/CueMesh.translation.x = -32 - power

func _process(delta):
	translation = Game.world.get_cue_ball().translation
	
	if Game.stage != Game.PLAN: return
	if not Game.is_current_turn(): return
	
	match Game.mode:
		Game.Mode.PICK_ANGLE:
			var cue_pos = global_transform.origin
			cue_pos = Util.to_vec2(cue_pos)
			var cursor_pos = Game.world.cursor_pos
			rot = -cursor_pos.angle_to_point(cue_pos)
			
			rotation.y = rot
		Game.Mode.PICK_POWER:
			var cue_pos = global_transform.origin
			cue_pos = Util.to_vec2(cue_pos)
			var cursor_pos = Game.world.cursor_pos
			var dist = cursor_pos - cue_pos
			dist = dist.rotated(rot)
			power = -dist.x
			power = clamp(power, min_dist, max_dist)
			
			$CueTip/CueMesh.translation.x = -32 - power
			var linear_power = range_lerp(power, min_dist, max_dist, 0.04, 0.98)
			$PowerInfo/PowerIcon.material_override.set_shader_param("power", linear_power)
			time += delta * (linear_power * linear_power + 0.1) * 0.7
			# Make tool script to see this animated
			$PowerInfo/PowerIcon.material_override.set_shader_param("time", time)

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

func _new_stage(stage):
	visible = stage == Game.Stage.PLAN