extends Area2D


func _input(event):
	if event.is_action_pressed("Interact") and len(get_overlapping_bodies()) > 0:
		get_tree().get_current_scene().get_node("Shop").visible = true
		get_tree().get_current_scene().get_node("Shop/ShopCamera").current = true
		get_tree().get_current_scene().get_node("UserInterface").visible = false
	if event.is_action_pressed("exit") and len(get_overlapping_bodies()) > 0:
		get_tree().get_current_scene().get_node("Shop").visible = false
		get_tree().get_current_scene().get_node("YSort/Player/Camera2D").current = true
		get_tree().get_current_scene().get_node("UserInterface").visible = true
