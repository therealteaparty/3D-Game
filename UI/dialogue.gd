extends Control

var dialogue = ["You have to escape.", "Find the answers...avenage us..."]
var dialogue_pos = 0

func start_dialogue():
	dialogue_pos = 0
	show()

func _physics_process(_delta):
	if Input.is_action_pressed("dialogue"):
		$Text.text = dialogue[0]
		await get_tree().create_timer(1).timeout
		$Text.text = dialogue[0]
	



