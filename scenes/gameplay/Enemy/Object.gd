extends Area2D


var on_bite_area


func _physics_process(delta):
		
	if on_bite_area:
		bite(delta)
		
		

#func dead():
	


func bite(delta):
	var speed = 6
	var direction = on_bite_area.global_position - global_position
	direction.normalized()
	position += direction * speed * delta
	scale /= 1.15
	print(scale.length())
	if scale.length() < .2:
		queue_free()
	

func _on_Object_area_entered(area):
	print(area)
	if area.name == "Bite":
		on_bite_area = area
