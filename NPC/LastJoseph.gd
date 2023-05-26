extends KinematicBody2D

var progress_required = 9

func _ready():
	if PlayerStats.progress != progress_required:
		visible = false
