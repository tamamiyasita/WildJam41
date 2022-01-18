extends ParallaxBackground

onready var back := $ParallaxLayer

#func _ready():
#	yield(get_tree(), "idle_frame" )
#	back.position = Vector2.ZERO
#	back.scale = Vector2(1,1)
#	scroll_offset = Vector2.ZERO

func _process(delta: float) -> void:
	scroll_offset.x -= 60 * delta
