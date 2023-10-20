extends Node2D


const sinker = "res://Sinker.tscn"
var lol = null



var rodAng = 0.0
var influenceAngle = 75
var rodInfluence = Vector2()
var launched = false
var launchPower = 1.5





func _process(delta):
	
	
	


	if launched == false:
		if Input.is_action_pressed("move_right"):
			rodAng = clamp(rodAng + 1,-90,0)
		if Input.is_action_pressed("move_left"):
			rodAng = clamp(rodAng - 1,-90,0)
		$Rod.rotation_degrees = rodAng
		
	if Input.is_action_just_pressed("decline"):
		launch()
		


func launch():
	rodInfluence = Vector2(cos(deg2rad(rodAng + influenceAngle)),sin(deg2rad(rodAng + influenceAngle))) * launchPower
	var loader = preload(sinker).instance()
	add_child(loader)
	loader.position = $Rod/flingPoint.global_position
	loader.linear_velocity = Vector2(-100,-100) * rodInfluence
	if lol != null:
		lol.queue_free()
	lol = loader
