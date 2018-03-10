extends Node

var highscore = 0 setget set_highscore
const filepath = "user://highscore.data"

func _ready():
	load_highscore()
	
func load_highscore():
	var file = File.new()
	file.open(filepath, File.READ)
	if not file.file_exists(filepath):
		return
	file.open(filepath, File.READ)
	highscore = file.get_var()
	file.close()
	
func save_highscore():
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_var(highscore)
	file.close()
	
func set_highscore(new_value):
	highscore = new_value
	save_highscore()