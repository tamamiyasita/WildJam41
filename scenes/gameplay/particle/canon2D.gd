extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)


func _physics_process(delta):
	global_position = get_parent().global_position
