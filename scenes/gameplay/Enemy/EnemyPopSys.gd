extends Position2D

export(PackedScene) var Enemy
export var min_num := 1
export var max_num := 3
export var pop_time := 5

onready var timer := $Timer

onready var pop_point := $PopPoint

func _ready():
	randomize()
	timer.start(pop_time)
	
func pop():
	var pop_num = randi() % max_num + min_num
	for i in range(pop_num):
		var enemy = Enemy.instance()
		var x = rand_range(-180, 180)
		var y = rand_range(-220, 220)
		
		enemy.global_position = pop_point.global_position
#		enemy.global_position += Vector2(x,y)
		pop_point.add_child(enemy)
#		enemy.set_as_toplevel(true)
		


func _on_Timer_timeout():
	pop() # Replace with function body.
	timer.start(pop_time)
