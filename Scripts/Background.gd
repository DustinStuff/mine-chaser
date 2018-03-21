extends ColorRect

var bg_color = "1f2a38" # Dark blue-ish

func _ready():
	rect_size = get_viewport().size #/ 4
	#rect_position = get_viewport().size #/ 4

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
