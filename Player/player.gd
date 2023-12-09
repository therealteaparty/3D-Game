extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.005
const MOUSE_RANGE = 1


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _unhandled_input(event):
	# if the mouse has moved
	if event is InputEventMouseMotion:
		# up-down motion, applied to the $Pivot
		$Pivot.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		# make sure we can't look inside ourselves :)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -MOUSE_RANGE, MOUSE_RANGE)
		# left-right motion, applied to the Player
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Toggles flashlight ON/OFF	
	var flashlight = get_node_or_null("/root/Game/NavigationRegion3D/Player/Flashlight")
	if flashlight != null:
		if Input.is_action_just_pressed("flashlight") and flashlight.visible == true:
				flashlight.hide()
		else:
			if Input.is_action_just_pressed("flashlight") and flashlight.visible == false:
				Global.dec_battery()
				if Global.battery <= 0:
					pass
				else:
					flashlight.show()
				await get_tree().create_timer(3).timeout
				if flashlight != null:
					flashlight.visible = false


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

#var flashlight = get_node_or_null("/root/Game/NavigationRegion3D/Player/Flashlight")

func _on_area_3d_body_entered(body):
	if body.name == "Monster" and $Flashlight.visible == true:
		body.position.x = 9.2
		body.position.y = 3.4
		body.position.x = 0
	elif body.name == "Monster":
		get_tree().change_scene_to_file("res://UI/lose.tscn")
	
