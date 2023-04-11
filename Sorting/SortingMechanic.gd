extends Node2D


func _ready():
	$SortScene.visible = false
	$TextureRect.visible = false
	visible = false

func start_sort():
	$SortScene.visible = true
	$TextureRect.visible = true
	get_node("Inventory").initialize_inventory()
	visible = true

func stop_sort():
	$SortScene.visible = false
	$TextureRect.visible = false
	visible = false
