extends Area2D

var MIN_SPEED = 50
var MAX_SPEED = 200

var player
var screen_diagnal

var rand_normalized_vector = Vector2()

var explosion = load("res://Scenes/explosion.tscn")

func _ready():
	rand_normalized_vector.x = rand_range(-1.0, 1.0)
	rand_normalized_vector.y = rand_range(-1.0, 1.0)
	player = get_parent().get_node("Player")
	screen_diagnal = Vector2(0, 0).distance_to(get_viewport_rect().size) / 2
	$AnimatedSprite.playing = true


func _process(delta):
	var velocity = 0
	var player_direction = Vector2()
	if player.is_visible_in_tree():
		var player_distance = position.distance_to(player.position)
		player_direction = player.position - position
		player_direction = player_direction.normalized()
		var distance_weight = pow(1 - min(player_distance/screen_diagnal, 1) ,2.5)

		velocity = clamp(lerp(MIN_SPEED, MAX_SPEED, distance_weight), MIN_SPEED, MAX_SPEED)
		#print(player_distance)
		
	else: 
		player_direction = rand_normalized_vector
		velocity = MIN_SPEED
	
	position += velocity * player_direction * delta
	rotation_degrees += velocity / 2 * delta


func _on_Mine_area_entered(area):
	if not area.is_in_group("coin"):
		
		var e = explosion.instance()
		get_parent().add_child(e)
		e.position = position
		e.scale *= 0.3
		e.explode()
		
		queue_free()
