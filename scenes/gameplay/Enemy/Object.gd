extends Area2D


var on_bite_area


func _ready() -> void:
	add_to_group("enemy")
	add_to_group("take_damage")


func _physics_process(delta):
		
	if on_bite_area:
		take_bite(delta)
		
		

#func dead():
	


func take_bite(delta):
	var speed = 6
	var direction = on_bite_area.global_position - global_position
	direction.normalized()
	position += direction * speed * delta
	scale /= 1.11
	rotation_degrees += 30
	print(scale.length())
	if scale.length() < .2:
		queue_free()
	

func _on_Object_area_entered(area):
	print(area)
	if area.name == "Bite2":
		on_bite_area = area
