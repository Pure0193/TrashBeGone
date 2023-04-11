extends Popup

var origin = ""
var slot = 0
var valid = false

func _ready():
	var item_name
	if origin == "Inventory":
		if PlayerInventory.inventory.has(slot):
			item_name = str(PlayerInventory.inventory[slot][0])
			valid = true
#			print(item_name)
	if valid:
		get_node("NinePatchRect/MarginContainer/VBoxContainer/Stats").visible = false
		get_node("NinePatchRect/MarginContainer/VBoxContainer/ItemName").set_text(String(JsonData.item_data[item_name]["Name"]))
		var item_type = JsonData.item_data[item_name]["ItemCategory"]
		get_node("NinePatchRect/MarginContainer/VBoxContainer/Category/ItemCategory").set_text(item_type)
		if item_type == "Weapon" || item_type == "Armor":
			get_node("NinePatchRect/MarginContainer/VBoxContainer/Stats").visible = true
			if item_type == "Weapon":
				get_node("NinePatchRect/MarginContainer/VBoxContainer/Stats/Stat").set_text("Damage: " + String(JsonData.item_data[item_name]["Damage"]))
				if PlayerInventory.inventory.has(30) && PlayerInventory.inventory[30][0] != item_name:
					get_node("NinePatchRect/MarginContainer/VBoxContainer/Stats/Diff").set_text(' | ' + String(JsonData.item_data[PlayerInventory.inventory[30][0]]["Damage"]))
				else:
					get_node("NinePatchRect/MarginContainer/VBoxContainer/Stats/Diff").visible = false
			else:
				get_node("NinePatchRect/MarginContainer/VBoxContainer/Stats/Stat").set_text("HP: +" + String(JsonData.item_data[item_name]["HP"]))
				if PlayerInventory.inventory.has(31) && PlayerInventory.inventory[31][0] != item_name:
					get_node("NinePatchRect/MarginContainer/VBoxContainer/Stats/Diff").set_text(' | +' + String(JsonData.item_data[PlayerInventory.inventory[31][0]]["HP"]))
				else:
					get_node("NinePatchRect/MarginContainer/VBoxContainer/Stats/Diff").visible = false
		get_node("NinePatchRect/MarginContainer/VBoxContainer/Desc/Description").set_text(String(JsonData.item_data[item_name]["Description"]))
