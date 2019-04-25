extends KinematicBody2D

var speed = 250
var velocity = Vector2()
var anim = ""

func get_input():
    # Detect up/down/left/right keystate and only move when pressed
    velocity = Vector2()
    if Input.is_action_pressed('ui_right'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    velocity = velocity.normalized() * speed
	
	var new_anim = "jumping"
	
	# Change animation
	if new_anim != anim:
		anim = new_anim
		$anim.play(anim)

func _physics_process(delta):
    get_input()
    move_and_collide(velocity * delta)
	