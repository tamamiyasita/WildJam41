extends Position2D

export(PackedScene) var Enemy
export var min_num := 1
export var max_num := 3
export var pop_time := 5
export var max_pop := 1
onready var timer := $Timer

onready var pop_point := $PopPoint

func _ready():
	randomize()
	timer.start(pop_time)
	
func pop():
	var pop_num = randi() % max_num + min_num
	for i in range(pop_num):
		var enemy = Enemy.instance()
#		var x = rand_range(-100, 100)
#		var y = rand_range(-100, 100)
		
		var pos = pop_point.global_position# + Vector2(x,y)
		enemy.global_position = pos
#		enemy.global_position += Vector2(x,y)
		pop_point.add_child(enemy)
#		enemy.set_as_toplevel(true)
		yield(get_tree().create_timer(0.3), "timeout")


func _on_Timer_timeout():
	if 0 < max_pop:
		pop() # Replace with function body.
		timer.start(pop_time)
		max_pop -= 1
