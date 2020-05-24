extends KinematicBody2D



const UP = Vector2(0, -1)
const MAXSPEED = 200
const GRAVITY = 20
const JUMP_HEIGHT = -550
const ACCELERATION = 25

var motion = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAXSPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAXSPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else :
		friction = true
		$Sprite.play("Idle")
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_jump"):
			motion.y = JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y <0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction:
			motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)
