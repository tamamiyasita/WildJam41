extends RigidBody2D

export var speed := Vector2(250,0)
export(PackedScene) var Explosion



func _ready() -> void:
	set_as_toplevel(true)
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	add_central_force(speed)


func _on_Timer_timeout() -> void:
	set_physics_process(true)


func _on_Area2D_body_entered(body: Node) -> void:
	var explosion = Explosion.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	$Polygon2D.color = Color.antiquewhite
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.visible = false
	$Polygon2D.visible = false
	$Particles2D.emitting = false
	yield(get_tree().create_timer(0.9), "timeout")
	queue_free()
