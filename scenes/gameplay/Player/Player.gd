extends RigidBody2D


export var move_force := 600.0
export(PackedScene) var Torpedo 

onready var camera = get_parent().get_node("Camera2D")
onready var shockwave = camera.get_node("Shockwave")

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var direction := Vector2(
	Input.get_action_strength('right') - 
	Input.get_action_strength('left'),
	
	Input.get_action_strength('down') - 
	Input.get_action_strength('up')
	).normalized()
	
	applied_force = direction * move_force


func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed('torpedo'):
		$Bite/AnimationPlayer.play("shot")
	elif event.is_action_pressed("bite"):
		shockwave.material.set_shader_param("global_position", $Bite.get_global_position())
		$Bite/AnimationPlayer.play("bite")
		shockwave.get_node("AnimationPlayer").play("shockwave")

func torpedo_shot():
	var torpedo = Torpedo.instance() as RigidBody2D
	torpedo.global_position = $Position2D.global_position
	torpedo.apply_central_impulse(Vector2(250, 0))
#	torpedo.global_position.y += 100
	add_child(torpedo)


func _on_Area2D_area_entered(area):
	pass
	



