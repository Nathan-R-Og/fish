#A stone that will simply fall into the water
extends RigidBody2D

#the gravity value
var gravity = 35

#the motion vector
#we'll use it to move our stone with move_and_slide
var motion = Vector2.ZERO

#so the stone won't accelerate forever
var base_max_speed = 450
var max_speed = 450
var max_speed_in_water = 200

var inOnce = false


func _physics_process(delta):
	linear_velocity.x = clamp(linear_velocity.x, -max_speed, max_speed)
	linear_velocity.y = clamp(linear_velocity.y, -max_speed, max_speed)

#initializes the stone at a set position
func initialize(pos):
	global_position = pos

func in_water():
	inOnce = true
	gravity_scale = 1 / 3
	linear_velocity /= 5
	max_speed = max_speed_in_water



func out_water():
	gravity_scale = 1
	max_speed = base_max_speed
