extends Area2D

onready var Shop_tooltip = preload("res://Shop/ShopTooltip.tscn")
onready var price = $Price
onready var sprite = $Sprite
onready var coin_sprite = $Coin
onready var sold_out = $SoldOut
onready var itemName = $ItemName
var item_name
var status

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db = SQLite.new()
var db_name = "res://DataStore/test"

func _ready():
	db.path = db_name
	db.open_db()
	item_name = get_name()
	itemName.text = String(JsonData.item_data[item_name]["Name"])
	db.query("select Avaliable from Shop where ItemName = \"" + item_name + "\";")
	status = db.query_result[0]["Avaliable"]
	if status == "True":
		db.query("select Price from Shop where ItemName = \"" + item_name + "\";")
		price.set_text(String(db.query_result[0]["Price"]))
	else:
		coin_sprite.visible = false
		price.visible = false
		sold_out.visible = true
	sprite.texture = load("res://Item/" + item_name+ ".PNG")

func _on_ShopItem_mouse_entered():
	var shop_tooltip_instance = Shop_tooltip.instance()
	item_name = ""
	shop_tooltip_instance.origin = "Shop"
	item_name = get_name()
	shop_tooltip_instance.item_name = item_name
	shop_tooltip_instance.rect_position = get_parent().get_parent().get_global_transform_with_canvas().origin + Vector2(243,0)
	add_child(shop_tooltip_instance)
#	yield(get_tree().create_timer(0.35), "timeout")
	if has_node("ShopTooltip") and get_node("ShopTooltip").valid:
		get_node("ShopTooltip").show()

