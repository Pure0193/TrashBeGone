extends Panel

var default_slot = preload("res://Player/Inventory/Inventory_Slot_Default.PNG")
var default_style: StyleBoxTexture = null
var ItemClass = preload("res://Item/Item.tscn")
var item = null
var slot_index

onready var tool_tip = preload("res://Item/Tooltip.tscn")

func _ready():
	default_style = StyleBoxTexture.new()
	default_style.texture = default_slot
	
#	if randi() % 2 == 0:
#		item = ItemClass.instance()
#		add_child(item)
#	refresh_inv()

#func refresh_inv():
#	if item == null:
#		set('custom_styles/panel', empty_style)
#	else:
#		set('custom_styles/panel', default_style)

func dragSlot():
	remove_child(item)
	var inv_Node = find_parent("Inventory")
	inv_Node.add_child(item)
	item = null
#	refresh_inv()
	
func dropSlot(new_item):
	item = new_item
	item.position = Vector2.ZERO
	var inv_Node = find_parent("Inventory")
	inv_Node.remove_child(item)
	add_child(item)
#	refresh_inv()
	
func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
#	refresh_inv()



func _on_Slot_mouse_entered():
	var tooltip_instance = tool_tip.instance()
	slot_index = ""
	tooltip_instance.origin = "Inventory"
	slot_index = get_name()
#	print(slot_index)
	slot_index = slot_index.replace("Slot", "")
	slot_index = int(slot_index) - 1
#	print(slot_index)
	tooltip_instance.slot = slot_index
	tooltip_instance.rect_position = get_parent().get_global_position() + Vector2(150, -25)
	
	add_child(tooltip_instance)
	yield(get_tree().create_timer(0.3), "timeout")
	if has_node("Tooltip") and get_node("Tooltip").valid:
		get_node("Tooltip").show()


func _on_Slot_mouse_exited():
	get_node("Tooltip").free()
