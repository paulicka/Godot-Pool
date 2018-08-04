tool
extends Node

# TODO When 3.1 comes out make this a class and make functions static

func _ready():
	pass

func _process(delta):
	pass

func to_vec2(vec3):
	return Vector2(vec3.x, vec3.z)

func to_vec3(vec2):
	return Vector3(vec2.x, 0, vec2.y)

func angle_vec2(angle, length):
	return Vector2(cos(angle) * length, sin(angle) * length)