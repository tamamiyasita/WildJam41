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
var is_dead = false


#func _ready() -> void:
#	set_as_toplevel(true)
#	area2d.add_to_group("enemy")
#	area2d.add_to_group("take_damage")
#	set_physics_process(false)


func _physics_process(delta):
	position.x -= delta * 400
#	if on_bite_area:
#		take_bite(delta)
		
		



func dead():
	if is_dead == false:
		is_dead = true
		
		var d = DeadExp.instance()
		d.exp_mod = dead_color
		d.exp_scale = dead_scale
		get_parent().add_child(d)
		d.global_position = area2d.global_position
		d.dead()
		area2d.dead_anime.play("dead")
		
		yield(area2d.dead_anime, "animation_finished" )
		print("boss_end")
		Game.change_scene("res://scenes/gameplay/EndKaijyou.tscn")
	

#func take_bite(delta):
#	$AnimationPlayer.stop()
#	var speeds = 6
#	var direction = on_bite_area.global_position - area2d.global_position
#	direction.normalized()
#	sprite.position += direction * speeds * delta
#	sprite.scale /= 1.21
#	sprite.rotation_degrees += 30
#	if sprite.scale.length() < .2:
#		queue_free()
#	dead()
	








func _on_Timer_timeout():
	set_physics_process(false)

	var _t = tween.interpolate_property(path_follow, "unit_offset",
							   0.0, 1.0, $Path2D.curve.get_baked_length() / move_speed, Tween.TRANS_QUAD)
	print(_t, " T")
	var _s = tween.start()
	
	yield(tween, "tween_completed")
	$Timer.start()
#	queue_free()


