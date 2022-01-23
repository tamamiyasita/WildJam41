extends CanvasLayer


onready var shockwave := $Shockwave
onready var anime:= $Shockwave/AnimationPlayer


func _ready():
	set_process(false)

func shock_wave():
	shockwave.material.set_shader_param("global_position",get_parent().global_position)
	anime.play("shockwave")


func shock_wave2():
	shockwave.material.set_shader_param("global_position",get_parent().global_position)
	anime.play("shockwave2")
	


func _process(delta):
	shockwave.material.set_shader_param("global_position",get_parent().global_position)
