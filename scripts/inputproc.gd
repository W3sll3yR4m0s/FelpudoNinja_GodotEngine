extends Node2D

onready var limit = get_node("Limit")
onready var interval = get_node("Interval")

var pressed = false
var drag = false
var currentPosition = Vector2(0, 0)
var previousPosition = Vector2(0, 0)

var acabou = false

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	update()
	if drag and currentPosition != previousPosition and previousPosition != Vector2(0, 0) and not acabou:
		var space_state = get_world_2d().get_direct_space_state()
		var result = space_state.intersect_ray(previousPosition, currentPosition)
		if not result.empty():
			result.collider.cut()

func _input(event):
	event = make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			pressed(event.pos)
		else:
			released()
	elif event.type == InputEvent.SCREEN_DRAG:
		drag(event.pos)
		
func pressed(pos):
	pressed = true
	previousPosition = pos
	limit.start()
	interval.start()
	
func released():
	pressed = false
	drag = false
	limit.stop()
	interval.stop()
	previousPosition = Vector2(0, 0)
	currentPosition = Vector2(0, 0)
	
func drag(pos):
	currentPosition = pos
	drag = true


func _on_Interval_timeout():
	previousPosition = currentPosition

func _on_Limit_timeout():
	released()

func _draw():
	if drag and currentPosition != previousPosition and previousPosition != Vector2(0, 0) and not acabou:
		draw_line(currentPosition, previousPosition, Color(1, 0, 0), 10)
