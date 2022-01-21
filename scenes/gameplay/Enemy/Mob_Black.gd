extends Node2D
export var move_speed := 350

func _physics_process(delta):
	position.x -= delta * move_speed	


func _on_Timer_timeout():
	queue_free()
