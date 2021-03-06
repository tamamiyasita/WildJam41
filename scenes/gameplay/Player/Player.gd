extends RigidBody2D


export var move_force := 600.0
export(PackedScene) var Torpedo 
export var dead_color = Color(1,1,1,1)
export var dead_scale = Vector2(1, 1)

onready var bite_anime := $Bite/AnimationPlayer
onready var damage_anime := $DamageAnime

var DeadExp = preload("res://scenes/gameplay/particle/DeadExplosion.tscn")
var Canon = preload("res://scenes/gameplay/particle/canon2D.tscn")

func _ready() -> void:
	pass ## Replace with function body.


func _physics_process(delta: float) -> void:
	var direction := Vector2(
	Input.get_action_strength('right') - 
	Input.get_action_strength('left'),
	
	Input.get_action_strength('down') - 
	Input.get_action_strength('up')
	).normalized()
	
	applied_force = direction * move_force
	
	if rotation_degrees != 0:
		rotation_degrees = 0


func _unhandled_key_input(event: InputEventKey) -> void:
	if !bite_anime.is_playing():
		if event.is_action_pressed('torpedo'):
			if 0 < Info.torpedo_nam:
				bite_anime.play("shot")
		elif event.is_action_pressed("bite"):
			bite_anime.play("bite")
			$Vpos/ShockLayer.set_process(true)
			$Vpos/ShockLayer.shock_wave()
			yield(bite_anime, "animation_finished" )
			$Vpos/ShockLayer.set_process(false)
		elif event.is_action_pressed("canon"):
			if Info.canon_charge:
				bite_anime.play("canon")
				$Vpos/ShockLayer.set_process(true)
				$Vpos/ShockLayer.shock_wave2()
				yield(bite_anime, "animation_finished" )
				$Vpos/ShockLayer.set_process(false)
				get_tree().call_group("ui", "update_charge")
		


func torpedo_shot():
	Info.torpedo_nam -= 1
	get_tree().call_group("ui", "update_torpedo")
	var torpedo = Torpedo.instance() as RigidBody2D
	torpedo.global_position = $Position2D.global_position
	torpedo.apply_central_impulse(Vector2(250, 0))
	add_child(torpedo)

func canon_shot():
	var canon = Canon.instance() as Position2D
	canon.global_position = $Position2D.global_position
	add_child(canon)
	yield(get_tree().create_timer(3.5), "timeout")
	canon.queue_free()



func _on_BiteArea_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("take_damage"):
		$Bite/mgmg.play()
		$Body/EatAnimationPlayer.play("eat")
		if area.is_in_group("take_damage"):
			area.remove_from_group("take_damage")
		#??????????????????
		if Info.torpedo_nam < Info.max_torpedo_nam:
			Info.torpedo_nam += 1
			get_tree().call_group("ui", "update_torpedo")
	elif area.is_in_group("fish"):
		$Bite/mgmg.play()
		$Body/EatAnimationPlayer.play("eat")
		print("fish!")
		get_tree().call_group("ui", "update_score", area.get_parent().score_num)
		
	
func take_damage(area):
	if 1 < Info.hp:
		var d = DeadExp.instance()
		d.exp_mod = dead_color
		d.exp_scale = dead_scale
		get_parent().add_child(d)
		d.global_position = global_position
		damage_anime.play("take_damage")
		yield(damage_anime, "animation_finished" )
		Info.hp -= 1
		get_tree().call_group("ui", "update_hp")
	else:
		set_physics_process(false)
		damage_anime.play("take_damage")
		apply_central_impulse(Vector2(-50, -500))
		add_torque(500)
		yield(damage_anime, "animation_finished" )
		Game.change_scene("res://scenes/menu/Gameover.tscn")






func _on_HPArea2D_area_entered(area: Area2D) -> void:
	if !damage_anime.is_playing():
		if area.is_in_group("take_damage"):
			take_damage(area)







func _on_VisibleArea2D_body_entered(body):
	if body.is_in_group("fish"):
	
		body.show()


func _on_VisibleArea2D_body_exited(body):
	if body.is_in_group("fish"):
		body.hide()

