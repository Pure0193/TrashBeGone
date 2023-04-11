extends Area2D

#const ItemClass = preload("res://Item.gd")
#const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
#var db
#var db_name = "res://DataStore/test"


#func _ready():
#	db = SQLite.new()
#	db.path = db_name
#	db.open_db()

#func readDB():
#	var tableName = "player"
#	db.query("select Coin from " + tableName + ";")
#	return db.query_result[0]["Coin"]

func increase_coin():
#	var tableName = "player"
#	var new_coin = readDB() + get_parent().get_node("Inventory").hold_item.item_quantity
#	db.update_rows(tableName, "id=1", {"Coin":new_coin})
	PlayerStats.set_coin(1 * get_parent().get_node("Inventory").hold_item.item_quantity)

func decrease_coin():
#	var tableName = "player"
#	if readDB() > 0:
#		var new_coin = readDB() -1
#		db.update_rows(tableName, "id=1", {"Coin":new_coin})
	if PlayerStats.coin_num > 0:
		PlayerStats.set_coin(-1)

func _input(event):
	if event.is_action_released("ui_touch") && is_visible_in_tree():
		for _a in get_overlapping_areas():
			if _a.get_item_type(_a.item_name) == "Garbage":
				if _a.get_garbage_type(_a.item_name) == "Organic":
					increase_coin()
					get_parent().get_parent().get_node("Inventory").hold_null()
					_a.queue_free()
				else:
					if _a.item_quantity > 1:
						_a.item_quantity -= 1
						_a.refresh_item()
					else:
						_a.queue_free()
						get_parent().get_parent().get_node("Inventory").hold_null()
