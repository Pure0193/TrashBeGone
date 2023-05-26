extends Button

func _on_Button_pressed():
	get_parent().get_node("Inventory").visible = !get_parent().get_node("Inventory").visible
	get_parent().get_node("Inventory").initialize_inventory()
