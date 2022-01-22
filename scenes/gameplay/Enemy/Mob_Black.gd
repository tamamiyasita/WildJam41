extends Node2D
export var move_speed := 150

func _ready():
	set_as_toplevel(true)


func _physics_process(delta):
	position.x -= delta * move_speed	


func _on_Timer_timeout():
	queue_free()
