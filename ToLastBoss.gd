extends Area2D

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func _input(event):
	if event.is_action_pressed("Interact") and len(get_overlapping_bodies()) > 0:
		for item_index in PlayerInventory.inventory:
			if "basement" in String(PlayerInventory.inventory[item_index][0]):
				save_data()
				get_tree().change_scene("res://Map11_LastBoss.tscn")

func save_data():
	game_data = {
		"Inventory": PlayerInventory.inventory,
		"Map": get_tree().get_current_scene().get_name(),
		"Current_Hp": PlayerStats.hp,
		"Max_Hp": PlayerStats.max_hp,
		"Attack": PlayerStats.damage
	}
	var file = File.new()
	var error = file.open(SAVE_FILE, file.WRITE)
	if error == OK:
		file.store_var(game_data)
		file.close()
	
	print("Data saved")
