extends Area2D

export var MAX_SPEED = 250
var velocity = 0.0

signal died
signal increment_score

var score = 0

func _ready():
	set_process(true)

func _process(delta):

	var move_direction = Vector2()

	if Input.is_action_pressed("move_up"):
		move_direction.y -= 1
	if Input.is_action_pressed("move_down"):
			move_direction.y += 1
	if Input.is_action_pressed("move_left"):
			move_direction.x -= 1
	if Input.is_action_pressed("move_right"):
			move_direction.x += 1

	position += move_direction.normalized() * MAX_SPEED * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
	look_at(move_direction + position)


func _on_PlayerShip_area_entered(area):

	if area.is_in_group("mine"):
		die()

	if area.is_in_group("coin"):
		score += area.value
		area.pickup()
		emit_signal("increment_score")


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	score = 0


func die():
	hide()
	$CollisionShape2D.disabled = true
	emit_signal("died")