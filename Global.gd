extends Node

var clues = 0
var battery = 100

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		var menu = get_node_or_null("/root/Game/UI/Pause")
		if menu == null:
			get_tree().quit()
		else:
			if menu.visible:
				get_tree().paused = false
				menu.hide()
			else:
				get_tree().paused = true
				menu.show()
				
func add_clue():
	clues += 1
	var CLUES = get_node_or_null("/root/Game/UI/HUD/Clues")
	if CLUES != null:
		CLUES.text = "CLUES FOUND: " + str(clues) + " of 4"
	if clues == 4:
		get_tree().change_scene_to_file("res://UI/win.tscn")

func dec_battery():
	battery -= 20
	var BATTERY = get_node_or_null("/root/Game/UI/HUD/Battery")
	if BATTERY != null:
		BATTERY.text = "BATTERY... " + str(battery) + " PERCENT"

