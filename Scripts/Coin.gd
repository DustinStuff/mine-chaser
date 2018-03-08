extends Area2D


var value = 0
var textures = [load("res://Textures/coin_brown_sprite.png"),
				load("res://Textures/coin_silver_sprite.png"),
				load("res://Textures/coin_gold_sprite.png"),
				load("res://Textures/coin_blue_sprite.png"),
				load("res://Textures/coin_rainbow_sprite.png")]

export var silver_weight = 5
export var gold_weight = 10
export var blue_weight = 20
export var rainbow_weight = 50

export var copper_value = 1
export var silver_value = 2
export var gold_value = 5
export var blue_value = 10
export var rainbow_value = 50

signal picked_up

func _ready():
	random_coin()

func coin_type(type):
	if type == "copper":
		$Sprite.set_texture(textures[0])
		value = copper_value
	elif type == "silver":
		$Sprite.set_texture(textures[1])
		value = silver_value
	elif type == "gold":
		$Sprite.set_texture(textures[2])
		value = gold_value
	elif type == "blue":
		$Sprite.set_texture(textures[3])
		value = blue_value
	elif type == "rainbow":
		$Sprite.set_texture(textures[4])
		value = rainbow_value


func random_coin():
	randomize()
	var randnum = randi()
	if randnum % rainbow_weight == 0:
		coin_type("rainbow")
	elif randnum % blue_weight == 0:
		coin_type("blue")
	elif randnum % gold_weight == 0:
		coin_type("gold")
	elif randnum % silver_weight == 0:
		coin_type("silver")
	else:
		coin_type("copper")
	

func pickup():
	emit_signal("picked_up")
	queue_free()