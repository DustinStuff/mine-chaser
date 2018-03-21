extends Sprite

export var SCALE = 0.25 # Multiples/divisibles of 2 (e.g., 4 or 0.25)
export var SCROLL_RATE = 10
var SCROLL_DIRECTION = Vector2(1,0).normalized()  # Only works in X axis... for now
#var TEXTURE# = load("res://Textures/New/near_stars.png")  # Remember to set repeat flag!

onready var screensize = get_viewport_rect().size

func _ready():

	texture.set_flags(Texture.FLAG_REPEAT)
	
	# Set tiling to match screensize*2 
	set_scale(Vector2(SCALE,SCALE))
	region_rect.size.x = screensize.x * (1 / SCALE) * 2 #/ 4
	region_rect.size.y = screensize.y * (1 / SCALE) * 2 #/ 4
	
	# Set center to corner where it will be scrolling from
	set_centered(true)
	var corner = Vector2(0, 0)
#	# 0, 0 - Top Left
#	# 1, 0 - Top Right
#	# 0, 1 - Bottom Left
#	# 1, 1 - Bottom Right
#	if SCROLL_DIRECTION.x < 0:
#		corner.x = 1
#	if SCROLL_DIRECTION.y < 0:
#		corner.y = 1
	position = screensize * corner
	pass
	
func _process(delta):
	if position.x >= screensize.x / 2:
		position.x = 0
	if position.y >= screensize.y / 2:
		position.y = 0 
	translate(SCROLL_DIRECTION * SCROLL_RATE * delta)
	pass
