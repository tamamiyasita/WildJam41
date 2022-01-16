extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export var move_force := 600.0
export(PackedScene) var Torpedo 

# Called when the node enters the scene tree for the first time.
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
		torpedo_shot()

func torpedo_shot():
	var torpedo = Torpedo.instance()
	torpedo.global_position = global_position
	torpedo.global_position.y += 100
	add_child(torpedo)
