extends RigidBody2D

onready var shape = get_node("Shape")
onready var sprite = get_node("Sprite")
onready var anim = get_node("AnimationBomb")

signal life

var cortada = false

func _ready():
	randomize()
	set_process(true)

func _process(delta):
	if get_pos().y > 800:
		queue_free()

func born(initialPos):
	set_pos(initialPos)
	
	var initialVelocity = Vector2(0, rand_range(-1000, -800))
	
	if initialPos.x < 640:
		initialVelocity = initialVelocity.rotated(deg2rad(rand_range(0, -30)))
	else:
		initialVelocity = initialVelocity.rotated(deg2rad(rand_range(0, 30)))
	
	set_linear_velocity(initialVelocity)
	set_angular_velocity(rand_range(-10, 10))
	
func cut():
	if cortada: return
	cortada = true
	emit_signal("life")
	set_mode(MODE_KINEMATIC)
	anim.play("Explode")