extends CharacterBody2D

var speed = 0
var move_direction = Vector2(0,0)
var walking_speed: float = 200.0
var dash_distance: float = 100.0
var dash_cooldown: float = 1.0
var can_dash: bool = true
var dash_timer: float = 0.0
var cooldown_timer: float = 0.0

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_is_alive = true
var attack_ip = false

func _physics_process(delta):
	if dash_timer > 0.0:
		dash_timer -= delta
	elif not can_dash:
		can_dash = true
	movementLoop(delta)
	enemy_attack()
	attack()
	
	if health <= 0:
		player_is_alive = false # dead
		health = 0
		$AnimatedSprite2D.play("dead")
		self.queue_free()

func _process(delta):
	animationLoop()

func movementLoop(delta):
	move_direction = Vector2(
		int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")),
		int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	).normalized()

	if move_direction != Vector2.ZERO:
		if Input.is_action_pressed("Dash") and can_dash and cooldown_timer <= 0.0:
			dash()
		else:
			velocity = move_direction * walking_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if cooldown_timer > 0.0:
		cooldown_timer -= delta

func dash():
	velocity = move_direction * dash_distance
	dash_timer = 0.1
	cooldown_timer = dash_cooldown
	can_dash = false
	position += velocity

func animationLoop():
	var anim = $AnimatedSprite2D
	if move_direction == Vector2(0, 0):
		if attack_ip == false:
			anim.play("idle")
		else:
			anim.play("attack_right_top")
	else:
		anim.play("running")
		if move_direction.x == 0:
			anim.flip_h = move_direction.y < 0
		else:
			anim.flip_h = move_direction.x < 0


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func player():
	pass

func attack():
	var dir = move_direction
	if Input.is_action_pressed("Attack"):
		Global.player_current_attack = true
		attack_ip = true
		$AnimatedSprite2D.play("attack_right_top")
		$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
