extends Area2D

var player = null


func PlayerDetected():
	return player != null
	

func _on_PickUpZone_body_entered(body):
	player = body


func _on_PickUpZone_body_exited(body):
	player = null

