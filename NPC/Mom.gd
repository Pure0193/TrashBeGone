extends KinematicBody2D

export(int) var progress_required = 1

func _ready():
	if PlayerStats.progress != progress_required:
		visible = false
