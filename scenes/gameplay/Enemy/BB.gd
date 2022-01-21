extends Area2D


onready var sprite := $Sprite

var on_bite_area

export (PackedScene) var Bullet 
export var move_speed = 30
export var speed := Vector2(-200,0)
export var score_num := 100 

export var dead_color = Color(1,1,1,1)
export var dead_scale = Vector2(1, 1)

var DeadExp = preload("res://scenes/gameplay/particle/DeadExplosion.tscn")

var shot_time := false

onready var shotpos := $ShotArea2D/CollisionShape2D2

func _ready() -> void:
	add_to_group("enemy")
	add_to_group("take_damage")



func dead():
	var d = DeadExp.instance()
	d.exp_mod = dead_color
	d.exp_scale = dead_scale
	get_parent().add_child(d)
	d.global_position = global_position
	d.dead()
	queue_free()




func _physics_process(delta):
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
	


		




func shot():
	print("shot!")
	var bullet = Bullet.instance()
	bullet.global_position = global_position
	bullet.rotation_degrees =shotpos.rotation_degrees+90
	
	get_parent().add_child(bullet)
	queue_free()



func _on_ShotArea2D_body_entered(body):
	if shot_time:
		if body.name == "Player":
			shot()
			shot_time = false
			$ShotArea2D/ShotTimer.start()


func _on_ShotTimer_timeout():
	shot_time = true




func _on_Timer_timeout():
	var s = rand_range(-1,-20)
	speed.x += s
	var t = rand_range(.5, 1.5)
	$Timer.start(t)



func _on_BlueEnemy_area_entered(area):
	if area.name == "BiteArea":
		on_bite_area = area
	elif area.name =="ExpArea":
		dead()


