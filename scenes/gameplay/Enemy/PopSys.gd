extends Node2D

export(PackedScene) var Fish
export var min_num := 1
export var max_num := 3
export var pop_time := 5

onready var timer := $Timer

func _ready():
	randomize()
	timer.start(pop_time)
	
func pop():
	var pop_num = randi() % max_num + min_num
	for i in range(pop_num):
		var fish = Fish.instance()
		var x = rand_range(-80, 80)
		var y = rand_range(-120, 120)
		
		fish.global_position = global_position
		fish.global_position += Vector2(x,y)
		add_child(fish)
#		fish.set_as_toplevel(true)
		


func _on_Timer_timeout():
	pop() # Replace with function body.
	timer.start(pop_time)
