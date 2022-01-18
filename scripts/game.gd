extends Node2D

onready var fruits = get_node("Fruits")

var pineapple = preload("res://scenes/pineapple.tscn")
var pear = preload("res://scenes/pear.tscn")
var orange = preload("res://scenes/orange.tscn")
var watermelon = preload("res://scenes/watermelon.tscn")
var tomato = preload("res://scenes/tomato.tscn")
var bomb = preload("res://scenes/bomb.tscn")

var score = 0
var lifes = 3

func _ready():
	
	pass


func _on_Generator_timeout():
	if lifes <= 0: return

	for i in range(0, rand_range(1, 4)):
		var type = int(rand_range(0, 6))
		var obj
		if type == 0:
			obj = pineapple.instance()
		elif type == 1:
			obj = pear.instance()
		elif type == 2:
			obj = orange.instance()
		elif type == 3:
			obj = watermelon.instance()
		elif type == 4:
			obj = tomato.instance()
		elif type == 5:
			obj = bomb.instance()
			
		obj.born(Vector2(rand_range(200, 1080), 800))
		
		obj.connect("life", self, "decrementa_life")
		
		if type != 5:
			obj.connect("score", self, "incrementa_score")
		
		fruits.add_child(obj)

func decrementa_life():
	lifes -= 1
	if lifes == 0:
		get_node("GameOverScreen").start()
		get_node("InputProc").acabou = true
		print("Game Over!")
		get_node("Control/Bomb1").set_modulate(Color(1, 0, 0))
	if lifes == 2:
		get_node("Control/Bomb3").set_modulate(Color(1, 0, 0))
	if lifes == 1:
		get_node("Control/Bomb2").set_modulate(Color(1, 0, 0))

func incrementa_score():
	if lifes == 0: return
	score += 1
	get_node("Control/Label").set_text(str(score))