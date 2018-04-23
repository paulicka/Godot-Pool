extends Spatial

const factor = 7.0
const max_pitch = PI/2 - 0.1
const min_pitch = 0.1
const max_zoom = 45.0
const min_zoom = 5.0

var yaw = 0.0
var pitch = 0.6
var zoom = (max_zoom + min_zoom) / 2.0
var pos = Vector2()

func _ready():
	pass

func _process(delta):
	var current_pos = Vector2(translation.x, translation.z)
	current_pos += (pos - current_pos) * min(1.0, factor * delta)
	translation.x = current_pos.x
	translation.z = current_pos.y
	
	rotation.y = yaw
	rotation.x = -pitch
	
	$Camera.translation.z = zoom

func move_to(move):
	pos = move

func translate(amount):
	amount = amount.rotated(-yaw)
	pos += amount

func rotate(yaw_amount, pitch_amount):
	pitch = clamp(pitch + pitch_amount, min_pitch, max_pitch)
	yaw += yaw_amount

func zoom(amount):
	zoom = clamp(zoom + amount, min_zoom, max_zoom)

func project_ray(point):
	var from = $Camera.project_ray_origin(point)
	#var from = $Camera.global_transform.origin
	var to = from + $Camera.project_ray_normal(point) * 1000
	var result = get_world().direct_space_state.intersect_ray(from, to, [], 0x2)
	if result:
		return result.position
	else:
		return null