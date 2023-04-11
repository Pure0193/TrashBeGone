extends VSplitContainer



func _on_gloveFabric_mouse_entered():
	for i in get_children():
		if i.has_node("ShopTooltip"):
			i.get_node("ShopTooltip").free()


func _on_gloveLeather_mouse_entered():
	for i in get_children():
		if i.has_node("ShopTooltip"):
			i.get_node("ShopTooltip").free()
