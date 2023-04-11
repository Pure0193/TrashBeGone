extends Node2D

var item_name
var item_quantity

export(String, "garbage", "equipment") var item_type
var garbage_type


#func _ready():
#	if randi() % 2 == 0:
#		item_name = "can"
#		garbage_type = "recycle"
#	else:
#		item_name = "burger"
#		garbage_type = "organic"
#
#	$TextureRect.texture = load("res://Item/" + item_name+ ".PNG")
#	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
#	item_quantity = randi() % stack_size + 1
#
#	if stack_size == 1:
#		$Label.visible = false
#	else:
#		$Label.text = String(item_quantity)

func set_item(name, quantity):
	item_name = name
	item_quantity = quantity
	$TextureRect.texture = load("res://Item/" + item_name + ".PNG")
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quantity)

func increase_quantity(amount):
	item_quantity += amount
	$Label.text = String(item_quantity)

func decrease_quantity(amount):
	item_quantity -= amount
	$Label.text = String(item_quantity)

func get_item_type(name):
	item_name = name
	var item_type = String(JsonData.item_data[item_name]["ItemCategory"])
	return item_type

func get_garbage_type(name):
	item_name = name
	var garbage_type = String(JsonData.item_data[item_name]["GarbageType"])
	return garbage_type

func get_item_dmg(name):
	item_name = name
	var item_dmg: int = JsonData.item_data[item_name]["Damage"]
	return item_dmg

func get_item_hp(name):
	item_name = name
	var item_hp: int = JsonData.item_data[item_name]["HP"]
	return item_hp

func refresh_item():
	$Label.text = String(item_quantity)
