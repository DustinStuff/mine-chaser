extends Control

signal restart_pressed
signal exit_pressed


func _on_Restart_pressed():
	emit_signal("restart_pressed")


func _on_Exit_pressed():
	emit_signal("exit_pressed")