extends KinematicBody2D


const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)

const WALK_SPEED = 70
const STATE_WALKING = 0
const STATE_KILLED = 1

const BULLET_VELOCITY = 1000
var linear_velocity = Vector2()
var direction = 0
var anim=""

var shoot_time=99999 #time since last shot
var state = STATE_WALKING


onready var sprite = $sprite

func _physics_process(delta):
	var new_anim = "idle"
	linear_velocity += GRAVITY_VEC * delta
	linear_velocity.x = direction * WALK_SPEED
	linear_velocity = move_and_slide(linear_velocity, FLOOR_NORMAL)
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = preload("res://Scenes/bullet.tscn").instance()
		bullet.position = $sprite/bullet_shoot.global_position #use node for shoot position
		bullet.linear_velocity = Vector2(sprite.scale.x * BULLET_VELOCITY, 0)
		bullet.add_collision_exception_with(self) # don't want player to collide with bullet
		get_parent().add_child(bullet) #don't want bullet to move with me, so add it as child of parent
		shoot_time = 0


	if anim != new_anim:
		anim = new_anim
		$anim.play(anim)


func hit_by_bullet():
	state = STATE_KILLED
