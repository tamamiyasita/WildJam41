extends Node2D

onready var area2d := $Path2D/PathFollow2D/BossArea2D
onready var tween := $Tween
onready var path_follow := $Path2D/PathFollow2D


var on_bite_area
export var speed := Vector2(-200,0)
export var score_num := 100 
export var move_speed = 100
export var dead_color = Color(1,1,1,1)
export var dead_scale = Vector2(1, 1)

var DeadExp = preload("res://scenes/gameplay/particle/DeadExplosion.tscn")

func _ready() -> void:
	set_as_toplevel(true)
	area2d.add_to_group("enemy")
	area2d.add_to_group("take_damage")
	set_physics_process(false)


func _physics_process(delta):
	
#	position.x += delta * speed
	if on_bite_area:
		take_bite(delta)
		
		

func dead():
	var d = DeadExp.instance()
	d.exp_mod = dead_color
	d.exp_scale = dead_scale
	get_parent().add_child(d)
	d.global_position = area2d.global_position
	d.dead()
	queue_free()

func take_bite(delta):
	$AnimationPlayer.stop()
	var speeds = 6
	var direction = on_bite_area.global_position - area2d.global_position
	direction.normalized()
	sprite.position += direction * speeds * delta
	sprite.scale /= 1.21
	sprite.rotation_degrees += 30
	if sprite.scale.length() < .2:
		queue_free()
#	dead()
	


func _on_Area2D_area_entered(area):
	print(area)
	
	if area.name =="ExpArea":
		var d = randi() % 3 +1
		get_tree().call_group("ui", "update_boss_hp", d)
	

	





func _on_Timer_timeout():

	var _t = tween.interpolate_property(path_follow, "unit_offset",
							   0.0, 1.0, $Path2D.curve.get_baked_length() / move_speed, Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	print(_t, " T")
	var _s = tween.start()
	
	yield(tween, "tween_completed")
#	queue_free()


