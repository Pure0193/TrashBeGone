extends CanvasLayer

export(String, FILE, "*json") var dialogues_file

var dialogue = []
var current_line = 0
var Dbox_active = false

func _ready():
	$NinePatchRect.visible = false

func start():
	if Dbox_active:
		return
	Dbox_active = true
	$NinePatchRect.visible = true
	
	dialogue = load_dialogue()
	current_line = -1
	next_line()
	
func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogues_file):
		file.open(dialogues_file, file.READ)
		return parse_json(file.get_as_text())

func _input(event):
	if !Dbox_active:
		return
	if event.is_action_pressed("play_dialogue"):
		next_line()
		
func next_line():
	current_line += 1
	
	if current_line >= len(dialogue):
		$Timer.start()
		Dbox_active = false
		$NinePatchRect.visible = false
		return
	
	$NinePatchRect/Name.text = dialogue[current_line]["name"]
	$NinePatchRect/Message.text = dialogue[current_line]["text"]


func _on_Timer_timeout():
	Dbox_active = false
