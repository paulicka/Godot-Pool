extends Spatial

func _ready():
	Game.connect("new_mode", self, "_new_mode")

func _process(delta):
	pass

func _new_mode(mode):
	pass