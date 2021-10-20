extends KinematicBody2D
var rng = RandomNumberGenerator.new()



export var state = "normal"
export var swimming = true
export var xLimits = Vector2()
export var yLimits = Vector2()
export var timings = Vector2()
var edge = false
var timeToMove = 0.0
export var normalSpeedNerf = 0.0

var velocity = Vector2()
var baseSwim = 200
var direction = 1
var animateDirection = 1

var chanceResult = 0.0
var moveE = false



func _ready():
	pass # Replace with function body.


func _process(delta):
	rng.randomize()
	if state == "rabid":
		if swimming == true:
			var impulse = Vector2()
			impulse.x = baseSwim * direction
			impulse.y = chanceResult
			velocity = impulse
			velocity = move_and_slide(velocity, Vector2.UP)

			scale = Vector2(animateDirection,1)
			rotation_degrees = 0
	elif state == "normal":
		if swimming == true:
			if moveE == false:
				
				moveE = true
				timeToMove = rng.randf_range(timings.x,timings.y)
				$TimeToMove.start(timeToMove)
			elif moveE == true:
				velocity = move_and_slide(velocity, Vector2.UP)
				position.x = clamp(position.x,xLimits.x, xLimits.y )
				position.y = clamp(position.y,yLimits.x, yLimits.y )
				
		

func chance():
	var direee = (rng.randi_range(-1,0) * 2) + 1
	var move = rng.randi_range(0,1000)
	var chance = 0
	if move <= 700:
		chance = 0
	elif move > 700 and move <= 800:
		chance = 1
	elif move > 800 and move <= 900:
		chance = 3
	elif move > 900 and move <= 1000:
		chance = 5
	chanceResult = (chance * direee) * baseSwim
	print(chanceResult)
	

func _on_wall_body_entered(body):
	if body.name == "rigid":
		direction = direction * -1
		animateDirection = direction
		chance()
		if state == "normal":
			normalSlow()


func _on_TimeToMove_timeout():
	var timeToMove = rng.randf_range(1.0,10.0)
	var impulse = Vector2()
	impulse.x = rng.randf_range(xLimits.x, xLimits.y)
	impulse.y = rng.randf_range(yLimits.x, yLimits.y)
	velocity = (((position - impulse)/ normalSpeedNerf) * -1)/timeToMove
	direction = velocity.x / abs(velocity.x)
	animateDirection = direction
	scale = Vector2(animateDirection,1)
	rotation_degrees = 0

func normalSlow():
	moveE = false
	velocity.x = move_toward(velocity.x, 0, 1)
	velocity.y = move_toward(velocity.y, 0, 1)
