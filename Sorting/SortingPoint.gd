extends Area2D

func _input(event):
	if event.is_action_pressed("Interact") and len(get_overlapping_bodies()) > 0:
		start_sort()
		get_tree().get_current_scene().get_node("UserInterface").visible = false
	if event.is_action_pressed("exit") and len(get_overlapping_bodies()) > 0:
		stop_sort()
		get_tree().get_current_scene().get_node("UserInterface").visible = true
		
func start_sort():
	var sort = get_parent().get_parent().get_node("Sorting")
	
	if sort:
		sort.start_sort()
		get_parent().get_parent().get_node("Camera2").current = true

func stop_sort():
	var sort = get_parent().get_parent().get_node("Sorting")
	
	if sort:
		sort.stop_sort()
