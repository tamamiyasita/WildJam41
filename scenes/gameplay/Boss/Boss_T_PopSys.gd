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
	$gyorai.play()
	var r = int(rand_range(2,5))
	for p in range(r):
		var pop_num = randi() % max_num + min_num
		for i in range(pop_num):
			var fish = Fish.instance()
			fish.global_position = global_position
			add_child(fish)
		yield(get_tree().create_timer(0.3), "timeout")
		


func _on_Timer_timeout():
	pop() # Replace with function body.
	var r = rand_range(1, 3)
	timer.start(pop_time + 3)
