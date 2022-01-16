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
	explosion.set_as_toplevel(true)
	explosion.global_position = body.global_position
	add_child(explosion)
	yield(get_tree().create_timer(0.3), "timeout")
	queue_free()
