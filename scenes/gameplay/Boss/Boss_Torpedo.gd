extends RigidBody2D

export var speed := Vector2(-60,0)
export(PackedScene) var Explosion
onready var hit_shape := $Area2D/CollisionShape2D
onready var hit_area := $Area2D
onready var sprite := $Sprite

var on_bite_area
var is_dead = false

func _ready() -> void:
	set_as_toplevel(true)
	set_physics_process(false)
	hit_area.add_to_group("enemy")
	hit_area.add_to_group("take_damage")

	var r = int(rand_range(-750, 750))
	add_central_force(Vector2(0, -r))
	

func _physics_process(delta: float) -> void:
	add_central_force(speed)
	
	if on_bite_area:
		take_bite(delta)

func _on_Timer_timeout() -> void:
	$Particles2D2.visible = true
	set_physics_process(true)


func explode():
	if is_dead == false:
#		$Area2D/CollisionShape2D.disabled = true
		get_tree().call_group("shockwave", "shock_wave", global_position)
		
		var explosion = Explosion.instance()
		get_parent().add_child(explosion)
		explosion.position = position
		queue_free()
	

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Area2D_area_entered(area):
	if area.name == "BiteArea":
		is_dead = true
		on_bite_area = area
#		call_deferred("hit_shape.disabled", true)
	elif area.name =="ExpArea":
		queue_free()
	elif area.name == "HPArea2D":
		call_deferred("explode")

func take_bite(delta):
	var speeds = 16
	var direction = on_bite_area.global_position - global_position
	direction.normalized()
	position += direction * speeds * delta
	sprite.scale /= 1.1
	if sprite.scale.length() < .2:
		queue_free()

