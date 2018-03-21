extends Area2D


var value = 0
var coin_color = ""

# Loads these textures every time a coin is spawned.
# Not a *great* way to do this, a better way would be to
# use a flyweight pattern or similar, but since it only
# spawns one coin at a time, and these textures are small
# and cheap, this works... for now.
#
# Actually, one coin texture + materials might be better... Maybe eventually.
var textures = [load("res://Textures/New/coin_orange.png"),
				load("res://Textures/New/coin_yellow.png"),
				load("res://Textures/New/coin_green.png"),
				load("res://Textures/New/coin_blue.png"),
				load("res://Textures/New/coin_purple.png"),
				load("res://Textures/New/coin_rainbow.png")]
# These are the same colors as their respective coins.
# Not straight yellow, orange, etc.
var colors = { 'orange': "f0916f",
			   'yellow': "e3e08f",
			   'green': "7ad6a1",
			   'blue': "5a80bc",
			   'purple': "866fd1"}

var label = load("res://Scenes/Value_text.tscn")

export var yellow_weight = 5
export var green_weight = 10
export var blue_weight = 25
export var purple_weight = 40
export var rainbow_weight = 100

export var orange_value = 1
export var yellow_value = 5
export var green_value = 10
export var blue_value = 25
export var purple_value = 25
export var rainbow_value = 50

signal picked_up

func _ready():
	coin_color = random_color()
	set_coin(coin_color)
	
	var animation = $AnimationPlayer.get_animation($AnimationPlayer.current_animation)
	animation.track_set_enabled(2, false)
	if value == rainbow_value: 
		animation.track_set_enabled(2, true)

func set_coin(type):
	if type == "orange":
		$Sprite.set_texture(textures[0])
		value = orange_value
	elif type == "yellow":
		$Sprite.set_texture(textures[1])
		value = yellow_value
	elif type == "green":
		$Sprite.set_texture(textures[2])
		value = green_value
	elif type == "blue":
		$Sprite.set_texture(textures[3])
		value = blue_value
	elif type == "purple":
		$Sprite.set_texture(textures[4])
		value = purple_value
	elif type == "rainbow":
		$Sprite.set_texture(textures[5])
		value = rainbow_value


func random_color():
	randomize()
	var randnum = randi()
	if randnum % rainbow_weight == 0:
		return "rainbow"
	elif randnum % blue_weight == 0:
		return "blue"
	elif randnum % purple_weight == 0:
		return "purple"
	elif randnum % green_weight == 0:
		return "green"
	elif randnum % yellow_weight == 0:
		return "yellow"
	else:
		return "orange"
	

func pickup():
	var l = label.instance()
	get_parent().add_child(l)
	l.rect_scale = Vector2(0.4,0.4)
	l.rect_position = position
	l.set_text("+%d" % value)
	if coin_color != "rainbow":
		l.set_color(colors[coin_color])
	l.pop()
	
	emit_signal("picked_up")
	queue_free()