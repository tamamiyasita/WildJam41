extends Area2D

onready var ray := $RayCast2D

export (PackedScene) var Bullet 

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	if Info.player != null:
		var p = (global_position.y - Info.player.global_position.y)
		print(p, "PPP")
		if abs(p) <= 80:
			shot()
	set_physics_process(false)

func shot():
	print("shot!")
	var bullet = Bullet.instance()
	bullet.global_position = global_position
	add_child(bullet)


func _on_Timer2_timeout():
	set_physics_process(true)
