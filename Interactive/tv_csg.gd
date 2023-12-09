extends CSGMesh3D

func _on_interact_body_entered(body):
	if body.name == "Player":
		$Dialogue.show()
		var TEXT = get_node_or_null("/root/Game/Clues/TV/Dialogue")
		if TEXT != null:
			$Dialogue/Text.text = "Unknown: Uncover the truth"
			await get_tree().create_timer(2).timeout
			$Dialogue/Text.text = "Unknown:...Only then can you escape"

func _on_interact_body_exited(body):
	if body.name == "Player":
		$Dialogue.hide()
