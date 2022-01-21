extends Area2D

var speed = 500
onready var anime :AnimationPlayer = $AnimationPlayer

func _ready():
	yield(get_tree(), "idle_frame" )
	add_to_group("take_damage")
	set_as_toplevel(true)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_EnmBullet_body_entered(body: Node) -> void:
	if body.name == "Player":
		anime.play('bom')
		yield(anime, "animation_finished" )
		queue_free()

