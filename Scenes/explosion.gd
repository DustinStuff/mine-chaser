extends Node2D

func explode():
	$"Red bit".emitting = true
	$Smoke.emitting = true
	$"White bit".emitting = true
	$DeleteTimer.start()

func _on_DeleteTimer_timeout():
	queue_free()