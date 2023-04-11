extends Node

const SlotClass = preload("res://Player/Inventory/Slot.gd")
const ItemClass = preload("res://Item.gd")
const NUM_INVENTORY_SLOTS = 32

var inventory = {
#	0: ["Can", 1],
#	1: ["Burger", 3],
#	2: ["Broom", 1],
#	3: ["Vacuum", 1],
#	4: ["gloveFabric", 1],
#	5: ["gloveLeather", 1]
}


func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var addable = stack_size - inventory[item][1]
			if addable >= item_quantity:
				inventory[item][1] += item_quantity
				return
			else:
				inventory[item][1] += addable
				item_quantity -= addable

	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return


func add_item_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]

func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)

func add_item_quantity(slot: SlotClass, quantity):
	inventory[slot.slot_index][1] += quantity
