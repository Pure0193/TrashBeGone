extends Area2D

export(String) var map_name

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func _on_Area2D_body_entered(body):
	Global.from_pos = name
	save_data()
	get_tree().change_scene("res://" + map_name + ".tscn")

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
