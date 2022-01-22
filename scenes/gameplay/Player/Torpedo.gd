extends RigidBody2D

export var speed := Vector2(250,0)
export(PackedScene) var Explosion
onready var hit_shape := $Area2D/CollisionShape2D


func _ready() -> void:
	set_as_toplevel(true)
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	add_central_force(speed)


func _on_Timer_timeout() -> void:
	$Particles2D2.visible = true
	set_physics_process(true)


func explode():
#		$Area2D/CollisionShape2D.disabled = true
#		call_deferred("hit_shape.disabled", true)
		get_tree().call_group("shockwave", "shock_wave", global_position)
		
		var explosion = Explosion.instance()
		get_parent().add_child(explosion)
		explosion.position = position
		queue_free()
	

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("take_damage"):
		call_deferred("explode")
#		explode()
