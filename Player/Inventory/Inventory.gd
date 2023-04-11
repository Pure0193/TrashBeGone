extends Node2D

const SlotClass = preload("res://Player/Inventory/Slot.gd")
onready var inv_slot = $GridContainer
onready var eqp_slot = $Equipment
onready var Attack_Label = $Attack
onready var MaxHP_Label = $Max_Hp
var hold_item = null
var stats = PlayerStats

func _ready():
	var slots = inv_slot.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
	
	var equipments = eqp_slot.get_children()
	for i in range(equipments.size()):
		equipments[i].connect("gui_input", self, "slot_gui_input", [equipments[i]])
		equipments[i].slot_index = 30 + i
	stats.connect("dmg_changed", self, "display_dmg")
	stats.connect("max_hp_changed", self, "display_maxHP")
	display_maxHP()
	display_dmg()
	initialize_inventory()

func initialize_inventory():
	var slots = inv_slot.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
	var equipments = eqp_slot.get_children()
	for i in range(equipments.size()):
		if PlayerInventory.inventory.has(i+30):
			equipments[i].initialize_item(PlayerInventory.inventory[i+30][0], PlayerInventory.inventory[i+30][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if hold_item != null:
				if !slot.item:
					left_click_empty_slot(slot)
				else:
					if hold_item.item_name != slot.item.item_name:
						left_click_different_item(event, slot)
					else:
						left_click_same_item(slot)
			elif slot.item:
				left_click_none(slot)

func _input(event):
	if hold_item:
		hold_item.global_position = get_global_mouse_position()

func left_click_empty_slot(slot: SlotClass):
	if slot.slot_index < 30:
		PlayerInventory.add_item_empty_slot(hold_item, slot)
		slot.dropSlot(hold_item)
		hold_item = null
	elif slot.slot_index == 30 && hold_item.get_item_type(hold_item.item_name) == "Weapon":
		PlayerInventory.add_item_empty_slot(hold_item, slot)
		slot.dropSlot(hold_item)
		stats.set_dmg(hold_item.get_item_dmg(hold_item.item_name))
		hold_item = null
	elif slot.slot_index == 31 && hold_item.get_item_type(hold_item.item_name) == "Armor":
		PlayerInventory.add_item_empty_slot(hold_item, slot)
		slot.dropSlot(hold_item)
		stats.set_max_hp(hold_item.get_item_hp(hold_item.item_name))
		hold_item = null

func left_click_different_item(event: InputEvent, slot: SlotClass):
	if slot.slot_index < 30:
		PlayerInventory.remove_item(slot)
		PlayerInventory.add_item_empty_slot(hold_item, slot)
		var temp_item = slot.item
		slot.dragSlot()
		temp_item.global_position = event.global_position
		slot.dropSlot(hold_item)
		hold_item = temp_item
	elif slot.slot_index == 30 && hold_item.get_item_type(hold_item.item_name) == "Weapon":
		PlayerInventory.remove_item(slot)
		PlayerInventory.add_item_empty_slot(hold_item, slot)
		var temp_item = slot.item
		slot.dragSlot()
		temp_item.global_position = event.global_position
		slot.dropSlot(hold_item)
		stats.set_dmg(hold_item.get_item_dmg(hold_item.item_name))
		hold_item = temp_item
		stats.set_dmg(hold_item.get_item_dmg(hold_item.item_name) * -1)
	elif slot.slot_index == 31 && hold_item.get_item_type(hold_item.item_name) == "Armor":
		PlayerInventory.remove_item(slot)
		PlayerInventory.add_item_empty_slot(hold_item, slot)
		var temp_item = slot.item
		slot.dragSlot()
		temp_item.global_position = event.global_position
		slot.dropSlot(hold_item)
		stats.set_max_hp(hold_item.get_item_hp(hold_item.item_name))
		hold_item = temp_item
		stats.set_max_hp(hold_item.get_item_hp(hold_item.item_name) * -1)
	
func left_click_same_item(slot: SlotClass):
	if slot.slot_index < 30:
		var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
		var add_able = stack_size - slot.item.item_quantity
		if add_able >= hold_item.item_quantity:
			PlayerInventory.add_item_quantity(slot, hold_item.item_quantity)
			slot.item.increase_quantity(hold_item.item_quantity)
			hold_item.queue_free()
			hold_item = null
		else:
			PlayerInventory.add_item_quantity(slot, add_able)
			slot.item.increase_quantity(add_able)
			hold_item.decrease_quantity(add_able)
	
func left_click_none(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	hold_item = slot.item
	print(hold_item.item_name)
	if slot.slot_index == 30:
		stats.set_dmg(hold_item.get_item_dmg(hold_item.item_name) * -1)
	if slot.slot_index == 31:
		stats.set_max_hp(hold_item.get_item_hp(hold_item.item_name) * -1)
	slot.dragSlot()
	hold_item.global_position = get_global_mouse_position()
	
func hold_null():
	hold_item = null

func display_dmg():
	Attack_Label.text = String("Attack: ") + String(stats.damage)

func display_maxHP():
	MaxHP_Label.text = String("Max Hp: ") + String(stats.max_hp)
