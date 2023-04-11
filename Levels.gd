extends Node2D


func _ready():
	if Global.from_pos != null:
		get_node("YSort/Player").set_position(get_node(Global.from_pos).position)
