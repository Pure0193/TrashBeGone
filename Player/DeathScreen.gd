extends Node2D


func _on_RespawnButton_pressed():
	get_tree().reload_current_scene()
	PlayerStats.hp = PlayerStats.max_hp
