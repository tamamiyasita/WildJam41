extends Area2D

export var speed = 300
onready var anime :AnimationPlayer = $AnimationPlayer
onready var sprite := $Sprite

var on_bite_area

func _ready():
	yield(get_tree(), "idle_frame" )
	add_to_group("take_damage")
	set_as_toplevel(true)




func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

	if on_bite_area:
		take_bite(delta)
		

func take_bite(delta):
	$AnimationPlayer.stop()
	var speeds = 6
	var direction = on_bite_area.global_position - global_position
	direction.normalized()
	position += direction * speeds * delta
	sprite.scale /= 1.1
	if sprite.scale.length() < .2:
		queue_free()




func _on_Bullet_area_entered(area):
	if area.name == "BiteArea":
		on_bite_area = area
	elif area.name =="ExpArea" or area.name == "CanonArea":
		queue_free()
