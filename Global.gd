extends Node

var clues = 0

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

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _unhandled_input(event):
#	if event.is_action_pressed("menu"):
#		get_tree().quit()
