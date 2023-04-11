extends Node2D

onready var mon_canny = preload("res://Monsters/Canny.tscn")
onready var mon_burgy = preload("res://Monsters/Burgy.tscn")
onready var mon_cabbage = preload("res://Monsters/Cabbage.tscn")
onready var mon_mama = preload("res://Monsters/Mama.tscn")
onready var mon_straw = preload("res://Monsters/Straw.tscn")
onready var mon_snack = preload("res://Monsters/Snack.tscn")
onready var mon_milky = preload("res://Monsters/Milky.tscn")
onready var mon_sodaz = preload("res://Monsters/Sodaz.tscn")
onready var mon_botty = preload("res://Monsters/Botty.tscn")
onready var mon_mice = preload("res://Monsters/Mice.tscn")
onready var mon_spraycanny = preload("res://Monsters/Spraycanny.tscn")
onready var mon_lighting = preload("res://Monsters/Lighting.tscn")
onready var mon_battery = preload("res://Monsters/Battery.tscn")
onready var mon_wineglass = preload("res://Monsters/Wineglass.tscn")
onready var mon_skylight = preload("res://Monsters/Skylight.tscn")
onready var mon_fatissue = preload("res://Monsters/Fattissue.tscn")
onready var mon_infecty = preload("res://Monsters/Infecty.tscn")


func _ready():
	var map_name = get_tree().get_current_scene().get_name()
	randomize()
	print(map_name)
	var chance = randf()
	
	match map_name:
		"DemoMap":
			if chance < 0.33:
				var Canny = mon_canny.instance()
				call_deferred("add_child", Canny)
				Canny.set_position(get_node("SpawnPosition").position)
			elif chance < 0.67:
				var Burgy = mon_burgy.instance()
				call_deferred("add_child", Burgy)
				Burgy.set_position(get_node("SpawnPosition").position)
			else:
				var cabbage = mon_cabbage.instance()
				call_deferred("add_child", cabbage)
				cabbage.set_position(get_node("SpawnPosition").position)
		"Map1":
			if chance < 0.33:
				var Canny = mon_canny.instance()
				call_deferred("add_child", Canny)
				Canny.set_position(get_node("SpawnPosition").position)
			elif chance < 0.67:
				var Burgy = mon_burgy.instance()
				call_deferred("add_child", Burgy)
				Burgy.set_position(get_node("SpawnPosition").position)
			else:
				var cabbage = mon_cabbage.instance()
				call_deferred("add_child", cabbage)
				cabbage.set_position(get_node("SpawnPosition").position)
		"Map2":
			if chance < 0.33:
				var Mama = mon_mama.instance()
				call_deferred("add_child", Mama)
				Mama.set_position(get_node("SpawnPosition").position)
			elif chance < 0.67:
				var Straw = mon_straw.instance()
				call_deferred("add_child", Straw)
				Straw.set_position(get_node("SpawnPosition").position)
			else:
				var Snack = mon_snack.instance()
				call_deferred("add_child", Snack)
				Snack.set_position(get_node("SpawnPosition").position)
		"Map3":
			if chance < 0.33:
				var Wineglass = mon_wineglass.instance()
				call_deferred("add_child", Wineglass)
				Wineglass.set_position(get_node("SpawnPosition").position)
			elif chance < 0.67:
				var Mice = mon_mice.instance()
				call_deferred("add_child", Mice)
				Mice.set_position(get_node("SpawnPosition").position)
			else:
				var Botty = mon_botty.instance()
				call_deferred("add_child", Botty)
				Botty.set_position(get_node("SpawnPosition").position)
		"Map6_Field":
			if chance < 0.33:
				var Spraycanny = mon_spraycanny.instance()
				call_deferred("add_child", Spraycanny)
				Spraycanny.set_position(get_node("SpawnPosition").position)
			elif chance < 0.67:
				var Mice = mon_mice.instance()
				call_deferred("add_child", Mice)
				Mice.set_position(get_node("SpawnPosition").position)
			else:
				var Botty = mon_botty.instance()
				call_deferred("add_child", Botty)
				Botty.set_position(get_node("SpawnPosition").position)
		"Map7_Field":
			if chance < 0.5:
				var Mama = mon_mama.instance()
				call_deferred("add_child", Mama)
				Mama.set_position(get_node("SpawnPosition").position)
			else:
				var Burgy = mon_burgy.instance()
				call_deferred("add_child", Burgy)
				Burgy.set_position(get_node("SpawnPosition").position)
		"Map8_Field":
			if chance < 0.33:
				var Skylight = mon_skylight.instance()
				call_deferred("add_child", Skylight)
				Skylight.set_position(get_node("SpawnPosition").position)
			elif chance < 0.67:
				var Battery = mon_battery.instance()
				call_deferred("add_child", Battery)
				Battery.set_position(get_node("SpawnPosition").position)
			else:
				var Lightning = mon_lighting.instance()
				call_deferred("add_child", Lightning)
				Lightning.set_position(get_node("SpawnPosition").position)
		"Map9_Field":
			if chance < 0.5:
				var Fatissue = mon_fatissue.instance()
				call_deferred("add_child", Fatissue)
				Fatissue.set_position(get_node("SpawnPosition").position)
			else:
				var Infecty = mon_infecty.instance()
				call_deferred("add_child", Infecty)
				Infecty.set_position(get_node("SpawnPosition").position)
		"Map10":
			if chance < 0.25:
				var Canny = mon_canny.instance()
				call_deferred("add_child", Canny)
				Canny.set_position(get_node("SpawnPosition").position)
			elif chance < 0.50:
				var Milky = mon_milky.instance()
				call_deferred("add_child", Milky)
				Milky.set_position(get_node("SpawnPosition").position)
			elif chance < 0.75:
				var Sodaz = mon_sodaz.instance()
				call_deferred("add_child", Sodaz)
				Sodaz.set_position(get_node("SpawnPosition").position)
			else:
				var Snack = mon_snack.instance()
				call_deferred("add_child", Snack)
				Snack.set_position(get_node("SpawnPosition").position)
