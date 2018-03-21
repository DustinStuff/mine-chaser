extends Area2D

export var MAX_SPEED = 300
export var MAX_ACCELERATION = 1000
export var MAX_DECELERATION = 500

var velocity = Vector2()
var last_position = Vector2(-1, -1)
var current_position = Vector2()

signal died
signal increment_score

var score = 0

var explosion = load("res://Scenes/explosion.tscn")

func _ready():
	set_process(true)
	velocity = Vector2(50, 0)

func _process(delta):

	var move_direction = get_input()
	
	current_position = position
	
	if last_position != Vector2(-1, -1):
		do_movement(move_direction, delta)
		pass
	
	last_position = current_position
	
	$Particles2D.emitting = false
	if move_direction.length() > 0 and is_visible_in_tree():
		$Particles2D.emitting = true
		
	#rotation = fmod(rotation + 0.2, 2 * PI)
		
	
func get_input():
	var input = Vector2()
	
	if Input.is_action_pressed("move_up"):
		input.y -= 1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
		
	return input.normalized()


func do_movement(move_direction, delta):
	
	var forward_vector = Vector2(1,0).rotated(rotation)
	forward_vector = forward_vector.normalized()
	
	current_position = position
	if not last_position == Vector2(-1, -1): 
		velocity = (current_position - last_position) / delta
	var friction_direction = -1 * (current_position - last_position)
	friction_direction = friction_direction.normalized()
	
	velocity += friction_direction * MAX_DECELERATION * delta

	if velocity.length() < MAX_SPEED:
		velocity += forward_vector * move_direction.length() * MAX_ACCELERATION * delta
	
	position += velocity * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)

	rotate(get_angle_to(move_direction + position) / 12)
	
	
	last_position = current_position


func _on_PlayerShip_area_entered(area):

	if area.is_in_group("mine"):
		die()

	if area.is_in_group("coin"):
		score += area.value
		area.pickup()
		emit_signal("increment_score")


func start(pos):
	position = pos
	last_position = Vector2(-1, -1)
	show()
	$CollisionShape2D.disabled = false
	score = 0


func die():
	var e = explosion.instance()
	get_parent().add_child(e)
	e.position = position
	e.scale *= 0.3
	e.explode()
	hide()
	$CollisionShape2D.disabled = true
	emit_signal("died")