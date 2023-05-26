extends Node2D

const SAVE_FILE = "user://save_file.save"
var game_data = {}



func _on_LoadGame_pressed():
	var file = File.new()
	if file.file_exists(SAVE_FILE):
		var error = file.open(SAVE_FILE, File.READ)
		if error == OK:
			game_data = file.get_var()
			file.close()
			PlayerInventory.inventory = game_data["Inventory"]
			PlayerStats.hp = game_data["Current_Hp"]
			PlayerStats.max_hp = game_data["Max_Hp"]
			PlayerStats.damage = game_data["Attack"] - 1
			get_tree().change_scene("res://" + game_data["Map"] + ".tscn")
			print("Data Loaded")


func _on_NewGame_pressed():
	get_tree().change_scene("res://" + "Map0_home" + ".tscn")
