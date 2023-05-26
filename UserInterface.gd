extends CanvasLayer

onready var DeathScreen = $DeathScreen
onready var HelpScreen = $HelpScreen

const SAVE_FILE = "user://save_file.save"
var game_data = {}

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

func load_data():
	var file = File.new()
#	if not file.file_exists(SAVE_FILE):
#		game_data = {
#			"Inventory": {},
#			"Map": "DemoMap"
#		}
#		save_data()
	file.open(SAVE_FILE, File.read())
	game_data = file.get_var()
	file.close()

func _ready():
	PlayerStats.connect("dead", self, "PlayerDeath")
	DeathScreen.visible = false


func _input(event):
	if event.is_action_pressed("inventory"):
		$Inventory.visible = !$Inventory.visible
		$Inventory.initialize_inventory()

func PlayerDeath():
	DeathScreen.visible = true


func _on_SaveButton_pressed():
	save_data()


func _on_BackpackButton_pressed():
	get_node("Inventory").visible = !get_node("Inventory").visible
	get_node("Inventory").initialize_inventory()


func _on_HelpButton_pressed():
	HelpScreen.visible = !HelpScreen.visible
