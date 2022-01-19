extends RigidBody2D


onready var sprite := $Sprite

var on_bite_area
export var speed := Vector2(-200,0)
export var score_num := 100 

func _ready() -> void:
	set_as_toplevel(true)
	add_to_group("fish")
#	add_to_group("take_damage")
	set_physics_process(false)
	hide()


func _physics_process(delta):
	
#	position.x += delta * speed
	if on_bite_area:
		take_bite(delta)
		
		

#func dead():
	


func take_bite(delta):
	$AnimationPlayer.stop()
	var speeds = 6
	var direction = on_bite_area.global_position - global_position
	direction.normalized()
	position += direction * speeds * delta
	sprite.scale /= 1.11
	rotation_degrees += 30
	if sprite.scale.length() < .2:
		queue_free()
	


func _on_Area2D_area_entered(area):
	print(area)
	if area.name == "BiteArea":
		set_physics_process(true)
		on_bite_area = area





func _on_Timer_timeout():
	var s = rand_range(-1,-20)
	speed.x += s
	apply_central_impulse(speed)
	var t = rand_range(.5, 1.5)
	$Timer.start(t)

