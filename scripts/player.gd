extends CharacterBody2D

const speed = 300

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector:
		velocity = input_vector * speed
	else:
		velocity = input_vector
	move_and_slide()


"""
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("ui_right") or Input.is_physical_key_pressed (KEY_D):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left") or Input.is_physical_key_pressed (KEY_A):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down") or Input.is_physical_key_pressed (KEY_S):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up") or Input.is_physical_key_pressed (KEY_W):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("running")
		elif movement == 0:
			anim.play("idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("running")
		elif movement == 0:
			anim.play("idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("running")
		elif movement == 0:
			anim.play("idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("running")
		elif movement == 0:
			anim.play("idle")

"""
