extends Label

#const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
#var db
#var db_name = "res://DataStore/test"


func _ready():
#	db = SQLite.new()
#	db.path = db_name
#	db.open_db()
#	var coin_num = str(readDB())
#	text = coin_num
	text = str(PlayerStats.coin_num)
	PlayerStats.connect("coin_changed", self, "update_coin")

func update_coin():
	text = str(PlayerStats.coin_num)

#func readDB():
##	db = SQLite.new()
##	db.path = db_name
##	db.open_db()
#	var tableName = "player"
#	db.query("select Coin from " + tableName + ";")
#	return db.query_result[0]["Coin"]

#func _input(event):
#	if event.is_action_released("ui_touch"):
#		$Timer.start(0.1)

#func _on_Timer_timeout():
#	var coin_num = str(readDB())
#	text = coin_num
