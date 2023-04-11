extends Area2D

var count = 1

func _ready():
	count = 1

func _input(event):
	if event.is_action_pressed("Interact") and len(get_overlapping_bodies()) > 0:
		play_dialog()
		
func play_dialog():
	var dialog = get_parent().get_node("Dialogue")
	
	if dialog:
		dialog.start()
		if count == 1:
			PlayerStats.next_progress()
			count -= 1
