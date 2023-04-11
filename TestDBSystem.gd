extends Node2D


#const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
#var db
#var db_name = "res://DataStore/test"
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	db = SQLite.new()
#	db.path = db_name
#	db.open_db()
#	readDB()
#	pass
#
#
#func readDB():
#	var tableName = "player"
#	db.query("select * from " + tableName + ";")
#	for i in range(0, db.query_result.size()):
#		print("Coin: ", db.query_result[i]["Coin"])
