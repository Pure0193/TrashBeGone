extends Area2D

const SlotClass = preload("res://Player/Inventory/Slot.gd")

var count = 1
var key_num = 0
var key_index = []

func _ready():
	count = 1

func _input(event):
	if event.is_action_pressed("Interact") and len(get_overlapping_bodies()) > 0:
		key_num = 0
		key_index = []
		for item_index in PlayerInventory.inventory:
			if "basement" in String(PlayerInventory.inventory[item_index][0]):
				key_index.append(item_index)
				key_num += 1
		if key_num == 5:
			play_dialog()
			for i in range(5):
				PlayerInventory.inventory.erase(key_index[i])
			get_parent().get_parent().get_parent().get_node("UserInterface/Inventory").initialize_inventory()
			PlayerInventory.add_item("basement_key", 1)
			get_tree().change_scene("res://map4.tscn")
		
func play_dialog():
	var dialog = get_parent().get_node("Dialogue")
	
	if dialog:
		dialog.start()
		if count == 1:
			PlayerStats.next_progress()
			count -= 1
