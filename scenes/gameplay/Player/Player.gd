extends RigidBody2D


export var move_force := 600.0
export(PackedScene) var Torpedo 
onready var bite_anime := $Bite/AnimationPlayer

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
	if event.is_action_pressed('torpedo'):
		if 0 < Info.torpedo_nam:
			bite_anime.play("shot")
	elif event.is_action_pressed("bite"):
		bite_anime.play("bite")
		yield(bite_anime, "animation_finished" )


func torpedo_shot():
	Info.torpedo_nam -= 1
	get_tree().call_group("ui", "update_torpedo")
	var torpedo = Torpedo.instance() as RigidBody2D
	torpedo.global_position = $Position2D.global_position
	torpedo.apply_central_impulse(Vector2(250, 0))
	add_child(torpedo)


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("take_damage"):
		area.remove_from_group("take_damage")
		if Info.torpedo_nam < Info.max_torpedo_nam:
			Info.torpedo_nam += 1
			get_tree().call_group("ui", "update_torpedo")
	


func _on_HPArea2D_area_entered(area: Area2D) -> void:
		if area.is_in_group("take_damage"):
			if 1 < Info.hp:
				Info.hp -= 1
				get_tree().call_group("ui", "update_hp")
			else:
				get_tree().quit()


