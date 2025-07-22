extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0


func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
			
		
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor(): 
		if direction: 
			if animated_sprite_2d.animation != "walk": 
				animated_sprite_2d.play("walk")
		else: 
			if animated_sprite_2d.animation != "idle": 
				animated_sprite_2d.play("idle")
	else: 
		if velocity.y < 0: 
			if animated_sprite_2d.animation != "jump": 
				animated_sprite_2d.play("jump")
		
	

	move_and_slide()
