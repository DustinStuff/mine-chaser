extends Control

var text = "Hello!" setget set_text
var color = "FF00FF" setget set_color  # Hot pink default ^-^

func _ready():
	hide()
	
func set_text(t):
	text = t
	update_label()
	
func set_color(c):
	color = c
	update_label()
	

func update_label():
	$Label.bbcode_text = "[center][color=#%s]%s[/color][/center]" % [color, text]

func pop():
	show()
	$Label/AnimationPlayer.play("coin_pop")
	$DeleteTimer.start()
	

func _on_DeleteTimer_timeout():
	queue_free()
