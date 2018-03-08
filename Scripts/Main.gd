extends Node

var MINE_MIN_SPAWN_DISTANCE = 200

var screensize = Vector2()
var coin = load("res://Scenes/Coin.tscn")
var mine = load("res://Scenes/Mine.tscn")

var score = 0
var time = 0


func _ready():
	randomize()
	screensize = $Player.get_viewport_rect().size
	$GameTime.start()
	$Player.position = screensize / 2
	start_game()

func spawn_coin():
	var c = coin.instance()
	add_child(c)
	c.connect("picked_up", self, "_on_coin_picked_up")
	var rpos = Vector2()
	rpos.x = randi() % int(screensize.x)
	rpos.y = randi() % int(screensize.y)
	
	c.position = rpos
	c.set_scale(Vector2(0.2, 0.2))


func spawn_mine():
	var rpos = Vector2()
	var m = mine.instance()
	add_child(m)
	m.set_scale(Vector2(0.2, 0.2))  # they be large
	# If the spawn position is within a no-spawn radius, 
	# reroll the spawn position until it's not.
	while not rpos or rpos.distance_to($Player.position) < MINE_MIN_SPAWN_DISTANCE:
		rpos.x = randi() % int(screensize.x)
		rpos.y = randi() % int(screensize.y)
	m.position = rpos
	

func _on_coin_picked_up():
	spawn_coin()
	spawn_mine()
	
	
func start_game():
	# Delete the field
	for child in get_children():
		if child.is_in_group("coin") or child.is_in_group("mine"):
			child.queue_free()
	score = 0
	time = 0
	update_hud(score, time)
	$Player.start(screensize / 2)
	spawn_coin()
	
	
func update_hud(score, time):
	$HUD/CenterContainer/HBoxContainer/Score.set_text("Score %d" % score)
	$HUD/CenterContainer/HBoxContainer/Time.set_text("Time: %d" % time)


func _on_Player_died():
	start_game()


func _on_Player_increment_score():
	score = $Player.score
	update_hud(score, time)

func _on_GameTime_timeout():
	time += 1
	update_hud(score, time)