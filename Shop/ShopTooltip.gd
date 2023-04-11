extends Popup

var origin = ""
var item_name = ""
var valid = false
var status
onready var sprite = $NinePatchRect/TextureRect
onready var buyButton = $BuyButton
onready var soldout_label = $SoldOut

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://DataStore/test"

func _ready():
	if origin == "Shop":
		valid = true

	if valid:
		db = SQLite.new()
		db.path = db_name
		db.open_db()
		db.query("select Avaliable from Shop where ItemName = \"" + item_name + "\";")
		status = db.query_result[0]["Avaliable"]
		print(item_name)
		print(status)
		if status == "False":
			buyButton.visible = false
			soldout_label.visible = true
		sprite.texture = load("res://Item/" + item_name+ ".PNG")
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


func _on_BuyButton_pressed():
	db.query("select Price from Shop where ItemName = \"" + item_name + "\";")
	var price = db.query_result[0]["Price"]
	var new_coin = readDB() - price
	if new_coin >= 0:
		PlayerStats.set_coin(-1 * price)
		PlayerInventory.add_item(item_name, 1)
		db.query("UPDATE Shop SET Avaliable = 'False' WHERE ItemName = '"+ item_name + "';")
		update_shop()
		print("bought")
	else:
		print("not enough coin")

func update_shop():
	db.query("select Avaliable from Shop where ItemName = \"" + item_name + "\";")
	status = db.query_result[0]["Avaliable"]
	print(item_name)
	print(status)
	if status == "False":
		buyButton.visible = false
		soldout_label.visible = true
	sprite.texture = load("res://Item/" + item_name+ ".PNG")
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


func readDB():
	var tableName = "player"
	db.query("select Coin from " + tableName + ";")
	return db.query_result[0]["Coin"]
