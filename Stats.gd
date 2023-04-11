extends Node

export(int) var max_hp = 1
onready var hp = max_hp setget set_hp
export(int) var mon_dmg setget set_mondmg
var damage = 1 setget set_dmg
var coin_num setget set_coin
var progress


signal dead
signal hp_changed(value)
signal max_hp_changed(value)
signal dmg_changed(value)
signal coin_changed(value)
signal progress_changed(value)

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://DataStore/test"

func set_max_hp(value):
	max_hp += value
	self.hp = min(hp, max_hp)
	emit_signal("max_hp_changed", max_hp)
	emit_signal("max_hp_changed")

func set_hp(value):
	hp = value
	emit_signal("hp_changed", hp)
	if hp <= 0:
		emit_signal("dead")

func set_dmg(value):
	damage += value
	emit_signal("dmg_changed")
	
func set_mondmg(value):
	mon_dmg = value

func set_coin(value):
	coin_num += value
	db.update_rows("Player", "id=1", {"Coin":coin_num})
	emit_signal("coin_changed")

func next_progress():
	progress += 1
	db.update_rows("Player", "id=1", {"Progress":progress})
	emit_signal("progress_changed")

func _ready():
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	self.hp = max_hp
	coin_num = int(readCoin())
	progress = int(readProgress())

func readCoin():
	var tableName = "player"
	db.query("select Coin from " + tableName + ";")
	return db.query_result[0]["Coin"]

func readProgress():
	var tableName = "player"
	db.query("select Progress from " + tableName + ";")
	return db.query_result[0]["Progress"]
